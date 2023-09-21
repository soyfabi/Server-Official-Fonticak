Game.createQuest("Threatened Dreams", {
    storageId = Storage.Quest.U11_40.ThreatenedDreams.QuestLine,
    storageValue = 1,

    missions = {
        {
            name = "Troubled Animals",
            storageId = Storage.Quest.U11_40.ThreatenedDreams.Mission01[1],
            startValue = 1,
            endValue = 16,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "You met the talking white deer Alkestios. It turned out he is actually a fae - and needs help. Search \z
						out a poacher camp noth of the Green Claw Swamps and keep the poachers from hunting white deers.",
					[2] = "You found a book with legends in the poacher camp. You asked Ahmed to add a story about how it brings \z
						ill luck to kill a white deer, hopefully the poachers will desist from hunting Alkestios.",
					[3] = "You returned to the poacher camp and placed the faked book noticeably on a table. You're quite sure the \z
						poachers will discover it soon and desist from hunting Alkestios.",
					[4] = "Alkestios asked you for help on another issue. There seemms to be a problem with a wolf mother and her \z
						whelps. Find the snake Ikassis in the north-west of Edron and talk to her, she knows more.",
					[5] = "The snake Ikassis asked you to find a female wolf in the south of Cormaya. The animal is in need of \z
						help, yet Ikassis didn't know any details.",
					[6] = "You found the ghostly wolf and promised to search for her lost whelps. The wolf told you to start \z
						your search at Ulderek's Rock",
						[7] = "At Ulderek's Rock you found a sleeping war wolf. It might actually be the now grown up whelp you were \z
					looking for. The skeleton nearby implies that the hunter didn't survive his misdeed.",
					[8] = "You talked to Irmana in Venore and she gave you the fur of one of the wolf whelps you're searching for. \z
						You should talk to their mother's ghost.",
					[9] = "As the ghostly wolf asked you, you placed the whelp fur in the mouth of a nearby stone, that is shaped \z
						like a big face.",
					[10] = "You redeemed the ghostly wolf. You should return to Ikassis and tell her about it.",
					[11] = "Ikassis was happy to hear that you redeemed the ghostly wolf. But she asked you to help someone else: \z
						one of her sisters. You can find her in the guise of swan at a river sourth-east of Ikassis.",
					[12] = "You met a swan that in truth is a swan maiden, a kind of fae. These fae have magical cloaks that allow \z
						them to shape change between swan and girl. Find this maiden's cloak that was stolen by a troll.",
					[13] = "The troll Grarkharok sold the cloak to Tereban and he lost it during a flight with magic carpet. The \z
						cloak's feathers are now scattered along the carpet's beeline between Edron and Darashia.",
					[14] = "You found many swan feathers on Edron and in Darama desert. Now you should have enough for an entire \z
						cloak. You should talk to the swan maiden.",
					[15] = "You found enough magical swan feathers. The swan maiden will now be able to restore her cloak. You \z
						should talk to Alkestios again.",
					[16] = "Alkestios was very happy about your support. You earned the Fae's trust and may now enter their secret \z
						realm. Search for an elemental shrine of ice, fire, earth or energy to reach Feyrist."
                }
                return descriptions[player:getStorageValue(Storage.Quest.U11_40.ThreatenedDreams.Mission01[1])]
            end
        },
		{
            name = "Nightmare Intruders",
            storageId = Storage.Quest.U11_40.ThreatenedDreams.Mission02[1],
            startValue = 1,
            endValue = 8,
            ignoreEndValue = false,
            description = function(player) 
				local descriptions = {
					[1] = "The fae queen asked for your help: Feyrist is threatened by intruders from Roshamuul. Kill 200 nightmare \z
						monsters and Kroazur.\n\nYou killed %d weakened frazzlemaws and %d efeebled silencers.",
                    [2] = "You killed 200 of the nightmare monsters that are invading Feyrist. Maelyrra was very happy but it seems \z
						she still has other problems. She may need your help once more.",
					[3] = "Maelyrra asked you to retrieve an artefact for her: the moon mirror. It was stolen by the tainted fae \z
						who inhabit the caves underneath Feyrist. She also asked you to free some captured fairies.",
					[4] = "You found the moon mirror and freed the captured fairies. Maelyrra was very happy but it seems she \z
						has another problem. Perhaps you should offer your assistance once more.",
					[5] = "The barrier that protects Feyrist from the outside world is weakened. To strengthen it again you \z
						need to find the starlight vial and the sun catcher. Ask Aurita and Taegen for these items.",
					[6] = "Gather sunlight, starlight and moon rays. You have to do this with the sun catcher on the beach, with \z
						the starlight vial high in the mountains and with the moon mirror on a glade in the forest.",
					[7] = "You may now repair the barrier. Charge the five moon sculptures of Feyrist with moon rays, the five \z
						dreambird trees with starlight and the five sun mosics with sunlight.",
					[8] = "You repaired tha magical barrier that protects Feyrist from the outside world. The fae's secret realm \z
						is safe again."
                }
                return descriptions[player:getStorageValue(Storage.Quest.U11_40.ThreatenedDreams.Mission02[1])]
            end
        },
    }
}):register()

