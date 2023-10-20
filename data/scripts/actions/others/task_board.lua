local taskboard = Action()

local exhaust = {}
local exhaustTime = 2

function taskboard.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	local playerId = player:getId()
    local currentTime = os.time()
    if exhaust[playerId] and exhaust[playerId] > currentTime then
		player:sendCancelMessage("You are on cooldown, wait (0." .. exhaust[playerId] - currentTime .. "s).")
		return true
	end
	
	-- Timer Task Normal
	local epochTime = player:getStorageValue(task_timer)
 
    local currentTime = os.time()
    local timeDifference = os.difftime(currentTime, epochTime)
	
	local hours = math.floor(timeDifference / 3600)
    local minutes = math.floor((timeDifference % 3600) / 60)
    local seconds = math.floor(timeDifference % 60)
	
	local elapsedTime
    if hours > 0 then
        elapsedTime = string.format("%d hours %d minutes %d seconds", hours, minutes, seconds)
    elseif minutes > 0 then
        elapsedTime = string.format("%d minutes %d seconds", minutes, seconds)
    else
        elapsedTime = string.format("%d seconds", seconds)
    end
	
	-- Timer Daily
	local epochTime_daily = player:getStorageValue(task_timerdaily)

    local timeDifference = os.difftime(currentTime, epochTime_daily)
	
	local hours = math.floor(timeDifference / 3600)
    local minutes = math.floor((timeDifference % 3600) / 60)
    local seconds = math.floor(timeDifference % 60)
	
	local elapsedTime_daily
    if hours > 0 then
        elapsedTime_daily = string.format("%d hours %d minutes %d seconds", hours, minutes, seconds)
    elseif minutes > 0 then
        elapsedTime_daily = string.format("%d minutes %d seconds", minutes, seconds)
    else
        elapsedTime_daily = string.format("%d seconds", seconds)
    end
	
	-- Timer Special
	local epochTime_special = player:getStorageValue(task_timerspecial)

    local timeDifference = os.difftime(currentTime, epochTime_special)
	
	local hours = math.floor(timeDifference / 3600)
    local minutes = math.floor((timeDifference % 3600) / 60)
    local seconds = math.floor(timeDifference % 60)
	
	local elapsedTime_special
    if hours > 0 then
        elapsedTime_special = string.format("%d hours %d minutes %d seconds", hours, minutes, seconds)
    elseif minutes > 0 then
        elapsedTime_special = string.format("%d minutes %d seconds", minutes, seconds)
    else
        elapsedTime_special = string.format("%d seconds", seconds)
    end
	
	function capitalizeSecondWord(str)
	local words = {}
	for word in str:gmatch("%S+") do
		table.insert(words, word)
	end

	if #words >= 1 then
		words[1] = words[1]:gsub("^%l", string.upper)
	end
	if #words >= 2 then
		words[2] = words[2]:gsub("^%l", string.upper)
	end
		return table.concat(words, " ")
	end
	
	local function firstStringToUpper(str)
		return (str:gsub("^%l", string.upper))
	end
	
	local function formatExp(exp)
    local formattedExp = tostring(exp)
    local formattedParts = {}

    while #formattedExp > 3 do
        table.insert(formattedParts, 1, formattedExp:sub(-3))
        formattedExp = formattedExp:sub(1, -4)
    end

    table.insert(formattedParts, 1, formattedExp)

		return table.concat(formattedParts, ".")
	end
	
	
	-------------------------------------------	
	local task_normal = getTaskInfos(player)
	local task_daily = getTaskDailyInfo(player)
	local task_special = getTaskSpecialInfo(player)
	
	--------NORMAL------------
	local combinedList = ""
	if task_normal then
		if task_normal.mons_list then
			local capitalizedMonsterList = {}
			for _, monsterName in ipairs(task_normal.mons_list) do
				local capitalizedMonsterName = capitalizeSecondWord(monsterName)
				table.insert(capitalizedMonsterList, capitalizedMonsterName)
			end
			combinedList = table.concat(capitalizedMonsterList, ", ")
			combinedList = capitalizeSecondWord(combinedList)
		end
	end	
	--------DAILY------------
	local capitalizedMonsterList2 = {}
	if task_daily then
		if task_daily.mons_list then
			for _, monsterName in ipairs(task_daily.mons_list) do
				local capitalizedMonsterName2 = capitalizeSecondWord(monsterName)
				table.insert(capitalizedMonsterList2, capitalizedMonsterName2)
			end
		end
	end
	local combinedList_td = table.concat(capitalizedMonsterList2, ", ")
	combinedList_td = capitalizeSecondWord(combinedList_td)
	--------SPECIAL----------
	local capitalizedMonsterList3 = {}
	if task_special then
		if task_special.mons_list then
			for _, monsterName in ipairs(task_special.mons_list) do
				local capitalizedMonsterName3 = capitalizeSecondWord(monsterName)
				table.insert(capitalizedMonsterList3, capitalizedMonsterName3)
			end
		end
	end
	local combinedList_ts = table.concat(capitalizedMonsterList3, ", ")
	combinedList_ts = capitalizeSecondWord(combinedList_ts)
	
	---------------------------
	
	if task_normal then
		sto_value_tasknormal = Player(player):getStorageValue(task_normal.storage)
	end
	
	if task_daily then
		sto_value_taskdaily = Player(player):getStorageValue(task_daily.storage)
	end
	
	if task_special then
		sto_value_taskspecial = Player(player):getStorageValue(task_special.storage)
	end
	
	----------------------------------
	local itemsSpecialText_tasknormal = ""
	if task_normal then
		if task_normal.items_special then
			itemsSpecialText_tasknormal = "- Special Rewards [+]: " .. getItemsFromTable(task_normal.items_special) .. ".\n"
		end
	end
		
	local itemsSpecialText_taskdaily = ""
	if task_daily then
		if task_daily.items_special then
			itemsSpecialText_taskdaily = "- Special Rewards [+]: " .. getItemsFromTable(task_daily.items_special) .. ".\n"
		end
	end
		
	local itemsSpecialText_taskspecial = ""
	if task_special then
		if task_special.items_special then
			itemsSpecialText_taskspecial = "- Special Rewards [+]: " .. getItemsFromTable(task_special.items_special) .. ".\n"
		end
	end
		
	local bossAccessText_tasknormal = ""
	if task_normal then
		if task_normal.boss_access then
			bossAccessText_tasknormal = "- Boss Access: " .. task_normal.boss_access.name .. ".\n"
		end
	end
		
	local bossAccessText_taskdaily = ""
	if task_daily then
		if task_daily.boss_access then
			bossAccessText_taskdaily = "- Boss Access: " .. task_daily.boss_access.name .. ".\n"
		end
	end
		
	local bossAccessText_taskspecial = ""
	if task_special then
		if task_special.boss_access then
			bossAccessText_taskspecial = "- Boss Access: " .. task_special.boss_access.name .. ".\n"
		end
	end
	----------------------------------
	
	-- With Normal, Daily and Special
	if Position(32364, 32205, 7) == item:getPosition() then
		if task_normal and task_daily and task_special then
			if sto_value_tasknormal < task_normal.amount and sto_value_taskdaily < task_daily.amount and sto_value_taskspecial < task_special.amount then
				player:popupFYI("[Task System]\nCompleting Normal Task of " .. task_normal.name .. ".\n - You have killed [" .. sto_value_tasknormal .. "/" .. task_normal.amount .. "].\n" .. (combinedList ~= "" and "They also count in the task: " .. combinedList .. ".\n" or "") .. "\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(task_normal.items) .. ".\n"..itemsSpecialText_tasknormal.."- Experience [+]: " .. formatExp(task_normal.exp) .. " EXP.\n- Task Points [+]: " .. task_normal.pointsTask[1] .. " TP.\n"..bossAccessText_tasknormal.."\nTime with the task: " .. elapsedTime .. ".\n\nCompleting Daily Task of "..task_daily.name..".\n- You have killed [" .. sto_value_taskdaily .. "/" .. task_daily.amount .. "].\n" .. (combinedList_td ~= "" and "They also count in the task: " .. combinedList_td .. ".\n" or "") .. "\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(task_daily.items) .. ".\n"..itemsSpecialText_taskdaily.."- Experience [+]: " .. formatExp(task_daily.exp) .. " EXP.\n- Task Points [+]: " .. task_daily.pointsTask[1] .. " TP.\n"..bossAccessText_taskdaily.."\nTime with the task: " .. elapsedTime_daily .. ".\n\nCompleting Special Task of " .. task_special.name .. ".\n - You have killed [" .. sto_value_taskspecial .. "/" .. task_special.amount .. "].\n" .. (combinedList_ts ~= "" and "They also count in the task: " .. combinedList_ts .. ".\n" or "") .. "\nBy completing the task you receive:\n- Special Rewards [+]: " .. getItemsFromTable(task_normal.items_special) .. ".\n- Experience [+]: " .. formatExp(task_special.exp) .. " EXP.\n- Task Points [+]: " .. task_special.pointsTask[1] .. " TP.\n"..bossAccessText_taskspecial.."\nTime with the task: " .. elapsedTime_special .. ".")
			--- Esto es cuando la Special Task esta completada
			elseif sto_value_tasknormal < task_normal.amount and sto_value_taskdaily < task_daily.amount then
				player:popupFYI("[Task System]\nCompleting Normal Task of " .. task_normal.name .. ".\n - You have killed [" .. sto_value_tasknormal .. "/" .. task_normal.amount .. "].\n" .. (combinedList ~= "" and "They also count in the task: " .. combinedList .. ".\n" or "") .. "\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(task_normal.items) .. ".\n"..itemsSpecialText_tasknormal.."- Experience [+]: " .. formatExp(task_normal.exp) .. " EXP.\n- Task Points [+]: " .. task_normal.pointsTask[1] .. " TP.\n"..bossAccessText_tasknormal.."\nTime with the task: " .. elapsedTime .. ".\n\nCompleting Daily Task of "..task_daily.name..".\n- You have killed [" .. sto_value_taskdaily .. "/" .. task_daily.amount .. "].\n" .. (combinedList_td ~= "" and "They also count in the task: " .. combinedList_td .. ".\n" or "") .. "\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(task_daily.items) .. ".\n"..itemsSpecialText_taskdaily.."- Experience [+]: " .. formatExp(task_daily.exp) .. " EXP.\n- Task Points [+]: " .. task_daily.pointsTask[1] .. " TP.\n"..bossAccessText_taskdaily.."\nTime with the task: " .. elapsedTime_daily .. ".\n\nCompleting Special Task of " .. task_special.name .. ".\n - You have killed [" .. sto_value_taskspecial .. "/" .. task_special.amount .. "]. (Completed)\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Special Rewards [+]: " .. getItemsFromTable(task_normal.items_special) .. ".\n- Experience [+]: " .. formatExp(task_special.exp) .. " EXP.\n- Task Points [+]: " .. task_special.pointsTask[1] .. " TP.\n"..bossAccessText_taskspecial.."\nTime with the task: " .. elapsedTime_special .. ".")
			--- Esto es cuando la Daily Task esta completada
			elseif sto_value_tasknormal < task_normal.amount and sto_value_taskspecial < task_special.amount then	
				player:popupFYI("[Task System]\nCompleting Normal Task of " .. task_normal.name .. ".\n - You have killed [" .. sto_value_tasknormal .. "/" .. task_normal.amount .. "].\n" .. (combinedList ~= "" and "They also count in the task: " .. combinedList .. ".\n" or "") .. "\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(task_normal.items) .. ".\n"..itemsSpecialText_tasknormal.."- Experience [+]: " .. formatExp(task_normal.exp) .. " EXP.\n- Task Points [+]: " .. task_normal.pointsTask[1] .. " TP.\n"..bossAccessText_tasknormal.."\nTime with the task: " .. elapsedTime .. ".\n\nCompleting Daily Task of "..task_daily.name..".\n- You have killed [" .. sto_value_taskdaily .. "/" .. task_daily.amount .. "]. (Completed)\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(task_daily.items) .. ".\n"..itemsSpecialText_taskdaily.."- Experience [+]: " .. formatExp(task_daily.exp) .. " EXP.\n- Task Points [+]: " .. task_daily.pointsTask[1] .. " TP.\n"..bossAccessText_taskdaily.."\nTime with the task: " .. elapsedTime_daily .. ".\n\nCompleting Special Task of " .. task_special.name .. ".\n - You have killed [" .. sto_value_taskspecial .. "/" .. task_special.amount .. "].\n" .. (combinedList_ts ~= "" and "They also count in the task: " .. combinedList_ts .. ".\n" or "") .. "\nBy completing the task you receive:\n- Special Rewards [+]: " .. getItemsFromTable(task_normal.items_special) .. ".\n- Experience [+]: " .. formatExp(task_special.exp) .. " EXP.\n- Task Points [+]: " .. task_special.pointsTask[1] .. " TP.\n"..bossAccessText_taskspecial.."\nTime with the task: " .. elapsedTime_special .. ".")
			--- Esto es cuando la Normal Task esta completada
			elseif sto_value_taskspecial < task_special.amount and sto_value_taskdaily < task_daily.amount then
				player:popupFYI("[Task System]\nCompleting Normal Task of " .. task_normal.name .. ".\n - You have killed [" .. sto_value_tasknormal .. "/" .. task_normal.amount .. "]. (Completed)\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(task_normal.items) .. ".\n"..itemsSpecialText_tasknormal.."- Experience [+]: " .. formatExp(task_normal.exp) .. " EXP.\n- Task Points [+]: " .. task_normal.pointsTask[1] .. " TP.\n"..bossAccessText_tasknormal.."\nTime with the task: " .. elapsedTime .. ".\n\nCompleting Daily Task of "..task_daily.name..".\n- You have killed [" .. sto_value_taskdaily .. "/" .. task_daily.amount .. "].\n" .. (combinedList_td ~= "" and "They also count in the task: " .. combinedList_td .. ".\n" or "") .. "\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(task_daily.items) .. ".\n"..itemsSpecialText_taskdaily.."- Experience [+]: " .. formatExp(task_daily.exp) .. " EXP.\n- Task Points [+]: " .. task_daily.pointsTask[1] .. " TP.\n"..bossAccessText_taskdaily.."\nTime with the task: " .. elapsedTime_daily .. ".\n\nCompleting Special Task of " .. task_special.name .. ".\n - You have killed [" .. sto_value_taskspecial .. "/" .. task_special.amount .. "].\n" .. (combinedList_ts ~= "" and "They also count in the task: " .. combinedList_ts .. ".\n" or "") .. "\nBy completing the task you receive:\n- Special Rewards [+]: " .. getItemsFromTable(task_normal.items_special) .. ".\n- Experience [+]: " .. formatExp(task_special.exp) .. " EXP.\n- Task Points [+]: " .. task_special.pointsTask[1] .. " TP.\n"..bossAccessText_taskspecial.."\nTime with the task: " .. elapsedTime_special .. ".")
			--- Esto es cuando la Daily Task y special estan completadas
			elseif sto_value_tasknormal < task_normal.amount then
				player:popupFYI("[Task System]\nCompleting Normal Task of " .. task_normal.name .. ".\n - You have killed [" .. sto_value_tasknormal .. "/" .. task_normal.amount .. "].\n" .. (combinedList ~= "" and "They also count in the task: " .. combinedList .. ".\n" or "") .. "\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(task_normal.items) .. ".\n"..itemsSpecialText_tasknormal.."- Experience [+]: " .. formatExp(task_normal.exp) .. " EXP.\n- Task Points [+]: " .. task_normal.pointsTask[1] .. " TP.\n"..bossAccessText_tasknormal.."\nTime with the task: " .. elapsedTime .. ".\n\nCompleting Daily Task of "..task_daily.name..".\n- You have killed [" .. sto_value_taskdaily .. "/" .. task_daily.amount .. "]. (Completed)\nGo back to Vauter to Report the task.\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(task_daily.items) .. ".\n"..itemsSpecialText_taskdaily.."- Experience [+]: " .. formatExp(task_daily.exp) .. " EXP.\n- Task Points [+]: " .. task_daily.pointsTask[1] .. " TP.\n"..bossAccessText_taskdaily.."\nTime with the task: " .. elapsedTime_daily .. ".\n\nCompleting Special Task of " .. task_special.name .. ".\n - You have killed [" .. sto_value_taskspecial .. "/" .. task_special.amount .. "]. (Completed)\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Special Rewards [+]: " .. getItemsFromTable(task_normal.items_special) .. ".\n- Experience [+]: " .. formatExp(task_special.exp) .. " EXP.\n- Task Points [+]: " .. task_special.pointsTask[1] .. " TP.\n"..bossAccessText_taskspecial.."\nTime with the task: " .. elapsedTime_special .. ".")
			--- Esto es cuando la Normal Task y Special estan completadas	
			elseif sto_value_taskdaily < task_daily.amount then
				player:popupFYI("[Task System]\nCompleting Normal Task of " .. task_normal.name .. ".\n - You have killed [" .. sto_value_tasknormal .. "/" .. task_normal.amount .. "]. (Completed)\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(task_normal.items) .. ".\n"..itemsSpecialText_tasknormal.."- Experience [+]: " .. formatExp(task_normal.exp) .. " EXP.\n- Task Points [+]: " .. task_normal.pointsTask[1] .. " TP.\n"..bossAccessText_tasknormal.."\nTime with the task: " .. elapsedTime .. ".\n\nCompleting Daily Task of "..task_daily.name..".\n- You have killed [" .. sto_value_taskdaily .. "/" .. task_daily.amount .. "].\n" .. (combinedList_td ~= "" and "They also count in the task: " .. combinedList_td .. ".\n" or "") .. "\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(task_daily.items) .. ".\n"..itemsSpecialText_taskdaily.."- Experience [+]: " .. formatExp(task_daily.exp) .. " EXP.\n- Task Points [+]: " .. task_daily.pointsTask[1] .. " TP.\n"..bossAccessText_taskdaily.."\nTime with the task: " .. elapsedTime_daily .. ".\n\nCompleting Special Task of " .. task_special.name .. ".\n - You have killed [" .. sto_value_taskspecial .. "/" .. task_special.amount .. "]. (Completed)\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Special Rewards [+]: " .. getItemsFromTable(task_normal.items_special) .. ".\n- Experience [+]: " .. formatExp(task_special.exp) .. " EXP.\n- Task Points [+]: " .. task_special.pointsTask[1] .. " TP.\n"..bossAccessText_taskspecial.."\nTime with the task: " .. elapsedTime_special .. ".")
			--- Esto es cuando la task normal y daily estan completadas	
			elseif sto_value_taskspecial < task_special.amount then
				player:popupFYI("[Task System]\nCompleting Normal Task of " .. task_normal.name .. ".\n - You have killed [" .. sto_value_tasknormal .. "/" .. task_normal.amount .. "]. (Completed)\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(task_normal.items) .. ".\n"..itemsSpecialText_tasknormal.."- Experience [+]: " .. formatExp(task_normal.exp) .. " EXP.\n- Task Points [+]: " .. task_normal.pointsTask[1] .. " TP.\n"..bossAccessText_tasknormal.."\nTime with the task: " .. elapsedTime .. ".\n\nCompleting Daily Task of "..task_daily.name..".\n- You have killed [" .. sto_value_taskdaily .. "/" .. task_daily.amount .. "]. (Completed)\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(task_daily.items) .. ".\n"..itemsSpecialText_taskdaily.."- Experience [+]: " .. formatExp(task_daily.exp) .. " EXP.\n- Task Points [+]: " .. task_daily.pointsTask[1] .. " TP.\n"..bossAccessText_taskdaily.."\nTime with the task: " .. elapsedTime_daily .. ".\n\nCompleting Special Task of " .. task_special.name .. ".\n - You have killed [" .. sto_value_taskspecial .. "/" .. task_special.amount .. "].\n" .. (combinedList_ts ~= "" and "They also count in the task: " .. combinedList_ts .. ".\n" or "") .. "\nBy completing the task you receive:\n- Special Rewards [+]: " .. getItemsFromTable(task_normal.items_special) .. ".\n- Experience [+]: " .. formatExp(task_special.exp) .. " EXP.\n- Task Points [+]: " .. task_special.pointsTask[1] .. " TP.\n"..bossAccessText_taskspecial.."\nTime with the task: " .. elapsedTime_special .. ".")
			else
				player:popupFYI("[Task System]\nCompleting Normal Task of " .. task_normal.name .. ".\n - You have killed [" .. sto_value_tasknormal .. "/" .. task_normal.amount .. "]. (Completed)\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(task_normal.items) .. ".\n"..itemsSpecialText_tasknormal.."- Experience [+]: " .. formatExp(task_normal.exp) .. " EXP.\n- Task Points [+]: " .. task_normal.pointsTask[1] .. " TP.\n"..bossAccessText_tasknormal.."\nTime with the task: " .. elapsedTime .. ".\n\nCompleting Daily Task of "..task_daily.name..".\n- You have killed [" .. sto_value_taskdaily .. "/" .. task_daily.amount .. "]. (Completed)\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(task_daily.items) .. ".\n"..itemsSpecialText_taskdaily.."- Experience [+]: " .. formatExp(task_daily.exp) .. " EXP.\n- Task Points [+]: " .. task_daily.pointsTask[1] .. " TP.\n"..bossAccessText_taskdaily.."\nTime with the task: " .. elapsedTime_daily .. ".\n\nCompleting Special Task of " .. task_special.name .. ".\n - You have killed [" .. sto_value_taskspecial .. "/" .. task_special.amount .. "]. (Completed)\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Special Rewards [+]: " .. getItemsFromTable(task_normal.items_special) .. ".\n- Experience [+]: " .. formatExp(task_special.exp) .. " EXP.\n- Task Points [+]: " .. task_special.pointsTask[1] .. " TP.\n"..bossAccessText_taskspecial.."\nTime with the task: " .. elapsedTime_special .. ".")
			end

		-- Task Normal and Daily
		elseif task_normal and task_daily then
			if sto_value_tasknormal < task_normal.amount and sto_value_taskdaily < task_daily.amount then
				player:popupFYI("[Task System]\nCompleting Normal Task of " .. task_normal.name .. ".\n - You have killed [" .. sto_value_tasknormal .. "/" .. task_normal.amount .. "].\n" .. (combinedList ~= "" and "They also count in the task: " .. combinedList .. ".\n" or "") .. "\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(task_normal.items) .. ".\n"..itemsSpecialText_tasknormal.."- Experience [+]: " .. formatExp(task_normal.exp) .. " EXP.\n- Task Points [+]: " .. task_normal.pointsTask[1] .. " TP.\n"..bossAccessText_tasknormal.."\nTime with the task: " .. elapsedTime .. ".\n\nCompleting Daily Task of "..task_daily.name..".\n- You have killed [" .. sto_value_taskdaily .. "/" .. task_daily.amount .. "].\n" .. (combinedList_td ~= "" and "They also count in the task: " .. combinedList_td .. ".\n" or "") .. "\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(task_daily.items) .. ".\n"..itemsSpecialText_taskdaily.."- Experience [+]: " .. formatExp(task_daily.exp) .. " EXP.\n- Task Points [+]: " .. task_daily.pointsTask[1] .. " TP.\n"..bossAccessText_taskdaily.."\nTime with the task: " .. elapsedTime_daily .. ".")
			elseif sto_value_tasknormal < task_normal.amount then
				player:popupFYI("[Task System]\nCompleting Normal Task of " .. task_normal.name .. ".\n - You have killed [" .. sto_value_tasknormal .. "/" .. task_normal.amount .. "].\n" .. (combinedList ~= "" and "They also count in the task: " .. combinedList .. ".\n" or "") .. "\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(task_normal.items) .. ".\n"..itemsSpecialText_tasknormal.."- Experience [+]: " .. formatExp(task_normal.exp) .. " EXP.\n- Task Points [+]: " .. task_normal.pointsTask[1] .. " TP.\n"..bossAccessText_tasknormal.."\nTime with the task: " .. elapsedTime .. ".\n\nCompleting Daily Task of "..task_daily.name..".\n- You have killed [" .. sto_value_taskdaily .. "/" .. task_daily.amount .. "]. (Completed)\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(task_daily.items) .. ".\n"..itemsSpecialText_taskdaily.."- Experience [+]: " .. formatExp(task_daily.exp) .. " EXP.\n- Task Points [+]: " .. task_daily.pointsTask[1] .. " TP.\n"..bossAccessText_taskdaily.."\nTime with the task: " .. elapsedTime_daily .. ".")
			elseif sto_value_taskdaily < task_daily.amount then
				player:popupFYI("[Task System]\nCompleting Normal Task of " .. task_normal.name .. ".\n - You have killed [" .. sto_value_tasknormal .. "/" .. task_normal.amount .. "]. (Completed)\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(task_normal.items) .. ".\n"..itemsSpecialText_tasknormal.."- Experience [+]: " .. formatExp(task_normal.exp) .. " EXP.\n- Task Points [+]: " .. task_normal.pointsTask[1] .. " TP.\n"..bossAccessText_tasknormal.."\nTime with the task: " .. elapsedTime .. ".\n\nCompleting Daily Task of "..task_daily.name..".\n- You have killed [" .. sto_value_taskdaily .. "/" .. task_daily.amount .. "].\n" .. (combinedList_td ~= "" and "They also count in the task: " .. combinedList_td .. ".\n" or "") .. "\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(task_daily.items) .. ".\n"..itemsSpecialText_taskdaily.."- Experience [+]: " .. formatExp(task_daily.exp) .. " EXP.\n- Task Points [+]: " .. task_daily.pointsTask[1] .. " TP.\n"..bossAccessText_taskdaily.."\nTime with the task: " .. elapsedTime_daily .. ".")
			else
				player:popupFYI("[Task System]\nCompleting Normal Task of " .. task_normal.name .. ".\n - You have killed [" .. sto_value_tasknormal .. "/" .. task_normal.amount .. "]. (Completed)\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(task_normal.items) .. ".\n"..itemsSpecialText_tasknormal.."- Experience [+]: " .. formatExp(task_normal.exp) .. " EXP.\n- Task Points [+]: " .. task_normal.pointsTask[1] .. " TP.\n"..bossAccessText_tasknormal.."\nTime with the task: " .. elapsedTime .. ".\n\nCompleting Daily Task of "..task_daily.name..".\n- You have killed [" .. sto_value_taskdaily .. "/" .. task_daily.amount .. "]. (Completed)\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(task_daily.items) .. ".\n"..itemsSpecialText_taskdaily.."- Experience [+]: " .. formatExp(task_daily.exp) .. " EXP.\n- Task Points [+]: " .. task_daily.pointsTask[1] .. " TP.\n"..bossAccessText_taskdaily.."\nTime with the task: " .. elapsedTime_daily .. ".")
			end
		-- Task Normal and Special	
		elseif task_normal and task_special then
			if sto_value_tasknormal < task_normal.amount and sto_value_taskspecial < task_special.amount then
				player:popupFYI("[Task System]\nCompleting Normal Task of " .. task_normal.name .. ".\n - You have killed [" .. sto_value_tasknormal .. "/" .. task_normal.amount .. "].\n" .. (combinedList ~= "" and "They also count in the task: " .. combinedList .. ".\n" or "") .. "\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(task_normal.items) .. ".\n"..itemsSpecialText_tasknormal.."- Experience [+]: " .. formatExp(task_normal.exp) .. " EXP.\n- Task Points [+]: " .. task_normal.pointsTask[1] .. " TP.\n"..bossAccessText_tasknormal.."\nTime with the task: " .. elapsedTime .. ".\n\nCompleting Special Task of "..task_special.name..".\n- You have killed [" .. sto_value_taskspecial .. "/" .. task_special.amount .. "].\n" .. (combinedList_ts ~= "" and "They also count in the task: " .. combinedList_ts .. ".\n" or "") .. "\nBy completing the task you receive:\n- Special Rewards [+]: " .. getItemsFromTable(task_special.items_special) .. ".\n- Experience [+]: " .. formatExp(task_special.exp) .. " EXP.\n- Task Points [+]: " .. task_special.pointsTask[1] .. " TP.\n"..bossAccessText_taskspecial.."\nTime with the task: " .. elapsedTime_special .. ".")
			elseif sto_value_tasknormal < task_normal.amount then
				player:popupFYI("[Task System]\nCompleting Normal Task of " .. task_normal.name .. ".\n - You have killed [" .. sto_value_tasknormal .. "/" .. task_normal.amount .. "].\n" .. (combinedList ~= "" and "They also count in the task: " .. combinedList .. ".\n" or "") .. "\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(task_normal.items) .. ".\n"..itemsSpecialText_tasknormal.."- Experience [+]: " .. formatExp(task_normal.exp) .. " EXP.\n- Task Points [+]: " .. task_normal.pointsTask[1] .. " TP.\n"..bossAccessText_tasknormal.."\nTime with the task: " .. elapsedTime .. ".\n\nCompleting Special Task of "..task_special.name..".\n- You have killed [" .. sto_value_taskspecial .. "/" .. task_special.amount .. "]. (Completed)\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Special Rewards [+]: " .. getItemsFromTable(task_special.items_special) .. ".\n- Experience [+]: " .. formatExp(task_special.exp) .. " EXP.\n- Task Points [+]: " .. task_special.pointsTask[1] .. " TP.\n"..bossAccessText_taskspecial.."\nTime with the task: " .. elapsedTime_special .. ".")
			elseif sto_value_taskspecial < task_special.amount then
				player:popupFYI("[Task System]\nCompleting Normal Task of " .. task_normal.name .. ".\n - You have killed [" .. sto_value_tasknormal .. "/" .. task_normal.amount .. "]. (Completed)\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(task_normal.items) .. ".\n"..itemsSpecialText_tasknormal.."- Experience [+]: " .. formatExp(task_normal.exp) .. " EXP.\n- Task Points [+]: " .. task_normal.pointsTask[1] .. " TP.\n"..bossAccessText_tasknormal.."\nTime with the task: " .. elapsedTime .. ".\n\nCompleting Special Task of "..task_special.name..".\n- You have killed [" .. sto_value_taskspecial .. "/" .. task_special.amount .. "].\n" .. (combinedList_ts ~= "" and "They also count in the task: " .. combinedList_ts .. ".\n" or "") .. "\nBy completing the task you receive:\n- Special Rewards [+]: " .. getItemsFromTable(task_special.items_special) .. ".\n- Experience [+]: " .. formatExp(task_special.exp) .. " EXP.\n- Task Points [+]: " .. task_special.pointsTask[1] .. " TP.\n"..bossAccessText_taskspecial.."\nTime with the task: " .. elapsedTime_special .. ".")
			else
				player:popupFYI("[Task System]\nCompleting Normal Task of " .. task_normal.name .. ".\n - You have killed [" .. sto_value_tasknormal .. "/" .. task_normal.amount .. "]. (Completed)\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(task_normal.items) .. ".\n"..itemsSpecialText_tasknormal.."- Experience [+]: " .. formatExp(task_normal.exp) .. " EXP.\n- Task Points [+]: " .. task_normal.pointsTask[1] .. " TP.\n"..bossAccessText_tasknormal.."\nTime with the task: " .. elapsedTime .. ".\n\nCompleting Special Task of "..task_special.name..".\n- You have killed [" .. sto_value_taskspecial .. "/" .. task_special.amount .. "]. (Completed)\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Special Rewards [+]: " .. getItemsFromTable(task_special.items_special) .. ".\n- Experience [+]: " .. formatExp(task_special.exp) .. " EXP.\n- Task Points [+]: " .. task_special.pointsTask[1] .. " TP.\n"..bossAccessText_taskspecial.."\nTime with the task: " .. elapsedTime_special .. ".")
			end
			
		-- Task Daily and Special	
		elseif task_daily and task_special then
			if sto_value_taskdaily < task_daily.amount and sto_value_taskspecial < task_special.amount then
				player:popupFYI("[Task System]\nCompleting Daily Task of " .. task_daily.name .. ".\n - You have killed [" .. sto_value_taskdaily .. "/" .. task_daily.amount .. "].\n" .. (combinedList_td ~= "" and "They also count in the task: " .. combinedList_td .. ".\n" or "") .. "\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(task_daily.items) .. ".\n"..itemsSpecialText_taskdaily.."- Experience [+]: " .. formatExp(task_daily.exp) .. " EXP.\n- Task Points [+]: " .. task_daily.pointsTask[1] .. " TP.\n"..bossAccessText_taskdaily.."\nTime with the task: " .. elapsedTime_daily .. ".\n\nCompleting Special Task of "..task_special.name..".\n- You have killed [" .. sto_value_taskspecial .. "/" .. task_special.amount .. "].\n" .. (combinedList_ts ~= "" and "They also count in the task: " .. combinedList_ts .. ".\n" or "") .. "\nBy completing the task you receive:\n- Special Rewards [+]: " .. getItemsFromTable(task_special.items_special) .. ".\n- Experience [+]: " .. formatExp(task_special.exp) .. " EXP.\n- Task Points [+]: " .. task_special.pointsTask[1] .. " TP.\n"..bossAccessText_taskspecial.."\nTime with the task: " .. elapsedTime_special .. ".")
			elseif sto_value_taskdaily < task_daily.amount then
				player:popupFYI("[Task System]\nCompleting Daily Task of " .. task_daily.name .. ".\n - You have killed [" .. sto_value_taskdaily .. "/" .. task_daily.amount .. "].\n" .. (combinedList_td ~= "" and "They also count in the task: " .. combinedList_td .. ".\n" or "") .. "\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(task_daily.items) .. ".\n"..itemsSpecialText_taskdaily.."- Experience [+]: " .. formatExp(task_daily.exp) .. " EXP.\n- Task Points [+]: " .. task_daily.pointsTask[1] .. " TP.\n"..bossAccessText_taskdaily.."\nTime with the task: " .. elapsedTime_daily .. ".\n\nCompleting Special Task of "..task_special.name..".\n- You have killed [" .. sto_value_taskspecial .. "/" .. task_special.amount .. "]. (Completed)\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Special Rewards [+]: " .. getItemsFromTable(task_special.items_special) .. ".\n- Experience [+]: " .. formatExp(task_special.exp) .. " EXP.\n- Task Points [+]: " .. task_special.pointsTask[1] .. " TP.\n"..bossAccessText_taskspecial.."\nTime with the task: " .. elapsedTime_special .. ".")
			elseif sto_value_taskspecial < task_special.amount then
				player:popupFYI("[Task System]\nCompleting Daily Task of " .. task_daily.name .. ".\n - You have killed [" .. sto_value_taskdaily .. "/" .. task_daily.amount .. "]. (Completed)\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(task_daily.items) .. ".\n"..itemsSpecialText_taskdaily.."- Experience [+]: " .. formatExp(task_daily.exp) .. " EXP.\n- Task Points [+]: " .. task_daily.pointsTask[1] .. " TP.\n"..bossAccessText_taskdaily.."\nTime with the task: " .. elapsedTime_daily .. ".\n\nCompleting Special Task of "..task_special.name..".\n- You have killed [" .. sto_value_taskspecial .. "/" .. task_special.amount .. "].\n" .. (combinedList_ts ~= "" and "They also count in the task: " .. combinedList_ts .. ".\n" or "") .. "\nBy completing the task you receive:\n- Special Rewards [+]: " .. getItemsFromTable(task_special.items_special) .. ".\n- Experience [+]: " .. formatExp(task_special.exp) .. " EXP.\n- Task Points [+]: " .. task_special.pointsTask[1] .. " TP.\n"..bossAccessText_taskspecial.."\nTime with the task: " .. elapsedTime_special .. ".")
			else
				player:popupFYI("[Task System]\nCompleting Daily Task of " .. task_daily.name .. ".\n - You have killed [" .. sto_value_taskdaily .. "/" .. task_daily.amount .. "]. (Completed)\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(task_daily.items) .. ".\n"..itemsSpecialText_taskdaily.."- Experience [+]: " .. formatExp(task_daily.exp) .. " EXP.\n- Task Points [+]: " .. task_daily.pointsTask[1] .. " TP.\n"..bossAccessText_taskdaily.."\nTime with the task: " .. elapsedTime_daily .. ".\n\nCompleting Special Task of "..task_special.name..".\n- You have killed [" .. sto_value_taskspecial .. "/" .. task_special.amount .. "]. (Completed)\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Special Rewards [+]: " .. getItemsFromTable(task_special.items_special) .. ".\n- Experience [+]: " .. formatExp(task_special.exp) .. " EXP.\n- Task Points [+]: " .. task_special.pointsTask[1] .. " TP.\n"..bossAccessText_taskspecial.."\nTime with the task: " .. elapsedTime_special .. ".")
			end	
		
		-- Only Task Normal	
		elseif task_normal then
			if sto_value_tasknormal < task_normal.amount then
				player:popupFYI("[Task System]\nCompleting Normal Task of " .. task_normal.name .. ".\n - You have killed [" .. sto_value_tasknormal .. "/" .. task_normal.amount .. "].\n" .. (combinedList ~= "" and "They also count in the task: " .. combinedList .. ".\n" or "") .. "\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(task_normal.items) .. ".\n"..itemsSpecialText_tasknormal.."- Experience [+]: " .. formatExp(task_normal.exp) .. " EXP.\n- Task Points [+]: " .. task_normal.pointsTask[1] .. " TP.\n"..bossAccessText_tasknormal.."\nTime with the task: " .. elapsedTime .. ".")
			else
				player:popupFYI("[Task System]\nCompleting Normal Task of " .. task_normal.name .. ".\n - You have killed [" .. sto_value_tasknormal .. "/" .. task_normal.amount .. "]. (Completed)\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(task_normal.items) .. ".\n"..itemsSpecialText_tasknormal.."- Experience [+]: " .. formatExp(task_normal.exp) .. " EXP.\n- Task Points [+]: " .. task_normal.pointsTask[1] .. " TP.\n"..bossAccessText_tasknormal.."\n\nTime with the task: " .. elapsedTime .. ".")
			end
			
			
		-- Only Task Daily	
		elseif task_daily then
			if sto_value_taskdaily < task_daily.amount then
				player:popupFYI("[Task System]\nCompleting Daily Task of " .. task_daily.name .. ".\n - You have killed [" .. sto_value_taskdaily .. "/" .. task_daily.amount .. "].\n" .. (combinedList_td ~= "" and "They also count in the task: " .. combinedList_td .. ".\n" or "") .. "\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(task_daily.items) .. ".\n"..itemsSpecialText_taskdaily.."- Experience [+]: " .. formatExp(task_daily.exp) .. " EXP.\n- Task Points [+]: " .. task_daily.pointsTask[1] .. " TP.\n"..bossAccessText_taskdaily.."\nTime with the task: " .. elapsedTime_daily .. ".")
			else
				player:popupFYI("[Task System]\nCompleting Daily Task of " .. task_daily.name .. ".\n - You have killed [" .. sto_value_taskdaily .. "/" .. task_daily.amount .. "]. (Completed)\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(task_daily.items) .. ".\n"..itemsSpecialText_taskdaily.."- Experience [+]: " .. formatExp(task_daily.exp) .. " EXP.\n- Task Points [+]: " .. task_daily.pointsTask[1] .. " TP.\n"..bossAccessText_taskdaily.."\nTime with the task: " .. elapsedTime_daily .. ".")
			end
			
		-- Only Task Special	
		elseif task_special then
			if sto_value_taskspecial < task_special.amount then
				player:popupFYI("[Task System]\nCompleting Special Task of " .. task_special.name .. ".\n - You have killed [" .. sto_value_taskspecial .. "/" .. task_special.amount .. "].\n" .. (combinedList_ts ~= "" and "They also count in the task: " .. combinedList_ts .. ".\n" or "") .. "\nBy completing the task you receive:\n- Special Rewards [+]: " .. getItemsFromTable(task_special.items_special) .. ".\n- Experience [+]: " .. formatExp(task_special.exp) .. " EXP.\n- Task Points [+]: " .. task_special.pointsTask[1] .. " TP.\n"..bossAccessText_taskspecial.."\nTime with the task: " .. elapsedTime_special .. ".")
			else
				player:popupFYI("[Task System]\nCompleting Special Task of " .. task_special.name .. ".\n - You have killed [" .. sto_value_taskspecial .. "/" .. task_special.amount .. "]. (Completed)\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Special Rewards [+]: " .. getItemsFromTable(task_special.items_special) .. ".\n- Experience [+]: " .. formatExp(task_special.exp) .. " EXP.\n- Task Points [+]: " .. task_special.pointsTask[1] .. " TP.\n"..bossAccessText_taskspecial.."\nTime with the task: " .. elapsedTime_special .. ".")
			end
		else
			player:popupFYI("[Task System]\n- You have not yet chosen a task with Vauter. \n\n- Task Rank: ".. getRankTask(player) ..".\n- Task Points: ".. taskRank_get(player) ..".")
		end
	end
	exhaust[playerId] = currentTime + exhaustTime
	return true
end

taskboard:id(36828)
taskboard:register()




local taskboard2 = Action()

function taskboard2.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	local currentDay = os.date("%A")
    local taskList = task_daily[currentDay]
	
    local message = "[Daily Task]\n- Here the tasks of the day will be shown.\nThen to choose go to Vauter.\n\nToday is ["..os.date("%A").."], Time: " .. os.date("%X") .. ".\n\n"
	
	local function formatExp(exp)
    local formattedExp = tostring(exp)
    local formattedParts = {}

    while #formattedExp > 3 do
        table.insert(formattedParts, 1, formattedExp:sub(-3))
        formattedExp = formattedExp:sub(1, -4)
    end

    table.insert(formattedParts, 1, formattedExp)

		return table.concat(formattedParts, ".")
	end
	
    for _, task in ipairs(taskList) do
		message = message .. "-> " .. task.name .. "\n"
		message = message .. "   [-] Count: " .. task.amount .. ".\n"
	
		if task.items and #task.items > 0 then
		message = message .. "   [+] Rewards: \n"
			for _, item in ipairs(task.items) do
				local itemName = getItemNameById(item.id)
				message = message .. "      -> " .. item.count .. "x " .. itemName .. ".\n"
			end
		end
    
		if task.items_special and #task.items_special > 0 then
		message = message .. "   [+] Special Items: \n"
			for _, item in ipairs(task.items_special) do
			local itemName = getItemNameById(item.id)
			message = message .. "      -> " .. item.count .. "x " .. itemName .. ".\n"
			end
		end
		
		message = message .. "   [-] Experience: " .. formatExp(task.exp) .. ".\n"
		message = message .. "   [-] Task Points: " .. task.pointsTask[1] .. ".\n"
		
		if task.boss_access then
            message = message .. "   [-] Boss Access: " .. task.boss_access.name .. ".\n"
        end
		
		message = message .. "   [+] Requirements:\n"
		if task.level_required then
            message = message .. "   -> Level Required: " .. task.level_required .. ".\n"
        end
		
		if task.taskp_required then
            message = message .. "   -> Task Points Required: " .. task.taskp_required .. ".\n"
        end
		
		if task.premium_required then
            message = message .. "   -> Premium Required: Yes.\n"
        end
		  
		message = message .. "\n"
	end	
	player:popupFYI(message)

	return true
end
taskboard2:id(42549, 42550)
taskboard2:register()