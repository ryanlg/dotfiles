# This file defines and exports some helpers that maybe used by all other scripts
#
# Quick handle for changing color of text
# @example: printf "%40s\n" "${BLUE}This text is blue${NORMAL}"
# @adapted: stackoverflow.com/questions/4332478/read-the-current-text-color-in-a-xterm/4332530#4332530
export BLACK=$(tput setaf 0)
export RED=$(tput setaf 1)
export GREEN=$(tput setaf 2)
export YELLOW=$(tput setaf 3)
export LIME_YELLOW=$(tput setaf 190)
export POWDER_BLUE=$(tput setaf 153)
export BLUE=$(tput setaf 4)
export MAGENTA=$(tput setaf 5)
export CYAN=$(tput setaf 6)
export WHITE=$(tput setaf 7)
export BRIGHT=$(tput bold)
export NORMAL=$(tput sgr0)
export BLINK=$(tput blink)
export REVERSE=$(tput smso)
export UNDERLINE=$(tput smul)

# Test if a program is available to be executed
__check_program() {
    if ! command -v "$1" &> /dev/null; then
        return 1
    fi

    return 0
}

# Print and format a message as an error
__print_error() {
    printf "${RED}Error:${NORMAL} $1\n" "${@:2}"
}

# Print and format a message as a notice
__print_notice() {
    printf "${BLUE}Notice:${NORMAL} $1\n" "${@:2}"
}

# Pipe a variable
# @example: __pipe "$a_variable" | jq
__pipe() {
    printf "%s\n" "$1"
}
