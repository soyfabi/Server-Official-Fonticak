function dump(o)
   	if type(o) == 'table' then
      	local s = '{ '
      	for k,v in pairs(o) do
        	if type(k) ~= 'number' then k = '"'..k..'"' end
         	s = s .. '['..k..'] = ' .. dump(v) .. ','
      	end
      	return s .. '} '
   	else
     	return tostring(o)
   	end
end

function sendHelp(player) 
    player:sendCastChannelMessage('', 'Commands:\n!cast on <password>\n!cast off\n!cast list\n!cast help\n!cast mute/unmute <spectator_name>\n!cast ban/unban <spectator_name>\n!cast kick <spectator_name>', 8)
end

function findIP(spectators, name)
	for k, v in pairs(spectators) do
		if k:lower() == name:lower() then
			return v
		end
	end
	return nil
end

function removeKey(t, k_to_remove)
  	local new = {}
  	for k, v in pairs(t) do
		if k:lower() ~= k_to_remove:lower() then
			new[k] = v
		end
  	end
  	return new
end

local talkAction = TalkAction("!cast")

local exhaust = {}

function talkAction.onSay(player, words, param)

	local playerId = player:getId()
    local currentTime = os.time()
    if exhaust[playerId] and exhaust[playerId] > currentTime then
		player:sendCancelMessage("You are on cooldown, wait (0." .. exhaust[playerId] - currentTime .. "s).")
		return true
	end
	
    local data = player:getSpectators()
	if param == "" or param == nil then
		sendHelp(player)
		return false
	end
	
	local split = param:split(" ")
	local action = split[1]:lower()
	table.remove(split, 1)
	local target = table.concat(split, " ")

	if action == "on" then
		data['broadcast'] = true
		data['password'] = target
		player:setSpectators(data)
		player:sendTextMessage(22, "You have started casting your gameplay.")
		player:setStorageValue(80009, 1)
		exhaust[playerId] = currentTime + 3
		return false
	elseif action == "off" then
		data['broadcast'] = false
		player:setSpectators(data)
		player:sendTextMessage(22, "You have stopped casting your gameplay.")
		player:setStorageValue(80009, -1)
		exhaust[playerId] = currentTime + 3
		return false
	elseif action == "list" or action == "show" then
		local spectators_list = ""
		for k, v in pairs(data['spectators']) do
			spectators_list = spectators_list .. k .. ", "
		end
		player:sendCastChannelMessage('', 'Spectators: ' .. spectators_list, 8)		
		return false
	elseif action == "kick" then
		local ip = findIP(data['spectators'], target)
		if ip == nil then
			player:sendCastChannelMessage('', 'There is no spectator: ' .. target, 8)		
		else
			player:sendCastChannelMessage('', 'Spectator ' .. target .. ' has been kicked', 8)		
			data['kicks'][target] = ip
		end
		player:setSpectators(data)
		return false
	elseif action == "mute" then
		local ip = findIP(data['spectators'], target)
		if ip == nil then
			player:sendCastChannelMessage('', 'There is no spectator: ' .. target, 8)		
		else
			player:sendCastChannelMessage('', 'Spectator ' .. target .. ' has been muted', 8)		
			data['mutes'][target] = ip
		end
		player:setSpectators(data)
		return false
	elseif action == "ban" then
		local ip = findIP(data['spectators'], target)
		if ip == nil then
			player:sendCastChannelMessage('', 'There is no spectator: ' .. target, 8)		
		else
			player:sendCastChannelMessage('', 'Spectator ' .. target .. ' has been banned', 8)		
			data['bans'][target] = ip
		end
		player:setSpectators(data)
		return false
	elseif action == "unmute" then
		local ip = findIP(data['mutes'], target)
		if ip == nil then
			player:sendCastChannelMessage('', 'There is no spectator: ' .. target, 8)		
		else
			player:sendCastChannelMessage('', 'Spectator ' .. target .. ' has been unmuted', 8)		
			data['mutes'] = removeKey(data['mutes'], target)
		end
		player:setSpectators(data)
		return false
	elseif action == "unban" then
		local ip = findIP(data['bans'], target)
		if ip == nil then
			player:sendCastChannelMessage('', 'There is no spectator: ' .. target, 8)		
		else
			player:sendCastChannelMessage('', 'Spectator ' .. target .. ' has been unbanned', 8)		
			data['bans'] = removeKey(data['bans'], target)
		end
		player:setSpectators(data)
		return false
	end
	sendHelp(player)
end

talkAction:separator(" ")
talkAction:register()

local cast_logout = CreatureEvent("cast_logout")
function cast_logout.onLogout(player)
	player:setStorageValue(80009, -1)
	return true
end

cast_logout:register()