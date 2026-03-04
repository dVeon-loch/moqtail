#!/bin/bash
set -e

LATEST=$(git tag --list "moqtail-v*.*.*" | sort -V | tail -1)

if [ -z "$LATEST" ]; then
    NEXT="moqtail-v0.0.1"
else
    VERSION="${LATEST#moqtail-v}"
    MAJOR=$(echo "$VERSION" | cut -d. -f1)
    MINOR=$(echo "$VERSION" | cut -d. -f2)
    PATCH=$(echo "$VERSION" | cut -d. -f3)
    NEXT="moqtail-v${MAJOR}.${MINOR}.$((PATCH + 1))"
fi

echo "Latest tag: ${LATEST:-none}"
echo "Next tag:   $NEXT"
echo ""
read -rp "Create and push $NEXT? [y/N] " response

if [[ "$response" =~ ^[Yy]$ ]]; then
    git tag "$NEXT"
    git push origin "$NEXT"
    echo "Tagged and pushed $NEXT."
else
    echo "Aborted."
fi
