local event = Event()

function event.onSpellCheck(player, spell)
	if BossEvent:hasPlayer(player) then
		player:sendCancelMessage("You can't use spells in this event.")
		return false
	end
	return true
end

event:register()