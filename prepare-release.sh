#!/bin/sh
set -eu

cd "$(dirname "$0")"
name=hpi-math-homework
version=0.1.0
work=$(mktemp -d)
package_dir="$work/preview/$name"
release="$package_dir/$version"

mkdir -p "$release"
cp -R typst.toml lib.typ homework.typ template README.md LICENSE LICENSE-MIT-0.md "$release/"

typst init --package-path "$work" "@preview/$name:$version" "$work/sheet"
main="$work/sheet/main.typ"
typst compile --package-path "$work" "$main" "$release/template.pdf"
typst compile --package-path "$work" --pages 1 --ppi 250 "$main" "$release/thumbnail.png"

cp "$release/template.pdf" "$release/thumbnail.png" .
printf 'Folder to upload: %s\n' "$package_dir"
