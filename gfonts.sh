#!/bin/sh

base='https://fonts\.(gstatic\.com|kavin\.rocks)'
fonts=$(cat /app/Piped/dist/assets/* | grep -Po "$base[^)]*" | sort | uniq)
for font in $fonts; do
	file="/app/Piped/dist/fonts$(echo $font | sed -E "s#$base##")"
	mkdir -p "$(dirname "$file")"
	curl -L "$font" -o "$file"
done
sed -Ei "s#$base#/fonts#g" /app/Piped/dist/assets/*
