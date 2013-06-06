local tags = { }
local statusbar = { }
local promptbox = { }
local taglist = { }
local layoutbox = { }
local settings = { }

local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
local wibox = require("wibox")

local beautiful = require("beautiful")
local naughty = require("naughty")
local vicious = require("vicious")
local menubar = require("menubar")

-- Handle runtime errors after startup
do
	local in_error = false
	awesome.connect_signal("debug::error", function (err)
		-- Make sure we don't go into an endless error loop
		if in_error then return end
		in_error = true

		naughty.notify({ preset = naughty.config.presets.critical,
		                 title = "Oops, an error happened!",
		                 text = err })
		in_error = false
	end)
end

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

beautiful.init("/home/plejeck/.config/awesome/autumn/theme.lua")

if beautiful.wallpaper then
	for s = 1, screen.count() do
		gears.wallpaper.maximized(beautiful.wallpaper, s, true)
	end
end

mm = awful.menu({
	items = {
		{ settings.term,     settings.term,                           theme.menu_terminal },
		{ settings.browser,  settings.browser,                        theme.menu_wbrowser },
		{ settings.fileman,  settings.fileman,                        theme.menu_fbrowser },
		{ "suspend",         "gksudo pm-suspend",                     theme.menu_suspend },
		{ "reload",          awesome.restart,                         theme.menu_reload },
		{ "configure",       settings.editor.." "..awesome.conffile,  theme.menu_config },
		{ "reboot",          "gksudo 'shutdown -r now'",              theme.menu_reboot },
		{ "shutdown",        "gksudo 'shutdown -h now'",              theme.menu_shutdown },
		{ "lock",            "dm-tool switch-to-greeter",             theme.menu_lockscreen }
	}
})

tags.settings = {
	{ name = "一", layout = settings.layouts[2], mwfact = .65 },
	{ name = "二", layout = settings.layouts[1], mwfact = .65 },
	{ name = "三", layout = settings.layouts[1], mwfact = .65 },
	{ name = "四", layout = settings.layouts[2], mwfact = .65 },
	{ name = "五", layout = settings.layouts[1], mwfact = .65 },
	{ name = "六", layout = settings.layouts[1], mwfact = .65 },
	{ name = "七", layout = settings.layouts[1], mwfact = .65 },
	{ name = "八", layout = settings.layouts[1], mwfact = .65 },
	{ name = "九", layout = settings.layouts[1], mwfact = .65 },
	{ name = "十", layout = settings.layouts[1], mwfact = .65 }
}

for s = 1, screen.count() do
	tags[s] = {}
	for i, v in ipairs(tags.settings) do
		tags[s][i] = awful.tag.add(v.name, {
			screen = s,
			layout = v.layout,
			mwfact = v.mwfact,
			hide = v.hide
		})
--		awful.tag.setscreen(tags[s][i], v.screen)
	end
	tags[s][1].selected = true
end

for s = 1, screen.count() do gears.wallpaper.maximized(beautiful.wallpaper, s, true) end

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Widgets
-- Create a textclock widget
mytextclock = awful.widget.textclock(settings.dateformat, 10)

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}

-- Tags List
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
	awful.button({ }, 1, awful.tag.viewonly),
	awful.button({ settings.modkey }, 1, function(t)
		awful.client.movetotag(t)
		awful.tag.viewonly(t)
	end),
	awful.button({ }, 3, awful.tag.viewtoggle),
	awful.button({ settings.modkey }, 3, awful.client.toggletag)
)

-- Windows List
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
awful.button({ }, 1, function (c)
	if c == client.focus then
		c.minimized = true
	else
		-- Without this, the following
		-- :isvisible() makes no sense
		c.minimized = false
		if not c:isvisible() then
			awful.tag.viewonly(c:tags()[1])
		end
		-- This will also un-minimize
		-- the client, if needed
		client.focus = c
		c:raise()
	end
end),
awful.button({ }, 3, function ()
	if instance then
		instance:hide()
		instance = nil
	else
		instance = awful.menu.clients({ width=250 })
	end
end))

