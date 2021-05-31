# This file defines and exports a helper that signs and backs up files according to our
# backup scheme.
#
# @author: Ryan Liang <rl@ryanl.io>

# __check_*
#
# Check if various tools and variables needed for the backup
# are present on the machine.
__check_op() {
    if ! command -v "op" &> /dev/null; then
        echo "Error: 1Password CLI (op) cannot be found, please install the tool from https://1password.com/downloads/command-line/"
        return -1
    fi

    return 0
}

__check_gnupg() {
    if ! command -v "gpg" &> /dev/null; then
        echo "Error: GnuPG (gpg) cannot be found, please install the tool."
        return -1
    fi

    return 0
}

__check_jq() {
    if ! command -v "jq" &> /dev/null; then
        echo "Error: JQ (jq) cannot be found, please install the tool."
        return -1
    fi

    return 0
}

__check_op_shorthand() {

    if [ -z "$BACKUP_OP_SHORTHAND" ]; then
        echo "Error: No 1Password account shorthand is present in the environment. Please export one to \$BACKUP_OP_SHORTHAND."
        return -1
    fi

    return 0
}

__check_signing_key_id() {

    if [ -z "$BACKUP_SIGNING_KEY_ID" ]; then
        echo "Error: No GPG Key ID used for signing backups is present in the environment. Please export one to \$GPG_BACKUP_SIGNING_KEY_ID."
        return -1
    fi

    return 0
}

__op_sign_in() {

    local op_eval
    local result

    op_eval="$(op signin $BACKUP_OP_SHORTHAND)"
    result=$?

    [ $result -eq 0 ] || return $result

    # @todo: some prelimary checks
    op_eval="$(printf "%s" "$op_eval" | head -n 1)"

    eval "$op_eval"
    return $result
}

__op_sign_out() {
    op signout
    unset "OP_SESSION_$BACKUP_OP_SHORTHAND"
}

# Get items related to PGP
#
# @notice: the list returned only contains items in "Password" category,
# and with "pgp" tags present.
__op_get_items_pgp() {

    local items
    local result

    items="$(op list items --categories Password)" # @todo: add tags
    result=$?

    printf "%s" "$items"
    return $result
}

# Get the "password" field for a specific item with uuid
__op_get_item_pass() {

    local pass
    local result

    pass="$(op get item --fields password \"$1\")"
    result=$?

    printf "%s" "$pass"
    return $result
}

# Parse a JSON list and filter for a certain key with requested name
#
# @param $1: JSON list to be filtered
# @param #2: name of the item.
__jq_get_op_item_uuid() {

    local filtered_uuid length

    # Get the UUID of items that matches the concatenated title
    # This filter keeps the surrouding array so we can check for duplicates
    filtered_uuids=$(printf "%s" "$1" | jq -r "[.[] | select(.overview.title == \"$2\") | .uuid]")

    # Check the length of the UUID array, in case of duplicate names
    length=$(printf "%s" "$filtered_uuids" | jq -r 'length')

    ! [ -z $length ] || return 3  # No key
    ! [ "$length" -eq 0 ] || return 1  # No key
    ! [ "$length" -ne 1 ] || return 2  # More than one key

    printf "%s" "$filtered_uuids" | jq -r '.[0]'
    return 0
}

__print_usage() {
    echo "Usage: gpgbackup <pass-name> <file>"
}

