local randomTeleports = {
	"This is very good.",
	"This shit got me in a loop.",
	"I feel like I'm going to fly.",
	"This is real?",
	"Is this real life or tibia?",
	"For this reason is that you should continue playing this Server.",
	"Let's smoke more in Fonticak Server.",
}


local waterPipe = Action()

function waterPipe.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	local randomPosition = randomTeleports[math.random(#randomTeleports)]
	if math.random(3) == 1 then
	item:getPosition():sendMagicEffect(CONST_ME_POFF)
	player:say(randomPosition)
	else
	item:getPosition():sendMagicEffect(CONST_ME_POFF)
	end
	
	return true
end

waterPipe:id(2974,2980,21323)
waterPipe:register()
