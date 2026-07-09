#!/usr/bin/env fish
# ~/.config/hypr/scripts/music-picker.fish

# ── 1. Toggle if already running ────────────────────────────────────
set cnt (hyprctl clients -j | python3 -c \
    "import sys,json;print(sum(1 for c in json.load(sys.stdin) if c.get('workspace',{}).get('name')=='special:music'))")
if test "$cnt" -gt 0
    hyprctl dispatch togglespecialworkspace music; exit 0
end

# ── 2. Generate themed config (pure Python, zero escape issues) ──────
python3 ~/.config/hypr/scripts/gen-music-config.py

# ── 3. Discover installed music services ─────────────────────────────
set -l names; set -l cmds; set -l icons

if command -q spotify
    set -a names "Spotify";         set -a cmds "app2unit -- spotify";                                                      set -a icons "spotify"
else if command -q spicetify
    set -a names "Spotify";         set -a cmds "spicetify watch -s";                                                       set -a icons "spotify"
end
if command -q brave
    set -a names "YouTube Music";   set -a cmds "app2unit -- brave --password-store=basic --app=https://music.youtube.com"; set -a icons "youtube-music"
end
if command -q tidal-hifi
    set -a names "Tidal HiFi";      set -a cmds "app2unit -- tidal-hifi";                                                   set -a icons "tidal-hifi"
end
if command -q cider
    set -a names "Apple Music";     set -a cmds "app2unit -- cider";                                                        set -a icons "cider"
end
if command -q feishin
    set -a names "Feishin";         set -a cmds "app2unit -- feishin";                                                      set -a icons "feishin"
end
if command -q plexamp
    set -a names "Plexamp";         set -a cmds "app2unit -- plexamp";                                                      set -a icons "plexamp"
end
if command -q youtube-music
    set -a names "YT Music Desktop";set -a cmds "app2unit -- youtube-music";                                                set -a icons "com.github.th_ch.youtube_music"
end
if command -q supersonic
    set -a names "Supersonic";      set -a cmds "app2unit -- supersonic";                                                   set -a icons "io.github.dweymouth.supersonic"
end

if test (count $names) -eq 0
    notify-send -a "Music" -i audio-headphones-symbolic "No music services found"; exit 1
end

# ── 4. Show picker ────────────────────────────────────────────────────
if test (count $names) -eq 1
    set choice $names[1]
else
    set choice (
        for i in (seq (count $names))
            printf "%s\000icon\x1f%s\n" $names[$i] $icons[$i]
        end | fuzzel --config=$HOME/.config/fuzzel/fuzzel-music.ini --dmenu --lines=(count $names)
    )
end

test -z "$choice"; and exit 0

# ── 5. Launch and reveal workspace ────────────────────────────────────
for i in (seq (count $names))
    if test "$names[$i]" = "$choice"
        eval $cmds[$i] &; disown
        begin
            for _ in (seq 40)
                sleep 0.25
                set n (hyprctl clients -j | python3 -c \
                    "import sys,json;print(sum(1 for c in json.load(sys.stdin) if c.get('workspace',{}).get('name')=='special:music'))")
                if test "$n" -gt 0
                    hyprctl dispatch togglespecialworkspace music; break
                end
            end
        end &; disown
        break
    end
end
