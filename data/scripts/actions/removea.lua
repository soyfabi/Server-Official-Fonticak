local falconShield = Action()

local ThreatenedDreams = Storage.Quest.U11_40.ThreatenedDreams
function falconShield.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local msg = "[Reward Level]\n\nThey were deposited in your bank 20.000 gold coins\nto reach the level 20!"
	player:getPosition():sendMagicEffect(math.random(CONST_ME_FIREWORK_YELLOW, CONST_ME_FIREWORK_BLUE))
	player:popupFYI(msg)
	return true
end

falconShield:id(7866)
falconShield:register()
