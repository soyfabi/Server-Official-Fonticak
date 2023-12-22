local config = {
    actionId = 18562, -- on lever
    lever = {
        left = 36709,
        right = 36710
    },
    playItem = {
        itemId = 42502, -- item required to pull lever
        count = 1
    },
    rouletteOptions = {
        rareItemChance_broadcastThreshold = 1700,
        ignoredItems = {1617}, -- if you have tables/counters/other items on the roulette tiles, add them here
        winEffects = {CONST_ANI_ICE, CONST_ME_CONFETTI_HORIZONTAL, CONST_ME_THUNDER}, -- first effect needs to be distance effect
        effectDelay = 333,
        spinTime = {min = 8, max = 12}, -- seconds
        spinSlowdownRamping = 5,
        rouletteStorage = 48550 -- required storage to avoid player abuse (if they logout/die before roulette finishes.. they can spin again for free)
    },
    prizePool = {
        {itemId = 42502, count = {1, 3},   chance = 10000}, -- fonticak tokens
        {itemId = 22516, count = {1, 4},    chance = 9000 }, -- silver tokens
        {itemId = 3079, count = {1, 1},    chance = 8500 }, -- boots of haste
		{itemId = 22721, count = {1, 2},    chance = 3000 }, -- gold tokens
		{itemId = 5907, count = {1, 1},    chance = 4500 }, -- slingshot
		{itemId = 3043, count = {50, 70},   chance = 6500 }, -- crystal coin
		{itemId = 42500, count = {1, 2},   chance = 4000 }, -- diamond ingot
		{itemId = 42527, count = {1, 1}, chance = 2000 }, -- hermes boots
        {itemId = 42534, count = {1, 1},    chance = 1500 }, -- fonticak mystery rod
        {itemId = 42535, count = {1, 1},    chance = 1500 }, -- fonticak mastery wand
        {itemId = 37745, count = {1, 1},    chance = 1200 }, -- draptor doll
        {itemId = 5903, count = {1, 1},    chance = 200  },  -- ferumbras' hat
		{itemId = 30317, count = {1, 1},    chance = 600  },  -- ferumbras puppet
		{itemId = 37335, count = {1, 1},    chance = 100  },  -- black skull
		{itemId = 37338, count = {1, 1},    chance = 300  },  -- red skull
		{itemId = 42525, count = {1, 1},    chance = 600  },  -- hermes helmet
		{itemId = 39761, count = {1, 1},    chance = 400  },  -- the gods'twilight doll
		{itemId = 12308, count = {1, 1},    chance = 5000  },  -- reins
		{itemId = 34258, count = {1, 1},    chance = 3000  },  -- red silk flower
		{itemId = 42528, count = {1, 1},    chance = 700  },  -- fonticak mastery crossbow
		{itemId = 42530, count = {1, 1},    chance = 700  },  -- fonticak mastery sword
		{itemId = 42524, count = {1, 1},    chance = 500  },  -- fonticak mastery double axe
		{itemId = 42512, count = {1, 1},    chance = 1200  },  -- VIP 30 days
		{itemId = 42513, count = {1, 1},    chance = 900  }, -- VIP 60 days
		{itemId = 42514, count = {1, 1},    chance = 500  },  -- VIP 90 days
    
    },
    roulettePositions = { -- hard-coded to 7 positions.
        Position(32364, 32239, 6),
        Position(32365, 32239, 6),
        Position(32366, 32239, 6),
        Position(32367, 32239, 6), -- position 4 in this list is hard-coded to be the reward location, which is the item given to the player
        Position(32368, 32239, 6),
        Position(32369, 32239, 6),
        Position(32370, 32239, 6),
		Position(32371, 32239, 6),
    	Position(32372, 32239, 6),
		Position(32373, 32239, 6),
		Position(32374, 32239, 6),
    }
}

local chancedItems = {} -- used for broadcast. don't edit

local function resetLever(position)
    local lever = Tile(position):getItemById(config.lever.right)
    lever:transform(config.lever.left)
end

local function updateRoulette(newItemInfo)
    local positions = config.roulettePositions
    for i = #positions, 1, -1 do
        local item = Tile(positions[i]):getTopVisibleThing()
        if item and item:getId() ~= Tile(positions[i]):getGround():getId() and not table.contains(config.rouletteOptions.ignoredItems, item:getId()) then
            if i ~= 11 then
                item:moveTo(positions[i + 1])
            else
                item:remove()
            end
        end
    end
    if ItemType(newItemInfo.itemId):hasShowCharges() then
        local item = Game.createItem(newItemInfo.itemId, 1, positions[1])
        item:setAttribute("charges", newItemInfo.count)
    else
        Game.createItem(newItemInfo.itemId, newItemInfo.count, positions[1])
    end
end

local function clearRoulette(newItemInfo)
    local positions = config.roulettePositions
    for i = #positions, 1, -1 do
        local item = Tile(positions[i]):getTopVisibleThing()
        if item and item:getId() ~= Tile(positions[i]):getGround():getId() and not table.contains(config.rouletteOptions.ignoredItems, item:getId()) then
            item:remove()
        end
        if newItemInfo == nil then
            positions[i]:sendMagicEffect(CONST_ME_POFF)
        else
            if ItemType(newItemInfo.itemId):hasShowCharges() then
                local item = Game.createItem(newItemInfo.itemId, 1, positions[i])
                item:setAttribute("charges", newItemInfo.count)
            else
                Game.createItem(newItemInfo.itemId, newItemInfo.count, positions[i])
            end
        end
    end
