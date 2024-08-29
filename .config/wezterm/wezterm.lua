-- Merge configs and return!
------------------------------------------
local mytable = require("mystdlib").mytable
local full_config = mytable.merge_all(
	require("appearance"),
	require("keybinding"),
	{} -- so the last table can have an ending comma for git diffs :)
)

return full_config
-- for k,v in pairs(second_table) do first_table[k] = v end
