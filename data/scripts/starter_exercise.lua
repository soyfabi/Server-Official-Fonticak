local action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
local text = "This starter kit will give you a free Exercise Weapons.\n\nSelect a Exercise Weapon:"
local modalWindow = ModalWindow(1500, "Exercise Weapons", text)

	player:registerEvent("Modal_Sell")

    modalWindow:addChoice(1, "Exercise Club")
    modalWindow:addChoice(2, "Exercise Axe")
    modalWindow:addChoice(3, "Exercise Sword")
    modalWindow:addChoice(4, "Exercise Wand")
	modalWindow:addChoice(5, "Exercise Rod")
	modalWindow:addChoice(6, "Exercise Bow")

    modalWindow:addButton(100, "Select")
    modalWindow:setDefaultEnterButton(0)
    modalWindow:addButton(101, "Cancel")
    modalWindow:setDefaultEscapeButton(1)
        
    modalWindow:sendToPlayer(player)
    
    return false
end
action:id(3052)
action:register()

local modal = CreatureEvent("Modal_Sell")
function modal.onModalWindow(player, modalWindowId, buttonId, choiceId)
    if modalWindowId ~= 1500 or buttonId == 101 then
        return false
    end
	
	player:unregisterEvent("Modal_Sell")
	
	if player:getStorageValue(Storage.STORAGEVALUE_STARTER_EXERCISE) > 0 then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You have already claimed your exercise weapons.")
		return true
	end

    if buttonId == 100 then -- steel
        if choiceId == 1 then
			player:addItem(28554, 1)
			player:sendTextMessage(MESSAGE_INFO_DESCR, "You have just chosen an Exercise Club, take advantage of it to improve your skills.")
		elseif choiceId == 2 then
			player:addItem(28553, 1)
			player:sendTextMessage(MESSAGE_INFO_DESCR, "You have just chosen an Exercise Axe, take advantage of it to improve your skills.")
		elseif choiceId == 3 then
			player:addItem(28552, 1)
			player:sendTextMessage(MESSAGE_INFO_DESCR, "You have just chosen an Exercise Sword, take advantage of it to improve your skills.")
		elseif choiceId == 4 then
			player:addItem(28557, 1)
			player:sendTextMessage(MESSAGE_INFO_DESCR, "You have just chosen an Exercise Wand, take advantage of it to improve your skills.")
		elseif choiceId == 5 then
			player:addItem(28556, 1, 1800)
			player:sendTextMessage(MESSAGE_INFO_DESCR, "You have just chosen an Exercise Rod, take advantage of it to improve your skills.")
		elseif choiceId == 6 then
			player:addItem(28555, 1)
			player:sendTextMessage(MESSAGE_INFO_DESCR, "You have just chosen an Exercise Bow, take advantage of it to improve your skills.")
		end
		player:getPosition():sendMagicEffect(CONST_ME_GIFT_WRAPS)
		--player:setStorageValue(Storage.STORAGEVALUE_STARTER_EXERCISE, 1)
	end
    return true
end
modal:register()