local mod = "SUPER"

-- Launch the core desktop tools.
hl.bind(mod .. " + T", hl.dsp.exec_cmd("ghostty"))
hl.bind(mod .. " + SPACE", hl.dsp.exec_cmd("hyprlauncher"))
hl.bind(mod .. " + E", hl.dsp.exec_cmd("thunar"))
hl.bind(mod .. " + N", hl.dsp.exec_cmd("swaync-client -t -sw"))
hl.bind(mod .. " + V", hl.dsp.exec_cmd("copyq toggle"))
-- Keep Super+L available for focus-right; use Shift for the lock action.
hl.bind(mod .. " + SHIFT + L", hl.dsp.exec_cmd("loginctl lock-session"))
-- Open the graphical session controls without bypassing UWSM on logout.
hl.bind(mod .. " + SHIFT + P", hl.dsp.exec_cmd("$HOME/.local/bin/power-menu"))

-- Save screenshots and copy the PNG itself so CopyQ can retain the image.
local screenshot_dir = "$HOME/Pictures/Screenshots"
local screenshot = "mkdir -p " .. screenshot_dir .. " && grim - | tee " .. screenshot_dir .. "/$(date +%Y-%m-%d_%H-%M-%S).png | wl-copy --type image/png"
local region_screenshot = "mkdir -p " .. screenshot_dir .. " && grim -g \"$(slurp)\" - | tee " .. screenshot_dir .. "/$(date +%Y-%m-%d_%H-%M-%S).png | wl-copy --type image/png"
hl.bind("Print", hl.dsp.exec_cmd(screenshot))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd(region_screenshot))

-- Manage the focused window and tiled layout. Shift+Space keeps floating next to the launcher key.
hl.bind(mod .. " + Q", hl.dsp.window.close())
hl.bind(mod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(mod .. " + SHIFT + SPACE", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + P", hl.dsp.window.pseudo())
hl.bind(mod .. " + J", hl.dsp.layout("togglesplit"))

-- Navigate and rearrange windows with home-row keys.
for key, direction in pairs({ h = "left", j = "down", k = "up", l = "right" }) do
    hl.bind(mod .. " + " .. key, hl.dsp.focus({ direction = direction }))
    hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ direction = direction }))
end

-- Use numbered workspaces and keep the scroll wheel for adjacent workspaces.
for i = 1, 10 do
    local key = i % 10
    hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end
hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move and resize floating windows with the pointer.
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Control PipeWire audio and media without requiring a desktop panel.
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
