local event = Event()
event.onInventoryUpdate = function(self, item, slot, equip)
	--itemAttributes(self, item, slot, equip)
	return true
end
event:register()