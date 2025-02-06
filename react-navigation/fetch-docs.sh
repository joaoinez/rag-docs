#!/usr/bin/env bash

url=https://github.com/react-navigation/react-navigation.github.io/tree/main/versioned_docs/version-7.x

uvx gitingest $url -s 100000000 -i '*.md, *.mdx' -o docs.txt

../split_docs.sh docs.txt
