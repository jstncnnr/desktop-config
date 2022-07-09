#!/bin/sh

id="${1?}"
instance="$3"
class="$2"
windowName=$(xprop -id $id | grep '^WM_NAME' | sed -r 's/^WM_NAME.*"(.*)"$/\1/')

case $class in
    "jetbrains-rider"|"jetbrains-idea-ce")
        case $windowName in
            "splash"|"Welcome to "*) echo "state=floating";;
            *) echo "";;
        esac
    ;;
esac;