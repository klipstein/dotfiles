#! /usr/bin/env bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
cd "$DIR" || exit 1

. ../scripts/functions.sh

COMMENT=\#*
REPO_PATH="$HOME/repos"

find . -name "*.list" | sort | while read -r fn; do
    folder="${fn#./}"
    folder="${folder%.list}"

    info "Cloning $folder repositories..."
    mkdir -p "$REPO_PATH/$folder"

    while read -r repo || [ -n "$repo" ]; do
        if [[ $repo == $COMMENT || -z "$repo" ]]; then
            continue
        fi

        repo_name=$(basename "$repo" .git)
        target_dir="$REPO_PATH/$folder/$repo_name"

        if [ -d "$target_dir/.git" ]; then
            substep_success "$repo already exists at $target_dir."
        else
            substep_info "Cloning $repo into $target_dir..."
            if git clone "$repo" "$target_dir"; then
                substep_success "Cloned $repo."
            else
                substep_error "Failed to clone $repo. Check your SSH keys or network access."
            fi
        fi
    done < "$fn"
    success "Finished cloning $folder repositories."
done
