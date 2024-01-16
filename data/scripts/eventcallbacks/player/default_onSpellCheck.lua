local event = Event()

function event.onSpellCheck(player, spell)
	return true
end

event:register()