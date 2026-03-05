#!/bin/bash
# Simple script to add, commit, and push files to GitHub

if [ $# -eq 0 ]; then
  echo "Usage: ./git-update.sh <file1> <file2> ... | all"
  exit 1
fi

branch=$(git rev-parse --abbrev-ref HEAD)
if [ "$branch" != "main" ]; then
  echo "You are on $branch, not main. Push aborted."
  exit 1
fi

if [ "$1" == "all" ]; then
  git add .
  echo "Staged all changes"
else
  for file in "$@"; do
    git add "$file"
    echo "Staged $file"
  done
fi

git commit -S -m "[sops] Updated files: $*"
git pull origin main --rebase
git push origin main

