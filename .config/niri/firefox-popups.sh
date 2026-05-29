#!/usr/bin/env bash

# Ждем, пока niri полностью загрузится
sleep 2

# Бесконечный цикл, который читает события от niri
niri msg -j event-stream | jq --unbuffered -r '
  .
  | select(has("WindowOpenedOrChanged"))
  | .["WindowOpenedOrChanged"].window
  | select(.title? and (.title | test("Extension:.*Mozilla Firefox|Bitwarden")) and .is_floating == false)
  | .id' | while read -r id; do

    # Даем Firefox немного времени, чтобы закончить создание окна
    sleep 0.1

    # Делаем окно плавающим
    niri msg action toggle-window-floating --id="$id"

    # Немного ждем для стабильности
    sleep 0.05

    # Устанавливаем размер (ширина 25%, высота 60%)
    niri msg action set-window-width 25% --id="$id"
    niri msg action set-window-height 60% --id="$id"

    # И центрируем его на экране
    niri msg action center-window --id="$id"
done
