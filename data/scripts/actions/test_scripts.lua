local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, monster, isHotkey)


	local randomText = {
		"#3545",
		"#4627",
		"#7236",
		"#8267",
		"#1477",
		"#8937",
		"#9316",
		"#2151",
		"#6732",
		"#8783",
		"#2346",
		"#1572",
		"#7893",
		"#9435",
		"#4687",
		"#5272"
	}
	
	local currentTime = os.time() -- Obtiene el tiempo actual en segundos desde el epoch (01/01/1970)
	local currentMonth = os.date("%m", currentTime)
	local currentDay = os.date("%d", currentTime) -- Obtiene el día del mes en formato de dos dígitos
	local currentHour = os.date("%H:%M:%S", currentTime) -- Obtiene la hora actual en formato HH:MM:SS
	local randomIndex = math.random(1, #randomText)
	local selectedText = randomText[randomIndex] -- Obtener el texto aleatorio seleccionado
	
	local letter = Game.createItem(3506, 1)
	local text_letter = ("                  <-Fonticak Receipt->\n-----------------------------\nOrder: "..selectedText.."\nFrom: "..player:getName().."\nDate: "..currentDay.." - "..currentMonth.." - Time: "..currentHour.."\n-----------------------------\nQTY                        ITEM                       COST\n-----------------------------\nHola\n\n  <~-~-~-!--!-------!--!-~-~-~>")
	
	player:addItemEx(letter, 1)
	letter:setAttribute(ITEM_ATTRIBUTE_TEXT, text_letter)
	player:say("hola")
	
	return true
end

action:id(4839)
action:register()



