--local storage1 = 1000
--local delay = 2 -- seconds

local event = Event()
function event.onChangeOutfit(self, outfit)

   --[[ if self:getStorageValue(storage1) >= os.time() then
		self:sendCancelMessage("Wait "..self:getStorageValue(storage1) - os.time().." seconds for change outfit.")
        return false
    else
		self:setStorageValue(storage1, os.time() + delay)
    end]]

	return true
end

event:register()
