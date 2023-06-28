

local action = Action()

function action.onUse(player, target, param)

	if taskRank_get(player) >= 1 then
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