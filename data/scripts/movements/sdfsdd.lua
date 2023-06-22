local equipTorch = MoveEvent()

function equipTorch.onEquip(player, item, slot)

	local function loop(cid)
		player:say("hola")
		player:addMana(50)
	end
	addEvent(loop, 1000, cid)
   --[[if player:getVocation():getBase():getId() == 0 then -- Rookgard
         player:addCondition(sorcRegeneration)      
   elseif player:getVocation():getBase():getId() == 1 then -- Sorcerer
      player:addCondition(sorcRegeneration)
   elseif player:isDruid() then -- Druid
      player:addCondition(druidRegeneration)
   elseif player:getVocation():getBase():getId() == 3 then -- Paladin
      player:addCondition(paladinRegeneration)
   else  -- Knight
      player:addCondition(knightRegeneration)
   end]]
  return true
end

equipTorch:type("equip")
equipTorch:slot("ammo")
equipTorch:id(39698)
equipTorch:register()

local unEquipTorch = MoveEvent()

function unEquipTorch.onDeEquip(player, item, slot)
	--player:removeCondition(CONDITION_REGENERATION, CONDITIONID_DRUID)
	player:addMana(-50)
	return true
end

unEquipTorch:type("deequip")
unEquipTorch:slot("ammo")
unEquipTorch:id(39698)
unEquipTorch:register()