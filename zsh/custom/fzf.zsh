# filtered fzf
fzfiltered() {
	find . build -not \( -path Library -prune \) \
                 -not \( -path System -prune \)  \
                 -not \( -path Movie -prune \)   \
                 -not \( -path Documents -prune \)  \
                 -not \( -path Pictures -prune \)   \
                 -not \( -name 'node_modules' -prune \)  \
                 -not \( -name 'Applications'  -prune \)  \
                 -not \( -name 'plugged' -prune \)  \
                 -maxdepth 5 -type f | fzf
}

# filtered vim
vimf(){
	local  result=$(fzfiltered)
	if [[ "$result" ]]; then
		vim $result
	fi
}
