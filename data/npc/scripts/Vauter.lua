local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end
function onPlayerCloseChannel(cid) npcHandler:onPlayerCloseChannel(cid) end

npcHandler:addModule(FocusModule:new())

function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end
local player = Player(cid)
local msg = msg:lower()
------------------------------------------------------------------
if npcHandler.topic[cid] == 0 and msg == 'normal' then
    npcHandler:say("Excellent. What monster task would you like to do? You can see the list saying {normal task list}.", cid)
    npcHandler.topic[cid] = 1
elseif npcHandler.topic[cid] == 1 then
    if player:getStorageValue(task_sto_time) < os.time() then
        if player:getStorageValue(task_storage) == -1 then 
            for mon, l in ipairs(task_monsters) do
                if msg == l.name:lower() then
                    if not l.premium_required or (l.premium_required and player:isPremium()) then
                        if taskRank_get(player) >= l.taskp_required then
                            if player:getLevel() >= l.level_required then
                                npcHandler:say("Ok, now you are doing the task of {" .. l.name:gsub("^%a", string.upper) .. "}, you need to {kill " .. l.amount .. "} from them. To see the {status} you can see using {!task} or using the {task board}. Good luck!", cid)
                                player:setStorageValue(task_storage, mon)
                                player:setStorageValue(task_timer, os.time())
                                player:setStorageValue(l.storage, 0)
                                player:openChannel(10) -- Task Channel
                                npcHandler.topic[cid] = 0
                                npcHandler:releaseFocus(cid)
                            else
                                npcHandler:say("You do not have the {necessary level} to request this task, you need to be level {" .. l.level_required .. "} to ask for it.", cid)
                                npcHandler.topic[cid] = 0
                                npcHandler:releaseFocus(cid)
                            end
                        else
                            npcHandler:say("You do not have enough {Task Points} to request this task, you need to have at least {" .. l.taskp_required .. " Task Points}.", cid)
                            npcHandler.topic[cid] = 0
                            npcHandler:releaseFocus(cid)
                        end
                    else
                        npcHandler:say("You need to be {Premium} to choose this task.", cid)
                        npcHandler.topic[cid] = 0
                        npcHandler:releaseFocus(cid)
                    end
                    break
                elseif mon == #task_monsters then
                    npcHandler:say("Sorry, but we don't have that {normal} task.", cid)
                    npcHandler.topic[cid] = 0
                    npcHandler:releaseFocus(cid)
                end
            end
        else
            npcHandler:say("You are already doing a {normal} task. You can only do one at a time. Say {!task} to see information about your current task.", cid)
            npcHandler.topic[cid] = 0
            npcHandler:releaseFocus(cid)
        end
    else
        npcHandler:say("I am not allowed to give you any tasks because you abandoned the previous one. Wait for {"..task_time.." hours} of punishment.", cid)
        npcHandler.topic[cid] = 0
        npcHandler:releaseFocus(cid)
    end
	
	
elseif npcHandler.topic[cid] == 0 and msg == 'daily' or msg == 'diária' then
	if player:getStorageValue(time_daySto) < os.time() then
		npcHandler:say("Remember that the {daily tasks} change {every day}, when you choose a task you will only have {24 hours} to finish otherwise it will be {deleted} and you will have to wait {another 24 hours}. Now what task do {you want to do}? To find out what the {daily tasks} are, just say {lists of daily task} or go to the {task board} found in the {city depots}.", cid)
		npcHandler.topic[cid] = 2
	else
		npcHandler:say('You completed a {daily task} today, expect to spend {24 hours} to do it again.', cid)
		npcHandler.topic[cid] = 0
		npcHandler:releaseFocus(cid)
	end
