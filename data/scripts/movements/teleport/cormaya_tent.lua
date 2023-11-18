local setting = {
	[50528] = {position = Position(33395, 31920, 8), message = 'You enter the tent! An elegant lady awaits you!'}, --entrance
	[50529] = {position = Position(33319, 32007, 7), message = 'You leave the tent!'}, --exit
}

local cormaya_tent = MoveEvent()

function cormaya_tent.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local teleport = setting[item.uid]
	if teleport then
		player:teleportTo(teleport.position)
		item:getPosition():sendMagicEffect(CONST_ME_GREEN_RINGS)
		player:say(teleport.message, TALKTYPE_MONSTER_SAY)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	end
	return true
end

cormaya_tent:type("stepin")

for index, value in pairs(setting) do
	cormaya_tent:uid(index)
end

cormaya_tent:register()
