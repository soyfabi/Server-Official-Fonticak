local event = Event()

event.onSpawn = function(self, monster, position, startup, artificial)
	if self:getType():isRewardBoss() then
		self:setReward(true)
	end
	
	return true
end
event:register()
