local config = {
	{position = Position(32396, 31806, 8), itemId = 1295}
}

local cultsOfTibiaTouch = Action()
function cultsOfTibiaTouch.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local wallItem
	local tile = Tile(Position(32396, 31806, 8))
	if getGlobalStorageValue(373377) >= os.time() then
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
	else
		for i = 1, #config do
			wallItem = Tile(config[i].position):getItemById(config[i].itemId)
			if wallItem then
				Position(32396, 31806, 8):sendMagicEffect(CONST_ME_POFF)
				wallItem:remove()
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You hear a loud grinding sound not very far from you. something very heavy seems to have moved.")
				setGlobalStorageValue(373377, os.time() + 306)	
				addEvent(Game.createItem, 300000, 1295, 1,  Position(32396, 31806, 8))
				addEvent(function()
					tile:relocateTo(Position(32396, 31805, 8), true)
				end, 3100)
			end
		end
	end
	return true
end

cultsOfTibiaTouch:aid(5524)
cultsOfTibiaTouch:register()