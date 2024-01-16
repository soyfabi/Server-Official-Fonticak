local SZ = {
    Global = {
        playersCount = 32550;
        gameState = 32551;
    },

    Player = {
        Joined = 32552;
        Damaged = 32553;
    };

    Cache = {
        Players = {};
        Winners = {};
        Tiles = {};
    },

    EventArea = {
        From = Position(24994, 24996, 7);
        To = Position(25008, 25009, 7);
    },

    Entrance = {
        MinPlayers = 2;
        MaxPlayers = 25;
        LevelRequired = 25;

        MinutesToStart = 1;
        SecondsToInitiateEvent = 5;

        EventRoom = Position(24911, 25000, 5);
		EventTP = Position(25001, 25002, 7);
        Teleport = {
            ID = 1949;
            Position = Position(32367, 32233, 7);
            ActionId = 15000;
        }
    },

    Rewards = {
        -- Set Winners
        MaxWinners = 3;
        [1] = {{3043, 100}, {43511, 1}, {42502, 10}};
        [2] = {{3043, 50}, {42502, 5}};
        [3] = {{3043, 25}, {42502, 2}};
    },

    Outfits = {
        -- If LookType is 0, MainOutfit will be taken instead
        MainOutfit = 128;
        -- Every row represents a player life (3 = 3 hits to die)
        [1] = {LookType = 0, Head = 79, Body = 79, Legs = 79, Feet = 79, Addons = 0};
        [2] = {LookType = 0, Head = 77, Body = 77, Legs = 77, Feet = 77, Addons = 0};
        [3] = {LookType = 0, Head = 113, Body = 113, Legs = 113, Feet = 113, Addons = 0};
    },

    Tiles = {
        -- Fixed seconds: 15
        -- Random seconds: {5, 7, 10, 15}
        -- Based on players: 0 (formula is on CreateSafeTiles)
        Seconds = {5, 7, 10, 15};
        RemoveTilesPerWave = 1; -- you can create a table {1,2} to randomize
        GemIDs = {
            {8646, TEXTCOLOR_RED};
            {8647, TEXTCOLOR_BLUE};
            {8648, TEXTCOLOR_PINK};
            {8649, TEXTCOLOR_LIGHTGREEN};
        },
        ShowEffectWithPlayer = true;
    },

    Days = {
		['Monday'] = {'10:41:00'};
        ['Wednesday'] = {'16:00:00'};
    },

    PlayersCanThrowItems = false;
}

local PlayerConditions = {}
for i, v in ipairs(SZ.Outfits) do
    PlayerConditions[i] = Condition(CONDITION_OUTFIT, CONDITIONID_COMBAT)
    PlayerConditions[i]:setTicks(-1)
    PlayerConditions[i]:setOutfit({lookType = SZ.Outfits[i].LookType > 0 and SZ.Outfits[i].LookType or SZ.Outfits.MainOutfit, lookHead = SZ.Outfits[i].Head, lookBody = SZ.Outfits[i].Body, lookLegs = SZ.Outfits[i].Legs, lookFeet = SZ.Outfits[i].Feet, lookAddons = SZ.Outfits[i].Addons})
end

SZ.CacheEvent = function(self, ...)
    local userdata = self.Cache.Players
    local tiles = self.Cache.Tiles
    for i = 1, #{...} do
        local v = select(i, ...)
        if tostring(v) then
            if v == "clear" or v == "remove" then
                for name, _ in pairs(self.Cache) do
                    self.Cache[name] = {}
                end
            elseif v == "create" then
                for x = self.EventArea.From.x, self.EventArea.To.x do
                    for y = self.EventArea.From.y, self.EventArea.To.y do
                        local tile = Tile(x, y, self.EventArea.From.z)
                        if tile then
                            -- add tiles
                            tiles[#tiles + 1] = tile
                            -- add players from tiles
                            local players = tile:getCreatures()
                            if #players > 0 then
                                for i = 1, #players do
                                    local player = players[i]
                                    if not player:getGroup():getAccess() then
                                        self.Cache.Players[player.uid] = player
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

SZ.GetS = function(self, int, str)
    return (int > 1 and int.." "..str.."s" or int.." "..str)
end

SZ.KickPlayers = function(self)
    if Game.getStorageValue(self.Global.playersCount) > 0 then
        self:CacheEvent('create') -- we create a new cache, so we dont loop through onlineList
        for uid, _ in pairs(self.Cache.Players) do
            local player = Player(uid)
            if player then  
                player:setStorageValue(self.Player.Joined)
                player:teleportTo(player:getTown():getTemplePosition())
                player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
                player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, "Safezone event could not start due not enough players.")
            end
        end
        self:CacheEvent('remove')
    end
    Game.setStorageValue(self.Global.playersCount)
