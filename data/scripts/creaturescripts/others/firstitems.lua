local FirstItems = CreatureEvent("FirstItems")
local config = {
	[1] = { -- Sorcerer
--equipment: magician hat, crystal wand, blue robe, spbk warding, blue legs, scarf, boh, life ring
		items = {{2662, 1}, {2525, 1}, {2463, 1}, {2190, 1}, {2647, 1}, {2661, 1}, {2643}, {2168}},
		--container rope, shovel, mana potion
		container = {{2120, 1}, {5710, 1}, {7620, 5}, {7618, 5}, {8841, 20}, {2160, 20}}
	},
	[2] = { -- Druid
--equipment: magician hat, crystal wand, blue robe, spbk warding, blue legs, scarf, boh, life ring
		items = {{2662, 1}, {2525, 1}, {2463, 1}, {2182, 1}, {2647, 1}, {2661, 1}, {2643}, {2168}},
		--container rope, shovel, mana potion
		container = {{2120, 1}, {5710, 1}, {7620, 5}, {7618, 5}, {8841, 20}, {2160, 20}}
	},
	[3] = { -- Paladin
--equipment: bonelord helmet, elvish bow, ranger cloak, bonelord shield, elven legs, scarf, boh, life ring
		items = {{3972, 1}, {7438, 1}, {2660, 1}, {2518, 1}, {2507, 1}, {2661, 1}, {2195}, {2168}},
		--container rope, shovel, health potion,
		container = {{7366, 1}, {7731, 1}, {5710, 1}, {7620, 1}, {7618, 5}, {8841, 20}, {2160, 20}}
	},
	[4] = { -- Knight
--equipment: crusader helmet, sword, noble armor, ornamented shield, knight legs, scarf, boh, life ring
		items = {{2497, 1}, {8932, 1}, {2486, 1}, {2524, 1}, {2477, 1}, {2661, 1}, {2195}, {2168}},
		--container rope, shovel, health potion,
		container = {{7431, 1}, {7420, 1}, {7420, 1}, {7731, 1}, {5710, 1}, {7620, 1}, {7618, 5}, {8841, 20}, {2160, 20}}
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

	local backpack = player:addItem(2000)
	if not backpack then
		return true
	end

	for i = 1, #targetVocation.container do
		backpack:addItem(targetVocation.container[i][1], targetVocation.container[i][2])
	end
	return true
end
FirstItems:register()
