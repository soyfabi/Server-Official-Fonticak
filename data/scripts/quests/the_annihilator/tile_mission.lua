local tile_anni = MoveEvent()

local tile = Tile(Position(33226, 31659, 13))

function tile_anni.onStepIn(creature, item, fromPosition, target, toPosition, isHotkey)
	local player = creature:getPlayer()
	if player:getStorageValue(Storage.Quest.U7_24.TheAnnihilator.MissionAnnihilator) < 1 then
		player:setStorageValue(Storage.Quest.U7_24.TheAnnihilator.MissionAnnihilator, 1)
		player:setStorageValue(Storage.TibiaTales.DefaultStart, 1)
	elseif tile and item.actionid == 10112 then
	if player:getStorageValue(Storage.Quest.U7_24.TheAnnihilator.MissionAnnihilator) == 2 then
		player:setStorageValue(Storage.Quest.U7_24.TheAnnihilator.MissionAnnihilator, 3)
	end
		return true
	end
	return true
end

tile_anni:aid(10112)
tile_anni:register()