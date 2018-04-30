if application "Spotify" is running then
	tell application "Spotify"
		if player state is playing then
			return (get artist of current track) & " - " & (get name of current track)
		else
			return "Not Playing"
		end if
	end tell
else
	return "Not Playing"
end if
