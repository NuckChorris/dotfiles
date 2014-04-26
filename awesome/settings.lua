local settings = {}
local awful = require("awful")
local theme = require("beautiful").get()

settings.modkey     = "Mod4"
settings.term       = "termite"
settings.editor     = "gvim"
settings.browser    = "firefox"
settings.fileman    = "thunar"
settings.dateformat = "%a %b %d %I:%M"
settings.configdir  = awful.util.getdir("config")
settings.widgetdir  = settings.configdir .. "/widgets"
settings.layouts    = {
	awful.layout.suit.max,
	awful.layout.suit.tile,
	awful.layout.suit.tile.bottom,
	awful.layout.suit.floating
}
settings.tags       = {
	{ name = "一", layout = settings.layouts[1], mwfact = .65 },
	{ name = "二", layout = settings.layouts[1], mwfact = .65 },
	{ name = "三", layout = settings.layouts[1], mwfact = .65 },
	{ name = "四", layout = settings.layouts[1], mwfact = .65 },
	{ name = "五", layout = settings.layouts[1], mwfact = .65 },
	{ name = "六", layout = settings.layouts[1], mwfact = .65 },
	{ name = "七", layout = settings.layouts[1], mwfact = .65 },
	{ name = "八", layout = settings.layouts[1], mwfact = .65 },
	{ name = "九", layout = settings.layouts[1], mwfact = .65 },
	{ name = "十", layout = settings.layouts[1], mwfact = .65 }
}
settings.menu       = {
	items = {
		{ settings.browser,  settings.browser,                            theme.menu_wbrowser },
		{ settings.fileman,  settings.fileman,                            theme.menu_fbrowser },
		{ "reload",          awesome.restart,                             theme.menu_reload },
		{ "configure",       settings.editor .. " " .. awesome.conffile,  theme.menu_config },
		{ "suspend",         "gksudo 'pm-suspend'",                       theme.menu_suspend },
		{ "reboot",          "gksudo 'shutdown -r now'",                  theme.menu_reboot },
		{ "shutdown",        "gksudo 'shutdown -h now'",                  theme.menu_shutdown }
	}
}

return settings