Game.createQuest("Tibia Tales", {
    storageId = Storage.TibiaTales.DefaultStart,
    storageValue = 1,

    missions = {
        {
            name = "The Annihilator",
            storageId = 10112,
            startValue = 1,
            endValue = 3,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "You have discovered annihilator, but you will need 4 players to proceed.",
					[2] = "Fight against the Angry demon, try not to get killed.",
					[3] = "Perfect, you have managed to pass annihilator without problems, collect your prize."
                }
                return descriptions[player:getStorageValue(10112)]
            end
        },
		{
            name = "The Exterminator",
            storageId = Storage.TibiaTales.TheExterminator,
            startValue = 1,
            endValue = 3,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Padreia in Carlin asked you to exterminate the slimes in the sewers of Carlin by poisoning their spawn pool.",
					[2] = "You poisoned the spawn pool of the slimes in the sewers of Carlin. Report to Padreia about your mission.",
					[3] = "You successfully helped Padreia in saving Carlin from a slimy disease."
                }
                return descriptions[player:getStorageValue(Storage.TibiaTales.TheExterminator)]
            end
        },
		{
            name = "An Interest In Botany",
            storageId = Storage.TibiaTales.AnInterestInBotany,
            startValue = 1,
            endValue = 4,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Rabaz in Farmine asked you to collect samples from rare plant specimen in Zao. Go to the storage room to the west and receive the Botany Almanach. Find then the Giant Dreadcoil and use your Obsidian Knife on it to obtain a sample.",
					[2] = "Now you must find the second plant, a Giant Verminous and use your Obsidian Knife on it to obtain a sample.",
					[3] = "You found the two samples, report back to Rabaz in Farmine!",
					[4] = "You have completed the Quest!"
                }
                return descriptions[player:getStorageValue(Storage.TibiaTales.AnInterestInBotany)]
            end
        },
		{
            name = "The Ultimate Booze",
            storageId = Storage.TibiaTales.ultimateBoozeQuest,
            startValue = 1,
            endValue = 3,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Boozer in Vernore asked you to bring him some special dwarven brown ale. You may find some in the brewery in Kazordoon.",
					[2] = "You found the special dwarven brown ale. Bring it to Boozer in Vernore.",
					[3] = "You have completed The Ultimate Booze Quest!."
                }
                return descriptions[player:getStorageValue(Storage.TibiaTales.ultimateBoozeQuest)]
            end
        },
		{
            name = "The Koshei The Deathless",
            storageId = Storage.TibiaTales.KosheiTheDeathlessQ,
            startValue = 1,
            endValue = 2,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "The Koshei has been burned, now you will have no curses, go through the door to receive your prize.",
					[2] = "You finished the Koshei The Deathless mission!",
                }
                return descriptions[player:getStorageValue(Storage.TibiaTales.KosheiTheDeathlessQ)]
            end
        },
    }
}):register()

