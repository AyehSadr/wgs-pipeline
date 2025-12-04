#!/bin/bash
# Script to push your WGS pipeline to GitHub
# Usage: ./push_to_github.sh YOUR_USERNAME YOUR_REPO_NAME

if [ $# -ne 2 ]; then
    echo "Usage: $0 YOUR_USERNAME YOUR_REPO_NAME"
    echo "Example: $0 johndoe wgs-pipeline"
    exit 1
fi

USERNAME=$1
REPO_NAME=$2

echo "Setting up remote repository..."
git remote add origin https://github.com/${USERNAME}/${REPO_NAME}.git 2>/dev/null || git remote set-url origin https://github.com/${USERNAME}/${REPO_NAME}.git

echo "Pushing to GitHub..."
git branch -M main
git push -u origin main

echo "Done! Your repository is now available at:"
echo "https://github.com/${USERNAME}/${REPO_NAME}"

