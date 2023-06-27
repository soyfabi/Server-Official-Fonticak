local storageKey = 4000
local isTimeStoppedKey = 4001

local tell_time = TalkAction("/tell_time", "!tell_time")

function tell_time.onSay(player, words, param)
    -- Obtener el tiempo almacenado previamente al completar la misión
    local epochTime = player:getStorageValue(storageKey)
    local isTimeStopped = player:getStorageValue(isTimeStoppedKey)
 
    -- Si el tiempo no se ha detenido, mostrar un mensaje de error
    if isTimeStopped == 0 then
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "El tiempo no se ha detenido.")
        return false
    end

    -- Calcular la diferencia de tiempo desde que se detuvo
    local currentTime = os.time()
    local timeDifference = os.difftime(currentTime, epochTime)
 
    -- Convertir la diferencia de tiempo a horas, minutos y segundos
    local minutes = math.floor(timeDifference / 60) -- Calcula los minutos

    -- Mostrar el tiempo en que se detuvo
    local stoppedTime = os.date("%Y-%m-%d %H:%M:%S", epochTime)
    
    -- Verificar si se pudo obtener el tiempo en que se detuvo
    if stoppedTime then
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "El tiempo se detuvo en: " .. stoppedTime)
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "El tiempo se detuvo en el minuto: " .. minutes)
    else
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "No se pudo obtener el tiempo en que se detuvo.")
    end
    
    return false
end

tell_time:separator(" ")
tell_time:register()