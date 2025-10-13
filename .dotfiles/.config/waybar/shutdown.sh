#!/usr/bin/env bash

res=$(notify-send "Shutdown now?" --action="yes=Yes" --action="no=No" --wait)

case "$res" in
  "yes")
    shutdown now;;
  *)
    ;;
esac
