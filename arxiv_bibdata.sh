#!/bin/bash

if [ $# -eq 0 ]; then
    echo " "
    exit 1
fi

for ARXIV_ID in "$@"; do

    URL="https://arxiv.org/abs/$ARXIV_ID"
    
    echo "---"
    curl -s "$URL" |
        grep -oP '<meta name="citation_[^"]+" content="[^"]*"' |
        sed -E 's/<meta name="([^"]+)" content="([^"]*)"/\1="\2"/' |
        while read -r LINE; do

            if [[ "$LINE" =~ citation_title=.* ]]; then
                echo "${LINE/citation_/}"
            elif [[ "$LINE" =~ citation_author=.* ]]; then
                echo "${LINE/citation_/}"
            elif [[ "$LINE" =~ citation_date=.* ]]; then
                echo "${LINE/citation_/}"
            elif [[ "$LINE" =~ citation_online_date=.* ]]; then
                echo "${LINE/citation_/}"
            elif [[ "$LINE" =~ citation_pdf_url=.* ]]; then
                echo "${LINE/citation_/}"
            fi
        done

    echo "arxiv_id=\"$ARXIV_ID\""
done
