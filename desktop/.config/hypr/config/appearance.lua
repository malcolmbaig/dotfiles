hl.monitor({
    output = "Unknown-2",
    mode = "3440x1440@179.99",
    position = "auto",
    scale = 1,
})

hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 12,
        border_size = 2,
        col = {
            active_border = { colors = { "rgba(33ccffff)", "rgba(8aadf4ff)" }, angle = 45 },
            inactive_border = "rgba(5b6078ff)",
        },
        resize_on_border = false,
        layout = "dwindle",
    },
    decoration = {
        rounding = 8,
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        shadow = {
            enabled = true,
            range = 12,
            render_power = 3,
            color = 0xaa000000,
        },
        blur = {
            enabled = true,
            size = 3,
            passes = 1,
            vibrancy = 0.12,
        },
    },
    animations = { enabled = true },
    dwindle = { preserve_split = true },
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
    },
})

hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.animation({ leaf = "global", enabled = true, speed = 8, bezier = "default" })
hl.animation({ leaf = "windows", enabled = true, speed = 4, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "popin 88%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3, bezier = "easeInOutCubic", style = "popin 88%" })
hl.animation({ leaf = "fade", enabled = true, speed = 4, bezier = "easeInOutCubic" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 4, bezier = "easeOutQuint" })
