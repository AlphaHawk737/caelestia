#!/usr/bin/env python3
"""
update-fuzzel-colors.py
Reads ~/.local/state/caelestia/scheme.json (Material Design 3 tokens)
and writes matching colors into ~/.config/fuzzel/fuzzel.ini.
Run once manually, or let the systemd watcher call it automatically.
"""

import json
import sys
from pathlib import Path

SCHEME_FILE = Path.home() / ".local/state/caelestia/scheme.json"
FUZZEL_CONF = Path.home() / ".config/fuzzel/fuzzel.ini"

# Material You token → fuzzel color role
# All values appended with "ff" (fully opaque) for fuzzel's RRGGBBAA format
MAPPING = {
    "background":       "background",       # window background
    "onSurface":        "text",             # normal text
    "primary":          "match",            # characters that match the query
    "surfaceVariant":   "selection",        # selected item background
    "onSurface":        "selection-text",   # selected item text
    "primary":          "selection-match",  # matching chars in selected item
    "outline":          "border",           # window border
}

def load_scheme() -> dict:
    if not SCHEME_FILE.exists():
        print(f"Error: scheme file not found at {SCHEME_FILE}", file=sys.stderr)
        print("Make sure Caelestia has run at least once.", file=sys.stderr)
        sys.exit(1)
    with open(SCHEME_FILE) as f:
        return json.load(f)

def hex_alpha(hex_color: str) -> str:
    """Strip any existing # and append ff for full opacity."""
    return hex_color.lstrip("#") + "ff"

def parse_fuzzel_ini(path: Path) -> list[str]:
    """Read existing fuzzel.ini lines, preserving everything outside [colors]."""
    if not path.exists():
        return []
    return path.read_text().splitlines()

def write_fuzzel_ini(scheme: dict):
    FUZZEL_CONF.parent.mkdir(parents=True, exist_ok=True)
    existing = parse_fuzzel_ini(FUZZEL_CONF)

    # Build the new [colors] block
    colors_block = ["[colors]"]

    # Map each fuzzel role to its Material You token
    token_to_fuzzel = {
        "background":    ("background",      "1a1a2eff"),  # fallback dark bg
        "onSurface":     ("text",            "e0e0f0ff"),
        "primary":       ("match",           "89b4faff"),
        "surfaceVariant":("selection",       "313244ff"),
        "onSurface":     ("selection-text",  "e0e0f0ff"),  # same token, reused
        "outline":       ("border",          "585b70ff"),
    }

    # We need to handle duplicate token keys properly
    roles = [
        ("background",     "background",     "1a1a2eff"),
        ("onSurface",      "text",           "e0e0f0ff"),
        ("primary",        "match",          "89b4faff"),
        ("surfaceVariant", "selection",      "313244ff"),
        ("onSurface",      "selection-text", "e0e0f0ff"),
        ("primary",        "selection-match","89b4faff"),
        ("outline",        "border",         "585b70ff"),
    ]

    for token, fuzzel_key, fallback in roles:
        value = scheme.get(token, fallback.rstrip("ff"))
        colors_block.append(f"{fuzzel_key}={hex_alpha(value)}")

    # Rebuild the file: keep all sections except [colors], then append new one
    output_lines = []
    skip = False
    for line in existing:
        stripped = line.strip()
        if stripped.startswith("[") and stripped.endswith("]"):
            skip = (stripped == "[colors]")
        if not skip:
            output_lines.append(line)

    # Strip trailing blank lines before appending
    while output_lines and output_lines[-1].strip() == "":
        output_lines.pop()

    if output_lines:
        output_lines.append("")  # blank line separator

    output_lines.extend(colors_block)
    output_lines.append("")  # trailing newline

    FUZZEL_CONF.write_text("\n".join(output_lines))
    print(f"Updated {FUZZEL_CONF} with current Caelestia scheme.")

if __name__ == "__main__":
    scheme = load_scheme()
    write_fuzzel_ini(scheme)
