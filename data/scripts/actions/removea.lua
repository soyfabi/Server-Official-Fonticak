local falconShield = Action()

local ThreatenedDreams = Storage.Quest.U11_40.ThreatenedDreams
function falconShield.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	player:setStorageValue(Storage.SweetyCyclops.AmuletStatus, 2)
	player:setStorageValue(Storage.KosheiTheDeathless.RewardDoor, -1)
	player:setStorageValue(Storage.KosheiTheDeathless.KosheiMission, -1)
	player:say("hola")
	player:getPosition():sendMagicEffect(CONST_ME_POFF)
	player:getPosition():sendMagicEffect(CONST_ME_BLOCKHIT)
	--player:clearStorageValue(Storage.ThievesGuild.Quest)
	return true
end

falconShield:id(7866)
falconShield:register()
