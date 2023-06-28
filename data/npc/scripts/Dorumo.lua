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
		npcHandler:say("I am not allowed to give you any tasks because you abandoned the previous one. wait for {"..task_time.." hours} of punishment.", cid)
		npcHandler.topic[cid] = 0
		npcHandler:releaseFocus(cid)
	end
elseif npcHandler.topic[cid] == 0 and msg == 'daily' or msg == 'diária' then
	if player:getStorageValue(time_daySto) < os.time() then
		npcHandler:say("Remember, it is of great importance that the daily tasks are carried out. Now tell me, which monster task would you like to do?", cid)
		npcHandler.topic[cid] = 2
	else
		npcHandler:say('You completed a {daily task} today, expect to spend {24 hours} to do it again.', cid)
		npcHandler.topic[cid] = 0
		npcHandler:releaseFocus(cid)
	end
elseif npcHandler.topic[cid] == 2 then
	if player:getStorageValue(task_sto_time) < os.time() then
		if player:getStorageValue(taskd_storage) == -1 then 
			for mon, l in ipairs(task_daily) do 
				if msg == l.name:lower()  then
					npcHandler:say("Alright, now you are doing a daily task {" .. l.name:gsub("^%a", string.upper) .. "}, you need to {kill "..l.amount.."} from them. To see the {status} you can see using {!task} or using the {task board}. Good luck!", cid)
					player:setStorageValue(taskd_storage, mon)
					player:setStorageValue(l.storage, 0)
					player:openChannel(10) -- Task Channel
					player:setStorageValue(task_timerdaily, os.time())
					npcHandler.topic[cid] = 0
					npcHandler:releaseFocus(cid)
					break
				elseif mon == #task_daily then
					npcHandler:say("Sorry, we don't have this {daily} task.", cid)
					npcHandler.topic[cid] = 0
					npcHandler:releaseFocus(cid)
				end
			end
		else
			npcHandler:say("You are already doing a {daily} task. You can only do one a day. Say {!task} to view information about your current task.", cid)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		end
	else
		npcHandler:say("I am not allowed to give you any tasks because you {abandoned} the previous one. wait for {"..task_time.." hours} of punishment.", cid)
		npcHandler.topic[cid] = 0
		npcHandler:releaseFocus(cid)
	end
	
	
	
	elseif npcHandler.topic[cid] == 0 and msg == 'special' or msg == 'specials' then
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
				if msg == l.name:lower()  then
					npcHandler:say("Perfect, you have chosen the special task of {" .. l.name:gsub("^%a", string.upper) .. "}, you need to {kill "..l.amount.."} from them. To see the {status} you can see using {!task} or using the {task board}. Good luck!", cid)
					player:setStorageValue(tasks_storage, mon)
					player:setStorageValue(l.storage, 0)
					player:openChannel(10) -- Task Channel
					player:setStorageValue(task_timerspecial, os.time())
					npcHandler.topic[cid] = 0
					npcHandler:releaseFocus(cid)
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
				local pt1 = ret_t.pointsTask[1]
				local pt2 = ret_t.pointsTask[2]
				local txt = 'Congratulations on completing the task, their prizes are: {'..(pt1 > 1 and pt1..' task points' or pt1 <= 1 and pt1..' task point}')..' and {'..(pt2 > 1 and pt2..' rank points' or pt2 <= 1 and pt2..' rank point}')..', '
				if #getItemsFromTable(ret_t.items) > 0 then
					txt = txt..'besides winning: {'..getItemsFromTable(ret_t.items)..'}, '
				for g = 1, #ret_t.items do
					player:addItem(ret_t.items[g].id, ret_t.items[g].count)
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
					local pt1 = getTaskDailyInfo(player).pointsTask[1]
					local pt2 = getTaskDailyInfo(player).pointsTask[2]
					local txt = 'Congratulations on completing the task, their prizes are: {'..(pt1 > 1 and pt1..' task points' or pt1 <= 1 and pt1..' task point}')..' and {'..(pt2 > 1 and pt2..' rank points' or pt2 <= 1 and pt2..' rank point}')..', '
						if #getTaskDailyInfo(player).items > 0 then
							txt = txt..'besides winning: {'..getItemsFromTable(getTaskDailyInfo(player).items)..'}, '
						for g = 1, #getTaskDailyInfo(player).items do
							player:addItem(getTaskDailyInfo(player).items[g].id, getTaskDailyInfo(player).items[g].count)
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
				local pt1 = getTaskSpecialInfo(player).pointsTask[1]
				local pt2 = getTaskSpecialInfo(player).pointsTask[2]
				local txt = 'Congratulations on completing the task, their prizes are: {'..(pt1 > 1 and pt1..' task points' or pt1 <= 1 and pt1..' task point}')..' and {'..(pt2 > 1 and pt2..' rank points' or pt2 <= 1 and pt2..' rank point}')..', '
					if #getTaskSpecialInfo(player).items > 0 then
						txt = txt..'besides winning: {'..getItemsFromTable(getTaskSpecialInfo(player).items)..'}, '
					for g = 1, #getTaskSpecialInfo(player).items do
						player:addItem(getTaskSpecialInfo(player).items[g].id, getTaskSpecialInfo(player).items[g].count)
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
		npcHandler.topic[cid] = 0
		npcHandler:releaseFocus(cid)
	else
		npcHandler:say("You are not doing any task so you can abandon it.", cid)
		npcHandler.topic[cid] = 0
		npcHandler:releaseFocus(cid)
	end
elseif msg == "normal task list" or msg == "lista de task normal" or msg == "lists of task normal" then
	local text = "----**| -> Tasks Normal <- |**----\n\n"
		for _, d in pairs(task_monsters) do
			text = text .."------ [*] "..d.name.." [*] ------ \n[+] Count [+] -> ["..(player:getStorageValue(d.storage) + 1).."/"..d.amount.."]:\n[+] Rewards [+] -> "..(#d.items > 1 and getItemsFromTable(d.items).." - " or "")..""..d.exp.." experience \n\n"
		end

		player:showTextDialog(9388, "" .. text)
		npcHandler:say("Here is the list of normal tasks .", cid)
elseif msg == "daily task list" or msg == "lista de task diária" or msg == "lists of task daily" then
	local text = "----**| -> Tasks Daily's <- |**----\n\n"
		for _, d in pairs(task_daily) do
			text = text .."------ [*] "..d.name.." [*] ------ \n[+] Count [+] -> ["..(player:getStorageValue(d.storage) + 1).."/"..d.amount.."]:\n[+] Rewards [+] -> "..(#d.items > 1 and getItemsFromTable(d.items).." - " or "")..""..d.exp.." experience \n\n"
		end

		player:showTextDialog(9388, "" .. text)
		npcHandler:say("Here is the list of daily tasks.", cid)
elseif msg == "special task list" or msg == "lista de task diária" or msg == "lists of task special" then
	local text = "----**| -> Tasks Special's <- |**----\n\n"
		for _, d in pairs(task_special) do
			text = text .."------ [*] "..d.name.." [*] ------ \n[+] Count [+] -> ["..(player:getStorageValue(d.storage) + 1).."/"..d.amount.."]:\n[+] Rewards [+] -> "..(#d.items > 1 and getItemsFromTable(d.items).." - " or "")..""..d.exp.." experience \n\n"
		end

		player:showTextDialog(9388, "" .. text)
		npcHandler:say("Here is the list of tasks specials.", cid)
		
	end
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)