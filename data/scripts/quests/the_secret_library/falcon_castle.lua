local teleports = {
	{position = {x = 33306, y = 31349, z = 8}, destination = Position(33349, 31346, 8)},
	{position = {x = 33310, y = 31325, z = 8}, access = Storage.TheSecretLibrary.OberonAccess, destination = Position(33329, 31332, 9)},
	{position = {x = 33329, y = 31333, z = 9}, destination = Position(33308, 31325, 8)},
	{positions = {
		{x = 33296, y = 31287, z = 9},
		{x = 33297, y = 31287, z = 9},
		{x = 33298, y = 31287, z = 9},
		{x = 33296, y = 31288, z = 9},
		{x = 33298, y = 31288, z = 9},
		{x = 33298, y = 31289, z = 9},
		{x = 33297, y = 31289, z = 9}
	}, timer = Storage.TheSecretLibrary.TheOrderOfTheFalcon.OberonTimer, destination = Position(33363, 31342, 9)}
}

local falconCastle = MoveEvent()

function falconCastle.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return false
	end
	for c = 1, #teleports do
		if teleports[c].position then
			if player:getPosition() == Position(teleports[c].position) then
				if teleports[c].access then
					if player:getStorageValue(teleports[c].access) == 1 then
						player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
						player:teleportTo(teleports[c].destination)
						player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
					else
						player:teleportTo(fromPosition, true)
						player:say("You need to complete the Access, killing the Dazed Leaf Golem.")
					end
				else
					player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
					player:teleportTo(teleports[c].destination)
					player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				end
			end
		elseif teleports[c].positions then
			for d = 1, #teleports[c].positions do
				if player:getPosition() == Position(teleports[c].positions[d]) then
					if player:getStorageValue(Storage.TheSecretLibrary.TheOrderOfTheFalcon.OberonTimer) > os.time() then
						local timeremaining = player:getStorageValue(Storage.TheSecretLibrary.TheOrderOfTheFalcon.OberonTimer) - os.time()
				
						if timeremaining > 0 then
							local horasRestantes = math.floor(timeremaining / 3600)
							local minutosRestantes = math.floor((timeremaining % 3600) / 60)
							local segundosRestantes = timeremaining % 60

							local message = "You have faced this boss, wait"

							if horasRestantes > 0 then
								message = message .. string.format(' %d hours', horasRestantes)
							end

							if minutosRestantes > 0 then
								message = message .. string.format(' %d minutes', minutosRestantes)
							end

							if segundosRestantes > 0 then
								message = message .. string.format(' %d seconds', segundosRestantes)
							end

							player:sendCancelMessage(message .. '.')
						end
						player:teleportTo(fromPosition)
						player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
						return false
					else
						player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
						player:teleportTo(teleports[c].destination)
						player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
					end
				end
			end
		end
	end
end

for a = 1, #teleports do
	if teleports[a].position then
		falconCastle:position(teleports[a].position)
	elseif teleports[a].positions then
		for b = 1, #teleports[a].positions do
			falconCastle:position(teleports[a].positions[b])
		end
	end
end
falconCastle:register()