Game.createQuest("The First Dragon", {
    storageId = Storage.FirstDragon.Questline,
    storageValue = 1,

    missions = {
        {
            name = "The First Dragon",
            storageId = Storage.FirstDragon.Questline,
            startValue = 0,
            endValue = 2,
            ignoreEndValue = false,
            description = function(player)
                return string.format("Tamoril told you about the First Dragon and his 4 descendants. To enter the lairs you have to undergo trials.\z
				\n\n\z
				Power %d/200.\nTreasure %d/5.\nKnowledge %d/3.\nLife %d/1\z
				", player.storage[Storage.FirstDragon.DragonCounter], player.storage[Storage.FirstDragon.ChestCounter], player.storage[Storage.FirstDragon.GelidrazahAccess], player.storage[Storage.FirstDragon.SecretsCounter])
            end
        },
    }
}):register()


Game.createQuest("The Thieves Guild", {
    storageId = Storage.ThievesGuild.Quest,
    storageValue = 1,

    missions = {
        {
            name = "Mission 1: Ivory Poaching",
            storageId = Storage.ThievesGuild.Mission01,
            startValue = 1,
            endValue = 2,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Dorian wants you to collect 10 elephant tusks and deliver them to him.",
                    [2] = "You delivered the ten tusks to Dorian."
                }
                return descriptions[player:getStorageValue(Storage.ThievesGuild.Mission01)]
            end
        },
		{
            name = "Mission 2: Burglary",
            storageId = Storage.ThievesGuild.Mission02,
            startValue = 1,
            endValue = 3,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Dorian wants you to steal a vase from Sarina, the owner of Carlin\'s general store.",
					[2] = "You have stolen the vase, report back to Dorian.",
					[3] = "You reported your successful vase theft to Dorian."
                }
                return descriptions[player:getStorageValue(Storage.ThievesGuild.Mission02)]
            end
        },
		{
            name = "Mission 3: Invitation",
            storageId = Storage.ThievesGuild.Mission03,
            startValue = 1,
            endValue = 3,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Your task is to somehow convince Oswald to hand you an invitation to the king\'s ball.",
					[2] = "You have received the invitation to the King\'s ball, report back to Dorian!",
					[3] = "You have delivered the invitation to Dorian, ask him for a new mission!"
                }
                return descriptions[player:getStorageValue(Storage.ThievesGuild.Mission03)]
            end
        },
		{
            name = "Mission 4: Bridge Robbery",
            storageId = Storage.ThievesGuild.Mission04,
            startValue = 1,
            endValue = 8,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Dorian wants you to find a forger in the outlaw camp, go talk to Snake eye.",
					[2] = "Snake Eye told you that the best forger for fake documents is old Ahmet in Ankrahmun.",
					[3] = "Ahmet told you that he will only help a friend and asked you to kill at least one Nomad.",
					[4] = "You have killed a Nomad, go back to Ahmet!",
					[5] = "You have received the forged documents from Ahmet, next is to get a disguise from Percybald in Venore!",
					[6] = "You have received the dwarf disguise from Percybald. Now go do the deal with Nurik.",
					[7] = "You have traded the forged documents for the painting, report back to Dorian.",
					[8] = "You have delivered the painting to Dorian, ask him for a new mission!"
                }
                return descriptions[player:getStorageValue(Storage.ThievesGuild.Mission04)]
            end
        },
		{
            name = "Mission 5: Enforcing Debts",
            storageId = Storage.ThievesGuild.Mission05,
            startValue = 1,
            endValue = 2,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Your mission is to travel to Tiquanda. Fina a hidden smuggler cave to the north of Port Hope \z
						and try to retrieve the valuable goblet which Dorian is looking for. Once you got it, bring it to him.",
					[2] = "You have delivered the golden goblet to Dorian, ask him for a new mission!"
                }
                return descriptions[player:getStorageValue(Storage.ThievesGuild.Mission05)]
            end
        },
		{
            name = "Mission 6: Fishnapping",
            storageId = Storage.ThievesGuild.Mission06,
            startValue = 1,
            endValue = 4,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Dorian wants you to fishnap Theodore Loveless' fish, first you need to get the key to his room. \z
						Talk to Chantalle in Liberty Bay.",
					[2] = "You have received the key for Theodore Loveless' room, time to fishnap his fish!",
					[3] = "You have fishnapped Theodore Loveless' fish, deliver it to Dorian.",
					[4] = "You have delivered the fish to Dorian, ask him for a new mission!"
                }
                return descriptions[player:getStorageValue(Storage.ThievesGuild.Mission06)]
            end
        },
		{
            name = "Mission 7: Blackmail",
            storageId = Storage.ThievesGuild.Mission07,
            startValue = 1,
            endValue = 2,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
					[1] = "Your current task is to find compromising information about one of the \z
						Venore city guards, no matter how. A good starting point might be in their barracks.",
					[2] = "You have delivered the compromising letter to Dorian, ask him for a new mission!"
                }
                return descriptions[player:getStorageValue(Storage.ThievesGuild.Mission07)]
            end
        },
		{
            name = "Mission 8: Message",
            storageId = Storage.ThievesGuild.Mission08,
            startValue = 1,
            endValue = 3,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Dorian wants you to deliver a message to his competitors in the dark cathedral.",
					[2] = "You have put up the message, report back to Dorian.",
					[3] = "You have reported back that you have completed the mission, \z
						Dorian now allows you to trade with Black Bert."
                }
                return descriptions[player:getStorageValue(Storage.ThievesGuild.Mission08)]
            end
        },
    }
}):register()
