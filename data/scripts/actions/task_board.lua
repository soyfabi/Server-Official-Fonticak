local taskboard = Action()

function taskboard.onUse(player, item, fromPosition, target, toPosition, isHotkey)

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
	
	local function firstStringToUpper(str)
		return (str:gsub("^%l", string.upper))
	end
	
	--[[local ret_td = getTaskDailyInfo(player)
	local sto_value_td = player:getStorageValue(ret_td.storage)
		if ret_td then
			if sto_value_td < ret_td.amount then
			player:say("hola")
			--player:popupFYI("[Task System]\nCompleting Task Daily of " .. ret_td.name .. ".\n - You have killed [" .. sto_value .. "/" .. ret_td.amount .. "].\nThey also count in the task: " .. combinedList  .. ".\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_td.items) .. ".\n- Experience [+]: " .. ret_td.exp .. " EXP.\n- Task Points [+]: " .. ret_td.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime .. ".")
		end
	end]]
	
	if Position(32364, 32205, 7) == item:getPosition() then
	local ret_t = getTaskInfos(player)
	local ret_td = getTaskDailyInfo(player)
		if ret_t and ret_td then
		local sto_value = player:getStorageValue(ret_t.storage)
		local sto_value_td = player:getStorageValue(ret_td.storage)
			-- With Normal and Daily
			if sto_value < ret_t.amount and sto_value_td < ret_td.amount then
				player:popupFYI("[Task System]\nCompleting Task of " .. ret_t.name .. ".\n - You have killed [" .. sto_value .. "/" .. ret_t.amount .. "].\nThey also count in the task: .\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_t.items) .. ".\n- Experience [+]: " .. ret_t.exp .. " EXP.\n- Task Points [+]: " .. ret_t.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime .. ".\n\nCompleting Task Daily of "..ret_td.name..".\n- You have killed [" .. sto_value_td .. "/" .. ret_td.amount .. "].\nThey also count in the task:\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_td.items) .. ".\n- Experience [+]: " .. ret_td.exp .. " EXP.\n- Task Points [+]: " .. ret_td.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime .. ".")
			elseif sto_value < ret_t.amount then
				player:popupFYI("[Task System]\nCompleting Task of " .. ret_t.name .. ".\n - You have killed [" .. sto_value .. "/" .. ret_t.amount .. "].\nThey also count in the task: .\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_t.items) .. ".\n- Experience [+]: " .. ret_t.exp .. " EXP.\n- Task Points [+]: " .. ret_t.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime .. ".\n\nCompleting Task Daily of "..ret_td.name..".\n- You have killed [" .. sto_value_td .. "/" .. ret_td.amount .. "] (Completed).\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_td.items) .. ".\n- Experience [+]: " .. ret_td.exp .. " EXP.\n- Task Points [+]: " .. ret_td.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime .. ".")
			elseif sto_value_td < ret_td.amount then
				player:popupFYI("[Task System]\nCompleting Task of " .. ret_t.name .. ".\n - You have killed [" .. sto_value .. "/" .. ret_t.amount .. "]. (Completed)\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_t.items) .. ".\n- Experience [+]: " .. ret_t.exp .. " EXP.\n- Task Points [+]: " .. ret_t.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime .. ".\n\nCompleting Task Daily of "..ret_td.name..".\n- You have killed [" .. sto_value_td .. "/" .. ret_td.amount .. "].\nThey also count in the task:\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_td.items) .. ".\n- Experience [+]: " .. ret_td.exp .. " EXP.\n- Task Points [+]: " .. ret_td.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime .. ".")
			else
				player:popupFYI("[Task System]\nCompleting Task of " .. ret_t.name .. ".\n - You have killed [" .. sto_value .. "/" .. ret_t.amount .. "] (Completed).\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_t.items) .. ".\n- Experience [+]: " .. ret_t.exp .. " EXP.\n- Task Points [+]: " .. ret_t.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime .. ".\n\nCompleting Task Daily of "..ret_td.name..".\n- You have killed [" .. sto_value_td .. "/" .. ret_td.amount .. "] (Completed).\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_td.items) .. ".\n- Experience [+]: " .. ret_td.exp .. " EXP.\n- Task Points [+]: " .. ret_td.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime .. ".")
			end
			---------
			-- Only Normal Task
			elseif ret_t then
			local sto_value = player:getStorageValue(ret_t.storage)
			if sto_value < ret_t.amount then
				player:popupFYI("[Task System]\nCompleting Task of " .. ret_t.name .. ".\n - You have killed [" .. sto_value .. "/" .. ret_t.amount .. "].\nThey also count in the task: .\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_t.items) .. ".\n- Experience [+]: " .. ret_t.exp .. " EXP.\n- Task Points [+]: " .. ret_t.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime .. ".")
			else
				player:popupFYI("[Task System]\nCompleting Task of " .. ret_t.name .. ".\n - You have killed [" .. sto_value .. "/" .. ret_t.amount .. "]. (Completed)\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_t.items) .. ".\n- Experience [+]: " .. ret_t.exp .. " EXP.\n- Task Points [+]: " .. ret_t.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime .. ".")
			end
			--------
		-- Only Daily Task
		elseif ret_td then
		local sto_value_td = player:getStorageValue(ret_td.storage)
		if sto_value_td < ret_td.amount then
			player:popupFYI("[Task System]\nCompleting Task Daily of " .. ret_td.name .. ".\n - You have killed [" .. sto_value_td .. "/" .. ret_td.amount .. "].\nThey also count in the task: .\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_td.items) .. ".\n- Experience [+]: " .. ret_td.exp .. " EXP.\n- Task Points [+]: " .. ret_td.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime .. ".")
		else
			player:popupFYI("[Task System]\nCompleting Task Daily of " .. ret_td.name .. ".\n - You have killed [" .. sto_value_td .. "/" .. ret_td.amount .. "]. (Completed)\nGo back to Vauter to Report the task.\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_td.items) .. ".\n- Experience [+]: " .. ret_td.exp .. " EXP.\n- Task Points [+]: " .. ret_td.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime .. ".")
		end
			---------
			---- SI NO TIENE NINGUNA TASK ENCIMA
		else
			player:popupFYI("[Task System]\n- You have not yet chosen a task with Grizzly Adams. \n\n- Task Rank: ".. getRankTask(player) ..".\n- Task Points: ".. taskRank_get(player) ..".")
		end
	end
	
	
	return true
end

taskboard:id(36828)
taskboard:register()

--[[local capitalizedMonsterList = {}
		for _, monsterName in ipairs(ret_t.mons_list) do
			local capitalizedMonsterName = firstStringToUpper(monsterName)
			table.insert(capitalizedMonsterList, capitalizedMonsterName)
		end
		for _, monsterName in ipairs(ret_td.mons_list) do
			local capitalizedMonsterName = firstStringToUpper(monsterName)
			table.insert(capitalizedMonsterList, capitalizedMonsterName)
		end
		local combinedList = table.concat(capitalizedMonsterList, ", ")
		local combinedList_td = table.concat(capitalizedMonsterList, ", ")]]













--[[local task_command = TalkAction("/task", "!task", "!status")

function task_command.onSay(player, words, param)

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
	
	local function firstStringToUpper(str)
		return (str:gsub("^%l", string.upper))
	end
	
	local ret_t = getTaskInfos(player)
	if ret_t then
	local sto_value = player:getStorageValue(ret_t.storage)
	local capitalizedMonsterList = {}
	for _, monsterName in ipairs(ret_t.mons_list) do
		local capitalizedMonsterName = firstStringToUpper(monsterName)
		table.insert(capitalizedMonsterList, capitalizedMonsterName)
	end
		local combinedList = table.concat(capitalizedMonsterList, ", ")
		if sto_value < ret_t.amount then
			player:popupFYI("[Task System]\nCompleting Task of " .. ret_t.name .. ".\n - You have killed [" .. sto_value .. "/" .. ret_t.amount .. "].\nThey also count in the task: " .. combinedList  .. ".\n\nBy completing the task you receive:\n- Rewards [+]: " .. getItemsFromTable(ret_t.items) .. ".\n- Experience [+]: " .. ret_t.exp .. " EXP.\n- Task Points [+]: " .. ret_t.pointsTask[1] .. " TP.\n\nTime with the task: " .. elapsedTime .. ".")
		else
			player:popupFYI("[Task System]\nCompleting Task of ".. ret_t.name ..".\n - You have killed [".. sto_value .."/".. ret_t.amount .."] (Completed).\nGo back to Vauter to report the task.\n\nBy completing the task you receive:\n- Rewards [+]: ".. getItemsFromTable(ret_t.items)..".\n- Experience [+]: ".. ret_t.exp .." EXP.\n- Task Points [+]: ".. ret_t.pointsTask[1] .." TP.\n\nTime with the task: ".. elapsedTime ..".")
		end
	else
		player:popupFYI("[Task System]\n- You have not yet chosen a task with Grizzly Adams. \n\n- Task Rank: ".. getRankTask(player) ..".\n- Task Points: ".. taskRank_get(player) ..".")
	end
	
    return false
end

task_command:separator(" ")
task_command:register()]]