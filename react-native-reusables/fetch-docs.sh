#!/usr/bin/env bash

url=https://github.com/mrzachnugent/react-native-reusables/tree/main/apps/docs/src/content/docs

uvx gitingest $url -s 100000000 -i '*.md, *.mdx' -o docs.txt

../split_docs.sh docs.txt
