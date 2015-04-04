#!/bin/bash
docker run --rm -v "$PWD:/src" grahamc/jekyll build . $@
