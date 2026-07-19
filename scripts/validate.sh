#!/usr/bin/env bash
# Allowlist check for issue-triggered repo creation.
# ASSIGNMENT comes from a label on the issue, which anyone can forge by
# editing the query string of the "click to sign up" link — that's the
# actual security boundary, not just input hygiene. USERNAME is the
# authenticated issue author (github.event.issue.user.login), not
# attacker-controlled, but validated anyway as cheap defense-in-depth.
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

ASSIGNMENT="$1"
USERNAME="$2"

if ! grep -qxF "$ASSIGNMENT" "$DIR/assignments.txt"; then
  echo "Unknown assignment: $ASSIGNMENT" >&2
  exit 1
fi

if ! [[ "$USERNAME" =~ ^[A-Za-z0-9-]{1,39}$ ]]; then
  echo "Invalid GitHub username: $USERNAME" >&2
  exit 1
fi

echo "${ASSIGNMENT}-${USERNAME}"
