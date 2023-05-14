local loginEvents = CreatureEvent("Premium_Login")
function loginEvents.onLogin(player)

	local textc = true
	local text = "V.I.P!"
	local color = 124

	if not player:isPremium() then
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, "You are not yet a premium account, you could get 15% Extra Exp, enter our website and enjoy the benefits of being premium.")
	else
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, "You have "..player:getPremiumDays().." days of V.I.P, you receive 15% Exp.")
		if textc then
		Game.sendAnimatedText(text, player:getPosition(), color)
		end
	end
	
	return true
end
loginEvents:register()


local event = Event()
event.onGainExperience = function(self, source, exp, rawExp)

	if self:isPremium() then
		exp = exp * 1.2 -- 15% Exp
	end
	
	return exp
end

event:register()