elseif npcHandler.topic[cid] == 2 then
      if player:getStorageValue(task_sto_time) < os.time() then
         if player:getStorageValue(taskd_storage) == -1 then 
            local currentDay = os.date("%A") -- Obtener el día actual en formato de texto
            local dailyTasks = task_daily[currentDay] -- Obtener las tareas diarias correspondientes al día actual

            if dailyTasks then
               for mon, l in ipairs(dailyTasks) do 
                  if msg == l.name:lower() then
                     if not l.premium_required or (l.premium_required and player:isPremium()) then
                        if taskRank_get(player) >= l.taskp_required then
                           if player:getLevel() >= l.level_required then 
                              npcHandler:say("Alright, now you are doing a daily task {" .. l.name:gsub("^%a", string.upper) .. "}, you need to {kill "..l.amount.."} from them. To see the {status} you can see using {!task} or using the {task board}, remember that you have {24 hours} to {complete the task}. Good luck!", cid)
                              player:setStorageValue(taskd_storage, mon)
                              player:setStorageValue(l.storage, 0)
                              player:setStorageValue(task_timerdaily_2, os.time() + 1 * 60 * 60 * 24)
                              player:openChannel(10) -- Task Channel
                              player:setStorageValue(task_timerdaily, os.time())
                              npcHandler.topic[cid] = 0
                              npcHandler:releaseFocus(cid)
                           else
                              npcHandler:say("You do not have the {necessary level} to request this task, you need to be level {" .. l.level_required .. "} to ask for it.", cid)
                              npcHandler.topic[cid] = 0
                              npcHandler:releaseFocus(cid)
                           end
                        else
                           npcHandler:say("You do not have enough {Task Points} to request this task, you need to have at least {" .. l.taskp_required .. " Task Points}.", cid)
                           npcHandler.topic[cid] = 0
                           npcHandler:releaseFocus(cid)
                        end
                     else
                        npcHandler:say("You need to be a {VIP} to request this task.", cid)
                        npcHandler.topic[cid] = 0
                        npcHandler:releaseFocus(cid)
                     end
                     break
                  elseif mon == #dailyTasks then
                     npcHandler:say("You need to be {Premium} to choose this task.", cid)
                     npcHandler.topic[cid] = 0
                     npcHandler:releaseFocus(cid)
                  end
               end
            else
               npcHandler:say("No hay tareas diarias disponibles para hoy.", cid)
               npcHandler.topic[cid] = 0
               npcHandler:releaseFocus(cid)
            end
         else
            npcHandler:say("You are already doing a {daily} task. You can only do one a day. Say {!task} to view information about your current task, remember that you have {24 hours} to {complete the task}.", cid)
            npcHandler.topic[cid] = 0
            npcHandler:releaseFocus(cid)
         end
      else
         npcHandler:say("I am not allowed to give you any tasks because you {abandoned} the previous one. Wait for {"..task_time.." hours} of punishment.", cid)
         npcHandler.topic[cid] = 0
         npcHandler:releaseFocus(cid)
      end
	
	
	
elseif npcHandler.topic[cid] == 0 and (msg == 'special' or msg == 'specials') then
    if player:getStorageValue(time_dayStoSpecial) < os.time() then
        npcHandler:say('These task {specials} are {very important}, you can {receive valuable prizes}, now tell me which one do you want to start with?, you can see the list saying {lists of task special}.', cid)
        npcHandler.topic[cid] = 5
    else
        npcHandler:say('You completed a {special task} today, expect to spend {48 hours} to do it again.', cid)
        npcHandler.topic[cid] = 0
        npcHandler:releaseFocus(cid)
    end
