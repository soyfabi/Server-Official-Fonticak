local falconShield = Action()

function falconShield.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	--player:setStorageValue(515206, 1)
	player:say("hola")
	player:getPosition():sendMagicEffect(CONST_ME_POFF)
	player:getPosition():sendMagicEffect(CONST_ME_BLOCKHIT)
	--player:clearStorageValue(Storage.ThievesGuild.Quest)
	return true
end

falconShield:id(7866)
falconShield:register()
