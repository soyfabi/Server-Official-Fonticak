local event = Event()
event.onInventoryUpdate = function(self, item, slot, equip)
<<<<<<< HEAD
=======
	--itemAttributes(self, item, slot, equip)
>>>>>>> 0431891660aed8c85ab25009335f819d112a84fe
	return true
end
event:register()