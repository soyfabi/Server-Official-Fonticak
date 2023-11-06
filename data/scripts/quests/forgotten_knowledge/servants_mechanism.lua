local config = {
	[26663] = {storage = GlobalStorage.ForgottenKnowledge.MechanismDiamond, counter = GlobalStorage.ForgottenKnowledge.DiamondServant, msg = "5 diamond entities are consuming too much raw energy for the cosmic chamber to awaken, it will be put to rest again in 10 minutes."},
	[26664] = {storage = GlobalStorage.ForgottenKnowledge.MechanismGolden, counter = GlobalStorage.ForgottenKnowledge.GoldenServant, msg = "5 golden entities are consuming too much raw energy for the cosmic chamber to awaken, it will be put to rest again in 10 minutes."}
}

local function clearGolems()
	local specs, spec = Game.getSpectators(Position(32815, 32874, 13), false, false, 63, 63, 63, 63)
	for i = 1, #specs do
		spec = specs[i]
		if getGlobalStorageValue(GlobalStorage.ForgottenKnowledge.MechanismDiamond) < 1 then
			if spec:isMonster() and spec:getName():lower() == 'diamond servant replica' then
				spec:getPosition():sendMagicEffect(CONST_ME_POFF)
				spec:remove()
			end
		end
		if getGlobalStorageValue(GlobalStorage.ForgottenKnowledge.MechanismGolden) < 1 then
			if spec:isMonster() and spec:getName():lower() == 'golden servant replica' then
				spec:getPosition():sendMagicEffect(CONST_ME_POFF)
				spec:remove()
			end
		end
		if spec:isMonster() and spec:getName():lower() == 'iron servant replica' then
			if math.random(100) <= 40 then
				spec:getPosition():sendMagicEffect(CONST_ME_POFF)
				spec:remove()
			end
		end
	end
end

local function turnOff(storage, counter)
	setGlobalStorageValue(storage, 0)
	setGlobalStorageValue(counter, 0)
	clearGolems()
	local teleport = Tile(Position(32815, 32870, 13)):getItemById(10840)
	if teleport then
		teleport:getPosition():sendMagicEffect(CONST_ME_POFF)
		teleport:remove()
	end
end

local forgottenKnowledgeMechanism = Action()
function forgottenKnowledgeMechanism.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local lever = config[item.actionid]
	if item.itemid == 9125 then
		if getGlobalStorageValue(lever.storage) >= 1 then
			player:say('seems that the mechanism still active.', TALKTYPE_MONSTER_SAY, false, nil, toPosition)
			return true
		end
		clearGolems()
		setGlobalStorageValue(lever.storage, 1)
		setGlobalStorageValue(lever.counter, 0)
		addEvent(turnOff, 10 * 60 * 1000, lever.storage, lever.counter)
		item:transform(9126)
		player:say('*click*', TALKTYPE_MONSTER_SAY, false, nil, toPosition)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, lever.msg)
	elseif item.itemid == 9126 then
		item:transform(9125)
	end
	return true
end

for actionId, info in pairs(config) do
	forgottenKnowledgeMechanism:aid(actionId)
end

forgottenKnowledgeMechanism:register()
