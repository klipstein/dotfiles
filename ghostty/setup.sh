#! /usr/bin/env sh

DIR=$(dirname "$0")
cd "$DIR"

. ../scripts/functions.sh

SOURCE="$(pwd -P)"
DESTINATION="$HOME/.config/ghostty"

info "Setting up Ghostty..."

substep_info "Creating Ghostty config folder..."
mkdir -p "$DESTINATION"

find * -not -name "$(basename ${0})" -type f | while read fn; do
    symlink "$SOURCE/$fn" "$DESTINATION/$fn"
done
clear_broken_symlinks "$DESTINATION"

success "Finished setting up Ghostty."
