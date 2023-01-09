#!/bin/bash

URL='https://www.google.com/search?q='
QUERY=$(echo '' | dmenu -p "Search:")
if [ -n "$QUERY" ]; then
    #chromium --app="${URL}${QUERY}"
    qutebrowser "${URL}${QUERY}"
fi
