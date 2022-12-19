#!/bin/bash
NOT_TRANSLATED=$(wl-paste)
TRANSLATED=$(trans -brief $NOT_TRANSLATED)
notify-send "$TRANSLATED" "$NOT_TRANSLATED"
