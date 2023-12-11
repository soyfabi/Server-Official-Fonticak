local setting = {
playerTalkactionsCommands = "*Player Commands*" .. "\n"
		.. "!aol " .. "- Buy Amulet of Loss for each 20K.\n"
		.. "!bless " .. "- Buy All Bless for 50K.\n"
		.. "!bp " .. "- Buy a backpack for 30 seconds.\n"
		.. "!tools " .. "- Buy tools, machete, scythe, shovel, rope, etc.\n"
		.. "!serverinfo " .. "- Displays all server information, Rates, Players Online, Skill, Host, etc.\n"
		.. "!info " .. "- Displays all your information, level, skill, addon, mount, speed, etc.\n"
		.. "!online " .. "- Shows the number of active players.\n"
		.. "!spawnrate " .. "- Show current spawn rate.\n"
		.. "!frags " .. "- Displays the total kills you have in total and for the week.\n"
		.. "!cast " .. "- Cast System, so that players can see your gameplay.\n"
		.. "!devotion " .. "- Devotion System, to increase your skills according to the amount of points awarded.\n"
		.. "!flaskpotion " .. "- Activate and deactivate empty flasks.\n"
		.. "!emotespell " .. "- Change emote status.\n"
		.. "!id or !clientid " .. "- Display the id of an object. Example: !clientid Demon helmet.\n"
		.. "!tradeoff " .. "- Place an item for sale.\n"
		.. "!oldwall " .. "- Replace the Magic Wall with the old or new one.\n"
		.. "!boost " .. "- Show your total experience bonus, with double exp, cast, castle, etc.\n"
		.. "!boostedcreature " .. "- Displays boosted monsters, experience, loot, boss and spawn rate.\n"
		.. "!bosscooldown or !boss " .. "- Displays the cooldowns of the bosses and minibosses you have made.\n"
		.. "!supremecube or !cube " .. "- Shows the locations that are available to be teleported with the Supreme Cube.\n\n"
		
		.. "*Party Commands*" .. "\n"
		.. "!party " .. "- View party member information, exp, shared, members actives, etc.\n"
		.. "!partyinvite " .. "- Invite a distant player to the party.\n"
		.. "!partyjoin " .. "- Accept the player's invitation.\n"
		.. "!partykick " .. "- Remove a party member.\n"
		.. "!partyleave " .. "- Leave the party.\n"
		.. "!partybc " .. "- Talk to all party members.\n\n"
		
		.. "*House Commands*" .. "\n"
		.. "!buyhouse " .. "- Buy a house.\n"
		.. "!leavehouse " .. "- Sell a house.\n"
		.. "!protecthouse " .. "- Protecting the players' home.\n"
		.. "!aleta sio " .. "- Invite a player.\n"
		.. "!alana sio " .. "- Leaving the house.\n\n"
		
		.. "*Guild Commands*" .. "\n"
		.. "!guild " .. "- Displays all the information of your guild, level, guild level, active members, top skill, exp\n  ->bonus, loot bonus, etc.\n"
		.. "!guildbc " .. "- Talk to the team with a blank text.\n"
		.. "!guildpoints " .. "- Give guild points for guild members. (Only Leader).\n\n"
		.. "*War Commands*" .. "\n"
		.. "!war invite " .. "- Invite a guild to a War System. (Only Leader).\n"
		.. "!war status " .. "- Displays the status of the war.\n"
		.. "!war kick " .. "- Removing a member from the war. (Only Leader or Vice-Leader).\n"
		.. "!war outfit " .. "- Change the outfit of all members of the guild (Only Leader).\n"
}

local commands = TalkAction("!commands","!commandos", "/commands", "!command")
local exhaust = {}
local exhaustTime = 2
function commands.onSay(player, words, param)

	local playerId = player:getId()
    local currentTime = os.time()
    if exhaust[playerId] and exhaust[playerId] > currentTime then
        player:sendCancelMessage("This Commands is still on cooldown. (0." .. exhaust[playerId] - currentTime .. "s).")
        return false
    end
	
	local commands = setting.playerTalkactionsCommands
	player:popupFYI(commands)
	exhaust[playerId] = currentTime + exhaustTime
	
	return false
end

commands:register()
