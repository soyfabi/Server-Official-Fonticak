local record = GlobalEvent("Records")
function record.onRecord(current, old)
	addEvent(Game.broadcastMessage, 150, "New record: " .. current .. " players are logged in, Invite your Friends so that the server grows more.", MESSAGE_STATUS_DEFAULT)
	return true
end
record:register()
