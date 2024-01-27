local buyHouse = TalkAction("!buyhouse")

function buyHouse.onSay(player, words, param)
	local housePrice = configManager.getNumber(configKeys.HOUSE_PRICE)
	if housePrice == -1 then
		return true
	end

	local position = player:getPosition()
	position:getNextPosition(player:getDirection())

	local tile = Tile(position)
	local house = tile and tile:getHouse()
	local playerPos = player:getPosition()
	local houseEntry = house and house:getExitPosition()

	if not house or playerPos ~= houseEntry then
		player:sendCancelMessage("You have to be looking at the door of the house you would like to buy.")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end

	if house:getOwnerGuid() > 0 then
		player:sendCancelMessage("This house already has an owner.")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end

	if player:getHouse() then
		player:sendCancelMessage("You are already the owner of a house.")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end

	local price = house:getTileCount() * housePrice
	if not player:removeMoneyNpc(price) then
		player:sendCancelMessage("You do not have enough money.")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end

	house:setOwnerGuid(player:getGuid())
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have successfully bought this house, be sure to have the money for the rent in the bank.")
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
	return false
end

buyHouse:separator(" ")
buyHouse:register()
