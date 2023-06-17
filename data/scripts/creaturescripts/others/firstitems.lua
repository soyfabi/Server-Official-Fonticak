local FirstItems = CreatureEvent("FirstItems")
local config = {
	[1] = { -- Sorcerer
--equipment: mage hat, spellbook, magician's robe, snakebite rod, studded legs, scarf, leather boots, life ring
		items = {{7992, 1}, {3059, 1}, {7991, 1}, {3074, 1}, {3362, 1}, {3572, 1}, {3552, 1}, {3007, 1}},
		--container brown mushrooms, adventurer's stone, mana potion, health potion, rope, shovel
		container = {{3003, 1}, {3457, 1}, {3725, 10}, {16277, 1}, {3052, 1}, {268, 5}, {266, 5}}
	},
	[2] = { -- Druid
--equipment: mage hat, spellbook, magician's robe, snakebite rod, studded legs, scarf, leather boots, life ring
		items = {{7992, 1}, {3059, 1}, {7991, 1}, {3066, 1}, {3362, 1}, {3572, 1}, {3552, 1}, {3007, 1}},
		--container brown mushrooms, adventurer's stone, mana potion, health potion, rope, shovel
		container = {{3003, 1}, {3457, 1}, {3725, 10}, {16277, 1}, {3052, 1}, {268, 5}, {266, 5}}
	},
	[3] = { -- Paladin
--equipment: legion helmet, dwarven shield, ranger's cloak, spear, elven legs, scarf, leather boots, life ring
		items = {{3374, 1}, {3425, 1}, {3571, 1}, {3277, 1}, {3401, 1}, {3572, 1}, {3552, 1}, {3007, 1}},
		--container brown mushrooms, adventurer's stone, mana potion, health potion, rope, shovel, arrow, blue quiver, bow
		container = {{3003, 1}, {3457, 1}, {3725, 10}, {16277, 1}, {3052, 1}, {268, 5}, {266, 5}, {3447, 50}, {35848, 1}, {3350, 1}}
	},
	[4] = { -- Knight
--equipment: brass helmet, dwarven shield, brass armor, steel axe, brass legs, scarf, leather boots, life ring
		items = {{3354, 1}, {3425, 1}, {3359, 1}, {7773, 1}, {3372, 1}, {3572, 1}, {3552, 1}, {3007, 1}},
		--container brown mushrooms, adventurer's stone, mana potion, health potion, rope, shovel, jagged sword, daramian club 
		container = {{3003, 1}, {3457, 1}, {3725, 10}, {16277, 1}, {3052, 1}, {268, 5}, {266, 5}, {7774, 1}, {3327, 1}}
	}
}

function FirstItems.onLogin(player)
	player:registerEvent("FirstItems")
	if player:getLastLoginSaved() ~= 0 then
		return true
	end

	local targetVocation = config[player:getVocation():getId()]
	if not targetVocation then
		return true
	end

	for i = 1, #targetVocation.items do
		player:addItem(targetVocation.items[i][1], targetVocation.items[i][2])
	end

	local backpack = player:addItem(2870)
	if not backpack then
		return true
	end

	for i = 1, #targetVocation.container do
	backpack:addItem(targetVocation.container[i][1], targetVocation.container[i][2])
	end
	
	return true
end
FirstItems:register()
