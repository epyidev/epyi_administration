---main_players_showContentThisFrame → Function to show the main/players menu content
---@param playerGroup string
---@return void
function main_players_showContentThisFrame(playerGroup)
	_var.players.list = GlobalState["epyi_administration:playerList"] or {}
	RageUI.ButtonWithStyle(
		"Rechercher",
		"Permet de rechercher par ~r~ID/Prénom/Nom/Pseudo",
		{ RightLabel = (_var.menu.playersFilter ~= "" and _var.menu.playersFilter or "Aucun filtre") },
		true,
		function(_h, _a, Selected)
			if Selected then
				local search = textEntry(_U("textentry_search"), _var.menu.playersFilter, 30)
				if search == nil or search == "" then
					_var.menu.playersFilter = ""
					return
				end
				_var.menu.playersFilter = search
			end
		end
	)
	RageUI.Separator("↓ Résultats du ~r~filtre ~s~↓")
	local count = 0
	for _k, player in pairs(_var.players.list) do
		if
			player.ooc_name
			and (
				_var.menu.playersFilter == ""
				or string.find(
						string.lower(player.ooc_name .. player.source .. player.name .. player.group),
						string.lower(_var.menu.playersFilter)
					)
					~= nil
			)
		then
			count = count + 1
			local targetisLower = true
			if
				Config.Groups[playerGroup] ~= nil
				and Config.Groups[player.group] ~= nil
				and Config.Groups[player.group].Priority > Config.Groups[playerGroup].Priority
			then
				targetisLower = false
			end
			local group = _U("invalid")
			if Config.Groups[player.group] ~= nil then
				group = Config.Groups[player.group].Color .. Config.Groups[player.group].Label
			end
			RageUI.ButtonWithStyle(
				player.name .. " - " .. player.ooc_name .. " ~s~[" .. group .. "~s~] - ID: " .. player.source,
				_U("main_players_desc", player.ooc_name .. " ~s~[" .. group .. "~s~] - ID: " .. player.source),
				{ RightLabel = "→" },
				Config.Groups[playerGroup].Access["submenu_players_interact"]
					and (
						Config.Groups[playerGroup].Access["submenu_players_interact_highergroup"] and true
						or targetisLower
					),
				function(_h, _a, Selected)
					if Selected then
						_var.players.selected = player
					end
				end,
				_var.menus.admin.objects.mainPlayersInteract
			)
		end
	end
	if count == 0 then
		RageUI.Separator("")
		RageUI.Separator("~c~Aucun joueur trouvé")
		RageUI.Separator("")
	end
end
