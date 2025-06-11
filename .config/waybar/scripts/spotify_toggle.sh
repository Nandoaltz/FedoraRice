#!/bin/bash

# Verifica se o Spotify está em execução
if ! playerctl --player=spotify status &>/dev/null; then
    exit 0
fi

# Alterna play/pause do Spotify diretamente
playerctl --player=spotify play-pause