elseif npcHandler.topic[cid] == 5 then
    if player:getStorageValue(task_sto_time) < os.time() then
        if player:getStorageValue(tasks_storage) == -1 then 
            for mon, l in ipairs(task_special) do 
                if msg == l.name:lower() then
                    if not l.premium_required or (l.premium_required and player:isPremium()) then
                        if taskRank_get(player) >= l.taskp_required then
                            if player:getLevel() >= l.level_required then
                                npcHandler:say("Perfect, you have chosen the special task of {" .. l.name:gsub("^%a", string.upper) .. "}, you need to {kill "..l.amount.."} from them. To see the {status} you can see using {!task} or using the {task board}. Good luck!", cid)
                                player:setStorageValue(tasks_storage, mon)
                                player:setStorageValue(l.storage, 0)
                                player:openChannel(10) -- Task Channel
                                player:setStorageValue(task_timerspecial, os.time())
                                npcHandler.topic[cid] = 0
                                npcHandler:releaseFocus(cid)
                            else
                                npcHandler:say("You do not have the {necessary level} to request this task, you need to be level {" .. l.level_required .. "} to ask for it.", cid)
                                npcHandler.topic[cid] = 0
                                npcHandler:releaseFocus(cid)
                            end
                        else
                            npcHandler:say("You do not have enough {Task Points} to request this task, you need to have at least {" .. l.taskp_required .. " Task Points}.", cid)
                            npcHandler.topic[cid] = 0
                            npcHandler:releaseFocus(cid)
                        end
                    else
                        npcHandler:say("You need to be {Premium} to choose this task.", cid)
                        npcHandler.topic[cid] = 0
                        npcHandler:releaseFocus(cid)
                    end
                    break
                elseif mon == #task_special then
                    npcHandler:say("Sorry, we don't have this {special} task.", cid)
                    npcHandler.topic[cid] = 0
                    npcHandler:releaseFocus(cid)
                end
            end
        else
            npcHandler:say("You are already doing a {special} task. You can only do one a day. Say {!task} to view information about your current task.", cid)
            npcHandler.topic[cid] = 0
            npcHandler:releaseFocus(cid)
        end
    else
        npcHandler:say("I am not allowed to give you any tasks because you {abandoned} the previous one. wait for {"..task_time.." hours} of punishment.", cid)
        npcHandler.topic[cid] = 0
        npcHandler:releaseFocus(cid)
    end
	
elseif msg == 'receive' or msg == 'receber' then
	if npcHandler.topic[cid] == 0 then
		npcHandler:say("What kind of task did you finish, {normal}, {daily} or {special} ?", cid)
		npcHandler.topic[cid] = 3
	end
