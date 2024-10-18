---@class Wallpaper
---@field file_list string[]
---@field isWallpaperActive boolean
local M = {
	file_list = {},
}

-- Initializes the Wallpaper module
function M:init(file_list)
	self.file_list = file_list
	return M
end

-- Returns a random wallpaper filename from the list
function M:random_wallpaper()
	if #self.file_list > 0 then
		return self.file_list[math.random(#self.file_list)]
	else
		return nil
	end
end

function M:background()
	local background = {
		{
			source = {
				Color = "Black",
			},
			height = "100%",
			width = "100%",
		},
		{
			-- Supported formats: PNG, JPEG, GIF, BMP, ICO, TIFF, PNM, DDS, TGA
			source = {
				File = self:random_wallpaper(),
			},
			repeat_x = "Repeat",
			repeat_y = "Repeat",
			vertical_align = "Top",
			hsb = { brightness = 0.07 },
		},
	}
	return background
end
-- Toggles wallpaper display based on the window and pane
---@param window any? WezTerm `Window` see: https://wezfurlong.org/wezterm/config/lua/window/index.html
function M:toggle_wallpaper(window)
	local overrides = window:get_config_overrides() or {}
	if self.isWallpaperActive and #self.file_list > 0 then
		overrides.background = self:background()
	else
		overrides.background = nil
	end
	self.isWallpaperActive = not self.isWallpaperActive
	window:set_config_overrides(overrides)
end

return M
