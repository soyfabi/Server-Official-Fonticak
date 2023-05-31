--[[
    Little Quest Chests
    Create By: 𝓜𝓲𝓵𝓵𝓱𝓲𝓸𝓻𝓮 𝓑𝓣
    TFS Version: 1.5
]]--

local storageBase = 9000000
local actionId = 2000

local action = Action()

function action.onUse(player, chest, fromPos, target, toPos, isHotkey)
    local questId = chest:getUniqueId()
    if not chest:getType():isContainer() then
        error(string.format("[Error - LittleQuestChests::%d] Item %d is not a container.", questId, chest:getId()))
    end

    if player:getStorageValue(storageBase + questId) ~= -1 then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "It is empty.")
        return true
    end

    local items = chest:getItems()
    if #items == 0 then
        error(string.format("[Error - LittleQuestChests::%d] No items found for quest %d", questId, questId))
    end

    local totalWeight = 0
    for _, item in pairs(items) do
        totalWeight = totalWeight + item:getWeight()
    end

    if player:getFreeCapacity() < totalWeight then
        player:sendCancelMessage(RETURNVALUE_NOTENOUGHCAPACITY)
        return true
    end

    player:setStorageValue(storageBase + questId, 1)
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("You have found %s.", chest:getContentDescription()))
    for _, item in pairs(items) do
        player:addItemEx(item:clone(), true)
    end
    return true
end

action:aid(actionId)
action:register()