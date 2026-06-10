-- hyprland.lua
-- Translated from hyprlang config to Hyprland 0.55+ Lua syntax
-- https://wiki.hypr.land/Configuring/Start/

---------------------
---- MY PROGRAMS ----
---------------------

local mainMod    = "SUPER"
local terminal   = "ghostty"
local fileManager = "thunar"
local menu       = "qs -c noctalia-shell ipc call launcher toggle"

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("QT_QPA_PLATFORMTHEME=gtk3 QT_WAYLAND_FORCE_ARGB=1 qs -c noctalia-shell")
    hl.exec_cmd("valent --gapplication-service")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("QT_QPA_PLATFORMTHEME",      "qt5ct")
hl.env("QT_STYLE_OVERRIDE",         "kvantum")
hl.env("XCURSOR_THEME",             "Bibata-Modern-Ice")
hl.env("XCURSOR_SIZE",              "24")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("WLR_NO_HARDWARE_CURSORS",   "1")
hl.env("AQ_NO_MODIFIERS",           "1")
hl.env("MOZ_ENABLE_WAYLAND",        "1")
hl.env("QT_QPA_PLATFORM",           "wayland;xcb")

------------------
---- MONITORS ----
------------------

hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = 1,
})

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    cursor = {
        no_hardware_cursors = true,
        enable_hyprcursor   = false,
    },

    general = {
        gaps_in      = 5,
        gaps_out     = 10,
        border_size  = 2,
        allow_tearing = false,
        layout       = "master",
        col = {
            active_border   = "rgb(58a6ff)",
            inactive_border = "rgb(30363d)",
        },
    },

    decoration = {
        rounding          = 2,
        active_opacity   = 0.95,
        inactive_opacity = 0.90,
        fullscreen_opacity = 1.0,
        blur = {
            enabled           = true,
            size              = 4,
            passes            = 5,
            noise             = 0.01,
            contrast          = 0.9,
            brightness        = 0.8,
            new_optimizations = true,
        },
    },

    master = {
        new_on_top  = false,
        orientation = "left",
        mfact       = 0.5,
    },

    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo   = false,
    },

    input = {
        follow_mouse = 1,
        sensitivity  = 0,
    },
})

----------------------
---- ANIMATIONS ----
----------------------

hl.curve("snappy", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1 } } })

hl.animation({ leaf = "global",      enabled = true,  speed = 1,  bezier = "default"  })
hl.animation({ leaf = "windows",     enabled = true,  speed = 1,  bezier = "snappy",  style = "slide" })
hl.animation({ leaf = "windowsOut",  enabled = true,  speed = 1,  bezier = "snappy",  style = "slide" })
hl.animation({ leaf = "border",      enabled = false })
hl.animation({ leaf = "borderangle", enabled = false })
hl.animation({ leaf = "fade",        enabled = true,  speed = 1,  bezier = "snappy" })
hl.animation({ leaf = "fadeOut",     enabled = true,  speed = 1,  bezier = "snappy" })
hl.animation({ leaf = "workspaces",  enabled = true,  speed = 1,  bezier = "snappy" })
hl.animation({ leaf = "layers",      enabled = true,  speed = 1,  bezier = "snappy",  style = "slide" })
hl.animation({ leaf = "layersOut",   enabled = true,  speed = 1,  bezier = "snappy",  style = "slide" })

---------------------
---- KEYBINDINGS ----
---------------------

-- Window management
hl.bind(mainMod .. " + Q",           hl.dsp.window.close())
hl.bind(mainMod .. " + C",           hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Return",      hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E",           hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + T",           hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + V",           hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R",           hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + W",           hl.dsp.exec_cmd("qs -c noctalia-shell ipc call wallpaper toggle"))
hl.bind(mainMod .. " + F",           hl.dsp.exec_cmd("sh -c 'brave-origin &'"))

-- Layout switching
hl.bind(mainMod .. " + L",           hl.dsp.layout("master"))
hl.bind(mainMod .. " + SHIFT + L",   hl.dsp.layout("dwindle"))

-- Exit / shutdown
hl.bind(mainMod .. " + M",           hl.dsp.exec_cmd(
    "command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit"
))

-- Screenshot
hl.bind("Print",                     hl.dsp.exec_cmd("QT_QPA_PLATFORM=wayland flameshot gui"))
hl.bind(mainMod .. " + SHIFT + S",   hl.dsp.exec_cmd("QT_QPA_PLATFORM=wayland flameshot gui"))

-- Victus fan control
hl.bind(mainMod .. " + O",           hl.dsp.exec_cmd("~/.local/bin/victus-fan.sh max"))
hl.bind(mainMod .. " + SHIFT + O",   hl.dsp.exec_cmd("~/.local/bin/victus-fan.sh auto"))

-- Workspace switching (normal + locked for game input grab bypass)
for i = 1, 9 do
    hl.bind(mainMod .. " + " .. i,               hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + " .. i,               hl.dsp.focus({ workspace = i }), { locked = true })
    hl.bind(mainMod .. " + SHIFT + " .. i,       hl.dsp.window.move({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. i,       hl.dsp.window.move({ workspace = i }), { locked = true })
end

-- Mouse bindings
hl.bind(mainMod .. " + mouse:272",   hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273",   hl.dsp.window.resize(), { mouse = true })

-- Volume keys
hl.bind("XF86AudioRaiseVolume",      hl.dsp.exec_cmd("wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",      hl.dsp.exec_cmd("wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute",             hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),        { locked = true })

-- Brightness keys
hl.bind("XF86MonBrightnessUp",       hl.dsp.exec_cmd("brightnessctl set +5%"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",     hl.dsp.exec_cmd("brightnessctl set 5%-"), { locked = true, repeating = true })

-----------------------------
---- WINDOW RULES ----------
-----------------------------

-- Suppress maximize requests globally
hl.window_rule({
    name          = "suppress-maximize-events",
    match         = { class = ".*" },
    suppress_event = "maximize",
})

-- Fix XWayland drag issues
hl.window_rule({
    name       = "fix-xwayland-drags",
    match      = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus   = true,
})

-----------------------------
---- NOCTALIA COLORS --------
-----------------------------

-- Source dynamic color overrides (equivalent of `source = ~/.config/hypr/noctalia/noctalia-colors.conf`)
-- Place color overrides in a separate file and require it:
-- require("noctalia.noctalia-colors")
--
-- If that file sets border colors, move those hl.config() calls there.
-- The active/inactive border colors above already reflect the GitHub Dark overrides
-- from the original config. Remove them here if noctalia-colors.conf manages them. 
