#!/usr/bin/env bash

url=https://github.com/reactjs/react.dev/tree/main/src/content

uvx gitingest $url -s 100000000 -i '*.md, *.mdx' -o docs.txt

../split_docs.sh docs.txt
