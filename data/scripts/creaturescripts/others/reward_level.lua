local rewardsTable = {
    [20] = {type = "bank", id = {20000, 0}, msg = "[Reward Level]\n\nThey were deposited in your bank 20.000 gold coins\nto reach the level 20!"},
	[30] = {type = "bank", id = {30000, 0}, msg = "[Reward Level]\n\nThey were deposited in your bank 30.000 gold coins\nto reach the level 30!"},
	[50] = {type = "bank", id = {50000, 0}, msg = "[Reward Level]\n\nThey were deposited in your bank 50.000 gold coins\nto reach the level 50!"},
	[80] = {type = "bank", id = {50000, 0}, msg = "[Reward Level]\n\nThey were deposited in your bank 50.000 gold coins\nto reach the level 50!"},
	[100] = {type = "bank", id = {100000, 0}, msg = "[Reward Level]\n\nThey were deposited in your bank 100.000 gold coins\nto reach the level 100!"},
	[150] = {type = "bank", id = {100000, 0}, msg = "[Reward Level]\n\nThey were deposited in your bank 100.000 gold coins\nto reach the level 150!"},
	[200] = {type = "addon", id = {154, 158}, msg = "[Reward Level]\n\nYou have unlocked the outfit ssdsdsds\nto reach the level 200!"},
	[250] = {type = "bank", id = {100000, 0}, msg = "[Reward Level]\n\nThey were deposited in your bank 100.000 gold coins\nto reach the level 250!"},
	[300] = {type = "bank", id = {100000, 0}, msg = "[Reward Level]\n\nThey were deposited in your bank 100.000 gold coins\nto reach the level 300!"},
	[350] = {type = "bank", id = {100000, 0}, msg = "[Reward Level]\n\nThey were deposited in your bank 100.000 gold coins\nto reach the level 350!"},
}

local storage = 673737

local rewardLevelEvent = CreatureEvent("reward_level")

function rewardLevelEvent.onAdvance(player, skill, oldLevel, newLevel)
    if skill ~= SKILL_LEVEL or newLevel <= oldLevel then
        return true
    end

    for level, reward in pairs(rewardsTable) do
        if newLevel >= level and player:getStorageValue(storage) < level then
            if reward.type == "item" then
                player:addItem(reward.id[1], reward.id[2])
            elseif reward.type == "bank" then
                player:setBankBalance(player:getBankBalance() + reward.id[1])
            elseif reward.type == "addon" then
                player:addOutfitAddon(reward.id[1], 3)
                player:addOutfitAddon(reward.id[2], 3)
            else
                return false
            end

			player:popupFYI(reward.msg)
			player:getPosition():sendMagicEffect(math.random(CONST_ME_FIREWORK_YELLOW, CONST_ME_FIREWORK_BLUE))
            player:setStorageValue(storage, level)
        end
    end

    player:save()

    return true
end

rewardLevelEvent:register()

local rewardLevelEvent_2 = CreatureEvent("rewardLevelEvent_2")

