#!/bin/bash
# folder-switch.sh — switches Caelestia's wallpaperDir to a subfolder (or All)
# Usage: folder-switch.sh <foldername>   (use "All" to restore full directory)

WALL_BASE="$HOME/Pictures/Wallpapers"
CONFIG="$HOME/.config/caelestia/shell.json"
FOLDER="${1:-All}"

if [ "$FOLDER" = "All" ]; then
    TARGET="~/Pictures/Wallpapers"
else
    if [ ! -d "$WALL_BASE/$FOLDER" ]; then
        echo "Error: folder '$WALL_BASE/$FOLDER' does not exist." >&2
        exit 1
    fi
    TARGET="~/Pictures/Wallpapers/$FOLDER"
fi

mkdir -p "$(dirname "$CONFIG")"
[ -f "$CONFIG" ] || echo '{}' > "$CONFIG"

python3 << PYEOF
import json, os

config_path = os.path.expanduser("$CONFIG")
target      = "$TARGET"

with open(config_path) as f:
    cfg = json.load(f)

cfg.setdefault("paths", {})["wallpaperDir"] = target

with open(config_path, "w") as f:
    json.dump(cfg, f, indent=4)

print(f"Wallpaper folder → {target}")
PYEOF