elseif npcHandler.topic[cid] == 3 then
	if msgcontains(msg, 'normal') then
	local ret_t = getTaskInfos(player)
		if ret_t then
			if player:getStorageValue(ret_t.storage) == ret_t.amount then
				local boss_access = ret_t.boss_access
				if boss_access and player:getStorageValue(boss_access.storage) ~= 1 then
					player:setStorageValue(boss_access.storage, 1)
					player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have gained access to the boss "..boss_access.name ..".")
				end
				local pt1 = ret_t.pointsTask[1]
				local pt2 = ret_t.pointsTask[2]
				local txt = 'Congratulations on completing the task, their prizes are: {'..(pt1 > 1 and pt1..' task points' or pt1 <= 1 and pt1..' task point}')..'} and {'..(pt2 > 1 and pt2..' rank points' or pt2 <= 1 and pt2..' rank point}')..', '
				
				-- Items Normal (Repeat)
				if #getItemsFromTable(ret_t.items) > 0 then
                    txt = txt..'in addition to receiving: {'..getItemsFromTable(ret_t.items)..'}, '
                    -- Agrega los elementos de la línea items a la mochila del jugador
                    for g = 1, #ret_t.items do
                        player:addItem(ret_t.items[g].id, ret_t.items[g].count)
                    end
                end
				
				-- Items Special (Unique)
				if #getItemsFromTable(ret_t.items_special) > 0 then
                    local monsterName = ret_t.name
                    local monsterStorage = ret_t.storage .. "_" .. monsterName
                    if player:getStorageValue(monsterStorage) ~= 1 then
                        txt = txt..'and special items: {'..getItemsFromTable(ret_t.items_special)..'}, '
                        for g = 1, #ret_t.items_special do
                            player:addItem(ret_t.items_special[g].id, ret_t.items_special[g].count)
                        end
                        player:setStorageValue(monsterStorage, 1)
                    end
                end
		
				local exp = ret_t.exp
				if exp > 0 then
					txt = txt..'I will also give you {'..exp..' experience}, '
					player:addExperience(exp)
				end

				taskPoints_add(player, pt1)
				taskRank_add(player, pt2)
				player:clearStorageValue(ret_t.storage)
				player:clearStorageValue(task_storage)
				player:clearStorageValue(task_timer)
				player:getPosition():sendMagicEffect(CONST_ME_GIFT_WRAPS)
				npcHandler:say(txt..' see you soon.', cid)
				npcHandler.topic[cid] = 0
				npcHandler:releaseFocus(cid)
			else
				npcHandler:say('You haven\'t finished the task yet, {come back} when you finish it.', cid)
				npcHandler.topic[cid] = 0
				npcHandler:releaseFocus(cid)
			end
		else
			npcHandler:say("You are not in any task.", cid)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		end
	elseif npcHandler.topic[cid] == 3 and msg == 'daily' or msg == 'diária' then
		if player:getStorageValue(time_daySto)-os.time() <= 0 then
			local ret_td = getTaskDailyInfo(player)
				if ret_td then
					if player:getStorageValue(getTaskDailyInfo(player).storage) == getTaskDailyInfo(player).amount then
					local boss_access = ret_td.boss_access
					if boss_access and player:getStorageValue(boss_access.storage) ~= 1 then
						player:setStorageValue(boss_access.storage, 1)
						player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have gained access to the boss "..boss_access.name ..".")
					end
					local pt1 = getTaskDailyInfo(player).pointsTask[1]
					local pt2 = getTaskDailyInfo(player).pointsTask[2]
					local txt = 'Congratulations on completing the task, their prizes are: {'..(pt1 > 1 and pt1..' task points' or pt1 <= 1 and pt1..' task point}')..' and {'..(pt2 > 1 and pt2..' rank points' or pt2 <= 1 and pt2..' rank point}')..', '
						
						if #getTaskDailyInfo(player).items > 0 then
							txt = txt..'besides winning: {'..getItemsFromTable(getTaskDailyInfo(player).items)..'}, '
							for g = 1, #getTaskDailyInfo(player).items do
								player:addItem(getTaskDailyInfo(player).items[g].id, getTaskDailyInfo(player).items[g].count)
							end
						end
						
						-- Items Special (Unique)
						if #getItemsFromTable(ret_td.items_special) > 0 then
							local monsterName = ret_td.name
							local monsterStorage = ret_td.storage .. "_" .. monsterName
							if player:getStorageValue(monsterStorage) ~= 1 then
								txt = txt..'and special items: {'..getItemsFromTable(ret_td.items_special)..'}, '
								for g = 1, #ret_td.items_special do
									player:addItem(ret_td.items_special[g].id, ret_td.items_special[g].count)
								end
								player:setStorageValue(monsterStorage, 1)
							end
						end
						
						
						local exp = getTaskDailyInfo(player).exp
						if exp > 0 then
							txt = txt..'I will also give you {'..exp..' experience}, '
							player:addExperience(exp)
						end
						npcHandler:say(txt..' see you soon.', cid)
						taskPoints_add(player, pt1)
						taskRank_add(player, pt2)
						player:getPosition():sendMagicEffect(CONST_ME_GIFT_WRAPS)
						player:clearStorageValue(getTaskDailyInfo(player).storage)
						player:clearStorageValue(task_timerdaily)
						player:clearStorageValue(taskd_storage)
						player:setStorageValue(time_daySto, 1 * 60 * 60 * 24+os.time())
						npcHandler.topic[cid] = 0
						npcHandler:releaseFocus(cid)
					else
						npcHandler:say('You haven\'t finished the task yet, {come back} when you finish it.', cid)
						npcHandler.topic[cid] = 0
						npcHandler:releaseFocus(cid)
					end
				else
					npcHandler:say("You are not in any task.", cid)
					npcHandler.topic[cid] = 0
					npcHandler:releaseFocus(cid)
				end
		else
			npcHandler:say("Once you have done a {daily task}, {wait 24 hours} to do another one.", cid)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		end
		
	elseif npcHandler.topic[cid] == 3 and msg == 'special' or msg == 'specials' then
		if player:getStorageValue(time_dayStoSpecial)-os.time() <= 0 then
		local ret_ts = getTaskSpecialInfo(player)
			if ret_ts then
				if player:getStorageValue(getTaskSpecialInfo(player).storage) == getTaskSpecialInfo(player).amount then
				local boss_access = ret_ts.boss_access
					if boss_access and player:getStorageValue(boss_access.storage) ~= 1 then
						player:setStorageValue(boss_access.storage, 1)
						player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have gained access to the boss "..boss_access.name ..".")
					end
					local pt1 = getTaskSpecialInfo(player).pointsTask[1]
					local pt2 = getTaskSpecialInfo(player).pointsTask[2]
					local txt = 'Congratulations on completing the task, their prizes are: {'..(pt1 > 1 and pt1..' task points' or pt1 <= 1 and pt1..' task point}')..' and {'..(pt2 > 1 and pt2..' rank points' or pt2 <= 1 and pt2..' rank point}')..', '
					
					if #getTaskSpecialInfo(player).items > 0 then
						txt = txt..'besides winning: {'..getItemsFromTable(getTaskSpecialInfo(player).items)..'}, '
						for g = 1, #getTaskSpecialInfo(player).items do
							player:addItem(getTaskSpecialInfo(player).items[g].id, getTaskSpecialInfo(player).items[g].count)
						end
					end
					
					-- Items Special (Unique)
					if #getItemsFromTable(ret_ts.items_special) > 0 then
						local monsterName = ret_ts.name
						local monsterStorage = ret_ts.storage .. "_" .. monsterName
						if player:getStorageValue(monsterStorage) ~= 1 then
							txt = txt..'and special items: {'..getItemsFromTable(ret_ts.items_special)..'}, '
							for g = 1, #ret_ts.items_special do
								player:addItem(ret_ts.items_special[g].id, ret_ts.items_special[g].count)
							end
							player:setStorageValue(monsterStorage, 1)
						end
					end
					
					local exp = getTaskSpecialInfo(player).exp
					if exp > 0 then
					txt = txt..'I will also give you {'..exp..' experience}, '
					player:addExperience(exp)
					end
					npcHandler:say(txt..' see you soon.', cid)
					taskPoints_add(player, pt1)
					taskRank_add(player, pt2)
					player:getPosition():sendMagicEffect(CONST_ME_GIFT_WRAPS)
					player:clearStorageValue(getTaskSpecialInfo(player).storage)						
					player:clearStorageValue(tasks_storage)
					player:clearStorageValue(task_timerspecial)
					player:setStorageValue(time_dayStoSpecial, 1 * 60 * 60 * 24+os.time())
					npcHandler.topic[cid] = 0
					npcHandler:releaseFocus(cid)
				else
					npcHandler:say('You haven\'t finished the task yet, {come back} when you finish it.', cid)
					npcHandler.topic[cid] = 0
					npcHandler:releaseFocus(cid)
				end
			else
				npcHandler:say("You are not in any task.", cid)
				npcHandler.topic[cid] = 0
				npcHandler:releaseFocus(cid)
			end
		else
			npcHandler:say("Once you have done a {daily task}, {wait 24 hours} to do another one.", cid)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		end
		
	end

