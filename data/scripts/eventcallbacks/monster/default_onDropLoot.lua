local event = Event()

event.onDropLoot = function(self, corpse)

	local mType = self:getType()
	if mType:isRewardBoss() then
		corpse:registerReward()
		return
	end
	
	if configManager.getNumber(configKeys.RATE_LOOT) == 0 then
		return
	end

	local player = Player(corpse:getCorpseOwner())
	local mType = self:getType()
	if not player or player:getStamina() > 840 then
		local monsterLoot = mType:getLoot()
		
		-- Boost Loot
		local percentLoot = 0
		if player:getStorageValue(Storage.STORAGEVALUE_LOOT_TEMPO) > os.time() then
			local potion = lootPotion[player:getStorageValue(Storage.STORAGEVALUE_LOOT_ID)]
			if potion then
				percentLoot = (potion.exp / 100)
			end
		end
		
		local lootBonus = 0
		local guild = player:getGuild()
		if guild then
		local level = guild:getLevel()
			if GuildLevel.level_experience[level] then
				local lootBonusPercent = GuildLevel.level_experience[level].exp
				local lootBonus = (lootBonusPercent / 34)
				lootBonus = (lootBonus)
			end
		end
		
		-- Boost Creature
		local percent = 0
		if (mType:getName():lower() == capitalizeFirstLetter(boostCreature[2].name_loot):lower()) then
			player:sendTextMessage(MESSAGE_STATUS_DEFAULT, "[Boosted Creature] You have killed a "..mType:getName().." with Bonus Loot.")
			percent = (boostCreature[1].loot / 100)
		end
		
		local percent_boss = 0
		if (mType:getName():lower() == capitalizeFirstLetter(boostCreature[3].name_boss):lower()) then
			player:sendTextMessage(MESSAGE_STATUS_DEFAULT, "[Boosted Creature] You have killed a "..mType:getName().." with Bonus Loot.")
			percent_boss = (boostCreature[1].loot / 100)
		end
		
		

		for i = 1, #monsterLoot do
			monsterLoot[i].chance = monsterLoot[i].chance + (monsterLoot[i].chance * percent) + (monsterLoot[i].chance * percent_boss) + (monsterLoot[i].chance * percentLoot) + (monsterLoot[i].chance * lootBonus)
			local item = corpse:createLootItem(monsterLoot[i])
			if not item then
				print('[Warning] DropLoot:', 'Could not add loot item to corpse.')
			end
		end

		if player then
			local text = ("Loot of %s: %s."):format(mType:getNameDescription(), corpse:getContentDescription())
			local party = player:getParty()
			if party then
				party:broadcastPartyLoot(text)
			else
				if player:getStorageValue(Storage.STORAGEVALUE_LOOT) == 1 then
					sendChannelMessage(4, TALKTYPE_CHANNEL_O, text)
				else
					player:sendTextMessage(MESSAGE_INFO_DESCR, text)
				end
			end
		end
	else
		local text = ("Loot of %s: nothing (due to low stamina)."):format(mType:getNameDescription())
		local party = player:getParty()
		if party then
			party:broadcastPartyLoot(text)
		else
			if player:getStorageValue(Storage.STORAGEVALUE_LOOT) == 1 then
				sendChannelMessage(4, TALKTYPE_CHANNEL_O, text)
			else
				player:sendTextMessage(MESSAGE_INFO_DESCR, text)
			end
		end
	end
end

event:register()
