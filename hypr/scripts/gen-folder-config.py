#!/usr/bin/env python3
# ~/.config/hypr/scripts/gen-music-config.py

import os, re

home = os.environ['HOME']
colors = {}
with open(home + '/.config/hypr/scheme/current.conf') as f:
    for line in f:
        m = re.match(r'^\$(\w+) = ([0-9a-fA-F]+)', line)
        if m:
            colors[m.group(1)] = m.group(2)

bg  = colors.get('background',   '131317')
fg  = colors.get('onBackground', 'e5e1e7')
pri = colors.get('primary',      'c2c1ff')
out = colors.get('outline',      '918f9a')
sur = colors.get('onSurface',    'e5e1e7')
acc = colors.get('tertiary',     'f5b2e0')

config = (
    '[main]\n'
    'font=JetBrains Mono NF:size=13\n'
    'prompt=> "\n'
    'layer=overlay\n'
    'lines=8\n'
    'width=35\n'
    'dpi-aware=no\n'
    'inner-pad=10\n'
    'horizontal-pad=40\n'
    'vertical-pad=15\n'
    'match-counter=yes\n'
    'icons-enabled=yes\n'
    '\n'
    '[colors]\n'
    'background=' + bg + 'dd\n'
    'text=' + fg + 'dd\n'
    'prompt=' + pri + 'ff\n'
    'placeholder=' + out + 'ff\n'
    'input=' + sur + 'ff\n'
    'match=' + acc + 'ff\n'
    'selection=' + pri + '40\n'
    'selection-text=' + sur + 'ff\n'
    'selection-match=' + acc + 'ff\n'
    'counter=' + out + 'ff\n'
    'border=' + pri + '77\n'
    '\n'
    '[border]\n'
    'radius=10\n'
    'width=2\n'
)

with open(home + '/.config/fuzzel/fuzzel-folder.ini', 'w') as f:
    f.write(config)
