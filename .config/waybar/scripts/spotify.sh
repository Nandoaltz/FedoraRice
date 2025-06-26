#!/bin/bash
sleep 0.1

# Captura o nome do player ativo
player=$(playerctl metadata --format '{{playerName}}' 2>/dev/null)

# Se não houver player ativo ou for o Spotify, sair
if [ -z "$player" ] || [ "$player" = "spotify" ]; then
    exit 0
fi

# Define o ícone baseado no player (pode adicionar mais condições se quiser)
case "$player" in
    "firefox"|"chromium"|"google-chrome"|"brave") 
        icon=""  # Ícone de navegador
        ;;
    *) 
        icon=""  # Ícone genérico de música (para outros players)
        ;;
esac

# Verifica o status (Playing/Paused)
status=$(playerctl status 2>/dev/null)

if [ "$status" = "Playing" ]; then
    play_icon=""
elif [ "$status" = "Paused" ]; then
    play_icon=""
else
    exit 0
fi

# Pega título e artista
title=$(playerctl metadata title 2>/dev/null | sed 's/"/\\"/g')
artist=$(playerctl metadata artist 2>/dev/null | sed 's/"/\\"/g')

text="$icon  $play_icon $artist - $title"

# Limitar o texto a 20 caracteres
max_length=20
if [ ${#text} -gt $max_length ]; then
    text="${text:0:$((max_length - 3))}..."
fi

echo "{\"text\": \"$text\", \"tooltip\": \"$artist - $title\"}"
