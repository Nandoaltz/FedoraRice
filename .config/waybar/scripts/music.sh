#!/bin/bash

# Verifica se o Spotify está em execução
if ! playerctl --player=spotify status &>/dev/null; then
    exit 0
fi
sleep 0.1
# Status do player
status=$(playerctl --player=spotify status 2>/dev/null)

# Ícones de play/pause
if [ "$status" = "Playing" ]; then
    play_icon=""
elif [ "$status" = "Paused" ]; then
    play_icon=""
else
    exit 0
fi

# Informações da música
title=$(playerctl --player=spotify metadata title 2>/dev/null)
artist=$(playerctl --player=spotify metadata artist 2>/dev/null)
icon=""
text="$icon  $play_icon $artist - $title"

# Limita o texto
max_length=20
if [ ${#text} -gt $max_length ]; then
    text="${text:0:$((max_length - 3))}"
fi

echo "{\"text\": \"$text\", \"tooltip\": \"$artist - $title\"}"
