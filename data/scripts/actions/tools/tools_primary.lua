local crowbar = Action()
function crowbar.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return onUseCrowbar(player, item, fromPosition, target, toPosition, isHotkey)
end
crowbar:id(3304)
crowbar:register()

local machete = Action()
function machete.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return onUseMachete(player, item, fromPosition, target, toPosition, isHotkey)
end
machete:id(3308)
machete:register()

local pick = Action()
function pick.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return onUsePick(player, item, fromPosition, target, toPosition, isHotkey)
end
pick:id(3456)
pick:register()

local rope = Action()
function rope.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return onUseRope(player, item, fromPosition, target, toPosition, isHotkey)
end
rope:id(3003, 646)
rope:register()

local saw = Action()

function saw.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if target.itemid ~= 5901 then
		return false
	end

	target:transform(target.itemid, target.type - 1)
	player:addItem(9114, 1)
	toPosition:sendMagicEffect(CONST_ME_POFF) --Not sure if there's any magic effect when you use saw?
	return true
end

saw:id(3461)
saw:register()

local scythe = Action()
function scythe.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return onUseScythe(player, item, fromPosition, target, toPosition, isHotkey)
end
scythe:id(3453)
scythe:register()

local shovel = Action()
function shovel.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return onUseShovel(player, item, fromPosition, target, toPosition, isHotkey)
end
shovel:id(3457, 5710)
shovel:register()

local kitchen_knife = Action()
function kitchen_knife.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return onUseKitchenKnife(player, item, fromPosition, target, toPosition, isHotkey)
end
kitchen_knife:id(3469)
kitchen_knife:register()

local sickle = Action()

function sickle.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if target.itemid == 5463 then
		target:transform(5462)
		target:decay()
		Game.createItem(5466, 1, toPosition)
		return true
	end
end

sickle:id(3293)
sickle:register()

local spoon = Action()

function spoon.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return onUseSpoon(player, item, fromPosition, target, toPosition, isHotkey)
end

spoon:id(3468)
spoon:register()

local toolGear = Action()

function toolGear.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return onUseRope(player, item, fromPosition, target, toPosition, isHotkey)
		or onUseShovel(player, item, fromPosition, target, toPosition, isHotkey)
		or onUsePick(player, item, fromPosition, target, toPosition, isHotkey)
		or onUseMachete(player, item, fromPosition, target, toPosition, isHotkey)
		or onUseCrowbar(player, item, fromPosition, target, toPosition, isHotkey)
		or onUseSpoon(player, item, fromPosition, target, toPosition, isHotkey)
		or onUseScythe(player, item, fromPosition, target, toPosition, isHotkey)
		or onUseKitchenKnife(player, item, fromPosition, target, toPosition, isHotkey)
end

toolGear:id(9594, 9596, 9598)
toolGear:register()


