session="whatever"
window=${session}:0
pane=${window}.4

tmux new -s $session
tmux send-keys -t "$pane" C-z 'pwd -P' Enter
tmux select-pane -t "$pane"
tmux select-window -t "$window"
tmux attach-session -t "$session"
