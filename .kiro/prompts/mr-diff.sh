#!/bin/bash
parent=$(git parent 2>/dev/null)
range="${parent:-main}..HEAD"
echo "=== Commits ==="
git log --oneline "$range"
echo -e "\n=== Diff ==="
git diff "$range"