elseif msg == 'abandon' or msg == 'abandonar' then
	if npcHandler.topic[cid] == 0 then
		npcHandler:say("What a pity, what kind of task do you want to leave?, {normal}, {daily} or {special}?", cid)
		npcHandler.topic[cid] = 4
	end
elseif npcHandler.topic[cid] == 4 and msgcontains(msg, 'normal') then
	local ret_t = getTaskInfos(player)
	if ret_t then
		npcHandler:say('Unfortunately this situation, I had faith that you would bring me this task, but I was wrong. How punishment will be {'..task_time..' hours} unable to perform any tasks.', cid)
		player:setStorageValue(task_sto_time, os.time()+task_time*60*60)
		player:clearStorageValue(ret_t.storage)
		player:clearStorageValue(task_storage)
		player:clearStorageValue(task_timer)
		npcHandler.topic[cid] = 0
		npcHandler:releaseFocus(cid)
	else
		npcHandler:say("You are not doing any task so you can abandon it.", cid)
		npcHandler.topic[cid] = 0
		npcHandler:releaseFocus(cid)
	end
elseif npcHandler.topic[cid] == 4 and msg == 'daily' or msg == 'diária' then
	local ret_td = getTaskDailyInfo(player)
	if ret_td then
		npcHandler:say('Unfortunately this situation, I had faith that you would bring me this task, but I was wrong. How punishment will be {'..task_time..' hours} unable to perform any tasks.', cid)
		player:setStorageValue(task_sto_time, os.time()+task_time*60*60)
		player:clearStorageValue(ret_td.storage)
		player:clearStorageValue(taskd_storage)
		player:clearStorageValue(task_timerdaily)
		npcHandler.topic[cid] = 0
		npcHandler:releaseFocus(cid)
	else
		npcHandler:say("You are not doing any task so you can abandon it.", cid)
		npcHandler.topic[cid] = 0
		npcHandler:releaseFocus(cid)
	end
