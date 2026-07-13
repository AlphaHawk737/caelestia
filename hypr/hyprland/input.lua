local vars = require("variables")
hl.config({
    input = {
        kb_layout          = "us",
        numlock_by_default = false,
        repeat_delay       = 250,
        repeat_rate        = 35,
        focus_on_close     = 1,
        sensitivity        = vars.pointerSensitivity,
        touchpad           = {
            natural_scroll       = true,
            disable_while_typing = vars.touchpadDisableTyping,
            scroll_factor        = vars.touchpadScrollFactor,
        },
    },
    binds = {
        scroll_event_delay = 0,
    },
    cursor = {
        hotspot_padding = 1,
    },
})

-- Per-device override for external touchpad
hl.device({
    name        = "asue120b:00-04f3:31c0-touchpad",
    sensitivity = 0.3,
})
