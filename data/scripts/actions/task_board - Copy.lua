

local action = Action()

local premium = true

function action.onUse(player, target, param)

	if player:isPremium() == premium then
	player:say("hola")
	else
	player:say("eso que es?")
	end
    -- Obtener el tiempo almacenado previamente al completar la misión
   --player:setStorageValue(storageKey, 1)
  -- player:say("Storage Añadido")
    
    return true
end

action:id(3397)
action:register()