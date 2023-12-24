local event = Event()
event.onSay = function(self, message)
	local msgBlock = {"servegame", "sytes", "otserlist", "ot feio", ".net", ".org", "ot lixo", "ilusion", "icewar", "revolution", "ddns"}
	for _, m in ipairs(msgBlock) do
		local a = string.find(message, m)
		if a then
			self:getPosition():sendMagicEffect(CONST_ME_POFF)
			self:sendTextMessage(MESSAGE_STATUS_DEFAULT, "It is not allowed to post other content, this may cause bans (Ban).")
			local file = io.open("data/logs/block.txt", "a")
			if not file then
				print(">> Error trying to find the file of block messages on log.")
				return
			end
			io.output(file)
			io.write("------------------------------\n")
			io.write(self:getName() ..": ".. message .."\n")
			io.close(file)
			return true
		end
	end
	return true
end

event:register()
