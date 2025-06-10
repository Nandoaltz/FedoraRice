#!/bin/bash

status=$(playerctl status 2>/dev/null)

if [ "$status" = "Playing" ]; then
    icon="  "
elif [ "$status" = "Paused" ]; then
    icon="  "
else
    exit 0  # Não mostra nada se estiver parado
fi

title=$(playerctl metadata title 2>/dev/null)
artist=$(playerctl metadata artist 2>/dev/null)

text="$icon $artist - $title"

# Limitar a 40 caracteres e adicionar "..." se passar disso
max_length=15
if [ ${#text} -gt $max_length ]; then
    text="${text:0:$((max_length - 3))}..."
fi

echo "{\"text\": \"$text\", \"tooltip\": \"$artist - $title\"}"
