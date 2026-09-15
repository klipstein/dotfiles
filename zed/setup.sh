#! /usr/bin/env sh

DIR=$(dirname "$0")
cd "$DIR"

. ../scripts/functions.sh

SOURCE="$(realpath -m .)"
DESTINATION="$(realpath -m ~/.config/zed)"

info "Setting up Zed..."

substep_info "Creating Zed config folder..."
mkdir -p "$DESTINATION"

substep_info "Linking keymap..."
symlink "$SOURCE/keymap.json" "$DESTINATION/keymap.json"

substep_info "Generating settings.json from template..."
LLMGW_URL=""
if [ -f "$HOME/.secrets" ]; then
    LLMGW_URL=$(grep "^LLMGW_API_URL=" "$HOME/.secrets" | cut -d'=' -f2-)
fi
if [ -z "$LLMGW_URL" ]; then
    LLMGW_URL="https://api.openai.com/v1"
fi

rm -f "$DESTINATION/settings.json"
sed "s|__LLMGW_API_URL__|$LLMGW_URL|g" "$SOURCE/settings.json" > "$DESTINATION/settings.json"
substep_success "Generated $DESTINATION/settings.json with private substitutions."
clear_broken_symlinks "$DESTINATION"

success "Finished setting up Zed."