for s = 1, screen.count() do
	-- Create a promptbox for each screen
	mypromptbox[s] = awful.widget.prompt()
	-- Create an imagebox widget which will contains an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	mylayoutbox[s] = awful.widget.layoutbox(s)
	mylayoutbox[s]:buttons(awful.util.table.join(
		awful.button({ }, 1, function () awful.layout.inc(settings.layouts, 1) end),
		awful.button({ }, 3, function () awful.layout.inc(settings.layouts, -1) end),
		awful.button({ }, 4, function () awful.layout.inc(settings.layouts, 1) end),
		awful.button({ }, 5, function () awful.layout.inc(settings.layouts, -1) end))
	)
	-- Create a taglist widget
	mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

	-- Create a tasklist widget
	mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

	-- Create the wibox
	mywibox[s] = awful.wibox({ position = "top", screen = s })

	-- Widgets that are aligned to the left
	local left_layout = wibox.layout.fixed.horizontal()
	left_layout:add(mytaglist[s])
	left_layout:add(mypromptbox[s])

	-- Widgets that are aligned to the right
	local right_layout = wibox.layout.fixed.horizontal()
	if s == 1 then right_layout:add(wibox.widget.systray()) end
	right_layout:add(mytextclock)
	right_layout:add(mylayoutbox[s])

	-- Now bring it all together (with the tasklist in the middle)
	local layout = wibox.layout.align.horizontal()
	layout:set_left(left_layout)
	layout:set_middle(mytasklist[s])
	layout:set_right(right_layout)

	mywibox[s]:set_widget(layout)
end

-- Mouse bindings
root.buttons(awful.util.table.join(
	awful.button({ }, 3, function () mm:toggle() end),
	awful.button({ }, 4, awful.tag.viewnext),
	awful.button({ }, 5, awful.tag.viewprev)
))

