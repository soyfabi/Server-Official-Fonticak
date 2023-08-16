local lastQuestUpdate = {}

local event = Event()

event.onUpdateStorage = function(self, key, value, oldValue, isLogin)
    if isLogin then
        return
    end

    local playerId = self:getId()
    local now = os.mtime()
    if not lastQuestUpdate[playerId] then
        lastQuestUpdate[playerId] = now
    end

    if lastQuestUpdate[playerId] - now <= 0 and Game.isQuestStorage(key, value, oldValue) then
        lastQuestUpdate[playerId] = os.mtime() + 100
        self:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your questlog has been updated.\nView your questlog for more information.")
    end

    local trackedQuests = Game.getTrackedQuests()[playerId] or {}
    for mission, quest in pairs(trackedQuests) do
        if quest:isTracking(key, value) then
            self:sendUpdateQuestTracker(mission)
        end
    end
end

event:register()