#!/bin/bash

CONFIG="$HOME/.config/caelestia/shell.json"
HOME_LOCATION="23.0225,72.5714"   # Ahmedabad
HOME_ISP_LOCATION="21.19"         # Surat (ISP resolves here instead)

LOCATION=$(curl -s ipinfo.io/json | python3 -c "
import json, sys
data = json.load(sys.stdin)
print(data.get('loc', ''))
")

if [[ -z "$LOCATION" ]]; then
    echo "Could not detect location, keeping existing config."
    exit 1
fi

# ISP resolves to Surat — use Ahmedabad instead
if [[ "$LOCATION" == ${HOME_ISP_LOCATION}* ]]; then
    echo "Detected Surat (ISP location), using Ahmedabad."
    LOCATION="$HOME_LOCATION"
fi

echo "Setting location: $LOCATION"

python3 - "$CONFIG" "$LOCATION" << 'PYEOF'
import json, sys

config_path = sys.argv[1]
location = sys.argv[2]

with open(config_path, 'r') as f:
    config = json.load(f)

config.setdefault('services', {})['weatherLocation'] = location

with open(config_path, 'w') as f:
    json.dump(config, f, indent=4)

print(f"Updated weatherLocation to: {location}")
PYEOF

sleep 2
caelestia shell -k; caelestia shell -d
