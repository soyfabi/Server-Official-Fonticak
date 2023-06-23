local bastionAccess = Action()

function bastionAccess.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	--[[if target.itemid ~= 36828 then
		return false
	end]]
	
	if Position(32364, 32205, 7) == item:getPosition() then
		if player:getStorageValue(8000) >= 1 then
		player:popupFYI("[Task System]\n- You have not yet chosen a task with Grizzly Adams.")
		elseif player:getStorageValue(8001) >= 1 then
		player:popupFYI("[Task System]\nCompleting Task of Demon\n - You have 120 dead demon.")
	else
		--player:popupFYI("[Task System]\n- You haven't accepted the contract with Grizzly Adams yet, go and talk to him.")
		player:popupFYI("[Task System]\nCompleting Task of Demon.\n - You have 120/400 dead demon.\n\nTime with the task: \n\nBy completing the task you receive:\n- Rewards: Demon Helmet.\n- Experience: 5000 EXP.\n- Task Point: 6 TP.")
		end
	end
	return true
end

bastionAccess:id(36828)
bastionAccess:register()
