local reloadTypes = {
	["all"] = RELOAD_TYPE_ALL,
	
	["chat"] = RELOAD_TYPE_CHAT,
	["channel"] = RELOAD_TYPE_CHAT,
	["chatchannels"] = RELOAD_TYPE_CHAT,
	
	["config"] = RELOAD_TYPE_CONFIG,
	["configuration"] = RELOAD_TYPE_CONFIG,
	
	["events"] = RELOAD_TYPE_EVENTS,
	
	["monsters"] = RELOAD_TYPE_MONSTERS,
	["monster"] = RELOAD_TYPE_MONSTERS,
	
	["global"] = RELOAD_TYPE_GLOBAL,
	["items"] = RELOAD_TYPE_ITEMS,

	["npc"] = RELOAD_TYPE_NPCS,
	["npcs"] = RELOAD_TYPE_NPCS,

	["quest"] = RELOAD_TYPE_QUESTS,
	["quests"] = RELOAD_TYPE_QUESTS,

	["scripts"] = RELOAD_TYPE_SCRIPTS,
	["libs"] = RELOAD_TYPE_GLOBAL
}

local reload = TalkAction("/reload")
function reload.onSay(player, words, param)
	--[[if not player:getGroup():getAccess() then
		return true
	end

	if player:getAccountType() < ACCOUNT_TYPE_GOD then
		return false
	end]]

	local reloadType = reloadTypes[param:lower()]
	if not reloadType then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "Reload type not found.")
		return false
	end

	-- need to clear Event.data or we end up having duplicated events on /reload scripts
	if table.contains({RELOAD_TYPE_SCRIPTS, RELOAD_TYPE_ALL}, reloadType) then
		Event:clear()
	end

	Game.reload(reloadType)
	if reloadType == RELOAD_TYPE_GLOBAL then
		-- we need to reload the scripts as well
		Game.reload(RELOAD_TYPE_SCRIPTS)
	end
	player:sendTextMessage(MESSAGE_INFO_DESCR, string.format("Reloaded %s.", param:lower()))
	return false
end

reload:separator(" ")
reload:register()