-- {{{ Key bindings
globalkeys = awful.util.table.join(
	awful.key({ settings.modkey }, "Left", awful.tag.viewprev),
	awful.key({ settings.modkey }, "Right", awful.tag.viewnext),
	awful.key({ settings.modkey }, "Escape", awful.tag.history.restore),
	awful.key({ settings.modkey }, "Up", function ()
		awful.client.focus.byidx(1)
		if client.focus then client.focus:raise() end
	end),
	awful.key({ settings.modkey }, "Down", function ()
		awful.client.focus.byidx(-1)
		if client.focus then client.focus:raise() end
	end),
	awful.key({ settings.modkey }, "w", function ()
		mm:show()
	end),

	-- Layout manipulation
	awful.key({ settings.modkey, "Shift" }, "Right", function ()
		awful.client.swap.byidx(1)
	end),
	awful.key({ settings.modkey, "Shift" }, "Left", function ()
		awful.client.swap.byidx(-1)
	end),
	awful.key({ settings.modkey, "Control" }, "Left", function ()
		awful.screen.focus_relative(1)
	end),
	awful.key({ settings.modkey, "Control" }, "Right", function ()
		awful.screen.focus_relative(-1)
	end),
	awful.key({ settings.modkey }, "u", awful.client.urgent.jumpto),
	awful.key({ settings.modkey }, "Tab", function ()
		awful.client.focus.history.previous()
			if client.focus then
				client.focus:raise()
			end
	end),

	-- Standard program
	awful.key({ settings.modkey }, "Return", function ()
		awful.util.spawn(settings.term)
	end),
	awful.key({ settings.modkey }, "v", function ()
		awful.util.spawn(settings.editor)
	end),
	awful.key({ settings.modkey, "Control" }, "r", awesome.restart),
	awful.key({ settings.modkey, "Shift" }, "q", awesome.quit),

	awful.key({ settings.modkey, "Shift" }, "Up", function ()
		awful.tag.incmwfact(0.05)
	end),
	awful.key({ settings.modkey, "Shift" }, "Down", function ()
		awful.tag.incmwfact(-0.05)
	end),

	awful.key({ settings.modkey, "Control" }, "Up", function ()
		awful.tag.incnmaster(-1)
	end),
	awful.key({ settings.modkey, "Control" }, "Down", function ()
		awful.tag.incnmaster(1)
	end),

	awful.key({ settings.modkey, "Control", "Shift" }, "Down", function ()
		awful.tag.incncol(-1)
	end),
	awful.key({ settings.modkey, "Control", "Shift" }, "Up", function ()
		awful.tag.incncol(1)
	end),

	awful.key({ settings.modkey }, "space", function ()
		awful.layout.inc(settings.layouts, 1)
	end),
	awful.key({ settings.modkey, "Shift" }, "space", function ()
		awful.layout.inc(settings.layouts, -1)
	end),
	awful.key({ settings.modkey, "Shift" }, "f", function ()
		awful.layout.set(settings.layouts[4])
	end),

	awful.key({ settings.modkey, "Control" }, "n", awful.client.restore),

	-- Prompt
	awful.key({ settings.modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

awful.key({ settings.modkey }, "x",
function ()
	awful.prompt.run({ prompt = "Run Lua code: " },
	mypromptbox[mouse.screen].widget,
	awful.util.eval, nil,
	awful.util.getdir("cache") .. "/history_eval")
end),
-- Menubar
awful.key({ settings.modkey }, "p", function() menubar.show() end)
)

clientkeys = awful.util.table.join(
awful.key({ settings.modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
awful.key({ settings.modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
awful.key({ settings.modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
awful.key({ settings.modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
awful.key({ settings.modkey,           }, "o",      awful.client.movetoscreen                        ),
awful.key({ settings.modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
awful.key({ settings.modkey,           }, "n",
function (c)
	-- The client currently has the input focus, so it cannot be
	-- minimized, since minimized clients can't have the focus.
	c.minimized = true
end),
awful.key({ settings.modkey,           }, "m",
function (c)
	c.maximized_horizontal = not c.maximized_horizontal
	c.maximized_vertical   = not c.maximized_vertical
end)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
	globalkeys = awful.util.table.join(globalkeys,
	awful.key({ settings.modkey }, "#" .. i + 9,
	function ()
		local screen = mouse.screen
		local tag = awful.tag.gettags(screen)[i]
		if tag then
			awful.tag.viewonly(tag)
		end
	end),
	awful.key({ settings.modkey, "Control" }, "#" .. i + 9,
	function ()
		local screen = mouse.screen
		local tag = awful.tag.gettags(screen)[i]
		if tag then
			awful.tag.viewtoggle(tag)
		end
	end),
	awful.key({ settings.modkey, "Shift" }, "#" .. i + 9,
	function ()
		local tag = awful.tag.gettags(client.focus.screen)[i]
		if client.focus and tag then
			awful.client.movetotag(tag)
		end
	end),
	awful.key({ settings.modkey, "Control", "Shift" }, "#" .. i + 9,
	function ()
		local tag = awful.tag.gettags(client.focus.screen)[i]
		if client.focus and tag then
			awful.client.toggletag(tag)
		end
	end))
end

clientbuttons = awful.util.table.join(
awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
awful.button({ settings.modkey }, 1, awful.mouse.client.move),
awful.button({ settings.modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
	-- All clients will match this rule.
	{ rule = { },
	properties = { border_width = beautiful.border_width,
	border_color = beautiful.border_normal,
	focus = awful.client.focus.filter,
	keys = clientkeys,
	buttons = clientbuttons } },
	{ rule = { class = "MPlayer" },
	properties = { floating = true } },
	{ rule = { class = "pinentry" },
	properties = { floating = true } },
	{ rule = { class = "gimp" },
	properties = { floating = true } },
	-- Set Firefox to always map on tags number 2 of screen 1.
	-- { rule = { class = "Firefox" },
	--   properties = { tag = tags[1][2] } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
	if not startup then
		-- Set the windows at the slave,
		-- i.e. put it at the end of others instead of setting it master.
		-- awful.client.setslave(c)

		-- Put windows in a smart way, only if they does not set an initial position.
		if not c.size_hints.user_position and not c.size_hints.program_position then
			awful.placement.no_overlap(c)
			awful.placement.no_offscreen(c)
		end
	end

	local titlebars_enabled = false
	if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
		-- buttons for the titlebar
		local buttons = awful.util.table.join(
		awful.button({ }, 1, function()
			client.focus = c
			c:raise()
			awful.mouse.client.move(c)
		end),
		awful.button({ }, 3, function()
			client.focus = c
			c:raise()
			awful.mouse.client.resize(c)
		end)
		)

		-- Widgets that are aligned to the left
		local left_layout = wibox.layout.fixed.horizontal()
		left_layout:add(awful.titlebar.widget.iconwidget(c))
		left_layout:buttons(buttons)

		-- Widgets that are aligned to the right
		local right_layout = wibox.layout.fixed.horizontal()
		right_layout:add(awful.titlebar.widget.floatingbutton(c))
		right_layout:add(awful.titlebar.widget.maximizedbutton(c))
		right_layout:add(awful.titlebar.widget.stickybutton(c))
		right_layout:add(awful.titlebar.widget.ontopbutton(c))
		right_layout:add(awful.titlebar.widget.closebutton(c))

		-- The title goes in the middle
		local middle_layout = wibox.layout.flex.horizontal()
		local title = awful.titlebar.widget.titlewidget(c)
		title:set_align("center")
		middle_layout:add(title)
		middle_layout:buttons(buttons)

		-- Now bring it all together
		local layout = wibox.layout.align.horizontal()
		layout:set_left(left_layout)
		layout:set_right(right_layout)
		layout:set_middle(middle_layout)

		awful.titlebar(c):set_widget(layout)
	end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