end

local function chanceNewReward()
    local newItemInfo = {itemId = 0, count = 0}
    
    local rewardTable = {}
    while #rewardTable < 1 do
        for i = 1, #config.prizePool do
            if config.prizePool[i].chance >= math.random(10000) then
                rewardTable[#rewardTable + 1] = i
            end
        end
    end
    
    local rand = math.random(#rewardTable)
    newItemInfo.itemId = config.prizePool[rewardTable[rand]].itemId
    newItemInfo.count = math.random(config.prizePool[rewardTable[rand]].count[1], config.prizePool[rewardTable[rand]].count[2])
    chancedItems[#chancedItems + 1] = config.prizePool[rewardTable[rand]].chance
    
    return newItemInfo
end

local function initiateReward(leverPosition, effectCounter)
    if effectCounter < #config.rouletteOptions.winEffects then
        effectCounter = effectCounter + 1
        if effectCounter == 1 then
            config.roulettePositions[1]:sendDistanceEffect(config.roulettePositions[6], config.rouletteOptions.winEffects[1])
            config.roulettePositions[11]:sendDistanceEffect(config.roulettePositions[6], config.rouletteOptions.winEffects[1])
			config.roulettePositions[6]:sendMagicEffect(CONST_ME_TUTORIALARROW)
			config.roulettePositions[6]:sendMagicEffect(CONST_ME_TUTORIALSQUARE)
        else
            for i = 1, #config.roulettePositions do
                config.roulettePositions[i]:sendMagicEffect(config.rouletteOptions.winEffects[effectCounter])
				addEvent(function()config.roulettePositions[i]:sendMagicEffect(config.rouletteOptions.winEffects[effectCounter]) end, 300)
            end
        end
        if effectCounter == 2 then
            local item = Tile(config.roulettePositions[6]):getTopVisibleThing()
            local newItemInfo = {itemId = item:getId(), count = item:getCount()}
            clearRoulette(newItemInfo)
        end
        addEvent(initiateReward, config.rouletteOptions.effectDelay, leverPosition, effectCounter)
        return
    end
    resetLever(leverPosition)
end

local function rewardPlayer(playerId, leverPosition)
    local player = Player(playerId)
    if not player then
        return
    end
    
    local item = Tile(config.roulettePositions[6]):getTopVisibleThing()
    
    if ItemType(item:getId()):hasShowCharges() then
        local addedItem = player:addItem(item:getId(), 1, true)
        addedItem:setAttribute("charges", item:getCharges())
    else
        player:addItem(item:getId(), item:getCount(), true)
    end

    player:setStorageValue(config.rouletteOptions.rouletteStorage, -1)
    if chancedItems[#chancedItems - 3] <= config.rouletteOptions.rareItemChance_broadcastThreshold then
		Game.broadcastMessage("[Roulette]\nThe player " .. player:getName() .. " has won " .. item:getName() .. ", he was very lucky.", MESSAGE_EVENT_ADVANCE)
    end
end

local function roulette(playerId, leverPosition, spinTimeRemaining, spinDelay)
    local player = Player(playerId)
    if not player then
        resetLever(leverPosition)
        return
    end
    
    local newItemInfo = chanceNewReward()
    updateRoulette(newItemInfo)
    
    if spinTimeRemaining > 0 then
        spinDelay = spinDelay + config.rouletteOptions.spinSlowdownRamping
        addEvent(roulette, spinDelay, playerId, leverPosition, spinTimeRemaining - (spinDelay - config.rouletteOptions.spinSlowdownRamping), spinDelay)
        return
    end
    
    initiateReward(leverPosition, 0)
    rewardPlayer(playerId, leverPosition)
end

local casinoRoulette = Action()

function casinoRoulette.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if item:getId() == config.lever.right then
        player:sendTextMessage(MESSAGE_STATUS_SMALL, "Casino Roulette is currently in progress. Please wait.")
        return true
    end
    
    if player:getItemCount(config.playItem.itemId) < config.playItem.count then
        if player:getStorageValue(config.rouletteOptions.rouletteStorage) < 1 then
            player:sendTextMessage(MESSAGE_STATUS_SMALL, "Roulette requires " .. config.playItem.count .. " " .. (ItemType(config.playItem.itemId):getName()) .. " to use.")
            return true
        end
        -- player:sendTextMessage(MESSAGE_STATUS_SMALL, "Free Spin being used due to a previous unforeseen error.")
    end
    
    item:transform(config.lever.right)
    clearRoulette()
    chancedItems = {}
    
    player:removeItem(config.playItem.itemId, config.playItem.count)
    player:setStorageValue(config.rouletteOptions.rouletteStorage, 1)
    
    local spinTimeRemaining = math.random((config.rouletteOptions.spinTime.min * 1000), (config.rouletteOptions.spinTime.max * 1000))
    roulette(player:getId(), toPosition, spinTimeRemaining, 100)
    return true
end

casinoRoulette:aid(config.actionId)
casinoRoulette:register()


local disableMovingItemsToRoulettePositions = EventCallback

disableMovingItemsToRoulettePositions.onMoveItem = function(self, item, count, fromPosition, toPosition, fromCylinder, toCylinder)
    for v, k in pairs(config.roulettePositions) do
        if toPosition == k then
            return false
        end
    end
    return true
end

disableMovingItemsToRoulettePositions:register()