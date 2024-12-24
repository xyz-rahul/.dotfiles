hs = hs

-- Configuration Reload
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", hs.reload):start()
hs.alert.show("Hammerspoon config loaded!")

-- Application Launch Key Bindings
hs.hotkey.bind({ "cmd" }, "2", function()
	hs.application.launchOrFocus("WezTerm")
end)

hs.hotkey.bind({ "cmd" }, "3", function()
	hs.application.launchOrFocus("Google Chrome")
end)

hs.hotkey.bind({ "cmd" }, "4", function()
	hs.application.launchOrFocus("Visual Studio Code")
end)

hs.hotkey.bind({ "cmd" }, "5", function()
	hs.application.launchOrFocus("Postman")
end)

hs.hotkey.bind({ "cmd" }, "7", function()
	hs.application.launchOrFocus("Brave Browser")
end)

hs.hotkey.bind({ "cmd" }, "9", function()
	hs.application.launchOrFocus("Microsoft Outlook")
end)

hs.hotkey.bind({ "cmd" }, "0", function()
	hs.application.launchOrFocus("Notion")
end)

-- Special handling for Finder
hs.hotkey.bind({ "cmd" }, "8", function()
	hs.osascript.applescript('tell application "Finder" to reopen activate')
end)

-- Window Management Functions
local originalFrame = nil

local function resizeAndMoveWindow(position)
	local win = hs.window.focusedWindow()
	if not win then
		return
	end

	local screen = win:screen()
	local frame = screen:frame()
	local winFrame = {}

	if position == "right-half" then
		winFrame = { x = frame.x + frame.w / 2, y = frame.y, w = frame.w / 2, h = frame.h }
	elseif position == "left-half" then
		winFrame = { x = frame.x, y = frame.y, w = frame.w / 2, h = frame.h }
	elseif position == "top-half" then
		winFrame = { x = frame.x, y = frame.y, w = frame.w, h = frame.h / 2 }
	elseif position == "bottom-half" then
		winFrame = { x = frame.x, y = frame.y + frame.h / 2, w = frame.w, h = frame.h / 2 }
	elseif position == "maximize" then
		winFrame = { x = frame.x, y = frame.y, w = frame.w, h = frame.h }
	end

	win:setFrame(winFrame)
end

local function toggleMaximize()
	local win = hs.window.focusedWindow()
	if not win then
		return
	end

	if not originalFrame then
		originalFrame = win:frame()
		resizeAndMoveWindow("maximize")
	else
		win:setFrame(originalFrame)
		originalFrame = nil
	end
end

-- Window Management Key Bindings
hs.hotkey.bind({ "ctrl", "cmd" }, "right", function()
	resizeAndMoveWindow("right-half")
end)

hs.hotkey.bind({ "ctrl", "cmd" }, "left", function()
	resizeAndMoveWindow("left-half")
end)

hs.hotkey.bind({ "ctrl", "cmd" }, "up", function()
	resizeAndMoveWindow("top-half")
end)

hs.hotkey.bind({ "ctrl", "cmd" }, "down", function()
	resizeAndMoveWindow("bottom-half")
end)

hs.hotkey.bind({ "ctrl", "cmd" }, "f", toggleMaximize)

-- Toggle Dark Mode
hs.hotkey.bind({ "ctrl", "cmd" }, "d", function()
	local script = [[ tell app "System Events" to tell appearance preferences to set dark mode to not dark mode ]]
	hs.osascript.applescript(script)
end)

-- Play Video with MPV
hs.hotkey.bind({ "ctrl", "cmd" }, "space", function()
	os.execute("pkill mpv")

	local frontApp = hs.application.frontmostApplication()
	if frontApp:name() ~= "Finder" then
		return
	end

	local script = [[
      tell application "Finder"
          set selectedFiles to selection
          if selectedFiles is not {} then
              set firstFile to item 1 of selectedFiles
              set filePath to POSIX path of (firstFile as alias)
          else
              return ""
          end if
      end tell
      return filePath
  ]]

	local ok, filePath = hs.osascript.applescript(script)

	if ok and filePath ~= "" then
		local command = string.format("/opt/homebrew/bin/mpv %q > /dev/null 2>&1 &", filePath)
		os.execute(command)
	end
end)

-- Tab Navigation for Browsers
local function navigateTab(direction)
	local focusedApp = hs.window.frontmostWindow() and hs.window.frontmostWindow():application()
	if
		focusedApp
		and (
			focusedApp:name() == "Google Chrome"
			or focusedApp:name() == "Brave Browser"
			or focusedApp:name() == "Microsoft Edge"
		)
	then
		local menuItem = direction == "next" and { "Tab", "Select Next Tab" } or { "Tab", "Select Previous Tab" }
		focusedApp:selectMenuItem(menuItem)
	end
end

local nextTabHotkey = hs.hotkey.new({ "ctrl" }, "n", function()
	navigateTab("next")
end)

local prevTabHotkey = hs.hotkey.new({ "ctrl" }, "p", function()
	navigateTab("prev")
end)

-- Application Watcher for Tab Navigation
local appWatcher = hs.application.watcher.new(function(appName, eventType, app)
	if eventType == hs.application.watcher.activated then
		if appName == "Google Chrome" or appName == "Brave Browser" or appName == "Microsoft Edge" then
			nextTabHotkey:enable()
			prevTabHotkey:enable()
		else
			nextTabHotkey:disable()
			prevTabHotkey:disable()
		end
	end
end)

appWatcher:start()
