-- Threads pre init
_threads = {
	godmode = {},
	invisibility = {},
	fastwalk = {},
	fastswim = {},
	superjump = {},
	stayinvehicle = {},
	seethrough = {},
	shownames = { showed = {} },
}

-- Thread initialization
-- Thread → God mode
_threads.godmode.isActivated = false
_threads.godmode.enable = function()
	Citizen.CreateThread(function()
		_threads.godmode.isActivated = true
		while _threads.godmode.isActivated do
			SetEntityInvincible(PlayerPedId(), true)
			Citizen.Wait(1000)
		end
	end)
end
_threads.godmode.disable = function()
	_threads.godmode.isActivated = false
	SetEntityInvincible(PlayerPedId(), false)
end

-- Thread initialization
-- Thread → Invisibility
_threads.invisibility.isActivated = false
_threads.invisibility.enable = function()
	Citizen.CreateThread(function()
		_threads.invisibility.isActivated = true
		while _threads.invisibility.isActivated do
			SetEntityVisible(PlayerPedId(), false, 0)
			Citizen.Wait(1000)
		end
	end)
end
_threads.invisibility.disable = function()
	_threads.invisibility.isActivated = false
	SetEntityVisible(PlayerPedId(), true, 0)
end

-- Thread initialization
-- Thread → Fast walk
_threads.fastwalk.isActivated = false
_threads.fastwalk.enable = function()
	Citizen.CreateThread(function()
		_threads.fastwalk.isActivated = true
		while _threads.fastwalk.isActivated do
			SetPedMoveRateOverride(PlayerPedId(), 2.20)
			Citizen.Wait(1)
		end
	end)
end
_threads.fastwalk.disable = function()
	_threads.fastwalk.isActivated = false
	SetPedMoveRateOverride(PlayerPedId(), 0.0)
end

-- Thread initialization
-- Thread → Fast swim
_threads.fastswim.isActivated = false
_threads.fastswim.enable = function()
	Citizen.CreateThread(function()
		_threads.fastswim.isActivated = true
		while _threads.fastswim.isActivated do
			SetSwimMultiplierForPlayer(PlayerId(), 1.49)
			Citizen.Wait(1000)
		end
	end)
end
_threads.fastswim.disable = function()
	_threads.fastswim.isActivated = false
	SetSwimMultiplierForPlayer(PlayerId(), 0.0)
end

-- Thread initialization
-- Thread → Super jump
_threads.superjump.isActivated = false
_threads.superjump.enable = function()
	Citizen.CreateThread(function()
		_threads.superjump.isActivated = true
		while _threads.superjump.isActivated do
			SetSuperJumpThisFrame(PlayerId())
			Citizen.Wait(1)
		end
	end)
end
_threads.superjump.disable = function()
	_threads.superjump.isActivated = false
end

-- Thread initialization
-- Thread → Stay in vehicle
_threads.stayinvehicle.isActivated = false
_threads.stayinvehicle.enable = function()
	Citizen.CreateThread(function()
		_threads.stayinvehicle.isActivated = true
		while _threads.stayinvehicle.isActivated do
			local player = PlayerPedId()
			SetPedCanRagdoll(player, false)
			SetPedCanRagdollFromPlayerImpact(player, false)
			SetPedCanBeKnockedOffVehicle(player, 1)
			SetPedRagdollOnCollision(player, false)
			SetPedCanBeDraggedOut(player, false)
			Citizen.Wait(1000)
		end
	end)
end
_threads.stayinvehicle.disable = function()
	_threads.stayinvehicle.isActivated = false
	local player = PlayerPedId()
	SetPedCanRagdoll(player, true)
	SetPedCanRagdollFromPlayerImpact(player, true)
	SetPedCanBeKnockedOffVehicle(player, 0)
	SetPedRagdollOnCollision(player, true)
	SetPedCanBeDraggedOut(player, true)
end

-- Thread initialization
-- Thread → See through
_threads.seethrough.isActivated = false
_threads.seethrough.enable = function()
	Citizen.CreateThread(function()
		_threads.seethrough.isActivated = true
		while _threads.seethrough.isActivated do
			SetSeethrough(true)
			Citizen.Wait(1000)
		end
	end)
end
_threads.seethrough.disable = function()
	_threads.seethrough.isActivated = false
	SetSeethrough(false)
end

-- Thread initialization
-- Thread → Show names
_threads.shownames.isActivated = false
_threads.shownames.enable = function()
	Citizen.CreateThread(function()
		_threads.shownames.isActivated = true
		while _threads.shownames.isActivated do
			for k, v in pairs(ESX.Game.GetPlayers()) do
				local targetPed = GetPlayerPed(v)
				local selfPed = PlayerPedId()
				local targetPedCoords = GetEntityCoords(targetPed)
				local selfPedCoords = GetEntityCoords(selfPed)
				if GetDistanceBetweenCoords(selfPedCoords, targetPedCoords, true) < 400.0 then
					_threads.shownames.showed[v] = CreateFakeMpGamerTag(
						targetPed,
						("[%s] %s"):format(GetPlayerServerId(v), string.upper(GetPlayerName(v))),
						false,
						false,
						"",
						0
					)
					SetMpGamerTagVisibility(_threads.shownames.showed[v], 2, 1)
					SetMpGamerTagAlpha(_threads.shownames.showed[v], 2, 255)
					SetMpGamerTagHealthBarColor(_threads.shownames.showed[v], 129)
				else
					RemoveMpGamerTag(_threads.shownames.showed[v])
					_threads.shownames.showed[v] = nil
				end
			end
			Citizen.Wait(1)
		end
	end)
end
_threads.shownames.disable = function()
	_threads.shownames.isActivated = false
	for _, v in pairs(_threads.shownames.showed) do
		RemoveMpGamerTag(v)
		_threads.shownames.showed = {}
	end
end