#!/usr/bin/env bash
# One-time setup: pre-create the assignment:<name> labels this repo's
# "click to sign up" links rely on (GitHub only applies labels via the
# issues/new?labels= URL param if the label already exists).
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO="it-ptitsa-mentor/assignment-signup"

while read -r name; do
  gh label create "assignment:$name" --repo "$REPO" --color BFD4F2 --force
done < "$DIR/assignments.txt"
