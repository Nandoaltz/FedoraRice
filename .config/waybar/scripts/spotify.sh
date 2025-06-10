#!/bin/bash

# Captura o nome do player ativo
player=$(playerctl metadata --format '{{playerName}}' 2>/dev/null)

# Se não houver player ativo, sair
if [ -z "$player" ]; then
    exit 0
fi

# Verifica se o player é o Spotify
if [ "$player" = "spotify" ]; then
    icon=""  # Ícone do Spotify
else
    icon=""  # Ícone genérico para navegador (você pode adaptar)
fi

status=$(playerctl status 2>/dev/null)

if [ "$status" = "Playing" ]; then
    play_icon=""
elif [ "$status" = "Paused" ]; then
    play_icon=""
else
    exit 0
fi

title=$(playerctl metadata title 2>/dev/null)
artist=$(playerctl metadata artist 2>/dev/null)

text="$icon  $play_icon $artist - $title"

# Limitar o texto a 40 caracteres
max_length=20
if [ ${#text} -gt $max_length ]; then
    text="${text:0:$((max_length - 3))}..."
fi

echo "{\"text\": \"$text\", \"tooltip\": \"$artist - $title\"}"
