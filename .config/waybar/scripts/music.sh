#!/bin/bash

sleep 0.1

# Verifica se o Spotify está ativo
if ! playerctl --player=spotify status &>/dev/null; then
    exit 0
fi

# Define ícone do Spotify
icon=""

# Pega status, título e artista
status=$(playerctl --player=spotify status 2>/dev/null)

if [ "$status" = "Playing" ]; then
    play_icon=""
elif [ "$status" = "Paused" ]; then
    play_icon=""
else
    exit 0
fi

title=$(playerctl --player=spotify metadata title 2>/dev/null | sed 's/"/\\"/g')
artist=$(playerctl --player=spotify metadata artist 2>/dev/null | sed 's/"/\\"/g')

text="$icon  $play_icon $artist - $title"

# Limita o texto a 20 caracteres
max_length=20
if [ ${#text} -gt $max_length ]; then
    text="${text:0:$((max_length - 3))}..."
fi

# Exibe JSON
echo "{\"text\": \"$text\", \"tooltip\": \"$artist - $title\"}"
