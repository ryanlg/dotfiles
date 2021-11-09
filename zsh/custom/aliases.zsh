alias ws='cd ~/workspace'
alias re='.. && -'
alias c='clear'
alias vim='nvim'

# Log in with root and not saving to known host.
alias ssh!="ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -l root"

# Log in without saving to known host, but you can customize the user.
alias 'ssh#'="ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"
