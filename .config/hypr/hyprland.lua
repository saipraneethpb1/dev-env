-- Hyprland 0.56.x
-- `hl` is provided globally by Hyprland.

-- =========================================================
-- MONITORS
-- =========================================================

-- Dell SE2726D - main monitor, physically on the left/center
hl.monitor({
	output = "HDMI-A-1",
	mode = "2560x1440@143.97",
	position = "0x0",
	scale = 1,
})

-- Laptop display - physically to the right
hl.monitor({
	output = "eDP-2",
	mode = "2560x1440@165",
	position = "2560x0",
	scale = 1.6,
})

-- Fallback for unexpected displays
hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	scale = "auto",
})

-- =========================================================
-- CORE CONFIG
-- =========================================================

hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 10,
		border_size = 2,
		layout = "dwindle",

		col = {
			active_border = "rgb(26c6ca)",
			inactive_border = "rgb(2a2a2a)",
		},
	},

	decoration = {
		rounding = 8,

		blur = {
			enabled = false,
			-- size = 8,
			-- passes = 1,
		},

		shadow = {
			enabled = false,
		},
	},

	animations = {
		enabled = false,
	},

	input = {
		kb_layout = "us",
		follow_mouse = 1,

		touchpad = {
			natural_scroll = false,
		},
	},
})

-- =========================================================
-- VARIABLES
-- =========================================================

local mainMod = "SUPER"

local terminal = "ghostty"
local launcher = "rofi -show drun"

-- =========================================================
-- APPLICATIONS
-- =========================================================

hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))

hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(launcher))

-- =========================================================
-- WINDOW MANAGEMENT
-- =========================================================

-- Close active window
hl.bind(mainMod .. " + Q", hl.dsp.window.close())

-- Fullscreen
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())

-- =========================================================
-- FOCUS MOVEMENT
-- =========================================================

hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))

hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))

hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))

-- =========================================================
-- WORKSPACES
-- =========================================================

for i = 1, 9 do
	-- Switch workspace
	hl.bind(
		mainMod .. " + " .. i,
		hl.dsp.focus({
			workspace = i,
		})
	)

	-- Move active window to workspace
	hl.bind(
		mainMod .. " + SHIFT + " .. i,
		hl.dsp.window.move({
			workspace = i,
		})
	)
end

-- =========================================================
-- SCREENSHOTS
-- =========================================================

-- Select region -> clipboard
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd([[grim -g "$(slurp)" - | wl-copy]]))

-- Full screenshot -> file
hl.bind(
	mainMod .. " + PRINT",
	hl.dsp.exec_cmd(
		[[mkdir -p "$HOME/Pictures/Screenshots" && grim "$HOME/Pictures/Screenshots/screenshot-$(date +%Y%m%d-%H%M%S).png"]]
	)
)

-- =========================================================
-- AUDIO - SWAYOSD
-- =========================================================

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("swayosd-client --output-volume raise"))

hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("swayosd-client --output-volume lower"))

hl.bind("XF86AudioMute", hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"))

hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("swayosd-client --input-volume mute-toggle"))

-- =========================================================
-- BRIGHTNESS - SWAYOSD
-- =========================================================

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("swayosd-client --brightness raise"))

hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("swayosd-client --brightness lower"))

-- =========================================================
-- MEDIA
-- =========================================================

hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))

hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))

-- =========================================================
-- LOCK SCREEN
-- =========================================================

hl.bind(mainMod .. " + SHIFT + L", hl.dsp.exec_cmd("hyprlock"))

-- =========================================================
-- AUTOSTART
-- =========================================================

hl.on("hyprland.start", function()
	hl.exec_cmd("waybar")
	hl.exec_cmd("mako")
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("setsid swayosd-server >/tmp/swayosd.log 2>&1")
	hl.exec_cmd("hypridle")
end)
