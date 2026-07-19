#!/usr/bin/env bash
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

out=$("$DIR/validate.sh" "React-Counter" "octocat")
[ "$out" = "React-Counter-octocat" ] || { echo "FAIL: valid input"; exit 1; }

if "$DIR/validate.sh" "some-private-repo" "octocat" >/dev/null 2>&1; then
  echo "FAIL: unknown assignment should be rejected"; exit 1
fi

if "$DIR/validate.sh" "React-Counter" '$(rm -rf /)' >/dev/null 2>&1; then
  echo "FAIL: malicious username should be rejected"; exit 1
fi

echo "OK"
