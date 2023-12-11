local positions = {
	{x = 32056, y = 31889, z = 5},
	{x = 32056, y = 31892, z = 5},
	{x = 32063, y = 31900, z = 5},
	{x = 32066, y = 31900, z = 5},
	{x = 32074, y = 31892, z = 5},
	{x = 32074, y = 31889, z = 5},
	{x = 32063, y = 31881, z = 5},
	{x = 32066, y = 31881, z = 5}
}
local dawnportMagicEffect = GlobalEvent("DawnportMagicEffect")

function dawnportMagicEffect.onThink(interval)
	local spectators, spectator = Game.getSpectators(Position(32064, 31891, 5), false, true, 0, 8, 0, 8)
	for i = 1, #spectators do
		spectator = spectators[i]
		for i = 1, #positions do
			Position(positions[i]):sendMagicEffect(CONST_ME_THUNDER)
		end
	end
	return true
end

dawnportMagicEffect:interval(5000)
dawnportMagicEffect:register()
