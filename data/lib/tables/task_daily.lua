task_monsters = {
   [1] = {name = "Troll", mons_list = {"troll champion", "troll guard", "island troll", "swamp troll", "frost troll", "troll legionnaire", "furious troll", "troll marauder"},  storage = 80000, amount = 10, taskp_required = 1, level_required = 1, exp = 50000, pointsTask = {1, 1}, items = {{id = 3043, count = 10}}},
}

task_daily = {
   [1] = {name = "Demon", mons_list = {"demon outcast", "angry demon"}, storage = 83000, amount = 3, exp = 5000, pointsTask = {1, 1}, items = {{id = 2157, count = 1}, {id = 2160, count = 3}}},
  
}

task_special = {
   [1] = {name = "Dwarf", mons_list = {"dwarf guard", "dwarf geomancer", "dwarf soldier"},  storage = 84000, amount = 10, exp = 150000, pointsTask = {1, 1}, items = {{id = 3397, count = 1}}},
}

task_storage = 20020 -- storage que verifica se está fazendo alguma task e ver qual task é - task normal
task_points = 20021 -- storage que retorna a quantidade de pontos task que o player tem.
task_sto_time = 20022 -- storage de delay para não poder fazer a task novamente caso ela for abandonada.
task_time = 20 -- tempo em horas em que o player ficará sem fazer a task como punição
task_rank = 20023 -- storage do rank task
taskd_storage = 20024 -- storage que verifica se está fazendo alguma task e ver qual task é - task daily
time_daySto = 20025 -- storage do tempo da task daily, no caso para verificar e add 24 horas para fazer novamente a task daily
task_timer = 20026 -- start the stopwatch
task_timerdaily = 20027 -- stop the stopwatch
tasks_storage = 20028 -- storage special for each monster.
time_dayStoSpecial = 20029 -- storage special for each monster.
task_timerspecial = 20030 -- storage special for each monster.

local ranks_task = {
	[{1, 50}] = "Beginner", 
	[{51, 100}] = "Elite",
	[{101, 150}] = "Master",
	[{151, 200}] = "Destroyer",		
	[{201, math.huge}] = "Juggernaut"
}

local RankSequence = {
	["Beginner"] = 1,
	["Elite"] = 2,
	["Master"] = 3,
	["Destroyer"] = 4,
	["Juggernaut"] = 5,
}

function rankIsEqualOrHigher(myRank, RankCheck)
	local ret_1 = RankSequence[myRank]
	local ret_2 = RankSequence[RankCheck]
	return ret_1 >= ret_2
end

function getTaskInfos(player)
	local player = Player(player)
	return task_monsters[player:getStorageValue(task_storage)] or false
end

function getTaskDailyInfo(player)
	local player = Player(player)
	return task_daily[player:getStorageValue(taskd_storage)] or false
end

function getTaskSpecialInfo(player)
	local player = Player(player)
	return task_special[player:getStorageValue(tasks_storage)] or false
end


function taskPoints_get(player)
	local player = Player(player)
	if player:getStorageValue(task_points) == -1 then
		return 0 
	end
	return player:getStorageValue(task_points)
end

function taskPoints_add(player, count)
	local player = Player(player)
	return player:setStorageValue(task_points, taskPoints_get(player) + count)
end

function taskPoints_remove(player, count)
	local player = Player(player)
	return player:setStorageValue(task_points, taskPoints_get(player) - count)
end

function taskRank_get(player)
	local player = Player(player)
	if player:getStorageValue(task_rank) == -1 then
		return 1 
	end
	return player:getStorageValue(task_rank)
end

function taskRank_add(player, count)
	local player = Player(player)
	return player:setStorageValue(task_rank, taskRank_get(player) + count)
end

function getRankTask(player)
	local pontos = taskRank_get(player)
	local ret
	for _, z in pairs(ranks_task) do
		if pontos >= _[1] and pontos <= _[2] then
			ret = z
		end
	end
	return ret
end

function getItemsFromTable(itemtable)
     local text = ""
     for v = 1, #itemtable do
         count, info = itemtable[v].count, ItemType(itemtable[v].id)
         local ret = ", "
         if v == 1 then
             ret = ""
         elseif v == #itemtable then
             ret = ", "
         end
         text = text .. ret
         text = text .. (count > 1 and count or info:getArticle()).." "..(count > 1 and info:getPluralName() or info:getName())
     end
     return text
end