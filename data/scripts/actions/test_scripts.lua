local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, monster, isHotkey)

<<<<<<< HEAD
	local inbox = player:getInbox()
	local parcel = Game.createItem(3504, 1)
	local letter = Game.createItem(3506, 1)
	
	local text_letter = [[
                   ( Fonticak Shopper )
-----------------------------
Thank you for buying with us, your product has a 1-year warranty so do not throw away this letter to claim again.

Visit us on the website to see more products.
]]

	
	
	--ITEM_LETTER_STAMPED
	
	if inbox then
		parcel:addItemEx(letter, 1, INDEX_WHEREEVER, FLAG_NOLIMIT)
		inbox:addItemEx(parcel, 1, INDEX_WHEREEVER, FLAG_NOLIMIT)
		letter:setAttribute(ITEM_ATTRIBUTE_TEXT, text_letter)	
	end
	
	
	
	
	
	
	player:say("hola")
	
=======
	player:say("hola")
	
	
>>>>>>> a3a218a164dba496a0192e2afd4650761fdf7e28
	return true
end

action:id(4839)
action:register()



