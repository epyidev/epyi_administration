---main_personnal_showContentThisFrame → Function to show the main/personnal menu content
---@param playerGroup string
---@return void
function main_vehicles_showContentThisFrame(playerGroup)
	RageUI.ButtonWithStyle(
		_U("main_vehicles_current"),
		_U("main_vehicles_current_desc"),
		{ RightLabel = "→" },
		Config.Groups[playerGroup].Access["submenu_vehicles_current_access"],
		function(_, _, _) end,
		RMenu:Get("epyi_administration", "main_vehicles_current")
	)
	RageUI.ButtonWithStyle(
		_U("main_vehicles_favorites"),
		_U("main_vehicles_favorites_desc"),
		{ RightLabel = "→" },
		Config.Groups[playerGroup].Access["submenu_vehicles_favorites_access"],
		function(_, _, _) end
	)
	RageUI.ButtonWithStyle(
		_U("main_vehicles_spawn"),
		_U("main_vehicles_spawn_desc"),
		{ RightLabel = "→" },
		Config.Groups[playerGroup].Access["submenu_vehicles_spawn_access"],
		function(_, _, _) end
	)
end