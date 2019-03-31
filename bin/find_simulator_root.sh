#!/bin/bash

if ! which -s jq; then
	echo "Missing jq command" >&2
	exit 1
fi

root=$(xcrun simctl list runtimes --json 2> /dev/null | jq -r '.runtimes[] | select(.name | test("^iOS ")) | select(.version == "'$(xcrun --sdk iphonesimulator --show-sdk-version)'") | .bundlePath' 2>/dev/null)
if [ -z "$root" ]; then
	xcrun --sdk iphonesimulator --show-sdk-path
else
	echo "$root/Contents/Resources/RuntimeRoot"
fi
