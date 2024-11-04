#!/bin/bash

SEARCH_QUERY=$(echo "$*" | tr ' ' '+')

URL="https://arxiv.org/search/?query=$SEARCH_QUERY&searchtype=all"

curl -s "$URL" |
	tr -d '\n' |  
	tr ' ' '\n' | 
	grep -oP 'arXiv:[^<&?]+' |
	tr -d 'arXiv:' |
	sort -u
