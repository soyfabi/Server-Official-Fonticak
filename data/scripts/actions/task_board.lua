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
	
	if Position(32364, 32205, 7) == item:getPosition() then
	local ret_t = getTaskInfos(player)
	local ret_td = getTaskDailyInfo(player)
	local ret_ts = getTaskSpecialInfo(player)
		if ret_t and ret_td and ret_ts then
		local sto_value = player:getStorageValue(ret_t.storage)
		local sto_value_td = player:getStorageValue(ret_td.storage)
		local sto_value_ts = player:getStorageValue(ret_ts.storage)
		local capitalizedMonsterList = {}
		for _, monsterName in ipairs(ret_t.mons_list) do
			local capitalizedMonsterName = capitalizeSecondWord(monsterName)
			table.insert(capitalizedMonsterList, capitalizedMonsterName)
		end
		local combinedList = table.concat(capitalizedMonsterList, ", ")
		combinedList = capitalizeSecondWord(combinedList)
		--------DAILY------------
		local capitalizedMonsterList2 = {}
		for _, monsterName in ipairs(ret_td.mons_list) do
			local capitalizedMonsterName2 = capitalizeSecondWord(monsterName)
			table.insert(capitalizedMonsterList2, capitalizedMonsterName2)
		end
		local combinedList_td = table.concat(capitalizedMonsterList2, ", ")
		combinedList_td = capitalizeSecondWord(combinedList_td)
		--------SPECIAL-----------
		local capitalizedMonsterList3 = {}
		for _, monsterName in ipairs(ret_ts.mons_list) do
			local capitalizedMonsterName3 = capitalizeSecondWord(monsterName)
			table.insert(capitalizedMonsterList3, capitalizedMonsterName3)
		end
		local combinedList_ts = table.concat(capitalizedMonsterList3, ", ")
		combinedList_ts = capitalizeSecondWord(combinedList_ts)
			
		-- With Normal, Daily and Special
		if sto_value < ret_t.amount and sto_value_td < ret_td.amount and sto_value_ts < ret_ts.amount then
			player:popupFYI("[Task System]\nCompleting Normal Task of " .. ret_t.name .. ".\n - You have killed [" .. sto_value .. "/" .. ret_t.amount .. "].\nThey also count in the task: ".. combinedList ..".\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_t.items) .. ".\n- Experience [+]: " .. formatExp(ret_t.exp) .. " EXP.\n- Task Points [+]: " .. ret_t.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime .. ".\n\nCompleting Daily Task of "..ret_td.name..".\n- You have killed [" .. sto_value_td .. "/" .. ret_td.amount .. "].\nThey also count in the task: ".. combinedList_td ..".\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_td.items) .. ".\n- Experience [+]: " .. formatExp(ret_td.exp) .. " EXP.\n- Task Points [+]: " .. ret_td.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_daily .. ".\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_t.items) .. ".\n- Experience [+]: " .. formatExp(ret_t.exp) .. " EXP.\n- Task Points [+]: " .. ret_t.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime .. ".\n\nCompleting Task Special of "..ret_ts.name..".\n- You have killed [" .. sto_value_ts .. "/" .. ret_ts.amount .. "].\nThey also count in the task: ".. combinedList_ts ..".\n\nBy completing the task you receive:\n- Special Rewards [+]: " .. getItemsFromTable(ret_ts.items) .. ".\n- Experience [+]: " .. formatExp(ret_ts.exp) .. " EXP.\n- Task Points [+]: " .. ret_ts.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_special .. ".")
		--- Esto es cuando la task special esta completada
		elseif sto_value < ret_t.amount and sto_value_td < ret_td.amount then
			player:popupFYI("[Task System]\nCompleting Normal Task of " .. ret_t.name .. ".\n - You have killed [" .. sto_value .. "/" .. ret_t.amount .. "].\nThey also count in the task: ".. combinedList ..".\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_t.items) .. ".\n- Experience [+]: " .. formatExp(ret_t.exp) .. " EXP.\n- Task Points [+]: " .. ret_t.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime .. ".\n\nCompleting Daily Task of "..ret_td.name..".\n- You have killed [" .. sto_value_td .. "/" .. ret_td.amount .. "].\nThey also count in the task: ".. combinedList_td ..".\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_td.items) .. ".\n- Experience [+]: " .. formatExp(ret_td.exp) .. " EXP.\n- Task Points [+]: " .. ret_td.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_daily .. ".\n\nCompleting Special Task of "..ret_ts.name..".\n- You have killed [" .. sto_value_ts .. "/" .. ret_ts.amount .. "] (Completed).\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_ts.items) .. ".\n- Experience [+]: " .. formatExp(ret_ts.exp) .. " EXP.\n- Task Points [+]: " .. ret_ts.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_special .. ".")
		--- Esto es cuando la Daily Task esta completada
		elseif sto_value < ret_t.amount and sto_value_ts < ret_ts.amount then
			player:popupFYI("[Task System]\nCompleting Normal Task of " .. ret_t.name .. ".\n - You have killed [" .. sto_value .. "/" .. ret_t.amount .. "].\nThey also count in the task: ".. combinedList ..".\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_t.items) .. ".\n- Experience [+]: " .. formatExp(ret_t.exp) .. " EXP.\n- Task Points [+]: " .. ret_t.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime .. ".\n\nCompleting Daily Task of "..ret_td.name..".\n- You have killed [" .. sto_value_td .. "/" .. ret_td.amount .. "] (Completed).\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_td.items) .. ".\n- Experience [+]: " .. formatExp(ret_td.exp) .. " EXP.\n- Task Points [+]: " .. ret_td.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_daily .. ".\n\nCompleting Special Task of "..ret_ts.name..".\n- You have killed [" .. sto_value_ts .. "/" .. ret_ts.amount .. "].\nThey also count in the task: ".. combinedList_ts ..".\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_ts.items) .. ".\n- Experience [+]: " .. formatExp(ret_ts.exp) .. " EXP.\n- Task Points [+]: " .. ret_ts.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_special .. ".")
		--- Esto es cuando la task normal esta completada
		elseif sto_value_ts < ret_ts.amount and sto_value_td < ret_td.amount then
			player:popupFYI("[Task System]\nCompleting Normal Task of " .. ret_t.name .. ".\n - You have killed [" .. sto_value .. "/" .. ret_t.amount .. "] (Completed).\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_t.items) .. ".\n- Experience [+]: " .. formatExp(ret_t.exp) .. " EXP.\n- Task Points [+]: " .. ret_t.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime .. ".\n\nCompleting Daily Task of "..ret_td.name..".\n- You have killed [" .. sto_value_td .. "/" .. ret_td.amount .. "].\nThey also count in the task: ".. combinedList_td ..".\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_td.items) .. ".\n- Experience [+]: " .. formatExp(ret_td.exp) .. " EXP.\n- Task Points [+]: " .. ret_td.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_daily .. ".\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_t.items) .. ".\n- Experience [+]: " .. formatExp(ret_t.exp) .. " EXP.\n- Task Points [+]: " .. ret_t.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime .. ".\n\nCompleting Task Special of "..ret_ts.name..".\n- You have killed [" .. sto_value_ts .. "/" .. ret_ts.amount .. "].\nThey also count in the task: ".. combinedList_ts ..".\n\nBy completing the task you receive:\n- Special Rewards [+]: " .. getItemsFromTable(ret_ts.items) .. ".\n- Experience [+]: " .. formatExp(ret_ts.exp) .. " EXP.\n- Task Points [+]: " .. ret_ts.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_special .. ".")
		--- Esto es cuando la Daily Task y special estan completadas
		elseif sto_value < ret_t.amount then
			player:popupFYI("[Task System]\nCompleting Normal Task of " .. ret_t.name .. ".\n - You have killed [" .. sto_value .. "/" .. ret_t.amount .. "].\nThey also count in the task: ".. combinedList ..".\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_t.items) .. ".\n- Experience [+]: " .. formatExp(ret_t.exp) .. " EXP.\n- Task Points [+]: " .. ret_t.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime .. ".\n\nCompleting Daily Task of "..ret_td.name..".\n- You have killed [" .. sto_value_td .. "/" .. ret_td.amount .. "] (Completed).\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_td.items) .. ".\n- Experience [+]: " .. formatExp(ret_td.exp) .. " EXP.\n- Task Points [+]: " .. ret_td.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_daily .. ".\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_t.items) .. ".\n- Experience [+]: " .. formatExp(ret_t.exp) .. " EXP.\n- Task Points [+]: " .. ret_t.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime .. ".\n\nCompleting Task Special of "..ret_ts.name..".\n- You have killed [" .. sto_value_ts .. "/" .. ret_ts.amount .. "] (Completed).\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Special Rewards [+]: " .. getItemsFromTable(ret_ts.items) .. ".\n- Experience [+]: " .. formatExp(ret_ts.exp) .. " EXP.\n- Task Points [+]: " .. ret_ts.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_special .. ".")
		--- Esto es cuando la task normal y special estan completadas	
		elseif sto_value_td < ret_td.amount then
			player:popupFYI("[Task System]\nCompleting Task of " .. ret_t.name .. ".\n - You have killed [" .. sto_value .. "/" .. ret_t.amount .. "] (Completed).\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_t.items) .. ".\n- Experience [+]: " .. formatExp(ret_t.exp) .. " EXP.\n- Task Points [+]: " .. ret_t.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime .. ".\n\nCompleting Daily Task of "..ret_td.name..".\n- You have killed [" .. sto_value_td .. "/" .. ret_td.amount .. "].\nThey also count in the task: ".. combinedList_td ..".\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_td.items) .. ".\n- Experience [+]: " .. formatExp(ret_td.exp) .. " EXP.\n- Task Points [+]: " .. ret_td.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_daily .. ".\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_t.items) .. ".\n- Experience [+]: " .. formatExp(ret_t.exp) .. " EXP.\n- Task Points [+]: " .. ret_t.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime .. ".\n\nCompleting Task Special of "..ret_ts.name..".\n- You have killed [" .. sto_value_ts .. "/" .. ret_ts.amount .. "] (Completed).\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Special Rewards [+]: " .. getItemsFromTable(ret_ts.items) .. ".\n- Experience [+]: " .. formatExp(ret_ts.exp) .. " EXP.\n- Task Points [+]: " .. ret_ts.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_special .. ".")
		--- Esto es cuando la task normal y daily estan completadas	
		elseif sto_value_ts < ret_ts.amount then
			player:popupFYI("[Task System]\nCompleting Normal Task of " .. ret_t.name .. ".\n - You have killed [" .. sto_value .. "/" .. ret_t.amount .. "] (Completed).\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_t.items) .. ".\n- Experience [+]: " .. formatExp(ret_t.exp) .. " EXP.\n- Task Points [+]: " .. ret_t.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime .. ".\n\nCompleting Daily Task of "..ret_td.name..".\n- You have killed [" .. sto_value_td .. "/" .. ret_td.amount .. "] (Completed).\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_td.items) .. ".\n- Experience [+]: " .. formatExp(ret_td.exp) .. " EXP.\n- Task Points [+]: " .. ret_td.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_daily .. ".\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_t.items) .. ".\n- Experience [+]: " .. formatExp(ret_t.exp) .. " EXP.\n- Task Points [+]: " .. ret_t.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime .. ".\n\nCompleting Task Special of "..ret_ts.name..".\n- You have killed [" .. sto_value_ts .. "/" .. ret_ts.amount .. "].\nThey also count in the task: ".. combinedList_ts ..".\n\nBy completing the task you receive:\n- Special Rewards [+]: " .. getItemsFromTable(ret_ts.items) .. ".\n- Experience [+]: " .. formatExp(ret_ts.exp) .. " EXP.\n- Task Points [+]: " .. ret_ts.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_special .. ".")
		else
			player:popupFYI("[Task System]\nCompleting Normal Task of " .. ret_t.name .. ".\n - You have killed [" .. sto_value .. "/" .. ret_t.amount .. "] (Completed).\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_t.items) .. ".\n- Experience [+]: " .. formatExp(ret_t.exp) .. " EXP.\n- Task Points [+]: " .. ret_t.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime .. ".\n\nCompleting Daily Task of "..ret_td.name..".\n- You have killed [" .. sto_value_td .. "/" .. ret_td.amount .. "] (Completed).\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_td.items) .. ".\n- Experience [+]: " .. formatExp(ret_td.exp) .. " EXP.\n- Task Points [+]: " .. ret_td.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_daily .. ".\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_t.items) .. ".\n- Experience [+]: " .. formatExp(ret_t.exp) .. " EXP.\n- Task Points [+]: " .. ret_t.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime .. ".\n\nCompleting Task Special of "..ret_ts.name..".\n- You have killed [" .. sto_value_ts .. "/" .. ret_ts.amount .. "] (Completed).\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Special Rewards [+]: " .. getItemsFromTable(ret_ts.items) .. ".\n- Experience [+]: " .. formatExp(ret_ts.exp) .. " EXP.\n- Task Points [+]: " .. ret_ts.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_special .. ".")
		end
		
		
			---------
			
		-- Task Normal and Daily		
		elseif ret_t and ret_td then
		local capitalizedMonsterList = {}
		for _, monsterName in ipairs(ret_t.mons_list) do
			local capitalizedMonsterName = capitalizeSecondWord(monsterName)
			table.insert(capitalizedMonsterList, capitalizedMonsterName)
		end
		local combinedList = table.concat(capitalizedMonsterList, ", ")
		combinedList = capitalizeSecondWord(combinedList)
		
		local capitalizedMonsterList2 = {}
		for _, monsterName in ipairs(ret_td.mons_list) do
			local capitalizedMonsterName2 = capitalizeSecondWord(monsterName)
			table.insert(capitalizedMonsterList2, capitalizedMonsterName2)
		end
		local combinedList_td = table.concat(capitalizedMonsterList2, ", ")
		combinedList_td = capitalizeSecondWord(combinedList_td)
		local sto_value = player:getStorageValue(ret_t.storage)
		local sto_value_td = player:getStorageValue(ret_td.storage)
			if sto_value < ret_t.amount and sto_value_td < ret_td.amount then
				player:popupFYI("[Task System]\nCompleting Normal Task of " .. ret_t.name .. ".\n - You have killed [" .. sto_value .. "/" .. ret_t.amount .. "].\nThey also count in the task: ".. combinedList ..".\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_t.items) .. ".\n- Experience [+]: " .. ret_t.exp .. " EXP.\n- Task Points [+]: " .. ret_t.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime .. ".\n\nCompleting Daily Task of "..ret_td.name..".\n- You have killed [" .. sto_value_td .. "/" .. ret_td.amount .. "].\nThey also count in the task: ".. combinedList_td ..".\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_td.items) .. ".\n- Experience [+]: " .. formatExp(ret_td.exp) .. " EXP.\n- Task Points [+]: " .. ret_td.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_daily .. ".")
			elseif sto_value < ret_t.amount then
				player:popupFYI("[Task System]\nCompleting Normal Task of " .. ret_t.name .. ".\n - You have killed [" .. sto_value .. "/" .. ret_t.amount .. "].\nThey also count in the task: ".. combinedList ..".\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_t.items) .. ".\n- Experience [+]: " .. ret_t.exp .. " EXP.\n- Task Points [+]: " .. ret_t.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime .. ".\n\nCompleting Daily Task of "..ret_td.name..".\n- You have killed [" .. sto_value_td .. "/" .. ret_td.amount .. "] (Completed).\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_td.items) .. ".\n- Experience [+]: " .. formatExp(ret_td.exp) .. " EXP.\n- Task Points [+]: " .. ret_td.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_daily .. ".")
			elseif sto_value_td < ret_td.amount then
				player:popupFYI("[Task System]\nCompleting Normal Task of " .. ret_t.name .. ".\n - You have killed [" .. sto_value .. "/" .. ret_t.amount .. "]. (Completed)\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_t.items) .. ".\n- Experience [+]: " .. ret_t.exp .. " EXP.\n- Task Points [+]: " .. ret_t.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime .. ".\n\nCompleting Daily Task of "..ret_td.name..".\n- You have killed [" .. sto_value_td .. "/" .. ret_td.amount .. "].\nThey also count in the task: ".. combinedList_td ..".\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_td.items) .. ".\n- Experience [+]: " .. formatExp(ret_td.exp) .. " EXP.\n- Task Points [+]: " .. ret_td.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_daily .. ".")
			else
				player:popupFYI("[Task System]\nCompleting Normal Task of " .. ret_t.name .. ".\n - You have killed [" .. sto_value .. "/" .. ret_t.amount .. "] (Completed).\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_t.items) .. ".\n- Experience [+]: " .. ret_t.exp .. " EXP.\n- Task Points [+]: " .. ret_t.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime .. ".\n\nCompleting Daily Task of "..ret_td.name..".\n- You have killed [" .. sto_value_td .. "/" .. ret_td.amount .. "] (Completed).\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_td.items) .. ".\n- Experience [+]: " .. formatExp(ret_td.exp) .. " EXP.\n- Task Points [+]: " .. ret_td.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_daily .. ".")
			end
		


		
		-- Task Normal and Special		
		elseif ret_t and ret_ts then
		local capitalizedMonsterList = {}
		for _, monsterName in ipairs(ret_t.mons_list) do
			local capitalizedMonsterName = capitalizeSecondWord(monsterName)
			table.insert(capitalizedMonsterList, capitalizedMonsterName)
		end
		local combinedList = table.concat(capitalizedMonsterList, ", ")
		combinedList = capitalizeSecondWord(combinedList)
		
		--------SPECIAL-----------
		local capitalizedMonsterList3 = {}
		for _, monsterName in ipairs(ret_ts.mons_list) do
			local capitalizedMonsterName3 = capitalizeSecondWord(monsterName)
			table.insert(capitalizedMonsterList3, capitalizedMonsterName3)
		end
		local combinedList_ts = table.concat(capitalizedMonsterList3, ", ")
		combinedList_ts = capitalizeSecondWord(combinedList_ts)
		local sto_value = player:getStorageValue(ret_t.storage)
		local sto_value_ts = player:getStorageValue(ret_ts.storage)
			if sto_value < ret_t.amount and sto_value_ts < ret_ts.amount then
				player:popupFYI("[Task System]\nCompleting Normal Task of " .. ret_t.name .. ".\n - You have killed [" .. sto_value .. "/" .. ret_t.amount .. "].\nThey also count in the task: ".. combinedList ..".\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_t.items) .. ".\n- Experience [+]: " .. formatExp(ret_t.exp) .. " EXP.\n- Task Points [+]: " .. ret_t.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime .. ".\n\nCompleting Special Task of "..ret_ts.name..".\n- You have killed [" .. sto_value_ts .. "/" .. ret_ts.amount .. "].\nThey also count in the task: ".. combinedList_ts ..".\n\nBy completing the task you receive:\n- Special Rewards [+]: " .. getItemsFromTable(ret_ts.items_special) .. ".\n- Experience [+]: " .. formatExp(ret_ts.exp) .. " EXP.\n- Task Points [+]: " .. ret_ts.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_special .. ".")
			elseif sto_value < ret_t.amount then
				player:popupFYI("[Task System]\nCompleting Normal Task of " .. ret_t.name .. ".\n - You have killed [" .. sto_value .. "/" .. ret_t.amount .. "].\nThey also count in the task: ".. combinedList ..".\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_t.items) .. ".\n- Experience [+]: " .. formatExp(ret_t.exp) .. " EXP.\n- Task Points [+]: " .. ret_t.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime .. ".\n\nCompleting Special Task of "..ret_ts.name..".\n- You have killed [" .. sto_value_ts .. "/" .. ret_ts.amount .. "] (Completed).\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Special Rewards [+]: " .. getItemsFromTable(ret_ts.items_special) .. ".\n- Experience [+]: " .. formatExp(ret_ts.exp) .. " EXP.\n- Task Points [+]: " .. ret_ts.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_special .. ".")
			elseif sto_value_ts < ret_ts.amount then
				player:popupFYI("[Task System]\nCompleting Normal Task of " .. ret_t.name .. ".\n - You have killed [" .. sto_value .. "/" .. ret_t.amount .. "]. (Completed)\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_t.items) .. ".\n- Experience [+]: " .. formatExp(ret_t.exp) .. " EXP.\n- Task Points [+]: " .. ret_t.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime .. ".\n\nCompleting Special Task of "..ret_ts.name..".\n- You have killed [" .. sto_value_ts .. "/" .. ret_ts.amount .. "].\nThey also count in the task: ".. combinedList_ts ..".\n\nBy completing the task you receive:\n- Special Rewards [+]: " .. getItemsFromTable(ret_ts.items_special) .. ".\n- Experience [+]: " .. formatExp(ret_ts.exp) .. " EXP.\n- Task Points [+]: " .. ret_ts.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_special .. ".")
			else
				player:popupFYI("[Task System]\nCompleting Normal Task of " .. ret_t.name .. ".\n - You have killed [" .. sto_value .. "/" .. ret_t.amount .. "] (Completed).\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_t.items) .. ".\n- Experience [+]: " .. formatExp(ret_t.exp) .. " EXP.\n- Task Points [+]: " .. ret_t.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime .. ".\n\nCompleting Special Task of "..ret_ts.name..".\n- You have killed [" .. sto_value_ts .. "/" .. ret_ts.amount .. "] (Completed).\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Special Rewards [+]: " .. getItemsFromTable(ret_ts.items_special) .. ".\n- Experience [+]: " .. formatExp(ret_ts.exp) .. " EXP.\n- Task Points [+]: " .. ret_ts.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_special .. ".")
			end
			
		-- Daily Task and Special			
		elseif ret_td and ret_ts then
		local capitalizedMonsterList2 = {}
		for _, monsterName in ipairs(ret_td.mons_list) do
			local capitalizedMonsterName2 = capitalizeSecondWord(monsterName)
			table.insert(capitalizedMonsterList2, capitalizedMonsterName2)
		end
		local combinedList_td = table.concat(capitalizedMonsterList2, ", ")
		combinedList_td = capitalizeSecondWord(combinedList_td)
		
		--------SPECIAL-----------
		local capitalizedMonsterList3 = {}
		for _, monsterName in ipairs(ret_ts.mons_list) do
			local capitalizedMonsterName3 = capitalizeSecondWord(monsterName)
			table.insert(capitalizedMonsterList3, capitalizedMonsterName3)
		end
		local combinedList_ts = table.concat(capitalizedMonsterList3, ", ")
		combinedList_ts = capitalizeSecondWord(combinedList_ts)
		local sto_value_td = player:getStorageValue(ret_td.storage)
		local sto_value_ts = player:getStorageValue(ret_ts.storage)
			if sto_value_td < ret_td.amount and sto_value_ts < ret_ts.amount then
				player:popupFYI("[Task System]\nCompleting Daily Task of " .. ret_td.name .. ".\n - You have killed [" .. sto_value_td .. "/" .. ret_td.amount .. "].\nThey also count in the task: ".. combinedList_td ..".\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_td.items) .. ".\n- Experience [+]: " .. formatExp(ret_td.exp) .. " EXP.\n- Task Points [+]: " .. ret_td.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_daily .. ".\n\nCompleting Special Task of "..ret_ts.name..".\n- You have killed [" .. sto_value_ts .. "/" .. ret_ts.amount .. "].\nThey also count in the task: ".. combinedList_ts ..".\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_ts.items_special) .. ".\n- Experience [+]: " .. formatExp(ret_ts.exp) .. " EXP.\n- Task Points [+]: " .. ret_ts.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_special .. ".")
			elseif sto_value_td < ret_td.amount then
				player:popupFYI("[Task System]\nCompleting Daily Task of " .. ret_td.name .. ".\n - You have killed [" .. sto_value_td .. "/" .. ret_td.amount .. "].\nThey also count in the task: ".. combinedList_td ..".\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_td.items) .. ".\n- Experience [+]: " .. formatExp(ret_td.exp) .. " EXP.\n- Task Points [+]: " .. ret_td.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_daily .. ".\n\nCompleting Special Task of "..ret_ts.name..".\n- You have killed [" .. sto_value_ts .. "/" .. ret_ts.amount .. "] (Completed).\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_ts.items_special) .. ".\n- Experience [+]: " .. formatExp(ret_ts.exp) .. " EXP.\n- Task Points [+]: " .. ret_ts.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_special .. ".")
			elseif sto_value_ts < ret_ts.amount then
				player:popupFYI("[Task System]\nCompleting Daily Task of " .. ret_td.name .. ".\n - You have killed [" .. sto_value_td .. "/" .. ret_td.amount .. "]. (Completed)\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_td.items) .. ".\n- Experience [+]: " .. formatExp(ret_td.exp) .. " EXP.\n- Task Points [+]: " .. ret_td.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_daily .. ".\n\nCompleting Special Task of "..ret_ts.name..".\n- You have killed [" .. sto_value_ts .. "/" .. ret_ts.amount .. "].\nThey also count in the task: ".. combinedList_ts ..".\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_ts.items_special) .. ".\n- Experience [+]: " .. formatExp(ret_ts.exp) .. " EXP.\n- Task Points [+]: " .. ret_ts.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_special .. ".")
			else
				player:popupFYI("[Task System]\nCompleting Daily Task of " .. ret_td.name .. ".\n - You have killed [" .. sto_value_td .. "/" .. ret_td.amount .. "] (Completed).\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_td.items) .. ".\n- Experience [+]: " .. formatExp(ret_td.exp) .. " EXP.\n- Task Points [+]: " .. ret_td.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_daily .. ".\n\nCompleting Special Task of "..ret_ts.name..".\n- You have killed [" .. sto_value_ts .. "/" .. ret_ts.amount .. "] (Completed).\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_ts.items_special) .. ".\n- Experience [+]: " .. formatExp(ret_ts.exp) .. " EXP.\n- Task Points [+]: " .. ret_ts.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_special .. ".")
			end
			
			
			
			
			
		-- Only Normal Task			
		elseif ret_t then
		local capitalizedMonsterList = {}
		for _, monsterName in ipairs(ret_t.mons_list) do
			local capitalizedMonsterName = capitalizeSecondWord(monsterName)
			table.insert(capitalizedMonsterList, capitalizedMonsterName)
		end
		local combinedList = table.concat(capitalizedMonsterList, ", ")
		combinedList = capitalizeSecondWord(combinedList)
		local sto_value = player:getStorageValue(ret_t.storage)
			if sto_value < ret_t.amount then
				player:popupFYI("[Task System]\nCompleting Normal Task of " .. ret_t.name .. ".\n - You have killed [" .. sto_value .. "/" .. ret_t.amount .. "].\nThey also count in the task: ".. combinedList ..".\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_t.items) .. ".\n- Experience [+]: " .. formatExp(ret_t.exp) .. " EXP.\n- Task Points [+]: " .. ret_t.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime .. ".")
			else
				player:popupFYI("[Task System]\nCompleting Normal Task of " .. ret_t.name .. ".\n - You have killed [" .. sto_value .. "/" .. ret_t.amount .. "]. (Completed)\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_t.items) .. ".\n- Experience [+]: " .. formatExp(ret_t.exp) .. " EXP.\n- Task Points [+]: " .. ret_t.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime .. ".")
			end
			--------
		-- Only Daily Task
		elseif ret_td then
		local sto_value_td = player:getStorageValue(ret_td.storage)
		local capitalizedMonsterList2 = {}
		for _, monsterName in ipairs(ret_td.mons_list) do
			local capitalizedMonsterName2 = capitalizeSecondWord(monsterName)
			table.insert(capitalizedMonsterList2, capitalizedMonsterName2)
		end
		local combinedList_td = table.concat(capitalizedMonsterList2, ", ")
		combinedList_td = capitalizeSecondWord(combinedList_td)
		if sto_value_td < ret_td.amount then
			player:popupFYI("[Task System]\nCompleting Daily Task of " .. ret_td.name .. ".\n - You have killed [" .. sto_value_td .. "/" .. ret_td.amount .. "].\nThey also count in the task: ".. combinedList_td ..".\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_td.items) .. ".\n- Experience [+]: " .. formatExp(ret_td.exp) .. " EXP.\n- Task Points [+]: " .. ret_td.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_daily .. ".")
		else
			player:popupFYI("[Task System]\nCompleting Daily Task of " .. ret_td.name .. ".\n - You have killed [" .. sto_value_td .. "/" .. ret_td.amount .. "]. (Completed)\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_td.items) .. ".\n- Experience [+]: " .. formatExp(ret_td.exp) .. " EXP.\n- Task Points [+]: " .. ret_td.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_daily .. ".")
		end
			--------
		-- Only Special Task
		elseif ret_ts then
		local sto_value_ts = player:getStorageValue(ret_ts.storage)
		local capitalizedMonsterList3 = {}
		for _, monsterName in ipairs(ret_ts.mons_list) do
			local capitalizedMonsterName3 = capitalizeSecondWord(monsterName)
			table.insert(capitalizedMonsterList3, capitalizedMonsterName3)
		end
		local combinedList_ts = table.concat(capitalizedMonsterList3, ", ")
		combinedList_ts = capitalizeSecondWord(combinedList_ts)
		if sto_value_ts < ret_ts.amount then
			player:popupFYI("[Task System]\nCompleting Special Task of " .. ret_ts.name .. ".\n - You have killed [" .. sto_value_ts .. "/" .. ret_ts.amount .. "].\nThey also count in the task: ".. combinedList_ts ..".\n\nBy completing the task you receive:\n- Special Rewards [+]: " .. getItemsFromTable(ret_ts.items_special) .. ".\n- Experience [+]: " .. formatExp(ret_ts.exp) .. " EXP.\n- Task Points [+]: " .. ret_ts.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_special .. ".")
		else
			player:popupFYI("[Task System]\nCompleting Special Task of " .. ret_ts.name .. ".\n - You have killed [" .. sto_value_ts .. "/" .. ret_ts.amount .. "]. (Completed)\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Special Rewards [+]: " .. getItemsFromTable(ret_ts.items_special) .. ".\n- Experience [+]: " .. formatExp(ret_ts.exp) .. " EXP.\n- Task Points [+]: " .. ret_ts.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_special .. ".")
		end
			---------
			---- SI NO TIENE NINGUNA TASK ENCIMA
		else
			player:popupFYI("[Task System]\n- You have not yet chosen a task with Vauter. \n\n- Task Rank: ".. getRankTask(player) ..".\n- Task Points: ".. taskRank_get(player) ..".")
		end
		exhaust[playerId] = currentTime + exhaustTime
	end
	
	
	if Position(32348, 32222, 7) == item:getPosition() then
	local currentDay = os.date("%A") -- Obtener el nombre del día actual
    local taskList = task_daily[currentDay] -- Obtener la lista de tareas del día actual
	
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
	
    -- Recorrer la lista de tareas del día actual y agregarlas al mensaje
    for _, task in ipairs(taskList) do
		message = message .. "-> " .. task.name .. "\n"
		message = message .. "   [+] Count: " .. task.amount .. ".\n"
		message = message .. "   [+] Experience: " .. formatExp(task.exp) .. ".\n"
	
		if task.items and #task.items > 0 then
		message = message .. "   [+] Rewards: \n"
			for _, item in ipairs(task.items) do
				local itemName = getItemNameById(item.id) -- Obtener el nombre del objeto por su ID
				message = message .. "      -> " .. item.count .. "x " .. itemName .. ".\n"
			end
		end
    
    -- Mostrar los elementos especiales si existen
		if task.items_special and #task.items_special > 0 then
		message = message .. "   [+] Special Items: \n"
			for _, item in ipairs(task.items_special) do
			local itemName = getItemNameById(item.id) -- Obtener el nombre del objeto por su ID
			message = message .. "      -> " .. item.count .. "x " .. itemName .. ".\n\n"
			end
		end
	end	
		player:popupFYI(message)
	end
	
	
	
	return true
end

taskboard:id(36828)
taskboard:register()


local task_command = TalkAction("/task", "!task", "!status")

function task_command.onSay(player, words, param)

	local playerId = player:getId()
    local currentTime = os.time()
    if exhaust[playerId] and exhaust[playerId] > currentTime then
		player:sendCancelMessage("You are on cooldown, wait (0." .. exhaust[playerId] - currentTime .. "s).")
		return false
	end
	
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
	
	local ret_t = getTaskInfos(player)
	local ret_td = getTaskDailyInfo(player)
	local ret_ts = getTaskSpecialInfo(player)
		if ret_t and ret_td and ret_ts then
		local sto_value = player:getStorageValue(ret_t.storage)
		local sto_value_td = player:getStorageValue(ret_td.storage)
		local sto_value_ts = player:getStorageValue(ret_ts.storage)
		local capitalizedMonsterList = {}
		for _, monsterName in ipairs(ret_t.mons_list) do
			local capitalizedMonsterName = capitalizeSecondWord(monsterName)
			table.insert(capitalizedMonsterList, capitalizedMonsterName)
		end
		local combinedList = table.concat(capitalizedMonsterList, ", ")
		combinedList = capitalizeSecondWord(combinedList)
		--------DAILY------------
		local capitalizedMonsterList2 = {}
		for _, monsterName in ipairs(ret_td.mons_list) do
			local capitalizedMonsterName2 = capitalizeSecondWord(monsterName)
			table.insert(capitalizedMonsterList2, capitalizedMonsterName2)
		end
		local combinedList_td = table.concat(capitalizedMonsterList2, ", ")
		combinedList_td = capitalizeSecondWord(combinedList_td)
		--------SPECIAL-----------
		local capitalizedMonsterList3 = {}
		for _, monsterName in ipairs(ret_ts.mons_list) do
			local capitalizedMonsterName3 = capitalizeSecondWord(monsterName)
			table.insert(capitalizedMonsterList3, capitalizedMonsterName3)
		end
		local combinedList_ts = table.concat(capitalizedMonsterList3, ", ")
		combinedList_ts = capitalizeSecondWord(combinedList_ts)
			
		-- With Normal, Daily and Special
		if sto_value < ret_t.amount and sto_value_td < ret_td.amount and sto_value_ts < ret_ts.amount then
			player:popupFYI("[Task System]\nCompleting Normal Task of " .. ret_t.name .. ".\n - You have killed [" .. sto_value .. "/" .. ret_t.amount .. "].\nThey also count in the task: ".. combinedList ..".\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_t.items) .. ".\n- Experience [+]: " .. ret_t.exp .. " EXP.\n- Task Points [+]: " .. ret_t.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime .. ".\n\nCompleting Daily Task of "..ret_td.name..".\n- You have killed [" .. sto_value_td .. "/" .. ret_td.amount .. "].\nThey also count in the task: ".. combinedList_td ..".\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_td.items) .. ".\n- Experience [+]: " .. ret_td.exp .. " EXP.\n- Task Points [+]: " .. ret_td.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_daily .. ".\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_t.items) .. ".\n- Experience [+]: " .. ret_t.exp .. " EXP.\n- Task Points [+]: " .. ret_t.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime .. ".\n\nCompleting Task Special of "..ret_ts.name..".\n- You have killed [" .. sto_value_ts .. "/" .. ret_ts.amount .. "].\nThey also count in the task: ".. combinedList_ts ..".\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_ts.items) .. ".\n- Experience [+]: " .. ret_ts.exp .. " EXP.\n- Task Points [+]: " .. ret_ts.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_special .. ".")
		--- Esto es cuando la task special esta completada
		elseif sto_value < ret_t.amount and sto_value_td < ret_td.amount then
			player:popupFYI("[Task System]\nCompleting Normal Task of " .. ret_t.name .. ".\n - You have killed [" .. sto_value .. "/" .. ret_t.amount .. "].\nThey also count in the task: ".. combinedList ..".\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_t.items) .. ".\n- Experience [+]: " .. ret_t.exp .. " EXP.\n- Task Points [+]: " .. ret_t.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime .. ".\n\nCompleting Daily Task of "..ret_td.name..".\n- You have killed [" .. sto_value_td .. "/" .. ret_td.amount .. "].\nThey also count in the task: ".. combinedList_td ..".\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_td.items) .. ".\n- Experience [+]: " .. ret_td.exp .. " EXP.\n- Task Points [+]: " .. ret_td.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_daily .. ".\n\nCompleting Special Task of "..ret_ts.name..".\n- You have killed [" .. sto_value_ts .. "/" .. ret_ts.amount .. "] (Completed).\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_ts.items) .. ".\n- Experience [+]: " .. ret_ts.exp .. " EXP.\n- Task Points [+]: " .. ret_ts.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_special .. ".")
		--- Esto es cuando la Daily Task esta completada
		elseif sto_value < ret_t.amount and sto_value_ts < ret_ts.amount then
			player:popupFYI("[Task System]\nCompleting Normal Task of " .. ret_t.name .. ".\n - You have killed [" .. sto_value .. "/" .. ret_t.amount .. "].\nThey also count in the task: ".. combinedList ..".\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_t.items) .. ".\n- Experience [+]: " .. ret_t.exp .. " EXP.\n- Task Points [+]: " .. ret_t.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime .. ".\n\nCompleting Daily Task of "..ret_td.name..".\n- You have killed [" .. sto_value_td .. "/" .. ret_td.amount .. "] (Completed).\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_td.items) .. ".\n- Experience [+]: " .. ret_td.exp .. " EXP.\n- Task Points [+]: " .. ret_td.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_daily .. ".\n\nCompleting Special Task of "..ret_ts.name..".\n- You have killed [" .. sto_value_ts .. "/" .. ret_ts.amount .. "].\nThey also count in the task: ".. combinedList_ts ..".\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_ts.items) .. ".\n- Experience [+]: " .. ret_ts.exp .. " EXP.\n- Task Points [+]: " .. ret_ts.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_special .. ".")
		--- Esto es cuando la task normal esta completada
		elseif sto_value_ts < ret_ts.amount and sto_value_td < ret_td.amount then
			player:popupFYI("[Task System]\nCompleting Normal Task of " .. ret_t.name .. ".\n - You have killed [" .. sto_value .. "/" .. ret_t.amount .. "] (Completed).\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_t.items) .. ".\n- Experience [+]: " .. ret_t.exp .. " EXP.\n- Task Points [+]: " .. ret_t.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime .. ".\n\nCompleting Daily Task of "..ret_td.name..".\n- You have killed [" .. sto_value_td .. "/" .. ret_td.amount .. "].\nThey also count in the task: ".. combinedList_td ..".\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_td.items) .. ".\n- Experience [+]: " .. ret_td.exp .. " EXP.\n- Task Points [+]: " .. ret_td.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_daily .. ".\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_t.items) .. ".\n- Experience [+]: " .. ret_t.exp .. " EXP.\n- Task Points [+]: " .. ret_t.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime .. ".\n\nCompleting Task Special of "..ret_ts.name..".\n- You have killed [" .. sto_value_ts .. "/" .. ret_ts.amount .. "].\nThey also count in the task: ".. combinedList_ts ..".\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_ts.items) .. ".\n- Experience [+]: " .. ret_ts.exp .. " EXP.\n- Task Points [+]: " .. ret_ts.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_special .. ".")
		--- Esto es cuando la Daily Task y special estan completadas
		elseif sto_value < ret_t.amount then
			player:popupFYI("[Task System]\nCompleting Normal Task of " .. ret_t.name .. ".\n - You have killed [" .. sto_value .. "/" .. ret_t.amount .. "].\nThey also count in the task: ".. combinedList ..".\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_t.items) .. ".\n- Experience [+]: " .. ret_t.exp .. " EXP.\n- Task Points [+]: " .. ret_t.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime .. ".\n\nCompleting Daily Task of "..ret_td.name..".\n- You have killed [" .. sto_value_td .. "/" .. ret_td.amount .. "] (Completed).\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_td.items) .. ".\n- Experience [+]: " .. ret_td.exp .. " EXP.\n- Task Points [+]: " .. ret_td.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_daily .. ".\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_t.items) .. ".\n- Experience [+]: " .. ret_t.exp .. " EXP.\n- Task Points [+]: " .. ret_t.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime .. ".\n\nCompleting Task Special of "..ret_ts.name..".\n- You have killed [" .. sto_value_ts .. "/" .. ret_ts.amount .. "] (Completed).\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_ts.items) .. ".\n- Experience [+]: " .. ret_ts.exp .. " EXP.\n- Task Points [+]: " .. ret_ts.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_special .. ".")
		--- Esto es cuando la task normal y special estan completadas	
		elseif sto_value_td < ret_td.amount then
			player:popupFYI("[Task System]\nCompleting Task of " .. ret_t.name .. ".\n - You have killed [" .. sto_value .. "/" .. ret_t.amount .. "] (Completed).\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_t.items) .. ".\n- Experience [+]: " .. ret_t.exp .. " EXP.\n- Task Points [+]: " .. ret_t.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime .. ".\n\nCompleting Daily Task of "..ret_td.name..".\n- You have killed [" .. sto_value_td .. "/" .. ret_td.amount .. "].\nThey also count in the task: ".. combinedList_td ..".\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_td.items) .. ".\n- Experience [+]: " .. ret_td.exp .. " EXP.\n- Task Points [+]: " .. ret_td.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_daily .. ".\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_t.items) .. ".\n- Experience [+]: " .. ret_t.exp .. " EXP.\n- Task Points [+]: " .. ret_t.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime .. ".\n\nCompleting Task Special of "..ret_ts.name..".\n- You have killed [" .. sto_value_ts .. "/" .. ret_ts.amount .. "] (Completed).\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_ts.items) .. ".\n- Experience [+]: " .. ret_ts.exp .. " EXP.\n- Task Points [+]: " .. ret_ts.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_special .. ".")
		--- Esto es cuando la task normal y daily estan completadas	
		elseif sto_value_ts < ret_ts.amount then
			player:popupFYI("[Task System]\nCompleting Normal Task of " .. ret_t.name .. ".\n - You have killed [" .. sto_value .. "/" .. ret_t.amount .. "] (Completed).\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_t.items) .. ".\n- Experience [+]: " .. ret_t.exp .. " EXP.\n- Task Points [+]: " .. ret_t.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime .. ".\n\nCompleting Daily Task of "..ret_td.name..".\n- You have killed [" .. sto_value_td .. "/" .. ret_td.amount .. "] (Completed).\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_td.items) .. ".\n- Experience [+]: " .. ret_td.exp .. " EXP.\n- Task Points [+]: " .. ret_td.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_daily .. ".\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_t.items) .. ".\n- Experience [+]: " .. ret_t.exp .. " EXP.\n- Task Points [+]: " .. ret_t.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime .. ".\n\nCompleting Task Special of "..ret_ts.name..".\n- You have killed [" .. sto_value_ts .. "/" .. ret_ts.amount .. "].\nThey also count in the task: ".. combinedList_ts ..".\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_ts.items) .. ".\n- Experience [+]: " .. ret_ts.exp .. " EXP.\n- Task Points [+]: " .. ret_ts.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_special .. ".")
		else
			player:popupFYI("[Task System]\nCompleting Normal Task of " .. ret_t.name .. ".\n - You have killed [" .. sto_value .. "/" .. ret_t.amount .. "] (Completed).\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_t.items) .. ".\n- Experience [+]: " .. ret_t.exp .. " EXP.\n- Task Points [+]: " .. ret_t.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime .. ".\n\nCompleting Daily Task of "..ret_td.name..".\n- You have killed [" .. sto_value_td .. "/" .. ret_td.amount .. "] (Completed).\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_td.items) .. ".\n- Experience [+]: " .. ret_td.exp .. " EXP.\n- Task Points [+]: " .. ret_td.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_daily .. ".\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_t.items) .. ".\n- Experience [+]: " .. ret_t.exp .. " EXP.\n- Task Points [+]: " .. ret_t.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime .. ".\n\nCompleting Task Special of "..ret_ts.name..".\n- You have killed [" .. sto_value_ts .. "/" .. ret_ts.amount .. "] (Completed).\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_ts.items) .. ".\n- Experience [+]: " .. ret_ts.exp .. " EXP.\n- Task Points [+]: " .. ret_ts.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_special .. ".")
		end
			
		-- Task Normal and Daily		
		elseif ret_t and ret_td then
		local capitalizedMonsterList = {}
		for _, monsterName in ipairs(ret_t.mons_list) do
			local capitalizedMonsterName = capitalizeSecondWord(monsterName)
			table.insert(capitalizedMonsterList, capitalizedMonsterName)
		end
		local combinedList = table.concat(capitalizedMonsterList, ", ")
		combinedList = capitalizeSecondWord(combinedList)
		
		local capitalizedMonsterList2 = {}
		for _, monsterName in ipairs(ret_td.mons_list) do
			local capitalizedMonsterName2 = capitalizeSecondWord(monsterName)
			table.insert(capitalizedMonsterList2, capitalizedMonsterName2)
		end
		local combinedList_td = table.concat(capitalizedMonsterList2, ", ")
		combinedList_td = capitalizeSecondWord(combinedList_td)
		local sto_value = player:getStorageValue(ret_t.storage)
		local sto_value_td = player:getStorageValue(ret_td.storage)
			if sto_value < ret_t.amount and sto_value_td < ret_td.amount then
				player:popupFYI("[Task System]\nCompleting Normal Task of " .. ret_t.name .. ".\n - You have killed [" .. sto_value .. "/" .. ret_t.amount .. "].\nThey also count in the task: ".. combinedList ..".\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_t.items) .. ".\n- Experience [+]: " .. ret_t.exp .. " EXP.\n- Task Points [+]: " .. ret_t.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime .. ".\n\nCompleting Daily Task of "..ret_td.name..".\n- You have killed [" .. sto_value_td .. "/" .. ret_td.amount .. "].\nThey also count in the task: ".. combinedList_td ..".\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_td.items) .. ".\n- Experience [+]: " .. ret_td.exp .. " EXP.\n- Task Points [+]: " .. ret_td.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_daily .. ".")
			elseif sto_value < ret_t.amount then
				player:popupFYI("[Task System]\nCompleting Normal Task of " .. ret_t.name .. ".\n - You have killed [" .. sto_value .. "/" .. ret_t.amount .. "].\nThey also count in the task: ".. combinedList ..".\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_t.items) .. ".\n- Experience [+]: " .. ret_t.exp .. " EXP.\n- Task Points [+]: " .. ret_t.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime .. ".\n\nCompleting Daily Task of "..ret_td.name..".\n- You have killed [" .. sto_value_td .. "/" .. ret_td.amount .. "] (Completed).\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_td.items) .. ".\n- Experience [+]: " .. ret_td.exp .. " EXP.\n- Task Points [+]: " .. ret_td.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_daily .. ".")
			elseif sto_value_td < ret_td.amount then
				player:popupFYI("[Task System]\nCompleting Normal Task of " .. ret_t.name .. ".\n - You have killed [" .. sto_value .. "/" .. ret_t.amount .. "]. (Completed)\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_t.items) .. ".\n- Experience [+]: " .. ret_t.exp .. " EXP.\n- Task Points [+]: " .. ret_t.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime .. ".\n\nCompleting Daily Task of "..ret_td.name..".\n- You have killed [" .. sto_value_td .. "/" .. ret_td.amount .. "].\nThey also count in the task: ".. combinedList_td ..".\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_td.items) .. ".\n- Experience [+]: " .. ret_td.exp .. " EXP.\n- Task Points [+]: " .. ret_td.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_daily .. ".")
			else
				player:popupFYI("[Task System]\nCompleting Normal Task of " .. ret_t.name .. ".\n - You have killed [" .. sto_value .. "/" .. ret_t.amount .. "] (Completed).\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_t.items) .. ".\n- Experience [+]: " .. ret_t.exp .. " EXP.\n- Task Points [+]: " .. ret_t.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime .. ".\n\nCompleting Daily Task of "..ret_td.name..".\n- You have killed [" .. sto_value_td .. "/" .. ret_td.amount .. "] (Completed).\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_td.items) .. ".\n- Experience [+]: " .. ret_td.exp .. " EXP.\n- Task Points [+]: " .. ret_td.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_daily .. ".")
			end
		
		-- Task Normal and Special		
		elseif ret_t and ret_ts then
		local capitalizedMonsterList = {}
		for _, monsterName in ipairs(ret_t.mons_list) do
			local capitalizedMonsterName = capitalizeSecondWord(monsterName)
			table.insert(capitalizedMonsterList, capitalizedMonsterName)
		end
		local combinedList = table.concat(capitalizedMonsterList, ", ")
		combinedList = capitalizeSecondWord(combinedList)
		
		--------SPECIAL-----------
		local capitalizedMonsterList3 = {}
		for _, monsterName in ipairs(ret_ts.mons_list) do
			local capitalizedMonsterName3 = capitalizeSecondWord(monsterName)
			table.insert(capitalizedMonsterList3, capitalizedMonsterName3)
		end
		local combinedList_ts = table.concat(capitalizedMonsterList3, ", ")
		combinedList_ts = capitalizeSecondWord(combinedList_ts)
		local sto_value = player:getStorageValue(ret_t.storage)
		local sto_value_ts = player:getStorageValue(ret_ts.storage)
			if sto_value < ret_t.amount and sto_value_ts < ret_ts.amount then
				player:popupFYI("[Task System]\nCompleting Normal Task of " .. ret_t.name .. ".\n - You have killed [" .. sto_value .. "/" .. ret_t.amount .. "].\nThey also count in the task: ".. combinedList ..".\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_t.items) .. ".\n- Experience [+]: " .. ret_t.exp .. " EXP.\n- Task Points [+]: " .. ret_t.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime .. ".\n\nCompleting Special Task of "..ret_ts.name..".\n- You have killed [" .. sto_value_ts .. "/" .. ret_ts.amount .. "].\nThey also count in the task: ".. combinedList_ts ..".\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_ts.items) .. ".\n- Experience [+]: " .. ret_ts.exp .. " EXP.\n- Task Points [+]: " .. ret_ts.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_special .. ".")
			elseif sto_value < ret_t.amount then
				player:popupFYI("[Task System]\nCompleting Normal Task of " .. ret_t.name .. ".\n - You have killed [" .. sto_value .. "/" .. ret_t.amount .. "].\nThey also count in the task: ".. combinedList ..".\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_t.items) .. ".\n- Experience [+]: " .. ret_t.exp .. " EXP.\n- Task Points [+]: " .. ret_t.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime .. ".\n\nCompleting Special Task of "..ret_ts.name..".\n- You have killed [" .. sto_value_ts .. "/" .. ret_ts.amount .. "] (Completed).\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_ts.items) .. ".\n- Experience [+]: " .. ret_ts.exp .. " EXP.\n- Task Points [+]: " .. ret_ts.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_special .. ".")
			elseif sto_value_ts < ret_ts.amount then
				player:popupFYI("[Task System]\nCompleting Normal Task of " .. ret_t.name .. ".\n - You have killed [" .. sto_value .. "/" .. ret_t.amount .. "]. (Completed)\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_t.items) .. ".\n- Experience [+]: " .. ret_t.exp .. " EXP.\n- Task Points [+]: " .. ret_t.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime .. ".\n\nCompleting Special Task of "..ret_ts.name..".\n- You have killed [" .. sto_value_ts .. "/" .. ret_ts.amount .. "].\nThey also count in the task: ".. combinedList_ts ..".\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_ts.items) .. ".\n- Experience [+]: " .. ret_ts.exp .. " EXP.\n- Task Points [+]: " .. ret_ts.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_special .. ".")
			else
				player:popupFYI("[Task System]\nCompleting Normal Task of " .. ret_t.name .. ".\n - You have killed [" .. sto_value .. "/" .. ret_t.amount .. "] (Completed).\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_t.items) .. ".\n- Experience [+]: " .. ret_t.exp .. " EXP.\n- Task Points [+]: " .. ret_t.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime .. ".\n\nCompleting Special Task of "..ret_ts.name..".\n- You have killed [" .. sto_value_ts .. "/" .. ret_ts.amount .. "] (Completed).\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_ts.items) .. ".\n- Experience [+]: " .. ret_ts.exp .. " EXP.\n- Task Points [+]: " .. ret_ts.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_special .. ".")
			end
			
		-- Daily Task and Special			
		elseif ret_td and ret_ts then
		local capitalizedMonsterList2 = {}
		for _, monsterName in ipairs(ret_td.mons_list) do
			local capitalizedMonsterName2 = capitalizeSecondWord(monsterName)
			table.insert(capitalizedMonsterList2, capitalizedMonsterName2)
		end
		local combinedList_td = table.concat(capitalizedMonsterList2, ", ")
		combinedList_td = capitalizeSecondWord(combinedList_td)
		
		--------SPECIAL-----------
		local capitalizedMonsterList3 = {}
		for _, monsterName in ipairs(ret_ts.mons_list) do
			local capitalizedMonsterName3 = capitalizeSecondWord(monsterName)
			table.insert(capitalizedMonsterList3, capitalizedMonsterName3)
		end
		local combinedList_ts = table.concat(capitalizedMonsterList3, ", ")
		combinedList_ts = capitalizeSecondWord(combinedList_ts)
		local sto_value_td = player:getStorageValue(ret_td.storage)
		local sto_value_ts = player:getStorageValue(ret_ts.storage)
			if sto_value_td < ret_td.amount and sto_value_ts < ret_ts.amount then
				player:popupFYI("[Task System]\nCompleting Daily Task of " .. ret_td.name .. ".\n - You have killed [" .. sto_value_td .. "/" .. ret_td.amount .. "].\nThey also count in the task: ".. combinedList_td ..".\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_td.items) .. ".\n- Experience [+]: " .. ret_td.exp .. " EXP.\n- Task Points [+]: " .. ret_td.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_daily .. ".\n\nCompleting Special Task of "..ret_ts.name..".\n- You have killed [" .. sto_value_ts .. "/" .. ret_ts.amount .. "].\nThey also count in the task: ".. combinedList_ts ..".\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_ts.items) .. ".\n- Experience [+]: " .. ret_ts.exp .. " EXP.\n- Task Points [+]: " .. ret_ts.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_special .. ".")
			elseif sto_value_td < ret_td.amount then
				player:popupFYI("[Task System]\nCompleting Daily Task of " .. ret_td.name .. ".\n - You have killed [" .. sto_value_td .. "/" .. ret_td.amount .. "].\nThey also count in the task: ".. combinedList_td ..".\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_td.items) .. ".\n- Experience [+]: " .. ret_td.exp .. " EXP.\n- Task Points [+]: " .. ret_td.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_daily .. ".\n\nCompleting Special Task of "..ret_ts.name..".\n- You have killed [" .. sto_value_ts .. "/" .. ret_ts.amount .. "] (Completed).\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_ts.items) .. ".\n- Experience [+]: " .. ret_ts.exp .. " EXP.\n- Task Points [+]: " .. ret_ts.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_special .. ".")
			elseif sto_value_ts < ret_ts.amount then
				player:popupFYI("[Task System]\nCompleting Daily Task of " .. ret_td.name .. ".\n - You have killed [" .. sto_value_td .. "/" .. ret_td.amount .. "]. (Completed)\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_td.items) .. ".\n- Experience [+]: " .. ret_td.exp .. " EXP.\n- Task Points [+]: " .. ret_td.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_daily .. ".\n\nCompleting Special Task of "..ret_ts.name..".\n- You have killed [" .. sto_value_ts .. "/" .. ret_ts.amount .. "].\nThey also count in the task: ".. combinedList_ts ..".\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_ts.items) .. ".\n- Experience [+]: " .. ret_ts.exp .. " EXP.\n- Task Points [+]: " .. ret_ts.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_special .. ".")
			else
				player:popupFYI("[Task System]\nCompleting Daily Task of " .. ret_td.name .. ".\n - You have killed [" .. sto_value_td .. "/" .. ret_td.amount .. "] (Completed).\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_td.items) .. ".\n- Experience [+]: " .. ret_td.exp .. " EXP.\n- Task Points [+]: " .. ret_td.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_daily .. ".\n\nCompleting Special Task of "..ret_ts.name..".\n- You have killed [" .. sto_value_ts .. "/" .. ret_ts.amount .. "] (Completed).\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_ts.items) .. ".\n- Experience [+]: " .. ret_ts.exp .. " EXP.\n- Task Points [+]: " .. ret_ts.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_special .. ".")
			end
			
		-- Only Normal Task			
		elseif ret_t then
		local capitalizedMonsterList = {}
		for _, monsterName in ipairs(ret_t.mons_list) do
			local capitalizedMonsterName = capitalizeSecondWord(monsterName)
			table.insert(capitalizedMonsterList, capitalizedMonsterName)
		end
		local combinedList = table.concat(capitalizedMonsterList, ", ")
		combinedList = capitalizeSecondWord(combinedList)
		local sto_value = player:getStorageValue(ret_t.storage)
			if sto_value < ret_t.amount then
				player:popupFYI("[Task System]\nCompleting Normal Task of " .. ret_t.name .. ".\n - You have killed [" .. sto_value .. "/" .. ret_t.amount .. "].\nThey also count in the task: ".. combinedList ..".\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_t.items) .. ".\n- Experience [+]: " .. ret_t.exp .. " EXP.\n- Task Points [+]: " .. ret_t.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime .. ".")
			else
				player:popupFYI("[Task System]\nCompleting Normal Task of " .. ret_t.name .. ".\n - You have killed [" .. sto_value .. "/" .. ret_t.amount .. "]. (Completed)\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_t.items) .. ".\n- Experience [+]: " .. ret_t.exp .. " EXP.\n- Task Points [+]: " .. ret_t.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime .. ".")
			end
			--------
		-- Only Daily Task
		elseif ret_td then
		local sto_value_td = player:getStorageValue(ret_td.storage)
		local capitalizedMonsterList2 = {}
		for _, monsterName in ipairs(ret_td.mons_list) do
			local capitalizedMonsterName2 = capitalizeSecondWord(monsterName)
			table.insert(capitalizedMonsterList2, capitalizedMonsterName2)
		end
		local combinedList_td = table.concat(capitalizedMonsterList2, ", ")
		combinedList_td = capitalizeSecondWord(combinedList_td)
		if sto_value_td < ret_td.amount then
			player:popupFYI("[Task System]\nCompleting Daily Task of " .. ret_td.name .. ".\n - You have killed [" .. sto_value_td .. "/" .. ret_td.amount .. "].\nThey also count in the task: ".. combinedList_td ..".\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_td.items) .. ".\n- Experience [+]: " .. ret_td.exp .. " EXP.\n- Task Points [+]: " .. ret_td.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_daily .. ".")
		else
			player:popupFYI("[Task System]\nCompleting Daily Task of " .. ret_td.name .. ".\n - You have killed [" .. sto_value_td .. "/" .. ret_td.amount .. "]. (Completed)\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_td.items) .. ".\n- Experience [+]: " .. ret_td.exp .. " EXP.\n- Task Points [+]: " .. ret_td.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_daily .. ".")
		end
			--------
		-- Only Special Task
		elseif ret_ts then
		local sto_value_ts = player:getStorageValue(ret_ts.storage)
		local capitalizedMonsterList3 = {}
		for _, monsterName in ipairs(ret_ts.mons_list) do
			local capitalizedMonsterName3 = capitalizeSecondWord(monsterName)
			table.insert(capitalizedMonsterList3, capitalizedMonsterName3)
		end
		local combinedList_ts = table.concat(capitalizedMonsterList3, ", ")
		combinedList_ts = capitalizeSecondWord(combinedList_ts)
		if sto_value_ts < ret_ts.amount then
			player:popupFYI("[Task System]\nCompleting Special Task of " .. ret_ts.name .. ".\n - You have killed [" .. sto_value_ts .. "/" .. ret_ts.amount .. "].\nThey also count in the task: ".. combinedList_ts ..".\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_ts.items) .. ".\n- Experience [+]: " .. ret_ts.exp .. " EXP.\n- Task Points [+]: " .. ret_ts.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_special .. ".")
		else
			player:popupFYI("[Task System]\nCompleting Special Task of " .. ret_ts.name .. ".\n - You have killed [" .. sto_value_ts .. "/" .. ret_ts.amount .. "]. (Completed)\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_ts.items) .. ".\n- Experience [+]: " .. ret_ts.exp .. " EXP.\n- Task Points [+]: " .. ret_ts.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime_special .. ".")
		end
			---------
			---- SI NO TIENE NINGUNA TASK ENCIMA
		else
			player:popupFYI("[Task System]\n- You have not yet chosen a task with Vauter. \n\n- Task Rank: ".. getRankTask(player) ..".\n- Task Points: ".. taskRank_get(player) ..".")
		end
		exhaust[playerId] = currentTime + exhaustTime
	
    return false
end

task_command:separator(" ")
task_command:register()