end

SZ.BroadcastPlayers = function(self, msg)
    for uid, _ in pairs(self.Cache.Players) do
        local player = Player(uid)
        if player then
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, msg)
        end
    end
end

SZ.ReturnPlayer = function(self, player, winnerId)
    if winnerId ~= 0 then
        local reward = "Congratulations! Reward: "
        local prize = self.Rewards
        local inbox = player:getInbox()

        local bag = Game.createItem(8861, 1)

        for i = 1, #prize[winnerId] do
            local item = ItemType(prize[winnerId][i][1])
            if item then
                local amount = prize[winnerId][i][2]
				 if (i > 1) then
                    if (i == #prize[winnerId]) then
                        reward = reward.." and "
                    else
                        reward = reward..", "
                    end
                end
                reward = reward..(amount == 1 and (item:getArticle().." "..item:getName()) or self:GetS(amount, item:getName()))
                bag:addItem(item:getId(), amount)
            end
        end

        inbox:addItemEx(bag, 1, INDEX_WHEREEVER, FLAG_NOLIMIT)

        self.Cache.Winners[winnerId] = player:getName()
        if winnerId == 1 then
            local winners = self.Cache.Winners
            local broadcast = "Safezone event has been ended, congratulations to the "..(#winners > 1 and self:GetS(#winners, "winner") or "winner")..":\n\n"
            for i = 1, #winners do
                broadcast = broadcast..(#winners > 1 and "["..i.."]" or "").." - "..winners[i].."\n"
            end
            Game.setStorageValue(SZ.Global.gameState)
            Game.setStorageValue(SZ.Global.playersCount)
            Game.broadcastMessage(broadcast, MESSAGE_EVENT_ADVANCE)
        end
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, reward..". Claim your reward in Inbox.")
    else
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, "You have lost in safezone.")
    end

    self.Cache.Players[player.uid] = nil
    player:setStorageValue(self.Player.Joined, -1)
    player:setStorageValue(self.Player.Damaged, -1)
    player:teleportTo(player:getTown():getTemplePosition())
    player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
    player:removeCondition(CONDITION_OUTFIT)
end

SZ.TileEffect = function(self, repeatTimes, tile, color)
    if tile then
        if (not tile:getTopCreature() or self.Tiles.ShowEffectWithPlayer) then
            Game.sendAnimatedText("SAFE ZONE", tile:getPosition(), color)
        end
    end

    if repeatTimes then
        for i = 1, repeatTimes do
            addEvent(function() self:TileEffect(nil, tile, color) end, i * 1000)
        end
    end
end

SZ.RemoveTiles = function(self)
    local tiles = self.Cache.Tiles
    local userdata = self.Cache.Players
    if #tiles > 0 then
        for i = 1, #tiles do
            local player
            local tile = tiles[i]
            local isProtected = false

            if tile then
                local ground = tile:getGround()  
                local creature = tile:getTopCreature()

                if creature and creature:isPlayer() and not creature:getGroup():getAccess() then
                    player = userdata[creature.uid] -- no need to verify since we know creature exist
                end

                if ground then
                    if ground:getAttribute('aid') > 0 then
                        local item = tile:getItemById(ground:getAttribute('aid'))
                        if item then
                            item:remove()
                        end
                        ground:setAttribute('aid', 0)
                        isProtected = true
                    end
                end

                if player then
                    Game.sendAnimatedText(isProtected and "PROTECTED!" or "DAMAGED!", player:getPosition(), isProtected and TEXTCOLOR_LIGHTGREEN or TEXTCOLOR_DARKRED)
                    player:getPosition():sendMagicEffect(isProtected and CONST_ME_WATERSPLASH or CONST_ME_FIREAREA)

                    if not (isProtected) then
                        player:setStorageValue(self.Player.Damaged, player:getStorageValue(self.Player.Damaged) + 1)
                        player:addCondition(PlayerConditions[player:getStorageValue(self.Player.Damaged)])

                        if player:getStorageValue(self.Player.Damaged) > #PlayerConditions then
                            local playersLeft = Game.getStorageValue(self.Global.playersCount)
                            self:ReturnPlayer(player, playersLeft <= self.Rewards.MaxWinners and playersLeft or 0)
                            Game.setStorageValue(self.Global.playersCount, playersLeft - 1)

                            if (playersLeft - 1) == 1 then
                                for uid, _ in pairs(self.Cache.Players) do
                                    local player = Player(uid)
                                    if player then
                                        self:ReturnPlayer(player, 1)
                                    end
                                end
                            end
                        end
                    end
                else
                    tile:getPosition():sendMagicEffect(CONST_ME_PLANTATTACK)
                end  
            end
        end
    end
    if not Game.getStorageValue(self.Global.playersCount) or Game.getStorageValue(self.Global.playersCount) == -1 then
        return self:CacheEvent('remove')
    end
    addEvent(function() self:CreateSafeTiles() end, 3500)
end

SZ.CreateSafeTiles = function(self)
    local tileSeconds = type(self.Tiles.Seconds) ~= "table" and (self.Tiles.Seconds > 0 and self.Tiles.Seconds or math.max(math.random(2, 3), math.ceil(self:PlayersCount() / 1.5))) + 1 or self.Tiles.Seconds[math.random(1, #self.Tiles.Seconds)]
    local tileAmount = type(self.Tiles.RemoveTilesPerWave) ~= "table" and math.max(1, (Game.getStorageValue(self.Global.playersCount) - self.Tiles.RemoveTilesPerWave)) or math.max(1, math.random(self.Tiles.RemoveTilesPerWave[1], self.Tiles.RemoveTilesPerWave[2]))
    local tilesCreated = 0

    local tiles = self.Cache.Tiles
    if #tiles > 0 then
        while tilesCreated < tileAmount do
            local tile = tiles[math.random(1, #tiles)]
            if tile then
                local ground = tile:getGround()
                if ground then
                    if ground:getAttribute('aid') < 1 then
                        if not tile:getTopCreature() then
                            local gemType = self.Tiles.GemIDs[math.random(1, #self.Tiles.GemIDs)]
                            tile:addItem(gemType[1], 1)
                            tile:getPosition():sendMagicEffect(CONST_ME_TUTORIALARROW)
                            self:TileEffect(tileSeconds, tile, gemType[2])
                            ground:setAttribute('aid', gemType[1])
                            tilesCreated = tilesCreated + 1
                        end
                    end
                end
            end
        end
    end
    self:BroadcastPlayers("[Safezone]\n"..self:GetS(tilesCreated, "tile").." has been created and will be removed in "..self:GetS(tileSeconds, "second")..".")
    addEvent(function() self:RemoveTiles() end, tileSeconds * 1000)
end

SZ.CleanTile = function(self, tile)
    if tile then
        local items = tile:getItems()
        local creatures = tile:getCreatures()
        for i = 1, (#items + #creatures) do
            if i <= #items then
                items[i]:remove()
            else
                local creature = creatures[i - #items]
                if creature:isPlayer() then
                    creature:teleportTo(creature:getTown():getTemplePosition())
                    creature:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
                else
                    creature:remove()
                end
            end
        end
    end
end

SZ.EventTeleport = function(self, createTeleport)
    local tile = Tile(self.Entrance.Teleport.Position)
    if tile then      
        if tile:getItemById(self.Entrance.Teleport.ID) then
            tile:getPosition():sendMagicEffect(CONST_ME_POFF)
        end
        self:CleanTile(tile)

        if createTeleport then          
            local teleport = tile:addItem(self.Entrance.Teleport.ID, 1)
            if teleport then
                teleport:setAttribute('aid', self.Entrance.Teleport.ActionId)
                teleport:setDestination(self.Entrance.EventRoom)
                tile:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            end
        end
    end  
end

SZ.Countdown = function(self, interval)
    if Game.getStorageValue(self.Global.gameState) == 2 then
        return
    end
    if interval <= 0 then
        if Game.getStorageValue(self.Global.playersCount) >= self.Entrance.MinPlayers then
            self:StartEvent(SZ.Entrance.SecondsToInitiateEvent)
            broadcastMessage("Safezone teleport has been closed, good luck all the participants!")
        else
            self:KickPlayers()
            self:EventTeleport(false)
            Game.setStorageValue(self.Global.gameState)
            broadcastMessage("Safezone event didnt start because number of players registered was not enough.")
        end
        return
    end

    local players = SZ.Entrance.MaxPlayers - Game.getStorageValue(SZ.Global.playersCount)
    Game.broadcastMessage("Safezone event"..(interval == SZ.Entrance.MinutesToStart and " is open and" or "").." will start in "..self:GetS(interval, "minute")..", "..self:GetS(players, "player").." can join to the event.", MESSAGE_EVENT_ADVANCE)

    interval = interval - 1
    addEvent(function() self:Countdown(interval) end, 60 * 1000)
end

SZ.StartEvent = function(self, seconds)
    self:CacheEvent('create')
    self:EventTeleport(false)
    for uid, _ in pairs (self.Cache.Players) do
        local player = Player(uid)
        if player then
            player:setStorageValue(SZ.Player.Damaged, 1)
            player:addCondition(PlayerConditions[player:getStorageValue(SZ.Player.Damaged)])
            player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Safezone event starts in ".. SZ.Entrance.SecondsToInitiateEvent .." seconds.")
			player:teleportTo(SZ.Entrance.EventTP)
        end
    end
    Game.setStorageValue(self.Global.gameState, 2)
    addEvent(function() self:CreateSafeTiles() end, seconds * 1000)
end

local eventTeleport = MoveEvent()
function eventTeleport.onStepIn(creature, item, position, fromPosition)
    if not creature:isPlayer() then
        return true
    end
    local player = creature
    local returnPosition = player:getTown():getTemplePosition()

    if player:getGroup():getAccess() then
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, "You have joined as spectator.")
        return player:teleportTo(SZ.Entrance.EventRoom)
    end

    if Game.getStorageValue(SZ.Global.gameState) ~= 1 then
        player:sendCancelMessage("Safezone event is closed.")
        return player:teleportTo(returnPosition)
    end

    if player:getLevel() < SZ.Entrance.LevelRequired then
        player:sendCancelMessage("Only players level "..SZ.Entrance.LevelRequired.." or higher can join the event.")
        return player:teleportTo(fromPosition, true)
    end

    local countStr = SZ.Global.playersCount
    Game.setStorageValue(countStr, Game.getStorageValue(countStr) + 1)

    -- add player
    player:setStorageValue(SZ.Player.Joined, 1)

    if Game.getStorageValue(countStr) >= SZ.Entrance.MaxPlayers then
        broadcastMessage("Safezone event is full, good luck all the participants!")
        broadcastMessage(player:getName().." has joined to Safezone Event as last participant.", MESSAGE_STATUS_CONSOLE_RED)
        SZ:StartEvent(SZ.Entrance.SecondsToInitiateEvent)
    else
        broadcastMessage(player:getName().." has joined to Safezone Event.", MESSAGE_STATUS_CONSOLE_ORANGE)
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Welcome to Safezone Event!")
    end
    return true
end

eventTeleport:aid(SZ.Entrance.Teleport.ActionId)
eventTeleport:register()

local openEvent = GlobalEvent("Safezone_Event")
function openEvent.onThink()
    if SZ.Days[os.date('%A')] then
        if table.contains(SZ.Days[os.date('%A')], os.date('%X', os.time())) then
            Game.setStorageValue(SZ.Global.playersCount, 0)
            Game.setStorageValue(SZ.Global.gameState, 1)

            SZ:Countdown(SZ.Entrance.MinutesToStart)
            SZ:EventTeleport(true)
        end
    end
    return true
end

openEvent:interval(1000)
openEvent:register()

local onThrow = Event()
function onThrow.onMoveItem(player, item, count, fromPosition, toPosition, fromCylinder, toCylinder)
    if not SZ.PlayersCanThrowItems then
        if not player:getGroup():getAccess() then
            if toPosition.x ~= CONTAINER_POSITION then
                if (player:getStorageValue(SZ.Player.Joined) == 1) then
                    return false
                end
            end
        end
    end
    return true
end
onThrow:register()

local event = Event()

function event.onSpellCheck(player, spell)
	if (player:getStorageValue(SZ.Player.Joined) == 1) then
		player:sendCancelMessage("You can't use spells in this event.")
		return false
	end
	return true
end

event:register()