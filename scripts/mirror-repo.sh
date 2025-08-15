#!/bin/bash

# This script mirrors course GitHub repositories to a new repository under a specified GitHub username.
# Make sure you have already created the destination repositories on GitHub before running this script.
# Make sure you have the necessary permissions to push to the destination repository.
# Ensure you have SSH access set up for GitHub and that your public SSH key is added to your GitHub account.

# NOTE: There is no checks before it echoes the messages.

# ENTER YOUR GIT USERNAME
GIT_USERNAME="XXX"

# source repositories
course_repo_list=(
    "ict381/automation"
)

# Enter a directory path where you want to clone the repositories
# Example: DEST_DIR="/home/ubuntu/"
DEST_DIR=$HOME

if [ ! -d "$DEST_DIR" ]; then
    echo "Creating destination directory: $DEST_DIR"
    mkdir -p "$DEST_DIR"
else
    echo "Destination directory already exists: $DEST_DIR"
fi

for repo in "${course_repo_list[@]}"; do
    # extract the repository owner and name
    repo_owner=$(cut -d'/' -f1 <<< "$repo")
    repo_name=$(cut -d'/' -f2 <<< "$repo")

    # construct the full source repository URL
    src_repo="git@github.com:${repo}.git"
    dest_repo="git@github.com:${GIT_USERNAME}/${repo_name}.git"

    echo "Mirroring repository: $src_repo to $dest_repo"

    git clone --bare "$src_repo"
    cd  "${repo_name}.git"

    # Push to destination repository
    git push --mirror "$dest_repo"

    cd ../

    # Cleanup
    rm -rf "${repo_name}.git"

    echo "Finished mirroring $repo_name"
    echo "Cloning your repository to local machine..."
    cd $DEST_DIR
    git clone "$dest_repo"
    echo "Your repository is now cloned to your local machine."
    echo "-----------------------------------"
done