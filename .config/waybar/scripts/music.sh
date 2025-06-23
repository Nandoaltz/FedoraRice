#!/bin/bash

sleep 0.1
# Verifica se o Spotify está em execução
if ! playerctl --player=spotify status &>/dev/null; then
    exit 0
fi
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
#!/bin/bash
sleep 0.1
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
    icon=""  # Ícone para navegador
fi

status=$(playerctl status 2>/dev/null)

if [ "$status" = "Playing" ]; then
    play_icon=""
elif [ "$status" = "Paused" ]; then
    play_icon=""
else
    exit 0
fi

title=$(playerctl metadata title 2>/dev/null | sed 's/"/\\"/g')
artist=$(playerctl metadata artist 2>/dev/null | sed 's/"/\\"/g')

text="$icon  $play_icon $artist - $title"

# Limitar o texto a 20 caracteres
max_length=20
if [ ${#text} -gt $max_length ]; then
    text="${text:0:$((max_length - 3))}..."
fi

echo "{\"text\": \"$text\", \"tooltip\": \"$artist - $title\"}"

icon=""
text="$icon  $play_icon $artist - $title"

# Limita o texto
max_length=20
if [ ${#text} -gt $max_length ]; then
    text="${text:0:$((max_length - 3))}"
fi

echo "{\"text\": \"$text\", \"tooltip\": \"$artist - $title\"}"
