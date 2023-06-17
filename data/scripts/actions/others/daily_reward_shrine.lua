local config = {
  items = {
    ["Monday"] = { -- Lunes
		{itemID = 266, quantity = 10}, -- health potion x10
		{itemID = 268, quantity = 10}, -- mana potion x10
		{itemID = 3153, quantity = 10}, -- cure poison rune x10
		{itemID = 3172, quantity = 10}, -- poison field rune
		{itemID = 3174, quantity = 10}, -- light magic missile rune x10
		{itemID = 3175, quantity = 10}, -- light stone shower rune x10
		{itemID = 21352, quantity = 10}, -- lightest missile rune x10		
    },
    ["Tuesday"] = { -- Martes
      {itemID = 2345, quantity = 1}, -- Item 1 para el martes
      {itemID = 6789, quantity = 1}, -- Item 2 para el martes
    },
	["Wednesday"] = { -- Miercoles
      {itemID = 2345, quantity = 1}, -- Item 1 para el martes
      {itemID = 6789, quantity = 1}, -- Item 2 para el martes
    },
	["Thursday"] = { -- Jueves
      {itemID = 2345, quantity = 1}, -- Item 1 para el martes
      {itemID = 6789, quantity = 1}, -- Item 2 para el martes
    },
	["Friday"] = { -- Viernes
		{itemID = 266, quantity = 10}, -- health potion x10
		{itemID = 268, quantity = 10}, -- mana potion x10
		{itemID = 3153, quantity = 10}, -- cure poison rune x10
		{itemID = 3172, quantity = 10}, -- poison field rune
		{itemID = 3174, quantity = 10}, -- light magic missile rune x10
		{itemID = 3175, quantity = 10}, -- light stone shower rune x10
		{itemID = 21352, quantity = 10}, -- lightest missile rune x10									
    },
    -- Agrega el resto de los días de la semana siguiendo el mismo formato
  },
  storage = 1000 -- Valor de almacenamiento único para el cofre diario
}

local dailyRewardShrine = Action()

function dailyRewardShrine.onUse(cid, item, fromPosition, itemEx, toPosition)
	local player = Player(cid)
	local dayOfWeek = os.date("%A") --+ 1 -- Obtiene el día de la semana (1-7)
	local dayConfig = config.items[dayOfWeek]

	if not dayConfig then
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Hoy no hay un item disponible en el cofre.")
		return true
	end
	
	if player:getFreeCapacity() < 1000 then
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "You need to have at least \n\"30.00 oz capacity\"")
        return true
    end

	if (getPlayerStorageValue(cid, config.storage) - os.time() > 0) then
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You have already received the daily reward, come back tomorrow to receive another reward.")
		return true
	end

	local itemInfo = dayConfig[math.random(1, #dayConfig)]
	local itemID = itemInfo.itemID
	local quantity = itemInfo.quantity
  
	if getItemName(itemID) ~= "" then
		doPlayerAddItem(cid, itemID, quantity)
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "[Daily Reward]\nYou have obtained x" .. quantity .. " " .. getItemName(itemID) .. ".\nCome back tomorrow for another reward.")
		player:getPosition():sendMagicEffect(CONST_ME_GIFT_WRAPS)
	else
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "El cofre está vacío. ¡Mejor suerte la próxima vez!")
	end

	--setPlayerStorageValue(cid, config.storage, os.time() + 24 * 60 * 60) -- Almacena la próxima apertura del cofre
	
	return true
end

dailyRewardShrine:id(25720, 25721, 25722, 25723, 25802, 25803)
dailyRewardShrine:register()