elseif npcHandler.topic[cid] == 4 and msg == 'special' or msg == 'specials' then
	local ret_ts = getTaskSpecialInfo(player)
	if ret_ts then
		npcHandler:say('Unfortunately this situation, I had faith that you would bring me this task, but I was wrong. How punishment will be {'..task_time..' hours} unable to perform any tasks.', cid)
		player:setStorageValue(task_sto_time, os.time()+task_time*60*60)
		player:clearStorageValue(ret_ts.storage)
		player:clearStorageValue(taskd_storage)
		player:clearStorageValue(task_timerspecial)
		npcHandler.topic[cid] = 0
		npcHandler:releaseFocus(cid)
	else
		npcHandler:say("You are not doing any task so you can abandon it.", cid)
		npcHandler.topic[cid] = 0
		npcHandler:releaseFocus(cid)
	end
elseif msg == "normal task list" or msg == "lista de normal task" or msg == "lists of normal task" or msg == "list of normal task" then
	local text = "----**| -> Normal Tasks <- |**----\n\n"
	
		for i = 1, 52 do
		local d = task_monsters[i]

		text = text .. "------ [*] " .. d.name .. " [*] ------\n"
		text = text .. "[+] Count [+] -> [" .. (player:getStorageValue(d.storage) + 1) .. "/" .. d.amount .. "]\n"
		
		if d.taskp_required >= 20 then
			text = text .. "[+] Required Task Points [+] -> " .. d.taskp_required .. "\n"
		end
		
		-- Check if premium_required is true
		if d.premium_required then
			text = text .. "[+] Premium Required [+] -> Yes\n"
		end

		-- Check if items exist in the table
		if d.items and #d.items > 0 then
			text = text .. "[+] Rewards [+] -> "
			for j = 1, #d.items do
				local item = d.items[j]
				local itemName = getItemName(item.id)
				text = text .. item.count .. "x " .. itemName .. ", "
			end
			text = text:sub(1, -3) .. "\n"
		end

		-- Check if items_special exist in the table
		if d.items_special and #d.items_special > 0 then
			text = text .. "[+] Special Rewards [+] -> "
			for k = 1, #d.items_special do
				local itemSpecial = d.items_special[k]
				local itemSpecialName = getItemName(itemSpecial.id)
				text = text .. itemSpecial.count .. "x " .. itemSpecialName .. ", "
			end
			text = text:sub(1, -3) .. "\n"
		end

		-- Check if boss_access exists in the table
		if d.boss_access then
			text = text .. "[+] Boss Access [+] -> " .. d.boss_access.name .. "\n"
		end

			text = text .. "[+] Experience Reward [+] -> " .. d.exp .. "\n"
		end
	
		player:showTextDialog(9388, "" .. text)
		npcHandler:say("Here is the {list of normal} (level 1-100) tasks .", cid)
		
