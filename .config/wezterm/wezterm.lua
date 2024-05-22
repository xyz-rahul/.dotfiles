local Config = require("config")

require("config.wallpaper_cycler"):set_files():random()

return Config:init():append(require("config.bindings")):append(require("config.appearance")).options