# Conveniently sign and backup important files according to our backup scheme.
gpgbackup() {

    [ $1 ] || { __print_usage; return 1 }
    [ $2 ] || { __print_usage; return 1 }

    BACKUP_OP_ITEM_NAME_PREFIX="ryanl/pgp/"
    BACKUP_OP_ITEM_NAME_SUFFIX="/pass"

    BACKUP_OP_PASS_NAME_SHORT="$1"
    BACKUP_OP_ROOT_NAME_SHORT="root"

    op_item_root_name="${BACKUP_OP_ITEM_NAME_PREFIX}${BACKUP_OP_ROOT_NAME_SHORT}${BACKUP_OP_ITEM_NAME_SUFFIX}"
    op_item_pass_name="${BACKUP_OP_ITEM_NAME_PREFIX}${BACKUP_OP_PASS_NAME_SHORT}${BACKUP_OP_ITEM_NAME_SUFFIX}"

    # @documentation: assume `date` utility is universal
    # @documentation: short utc for filename, long iso for metadata
    current_time_epoch=$(date +"%s")
    current_time_filename=$(TZ=UTC+0 date -jf "%s" "$current_time_epoch" +"%Y%m%dT%H%M%S")
    current_time_metadata=$(date -jf  "%s" "$current_time_epoch" +"%Y-%m-%dT%H:%M:%S%z")

    BACKUP_IN_FILENAME="$2"
    out_filename="$2-$current_time_filename"

    # @todo: put echo in here, use a generic __check_program function
    # Check if tools and environment variables are present
    __check_op || return 1
    __check_gnupg || return 1
    __check_jq || return 1
    __check_op_shorthand || return 1
    __check_signing_key_id || return 1

    # Gimme a session key
    # __op_sign_in || return 2

    local result pgp_items root_uuid root_pass pass_uuid pass_key

    result=1

    # All items in OP related to PGP
    pgp_items=$(__op_get_items_pgp)
    result=$?
    [ $result -eq 0 ] || return 2

    # Get the root key passphrase
    root_uuid=$(__jq_get_op_item_uuid "$pgp_items" "$op_item_root_name")
    result=$?

    ! [ $result -eq 1 ] || { echo "Error: No root keys with name \"$op_item_root_name\" found in 1Password"; return 2 }
    ! [ $result -eq 2 ] || { echo "Error: Duplicate root keys with name \"$op_item_root_name\" found in 1Password"; return 3 }

    root_pass=$(__op_get_item_pass "$root_uuid")
    result=$?

    [ $result -eq 0 ] || { echo "Error: Unknown error ("$?") returned by 1Password when retrieving root key passphrase"; return 2 }

    # Get the item key passphrase
    pass_uuid=$(__jq_get_op_item_uuid "$pgp_items" "$op_item_pass_name")
    result=$?

    ! [ $result -eq 1 ] || { echo "Error: No pass items with name \"$op_item_pass_name\" found in 1Password"; return 2 }
    ! [ $result -eq 2 ] || { echo "Error: Duplicate pass items with name \"$op_item_pass_name\" found in 1Password"; return 3 }

    pass_key=$(__op_get_item_pass "$pass_uuid")
    [ $result -eq 0 ] || { echo "Error: Unknown error ("$?") returned by 1Password when retrieving encryption passphrase"; return 2 }

    # Revoke the session key ASAP
    __op_sign_out || return 3

    # Perform the backup through GnuPG
    # See File Header for why we are not using `--sign --symmetric`
    printf "%s" "$root_pass" | \
        gpg --sign \
            --local-user "${BACKUP_SIGNING_KEY_ID}!" \
            --output "${out_filename}.signed" \
            --batch \
            --passphrase-fd 0 \
            --pinentry-mode loopback \
            "${BACKUP_IN_FILENAME}"
    [ $? -eq 0 ] || { return 4 }

    printf "%s" "$pass_key" | \
        gpg --symmetric \
            --output "${out_filename}.enc" \
            --batch \
            --passphrase-fd 0 \
            --no-symkey-cache \
            --pinentry-mode loopback \
            "${out_filename}.signed"
    [ $? -eq 0 ] || { return 4 }

    gpg --detach-sign \
        --local-user "${BACKUP_SIGNING_KEY_ID}!" \
        --output "${out_filename}.enc.sig" \
        --batch \
        "${out_filename}.enc"
    [ $? -eq 0 ] || { return 4 }

    # Remove intermediate signed file
    rm "${out_filename}.signed"

    # Write metadata file
    # @vulnerability: someone can swap the underlying gpg to an old version
    gpg_version_raw="$(gpg --version | head -n 2)"
    gpg_version="$(echo "$gpg_version_raw" | head -n 1)"
    gpg_version="${gpg_version: -5}"
    libgcrypt_version="${gpg_version_raw: -5}"

    file_digest="$(gpg --print-md sha512 $BACKUP_IN_FILENAME)"
    file_digest="${file_digest##*:}"            # Remove prefix "filename : "
    file_digest="${file_digest//[[:space:]]/}"  # Remove spaces and newline
    file_digest="$(echo "$file_digest" | sed 's/.\{8\}/& /g;s/ $//')" # Separate in 8-char groups

    cat <<- EOF > "${out_filename}.metadata.json.unsigned"
	  "version": 1,
	  "gpg": {
	    "gpgVersion": "$gpg_version",
	    "libgcryptVersion": "$libgcrypt_version",
	    "signingKeyFingerprint": "$BACKUP_SIGNING_KEY_ID"
	  },
	  "timeCreated": "$current_time_metadata",
	  "file": {
	    "name": "$BACKUP_IN_FILENAME",
	    "sha512": "$file_digest"
	  }
	}
	
	EOF

    printf "%s" "$root_pass" | \
        gpg --clearsign \
            --local-user "${BACKUP_SIGNING_KEY_ID}!" \
            --output "${out_filename}.metadata.json" \
            --batch \
            --passphrase-fd 0 \
            --pinentry-mode loopback \
            "${out_filename}.metadata.json.unsigned"
    [ $? -eq 0 ] || { return 4 }

    # @documentation
    gpg-connect-agent "reloadagent" "/bye"

    rm "${out_filename}.metadata.json.unsigned"

    return 0
}
