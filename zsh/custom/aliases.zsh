alias ws='cd ~/workspace'
alias re='.. && -'
alias c='clear'
alias sha1='openssl sha1 '
alias vim='nvim'

# CS Department Remote Machine
alias rlmount='sshfs rliang@best-linux.cs.wisc.edu:/u/r/l/rliang/private ~/workspace/mnt/rliang/private'
alias rlumount='umount ~/workspace/mnt/rliang/private'
alias rlprivate='cd ~/workspace/mnt/rliang/private'
alias cpprivate='echo "/Users/ryan/workspace/mnt/rliang/private" | pbcopy'

alias ssh!="ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i $ISILON_DUCT_TAPE_SSH_PRIVATE_KEY_LOCATION -l root"
