local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, monster, isHotkey)

	player:say("hola")
	
	
	return true
end

action:id(4839)
action:register()



