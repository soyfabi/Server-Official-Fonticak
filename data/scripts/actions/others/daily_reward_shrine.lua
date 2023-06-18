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
		{itemID = 236, quantity = 10}, -- strong health potion x10
		{itemID = 237, quantity = 10}, -- strong mana potion x10
		{itemID = 238, quantity = 10}, -- great mana potion x10
		{itemID = 266, quantity = 10}, -- health potion x10
		{itemID = 268, quantity = 10}, -- mana potion x10
		{itemID = 7642, quantity = 10}, -- great spirit potion x10
		{itemID = 23374, quantity = 10}, -- ultimate spirit potion x10
		{itemID = 3152, quantity = 10}, -- intense healing rune x10
		{itemID = 3153, quantity = 10}, -- cure poison rune x10
		{itemID = 3172, quantity = 10}, -- poison field rune x10
		{itemID = 3174, quantity = 10}, -- light magic missile rune x10
		{itemID = 3188, quantity = 10}, -- fire field x10
		{itemID = 3175, quantity = 10}, -- light stone shower rune x10
		{itemID = 21352, quantity = 10}, -- lightest missile rune x10
    },
	["Wednesday"] = { -- Miercoles
      {itemID = 36736, quantity = 1}, -- fire amplification x1
      {itemID = 36737, quantity = 1}, -- ice amplification x1
	  {itemID = 36738, quantity = 1}, -- earth amplification x1
	  {itemID = 36739, quantity = 1}, -- energy amplification x1
	  {itemID = 36740, quantity = 1}, -- holy amplification x1
	  {itemID = 36741, quantity = 1}, -- death amplification x1
	  {itemID = 36742, quantity = 1}, -- physical amplification x1
    },
	["Thursday"] = { -- Jueves
      {itemID = 2345, quantity = 1}, -- Item 1 para el martes
      {itemID = 6789, quantity = 1}, -- Item 2 para el martes
    },
	["Friday"] = { -- Viernes
		{itemID = 36729, quantity = 1}, -- fire resilience x1
		{itemID = 36730, quantity = 1}, -- ice resilience x1
		{itemID = 36731, quantity = 1}, -- earth resilience x1
		{itemID = 36732, quantity = 1}, -- energy resilience x1
		{itemID = 36733, quantity = 1}, -- holy resilience x1
		{itemID = 36734, quantity = 1}, -- death resilience x1
		{itemID = 36735, quantity = 1}, -- physical resilience x1									
    },
	["Saturday"] = { -- Sabado
		{itemID = 25718, quantity = 1}, -- temple teleport scroll x1
									
    },
	["Sunday"] = { -- Domingo
		{itemID = 236, quantity = 10}, -- strong health potion x10
		{itemID = 237, quantity = 10}, -- strong mana potion x10
		{itemID = 238, quantity = 10}, -- great mana potion x10
		{itemID = 266, quantity = 10}, -- health potion x10
		{itemID = 268, quantity = 10}, -- mana potion x10
		{itemID = 7642, quantity = 10}, -- great spirit potion x10
		{itemID = 23374, quantity = 10}, -- ultimate spirit potion x10
		{itemID = 3152, quantity = 10}, -- intense healing rune x10
		{itemID = 3153, quantity = 10}, -- cure poison rune x10
		{itemID = 3172, quantity = 10}, -- poison field rune x10
		{itemID = 3174, quantity = 10}, -- light magic missile rune x10
		{itemID = 3188, quantity = 10}, -- fire field x10
		{itemID = 3175, quantity = 10}, -- light stone shower rune x10
		{itemID = 21352, quantity = 10}, -- lightest missile rune x10
    },
    -- Agrega el resto de los días de la semana siguiendo el mismo formato
  },
  storage = 5050134 -- Valor de almacenamiento único para el cofre diario
}

local dailyRewardShrine = Action()

function dailyRewardShrine.onUse(player, item, fromPosition, itemEx, toPosition)
	local dayOfWeek = os.date("%A") --+ 1 -- Obtiene el día de la semana (1-7)
	local dayConfig = config.items[dayOfWeek]

	if not dayConfig then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "Hoy no hay un item disponible en el cofre.")
		return true
	end
	
	if player:getFreeCapacity() < 3000 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need to have at least\n\"30.00 oz capacity\"")
        return true
    end

	if player:getStorageValue(config.storage) - os.time() > 0 then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You have already received the daily reward, come back tomorrow to receive another reward.")
		return true
	end

	local itemInfo = dayConfig[math.random(1, #dayConfig)]
	local itemID = itemInfo.itemID
	local quantity = itemInfo.quantity
  
	if getItemName(itemID) ~= "" then
		player:addItem(itemID, quantity)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[Daily Reward]\nYou have obtained x" .. quantity .. " " .. getItemName(itemID) .. ".\nCome back tomorrow for another reward.")
		player:say("You have obtained x" .. quantity .. " " .. getItemName(itemID) .. ".")
		player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
	else
		player:sendTextMessage(MESSAGE_INFO_DESCR, "El cofre está vacío. ¡Mejor suerte la próxima vez!")
	end

	--player:setStorageValue(config.storage, os.time() + 24 * 60 * 60) -- Almacena la próxima apertura del cofre
	--player:setStorageValue(config.storage, os.time() + 60) -- Almacena la próxima apertura del cofre
	
	return true
end

dailyRewardShrine:id(25720, 25721, 25722, 25723, 25802, 25803)
dailyRewardShrine:register()