function rewardLevelEvent_2.onAdvance(player, skill, oldLevel, newLevel)
	if skill ~= SKILL_LEVEL or newLevel <= oldLevel then
        return true
    end

	local storageBase = 673738
    -- Define las recompensas específicas para cada vocación
	local rewards = {
        [1] = { -- Sorcerer
            [13] = {backpackItemId = 2859, rewardItems = {{itemId = 3075, count = 1}, {itemId = 268, count = 10}}, rewardText = "For reaching the level 13, you have earned a reward."},
			[19] = {backpackItemId = 2859, rewardItems = {{itemId = 3072, count = 1}, {itemId = 268, count = 20}}, rewardText = "For reaching the level 19, you have earned a reward."},
			[22] = {backpackItemId = 2859, rewardItems = {{itemId = 8093, count = 1}, {itemId = 268, count = 20}}, rewardText = "For reaching the level 22, you have earned a reward."},
			[26] = {backpackItemId = 2859, rewardItems = {{itemId = 3073, count = 1}, {itemId = 268, count = 20}}, rewardText = "For reaching the level 26, you have earned a reward."},
			[30] = {backpackItemId = 2859, rewardItems = {{itemId = 3161, count = 25}, {itemId = 3191, count = 25}}, rewardText = "For reaching the level 30, you have earned a reward."},
			[45] = {backpackItemId = 2859, rewardItems = {{itemId = 3155, count = 50}}, rewardText = "For reaching the level 45, you have earned a reward."},
			[50] = {backpackItemId = 2859, rewardItems = {{itemId = 237, count = 50}, {itemId = 236, count = 50}}, rewardText = "For reaching the level 50, you have earned a reward."},
        },
        [2] = { -- Druid
            [13] = {backpackItemId = 2861, rewardItems = {{itemId = 3070, count = 1}, {itemId = 268, count = 10}}, rewardText = "For reaching the level 13, you have earned a reward."},
			[19] = {backpackItemId = 2861, rewardItems = {{itemId = 3069, count = 1}, {itemId = 268, count = 20}}, rewardText = "For reaching the level 19, you have earned a reward."},
			[22] = {backpackItemId = 2861, rewardItems = {{itemId = 8083, count = 1}, {itemId = 268, count = 20}}, rewardText = "For reaching the level 22, you have earned a reward."},
            [26] = {backpackItemId = 2861, rewardItems = {{itemId = 3065, count = 1}, {itemId = 268, count = 20}}, rewardText = "For reaching the level 26, you have earned a reward."},
			[30] = {backpackItemId = 2861, rewardItems = {{itemId = 3161, count = 25}, {itemId = 3191, count = 25}}, rewardText = "For reaching the level 30, you have earned a reward."},
			[45] = {backpackItemId = 2861, rewardItems = {{itemId = 3155, count = 50}}, rewardText = "For reaching the level 45, you have earned a reward."},
			[50] = {backpackItemId = 2861, rewardItems = {{itemId = 237, count = 50}, {itemId = 236, count = 50}}, rewardText = "For reaching the level 50, you have earned a reward."},
        },
        [3] = { -- Paladin
            [13] = {backpackItemId = 2857, rewardItems = {{itemId = 3449, count = 50}, {itemId = 266, count = 10}}, rewardText = "For reaching the level 13, you have earned a reward."},
			[20] = {backpackItemId = 2857, rewardItems = {{itemId = 3347, count = 3}, {itemId = 266, count = 20}}, rewardText = "For reaching the level 20, you have earned a reward."},
			[25] = {backpackItemId = 2857, rewardItems = {{itemId = 7378, count = 3}, {itemId = 266, count = 20}}, rewardText = "For reaching the level 25, you have earned a reward."},
			[42] = {backpackItemId = 2857, rewardItems = {{itemId = 7367, count = 1}, {itemId = 266, count = 20}}, rewardText = "For reaching the level 42, you have earned a reward."},
			[50] = {backpackItemId = 2857, rewardItems = {{itemId = 237, count = 50}, {itemId = 236, count = 50}}, rewardText = "For reaching the level 50, you have earned a reward."},
        },
        [4] = { -- Knight
			[13] = {backpackItemId = 2862, rewardItems = {{itemId = 268, count = 20}, {itemId = 266, count = 20}}, rewardText = "For reaching the level 13, you have earned a reward."},
			[20] = {backpackItemId = 2862, rewardItems = {{itemId = 268, count = 20}, {itemId = 266, count = 20}}, rewardText = "For reaching the level 20, you have earned a reward."},
			[31] = {backpackItemId = 2862, rewardItems = {{itemId = 3200, count = 50}, {itemId = 266, count = 50}}, rewardText = "For reaching the level 31, you have earned a reward."},
			[50] = {backpackItemId = 2862, rewardItems = {{itemId = 237, count = 50}, {itemId = 236, count = 50}}, rewardText = "For reaching the level 19, you have earned a reward."},
        }
    }

	local vocationId = player:getVocation():getId()
    local vocationRewards = rewards[vocationId]

    if vocationRewards then
        local rewardData = vocationRewards[newLevel]
        if rewardData then
			local playerStorage = player:getStorageValue(newLevel)
			if playerStorage ~= 1 then -- Verifica si el jugador ya ha recibido esta recompensa
				local rewardContainer = player:addItem(rewardData.backpackItemId, 1)
				for _, rewardItem in ipairs(rewardData.rewardItems) do
					rewardContainer:addItem(rewardItem.itemId, rewardItem.count)
				end
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, rewardData.rewardText)
				player:sendTextMessage(MESSAGE_EVENT_ORANGE, rewardData.rewardText)
				player:getPosition():sendMagicEffect(math.random(CONST_ME_FIREWORK_YELLOW, CONST_ME_FIREWORK_BLUE))
				player:setStorageValue(newLevel, 1) -- Almacena que el jugador ha recibido la recompensa
			end
		end
	end
	
    return true
end

rewardLevelEvent_2:register()