elseif msg == "normal intermediary list" or msg == "lista de normal intermediary task" or msg == "lists of normal intermediary task" then
	local text = "-| -> Normal Intermediary Tasks <- |-\n\n"
	
		for i = 53, 83 do
		local d = task_monsters[i]

		text = text .. "------ [*] " .. d.name .. " [*] ------\n"
		text = text .. "[+] Count [+] -> [" .. (player:getStorageValue(d.storage) + 1) .. "/" .. d.amount .. "]\n"
		
		if d.taskp_required >= 20 then
			text = text .. "[+] Required Task Points [+] -> " .. d.taskp_required .. "\n"
		end
		
		if d.level_required then
			text = text .. "[+] Level Required [+] -> " .. d.level_required .. "\n"
		end
		
		-- Check if premium_required is true
		if d.premium_required then
			text = text .. "[+] Premium Required [+] -> Yes\n"
		end

		-- Check if items exist in the table
		if d.items and #d.items > 0 then
			text = text .. "[+] Rewards [+] -> "
			for j = 1, #d.items do
				local item = d.items[j]
				local itemName = getItemName(item.id)
				text = text .. item.count .. "x " .. itemName .. ", "
			end
			text = text:sub(1, -3) .. "\n"
		end

		-- Check if items_special exist in the table
		if d.items_special and #d.items_special > 0 then
			text = text .. "[+] Special Rewards [+] -> "
			for k = 1, #d.items_special do
				local itemSpecial = d.items_special[k]
				local itemSpecialName = getItemName(itemSpecial.id)
				text = text .. itemSpecial.count .. "x " .. itemSpecialName .. ", "
			end
			text = text:sub(1, -3) .. "\n"
		end

		-- Check if boss_access exists in the table
		if d.boss_access then
			text = text .. "[+] Boss Access [+] -> " .. d.boss_access.name .. "\n"
		end

			text = text .. "[+] Experience Reward [+] -> " .. d.exp .. "\n\n"
		end

		player:showTextDialog(9388, "" .. text)
		npcHandler:say("Here is the {list of normal intermediary} (level 100) tasks .", cid)
		
elseif msg == "normal superior list" or msg == "lista de normal superior task" or msg == "lists of normal superior task" then
	local text = "-| -> Normal Superior Tasks <- |-\n\n"
	
		for i = 84, #task_monsters do
		local d = task_monsters[i]

		text = text .. "------ [*] " .. d.name .. " [*] ------\n"
		text = text .. "[+] Count [+] -> [" .. (player:getStorageValue(d.storage) + 1) .. "/" .. d.amount .. "]\n"
		
		if d.taskp_required >= 25 then
			text = text .. "[+] Required Task Points [+] -> " .. d.taskp_required .. "\n"
		end
		
		if d.level_required then
			text = text .. "[+] Level Required [+] -> " .. d.level_required .. "\n"
		end
		
		-- Check if premium_required is true
		if d.premium_required then
			text = text .. "[+] Premium Required [+] -> Yes\n"
		end

		-- Check if items exist in the table
		if d.items and #d.items > 0 then
			text = text .. "[+] Rewards [+] -> "
			for j = 1, #d.items do
				local item = d.items[j]
				local itemName = getItemName(item.id)
				text = text .. item.count .. "x " .. itemName .. ", "
			end
			text = text:sub(1, -3) .. "\n"
		end

		-- Check if items_special exist in the table
		if d.items_special and #d.items_special > 0 then
			text = text .. "[+] Special Rewards [+] -> "
			for k = 1, #d.items_special do
				local itemSpecial = d.items_special[k]
				local itemSpecialName = getItemName(itemSpecial.id)
				text = text .. itemSpecial.count .. "x " .. itemSpecialName .. ", "
			end
			text = text:sub(1, -3) .. "\n"
		end

		-- Check if boss_access exists in the table
		if d.boss_access then
			text = text .. "[+] Boss Access [+] -> " .. d.boss_access.name .. "\n"
		end

			text = text .. "[+] Experience Reward [+] -> " .. d.exp .. "\n\n"
		end

		player:showTextDialog(9388, "" .. text)
		npcHandler:say("Here is the {lists of normal superior} (level 150) tasks .", cid)
			
