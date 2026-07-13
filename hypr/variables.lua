local scheme = require("scheme.current")

local mainMod  = "ALT"
local mainModL = "ALT_L"

return {
    ------------------
    ---- HYPRLAND ----
    ------------------
    mainMod                    = mainMod,
    mainModL                   = mainModL,
    -- Apps
    terminal                   = "foot",
    browser                    = "brave --password-store=basic",
    editor                     = "codium",
    fileExplorer               = "thunar",
    audioSettings              = "pavucontrol",
    -- Touchpad
    touchpadDisableTyping      = true,
    touchpadScrollFactor       = 0.3,
    gestureFingers              = 3,
    workspaceSwipeFingers      = 4,
    gestureFingersMore         = 4,
    -- Blur
    blurEnabled                = true,
    blurSpecialWs              = false,
    blurPopups                 = true,
    blurInputMethods           = true,
    blurSize                   = 8,
    blurPasses                 = 2,
    blurXray                   = false,
    -- Shadow
    shadowEnabled               = true,
    shadowRange                = 15,
    shadowRenderPower          = 4,
    shadowColour               = "rgba(" .. scheme.inversePrimary .. "10)",
    -- Gaps
    workspaceGaps              = 20,
    windowGapsIn               = 5,
    windowGapsOut              = 10,
    singleWindowGapsOut        = 20,
    -- Window styling
    windowOpacity               = 0.95,
    windowRounding             = 15,
    windowBorderSize           = 1,
    activeWindowBorderColour   = "rgba(" .. scheme.primary .. "e6)",
    inactiveWindowBorderColour = "rgba(" .. scheme.onSurfaceVariant .. "11)",
    -- Misc
    volumeStep                 = 10,
    volumeMax                  = 100,
    cursorTheme                = "sweet-cursors",
    cursorSize                 = 24,
    sleepGestureCmd            = "systemctl suspend-then-hibernate",
    ------------------
    ---- KEYBINDS ----
    ------------------
    -- Workspaces
    kbMoveWinToWs               = "CTRL + " .. mainMod,
    -- kbMoveWinToWsGroup: omitted — you disabled workspace groups
    kbGoToWs                    = mainMod,
    -- kbGoToWsGroup: omitted — you disabled workspace groups
    kbNextWs                    = "CTRL + " .. mainMod .. " + Right",
    kbPrevWs                    = "CTRL + " .. mainMod .. " + Left",
    -- Window Group: omitted — you disabled all of these
    -- kbWindowGroupCycleNext, kbWindowGroupCyclePrev, kbUngroup, kbToggleGroup
    -- Window Action
    kbMoveWindow                = mainMod .. " + Z",
    kbResizeWindow              = mainMod .. " + X",
    kbWindowPip                 = "SUPER + ALT + backslash",   -- unchanged in your diff
    kbPinWindow                 = mainMod .. " + P",
    kbWindowFullscreen          = mainMod .. " + F",
    kbWindowBorderedFullscreen  = "SUPER + ALT + F",           -- unchanged in your diff
    kbToggleWindowFloating      = "SUPER + ALT + space",        -- unchanged in your diff
    kbCloseWindow                = mainMod .. " + Q",
    -- Special workspaces toggles
    kbSpecialWs                 = mainMod .. " + S",
    kbSystemMonitorWs           = "CTRL + SHIFT + Escape",     -- unchanged
    kbMusicWs                   = mainMod .. " + M",
    kbCommunicationWs           = mainMod .. " + D",
    kbTodoWs                    = mainMod .. " + R",
    -- Apps
    kbTerminal                  = mainMod .. " + Return",       -- key changed T -> Return
    kbBrowser                    = mainMod .. " + B",            -- key changed W -> B
    kbEditor                     = mainMod .. " + C",
    kbFileExplorer               = mainMod .. " + E",
    -- Misc
    kbSession                    = "CTRL + ALT + Delete",       -- unchanged
    kbShowSidebar                = mainMod .. " + N",
    kbClearNotifs                = "CTRL + ALT + C",            -- unchanged
    kbShowPanels                 = mainMod .. " + K",
    kbLock                        = mainMod .. " + L",
    kbRestoreLock                 = "SUPER + ALT + L",           -- unchanged
}
