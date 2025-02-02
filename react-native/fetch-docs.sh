#!/usr/bin/env bash

url=https://github.com/facebook/react-native-website/tree/main/docs

uvx gitingest $url -s 100000000 -i '*.md, *.mdx' -o docs.txt

../split_docs.sh docs.txt