elseif msg == "daily task list" or msg == "lista de task diária" or msg == "lists of daily task" then
	local text = "----**| -> Daily's Tasks <- |**----\n\n"
	
	local currentDay = os.date("%A") -- Obtener el día actual en formato de texto
      
      local dailyTasks = task_daily[currentDay] -- Obtener las tareas correspondientes al día actual
      
      if dailyTasks then
         for i = 1, #dailyTasks do
            local d = dailyTasks[i]

            text = text .. "------ [*] " .. d.name .. " [*] ------\n"
            text = text .. "[+] Count [+] -> [" .. (player:getStorageValue(d.storage) + 1) .. "/" .. d.amount .. "]\n"
            
            if d.taskp_required >= 5 then
               text = text .. "[+] Required Task Points [+] -> " .. d.taskp_required .. "\n"
            end
            
            if d.level_required then
               text = text .. "[+] Level Required [+] -> " .. d.level_required .. "\n"
            end
            
            -- Check if premium_required is true
            if d.premium_required then
               text = text .. "[+] Premium Required [+] -> Yes\n"
            end

            -- Check if items exist in the table
            if d.items and #d.items > 0 then
               text = text .. "[+] Rewards [+] -> "
               for j = 1, #d.items do
                  local item = d.items[j]
                  local itemName = getItemName(item.id)
                  text = text .. item.count .. "x " .. itemName .. ", "
               end
               text = text:sub(1, -3) .. "\n"
            end

            -- Check if items_special exist in the table
            if d.items_special and #d.items_special > 0 then
               text = text .. "[+] Special Rewards [+] -> "
               for k = 1, #d.items_special do
                  local itemSpecial = d.items_special[k]
                  local itemSpecialName = getItemName(itemSpecial.id)
                  text = text .. itemSpecial.count .. "x " .. itemSpecialName .. ", "
               end
               text = text:sub(1, -3) .. "\n"
            end

            -- Check if boss_access exists in the table
            if d.boss_access then
               text = text .. "[+] Boss Access [+] -> " .. d.boss_access.name .. "\n"
            end

            text = text .. "[+] Experience Reward [+] -> " .. d.exp .. "\n\n"
         end
      else
         text = text .. "No {daily tasks} today, come back tomorrow.\n"
      end

      player:showTextDialog(9388, "" .. text)
	  npcHandler:say("Here is the {lists of daily} tasks, these tasks are updated {every day}, be {pending} every day.", cid)
	
elseif msg == "special task list" or msg == "lista de especial task" or msg == "lists of special task" then
	local text = "----**| -> Special's Tasks <- |**----\n\n"
		for i = 1, #task_special do
		local d = task_special[i]

		text = text .. "------ [*] " .. d.name .. " [*] ------\n"
		text = text .. "[+] Count [+] -> [" .. (player:getStorageValue(d.storage) + 1) .. "/" .. d.amount .. "]\n"
		
		if d.taskp_required >= 10 then
			text = text .. "[+] Required Task Points [+] -> " .. d.taskp_required .. "\n"
		end
		
		if d.level_required then
			text = text .. "[+] Level Required [+] -> " .. d.level_required .. "\n"
		end
		
		-- Check if premium_required is true
		if d.premium_required then
			text = text .. "[+] Premium Required [+] -> Yes\n"
		end

		-- Check if items exist in the table
		if d.items and #d.items > 0 then
			text = text .. "[+] Rewards [+] -> "
			for j = 1, #d.items do
				local item = d.items[j]
				local itemName = getItemName(item.id)
				text = text .. item.count .. "x " .. itemName .. ", "
			end
			text = text:sub(1, -3) .. "\n"
		end

		-- Check if items_special exist in the table
		if d.items_special and #d.items_special > 0 then
			text = text .. "[+] Special Rewards [+] -> "
			for k = 1, #d.items_special do
				local itemSpecial = d.items_special[k]
				local itemSpecialName = getItemName(itemSpecial.id)
				text = text .. itemSpecial.count .. "x " .. itemSpecialName .. ", "
			end
			text = text:sub(1, -3) .. "\n"
		end

		-- Check if boss_access exists in the table
		if d.boss_access then
			text = text .. "[+] Boss Access [+] -> " .. d.boss_access.name .. "\n"
		end

			text = text .. "[+] Experience Reward [+] -> " .. d.exp .. "\n\n"
		end

		player:showTextDialog(9388, "" .. text)
		npcHandler:say("Here is the {lists of specials} tasks.", cid)
		
	end
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)