#!/usr/bin/env bash

swift build --configuration release
cp -f .build/release/tracker /usr/local/bin/tracker
