local thirdSealLever = Action()

function thirdSealLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.itemid ~= 2773 then
		return false
	end

	local switchNum = getGlobalStorageValue("switchNum")
	if switchNum == -1 then
		setGlobalStorageValue("switchNum", 1)
	end

	local table = thirdSealTable[switchNum]
	if not table then
		return true
	end

	if player:getStorageValue(Storage.Quest.U7_2.TheQueenOfTheBanshees.ThirdSeal) == 1 then
		return false
	end

	if player:getStorageValue(Storage.Quest.U7_2.TheQueenOfTheBanshees.ThirdSeal) < 1 then
		if item.uid == table then
			item:transform(2772)
			setGlobalStorageValue("switchNum", getGlobalStorageValue("switchNum") + 1)
			toPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
			for i = 1, #thirdSealTable.effectPosition[switchNum] do
				Position(thirdSealTable.effectPosition[switchNum][i]):sendMagicEffect(CONST_ME_ENERGYHIT)
			end
			if getGlobalStorageValue("switchNum") == 6 then
				for i = 1, #thirdSealTable.coalBasinPosition do
					local positions = thirdSealTable.coalBasinPosition[i]
					Position(positions):removeItem(2114)
					Position(positions):createItem(2113)
				end
			end
		else
			toPosition:sendMagicEffect(CONST_ME_ENERGYHIT)
		end
	end
	return true
end

for uniqueRange = 30013, 30017 do
	thirdSealLever:uid(uniqueRange)
end

thirdSealLever:register()
