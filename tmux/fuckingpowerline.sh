# based on nicknisi's base16

# colors
textColor=colour251 # greyish white
defaultStatus=colour235 
separator=colour12  # grey
secondaryBack=colour237  # #86C1B9
thirdBack=colour241  # #86C1B9
lightgreen=colour10  # #7CAFC2
firstBack=colour240  # #BA8BAF
lightblue=colour12 # #A16946

set -g status-left-length 32
set -g status-right-length 150
set -g status-interval 5

# default statusbar colors
set-option -g status-fg $textColor
set-option -g status-bg $defaultStatus
set-option -g status-attr default

# non-active window colors
set-window-option -g window-status-fg $textColor
set-window-option -g window-status-bg $secondaryBack
set -g window-status-format " #I #W "

# active window title colors
set-window-option -g window-status-current-fg $lightblue
set-window-option -g window-status-current-bg $thirdBack
set-window-option -g  window-status-current-format "    #I #[bold]#W    "

# pane border colors
set-window-option -g pane-border-fg $secondaryBack
set-window-option -g pane-active-border-fg $separator

# message text
set-option -g message-bg $textColor
set-option -g message-fg $secondaryBack

# pane number display
set-option -g display-panes-active-colour $secondaryBack
set-option -g display-panes-colour $defaultStatus

# clock
set-window-option -g clock-mode-colour $secondaryBack

tm_session_name="#[default,bg=$firstBack,fg=$textColor] Session: #S "
set -g status-left "$tm_session_name"

tm_tunes="#[bg=$secondaryBack,fg=$lightgreen] ♫ #(osascript ~/.dotfiles/applescript/playing.scpt)"
# tm_battery="#[fg=$textColor,bg=$base09] ♥ #(battery)"
tm_date="#[default,bg=$firstBack,fg=$textColor] %R %a %b %d"
# tm_host="#[fg=$textColor,bg=$firstBack] #h "
set -g status-right "$tm_tunes $tm_battery $tm_date $tm_host"
