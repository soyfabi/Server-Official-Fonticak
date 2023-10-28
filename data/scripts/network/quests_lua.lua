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
					[1] = function()
						return string.format(
							"The fae queen asked for your help: Feyrist is threatened by intruders from Roshamuul. Kill 200 nightmare \z
							monsters and Kroazur.\n\n- You killed %d weakened frazzlemaws.\n- You killed %d efeebled silencers.",
							math.max(player:getStorageValue(Storage.Quest.U11_40.ThreatenedDreams.Mission02.FrazzlemawsMission), 0),
							math.max(player:getStorageValue(Storage.Quest.U11_40.ThreatenedDreams.Mission02.EnfeebledMission), 0)
						)
					end,
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

				local descriptionKey = player:getStorageValue(Storage.Quest.U11_40.ThreatenedDreams.Mission02[1])
				local description = descriptions[descriptionKey]

				if type(description) == "function" then
					return description()
				else
					return description
				end
			end
        },
		{
            name = "An Unlikely Couple",
            storageId = Storage.Quest.U11_40.ThreatenedDreams.Mission03[1],
            startValue = 1,
            endValue = 4,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Help Aurita and Taegen and find a spell to transform Aurita's fishtail into legs temporarily. A \z
						fairy in a small fae village in the southwest of Feyrist might know more.",
					[2] = "You have succesfully created the magical music notes for the mermaid Aurita. Talk to the faun \z
						Taegen, he also needs your help.",
					[3] = "The faun Taegen wants to spend some time with his lover, the mermaid Aurita. He wants to visit her \z
						home and thus must be able to breath under water. Therefore he needs the rare raven herb.",
					[4] = "You found the rare raven herb and gave it to Taegen. Now he will create a sun catcher for you. \z
						You may also ask Aurita for the starlight vial now."
					}
                return descriptions[player:getStorageValue(Storage.Quest.U11_40.ThreatenedDreams.Mission03[1])]
            end
        },
    }
}):register()

Game.createQuest("The Hidden City of Beregar", {
    storageId = Storage.HiddenCityOfBeregar.DefaultStart,
    storageValue = 1,

    missions = {
        {
            name = "Going Down",
            storageId = Storage.HiddenCityOfBeregar.GoingDown,
            startValue = 1,
            endValue = 2,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Deliver 3 Gear Wheels to Xorlosh.",
					[2] = "You sucessfully helped Xorlosh in repairing the elevator. \z
						You can now enter the teleporter to the eastern part of the mine."
                }
                return descriptions[player:getStorageValue(Storage.HiddenCityOfBeregar.GoingDown)]
            end
        },
		{
            name = "Justice for All",
            storageId = Storage.HiddenCityOfBeregar.JusticeForAll,
            startValue = 1,
            endValue = 6,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Nokmir told you that he is falsely accused of being a thief. \z
						You could help him by talking to Grombur about the case. \z
						Furthermore you should try to find that ring which belongs to Rerun.",
					[2] = "You should talking to Grombur about Nokmir.",
					[3] = "You should try to find that ring which belongs to Rerun everywhere in the mine.",
					[4] = "You have found Rerun\'s ring. Bring the ring to the emperor Rehal and talk to him about Nokmir.",
					[5] = "You informed emperor Rehal about your recent discoveries and he acquitted Nokmir of being a thief.",
					[6] = "You told Nokmir about his acquittal and he granted you access to the northern mine."
                }
                return descriptions[player:getStorageValue(Storage.HiddenCityOfBeregar.JusticeForAll)]
            end
        },
		{
            name = "Pythius the Rotten",
            storageId = Storage.QuestChests.FirewalkerBoots,
            startValue = 1,
            endValue = 1,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
					[1] = "You won the battle against the malicious undead dragon Pythius the Rotten. \z
						He granted you firewalker boots as a reward."
                }
                return descriptions[player:getStorageValue(Storage.QuestChests.FirewalkerBoots)]
            end
        },
		{
            name = "Sweet as Chocolate Cake",
            storageId = Storage.HiddenCityOfBeregar.SweetAsChocolateCake,
            startValue = 1,
            endValue = 3,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
					[1] = "Bake a Chocolate Cake and bring it to Bolfona at the bar.",
					[2] = "Report back to Frafnar by telling him about the mission.",
					[3] = "You told Frafnar that you did everything he asked you to do. \z
						You may now enter the western part of the mine."
                }
                return descriptions[player:getStorageValue(Storage.HiddenCityOfBeregar.SweetAsChocolateCake)]
            end
        },
		{
            name = "The Good Guard",
            storageId = Storage.HiddenCityOfBeregar.TheGoodGuard,
            startValue = 1,
            endValue = 3,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
					[1] = "Grombur asked you to get him a cask of dwarven brown ale. \z
						You heard that Boozer in Venore tried to brew some. Maybe you should pay him a visit.",
					[2] = "Now go to Grombur to give him the dwarven brown ale.",
					[3] = "Grombur liked the ale and you are now allowed to enter his part of the mine."
                }
                return descriptions[player:getStorageValue(Storage.HiddenCityOfBeregar.TheGoodGuard)]
            end
        },
		{
            name = "Royal Rescue",
            storageId = Storage.HiddenCityOfBeregar.RoyalRescue,
            startValue = 1,
            endValue = 5,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
					[1] = "Emperor Rehal told you about the missing explorers and his own son Rehon among them. Use the ore wagon to the deeper mines to find and rescue them. Ask Xorlosh if you encounter any problems.",
					[2] = "You have been able to cross the bridge with the wagon in perfect condition, it will continue a long way until you find Tehlim.",
					[3] = "You have to find the prison key, then go to Rehon and free him.",
					[4] = "You have given the prison key to Rehon, now go back to Emperor Rehal.",
					[5] = "You have to find the prison key, then go to Rehon and free him."
                }
                return descriptions[player:getStorageValue(Storage.HiddenCityOfBeregar.RoyalRescue)]
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

Game.createQuest("Secret Service", {
    storageId = Storage.SecretService.Quest,
    storageValue = 1,

    missions = {
        {
            name = "Mission 1: From Thais with Love",
            storageId = Storage.SecretService.TBIMission01,
            startValue = 1,
            endValue = 3,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Your first mission is to deliver a warning to the Venoreans. \z
						Get a fire bug from Liberty Bay and set their shipyard on fire.",
					[2] = "You have set the Venoreans shipyard on fire, report back to Chester!",
					[3] = "You have reported back that you have completed your mission, ask Chester for a new mission!"
                }
                return descriptions[player:getStorageValue(Storage.SecretService.TBIMission01)]
            end
        },
		{
            name = "Mission 1: For Your Eyes Only",
            storageId = Storage.SecretService.AVINMission01,
            startValue = 1,
            endValue = 4,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Your first task is to deliver a letter to Gamel in thais, If he is a bit reluctant, be persuasive.",
					[2] = "Gamel sent his thugs on you, defeat them and deliver the letter to Gamel!",
					[3] = "After defeating Gamel\'s thugs, he found you to be persuasive enough to accept the letter. \z
						Report back to Uncle!",
					[4] = "You have reported back that you have completed your task. Ask Uncle for a new mission!"
                }
                return descriptions[player:getStorageValue(Storage.SecretService.AVINMission01)]
            end
        },
		{
            name = "Mission 1: Borrowed Knowledge",
            storageId = Storage.SecretService.CGBMission01,
            startValue = 1,
            endValue = 2,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
					[1] = "Emma has requested that you steal a Nature Magic Spellbook in the Edron academy.",
					[2] = "You have delivered the Nature Magic Spellbook to Emma, ask her for a new mission!"
                }
                return descriptions[player:getStorageValue(Storage.SecretService.CGBMission01)]
            end
        },
		{
            name = "Mission 2: Operation Green Claw",
            storageId = Storage.SecretService.TBIMission02,
            startValue = 1,
            endValue = 2,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Your next mission is to find some information about one of \z
						their missing agents in The Green Claw Swamp.",
					[2] = "You have delivered the Black Knight\'s notes to Chester, ask him for a new mission!"
                }
                return descriptions[player:getStorageValue(Storage.SecretService.TBIMission02)]
            end
        },
		{
            name = "Mission 2: A File Between Friends",
            storageId = Storage.SecretService.AVINMission02,
            startValue = 1,
            endValue = 2,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Your next task is to retrieve a file named AH-X17L89.",
					[2] = "You have delivered the file named AH-X17L89 to Uncle, ask him for a new mission!"
                }
                return descriptions[player:getStorageValue(Storage.SecretService.AVINMission02)]
            end
        },
		{
            name = "Mission 2: Codename:Lumberjack",
            storageId = Storage.SecretService.CGBMission02,
            startValue = 1,
            endValue = 2,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Emma has requested that you retrieve a Rotten Heart of a Tree from \z
						the Black Knight Villa in Greenclaw swamp north-west of Venore.",
					[2] = "You have delivered the Rotten Heart of a Tree to Emma, ask her for a new mission!"
                }
                return descriptions[player:getStorageValue(Storage.SecretService.CGBMission02)]
            end
        },
		{
            name = "Mission 3: Treachery in Port Hope",
            storageId = Storage.SecretService.TBIMission03,
            startValue = 1,
            endValue = 3,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
					[1] = "Your next mission is to retrieve some evidence that the traders in Port Hope are up to no good!",
					[2] = "You have found the evidence, report back to Chester!",
					[3] = "You have reported back that you have completed your mission, ask Chester for a new mission!"
                }
                return descriptions[player:getStorageValue(Storage.SecretService.TBIMission03)]
            end
        },
		{
            name = "Mission 3: What Men are Made of",
            storageId = Storage.SecretService.AVINMission03,
            startValue = 1,
            endValue = 4,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
					[1] = "Your next task is to bring a barrel of beer to the Secret Tavern in the sewers of Carlin.",
					[2] = "On your way to the Secret Tavern in the sewers you were attacked by amazons trying to stop you! \z
						Deliver the barrel of beer to Karl.",
					[3] = "You have delivered the barrel of beer to Karl, report back to Uncle!",
					[4] = "You have reported back that you have completed your task, ask Uncle for a new mission!"
                }
                return descriptions[player:getStorageValue(Storage.SecretService.AVINMission03)]
            end
        },
		{
            name = "Mission 3: Rust in Peace",
            storageId = Storage.SecretService.CGBMission03,
            startValue = 1,
            endValue = 3,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Emma has requested that you damage the Ironhouse of Venore, use the \z
						Case of Rust Bugs on the keyhole in the cellar of the ironhouse.",
					[2] = "The bugs are at work! Report back to Emma.",
					[3] = "You have reported back that you have completed your mission, ask her for a new mission!"
                }
                return descriptions[player:getStorageValue(Storage.SecretService.CGBMission03)]
            end
        },
		{
            name = "Mission 4: Objective Hellgate",
            storageId = Storage.SecretService.TBIMission04,
            startValue = 1,
            endValue = 2,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                	[1] = "Your next mission is to investigate for some documents in Hellgate.",
					[2] = "You have delivered the documents to Chester, ask him for a new mission!"
                }
                return descriptions[player:getStorageValue(Storage.SecretService.TBIMission04)]
            end
        },
		{
            name = "Mission 4: Pawn Captures Knight",
            storageId = Storage.SecretService.AVINMission04,
            startValue = 1,
            endValue = 3,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
					[1] = "Your next task is to travel to the Black Knight\'s Villa and kill the Black Knight!",
					[2] = "You have killed the Black Knight, report back to Uncle!",
					[3] = "You have reported back that you have completed your task, ask Uncle for a new mission!"
                }
                return descriptions[player:getStorageValue(Storage.SecretService.AVINMission04)]
            end
        },
		{
            name = "Mission 4: Plot for A Plan",
            storageId = Storage.SecretService.CGBMission04,
            startValue = 1,
            endValue = 2,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
					[1] = "Emma has requested that you retrieve the Building Plans for a ship from the Venore shipyard.",
					[2] = "You have delivered the Building Plans to Emma, ask her for a new mission!"
                }
                return descriptions[player:getStorageValue(Storage.SecretService.CGBMission04)]
            end
        },
		{
            name = "Mission 5: Coldfinger",
            storageId = Storage.SecretService.TBIMission05,
            startValue = 1,
            endValue = 3,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
					[1] = "Your next mission is to travel to the southern barbarians camp and place false evidence!",
					[2] = "You have placed the false evidence! Report back to Chester.",
					[3] = "You have reported back that you have completed your mission, ask Chester for a new mission!"
                }
                return descriptions[player:getStorageValue(Storage.SecretService.TBIMission05)]
            end
        },
		{
            name = "Mission 5: A Cryptic Mission",
            storageId = Storage.SecretService.AVINMission05,
            startValue = 1,
            endValue = 2,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
					[1] = "Your next task is to travel to the Isle of the Kings and find a ring.",
					[2] = "You have delivered the ring to Uncle, ask him for a new mission!"
                }
                return descriptions[player:getStorageValue(Storage.SecretService.AVINMission05)]
            end
        },
		{
            name = "Mission 5: No Admittance",
            storageId = Storage.SecretService.CGBMission05,
            startValue = 1,
            endValue = 2,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
					[1] = "Emma has requested that you find some hints in the ruins of Dark Cathedral.",
					[2] = "You have delivered the Suspicious Documents to Emma, ask her for a new mission!"
                }
                return descriptions[player:getStorageValue(Storage.SecretService.CGBMission05)]
            end
        },
		{
            name = "Mission 6: The Weakest Spot",
            storageId = Storage.SecretService.TBIMission06,
            startValue = 1,
            endValue = 3,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
					[1] = "Your next mission is to disguise yourself as an amazon and destroy a \z
						beer casket in the north-east corner in the cellar of Svargrond\'s Tavern.",
					[2] = "You have succesfully destroyed the beer casket disguised as an amazon, report back to Chester!",
					[3] = "You have reported back that you have completed your mission, ask Chester for a new mission!"
                }
                return descriptions[player:getStorageValue(Storage.SecretService.TBIMission06)]
            end
        },
		{
            name = "Mission 6: A Little Bribe Won't Hurt",
            storageId = Storage.SecretService.AVINMission06,
            startValue = 1,
            endValue = 3,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
					[1] = "Your next task is to bribe a barbarian in the large barbarian camp with a weapons crate.",
					[2] = "You have bribed Freezhild with the weapons create! Report back to Uncle.",
					[3] = "You have reported back that you have completed your task, ask Uncle for a new mission!"
                }
                return descriptions[player:getStorageValue(Storage.SecretService.AVINMission06)]
            end
        },
		{
            name = "Mission 6: News From the Past",
            storageId = Storage.SecretService.CGBMission06,
            startValue = 1,
            endValue = 2,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
					[1] = "Emma has requested that you go to the Isle of the Kings and retrieve a book.",
					[2] = "You have delivered the book to Emma, ask her for a new mission!"
                }
                return descriptions[player:getStorageValue(Storage.SecretService.CGBMission06)]
            end
        },
		{
            name = "Mission 7: Licence to Kill",
            storageId = Storage.SecretService.Mission07,
            startValue = 1,
            endValue = 2,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
					[1] = "A Mad Technomancer in Kazordoon is trying to blackmail the city! \z
						Kill him and bring back his beard as proof.",
					[2] = "You have reported back that you have completed your mission, you are now a Special Agent!"
                }
                return descriptions[player:getStorageValue(Storage.SecretService.Mission07)]
            end
        },
    }
}):register()

Game.createQuest("Bigfoot\'s Burden", {
    storageId = Storage.BigfootBurden.QuestLine,
    storageValue = 1,

    missions = {
        {
            name = "Looking for Gnomerik",
            storageId = Storage.BigfootBurden.QuestLine,
            startValue = 1,
            endValue = 2,
            ignoreEndValue = false,
            description = "The dwarf Xelvar has sent you to meet the gnome Gnomerik. \z
						He can recruit you to the Bigfoot Company. \z
						Use the teleporter near Xelvar to enter the gnomish base and start looking for Gnomerik."
        },
		{
            name = "A New Recruit",
            storageId = Storage.BigfootBurden.QuestLine,
            startValue = 3,
            endValue = 4,
            ignoreEndValue = false,
            description = "You have found the gnomish recruiter and are ready to become a Bigfoot."
        },
		{
            name = "Recruitment: A Test in Gnomology",
            storageId = Storage.BigfootBurden.QuestLine,
            startValue = 5,
            endValue = 6,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
					[5] = "Pass Gnomerik\'s test by answering his questions. \z
						If you fail to get a high enough score drink a mushroom beer and start again.",
					[6] = "You have passed the gnomish psychology test and can proceed to the medical exam. \z
						Talk to Gnomespector about your next examination."
                }
                return descriptions[player:getStorageValue(Storage.BigfootBurden.QuestLine)]
            end
        },
		{
            name = "Recruitment: Medical Examination",
            storageId = Storage.BigfootBurden.QuestLine,
            startValue = 8,
            endValue = 9,
            ignoreEndValue = false,
            description = "Walk through the g-ray apparatus for your g-raying."
        },
    }
}):register()

Game.createQuest("Cults of Tibia", {
    storageId = Storage.CultsOfTibia.Questline,
    storageValue = 1,

    missions = {
		{
            name = "The Strengthtening of the Minotaurs",
            storageId = Storage.CultsOfTibia.Minotaurs.JamesfrancisTask,
            startValue = 0,
            endValue = 50,
            ignoreEndValue = false,
            description = function(player)
					return ("James asked you to enter the cave for hunting 50 empowered minotaurs. \z
					Then he will be able to continue his research.\nMinotaurs killed: %d/50"):format(
					player:getStorageValue(Storage.CultsOfTibia.Minotaurs.JamesfrancisTask)
				)
			end
        },
		{
            name = "The Strengthtening of the Minotaurs",
            storageId = Storage.CultsOfTibia.Minotaurs.Mission,
            startValue = 1,
            endValue = 5,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Gerimor told you that the naturalist Jamesfrancis is an expert of minotaurs. \z
						Right now he is investigating a cave in minocity. But this time something seems to be completely different.",
					[2] = "Jamesfrancis already entered the inner part of the cave weeks ago but had to flee when \z
						the minotaurs became too strong. He gave you the key to investigate this room as well.",
					[3] = "You found an entrance to the minotaur boss. You killed it and now you have to return to Jamesfrancis.",
					[4] = "Jamesfrancis sent you to talk with Gerimor about the minotaur cult.",
					[5] = "You have reported the Druid of Crunor about the minotaur cult."
                }
                return descriptions[player:getStorageValue(Storage.CultsOfTibia.Minotaurs.Mission)]
            end
        },
		{
            name = "Patron of Arts",
            storageId = Storage.CultsOfTibia.MotA.Mission,
            startValue = 1,
            endValue = 15,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "The Druid of Cronor gave you the hint that the Thais exhibition has expanded. \z
						The new section is called MOTA (Museum of Tibian Arts). It\'s really worth a visit.",
					[2] = "Gareth told you how to become a patron of the arts. To fulfil your duty you have to manage some tasks. \z
						First you have to investigate the crime scene of a theft in the museum.",
					[3] = "You found a ransom note, wich requests you to pay some money for \z
						the stolen picture to a stonge in Kazordoon. His name is Iwar. Nevertheless I should talk to Gareth first.",
					[4] = "You told Gareth about the ransom note. \z
						He asked you to pay the money to Iwar to get the picture back. In his opinion, there is no alternative.",
					[5] = "You paid the money to stooge in Kazordoon. \z
						You were told that the picture is delivered to Gareth himself.",
					[6] = "You have to go to Angelo and get a magnifier to investigate all small \z
						pictures in the entrance hall of the MOTA. One of them should be a fake.",
					[7] = "Angelo allowed you to take a magnifier from a crate next to the cave entrance.",
					[8] = "You've fetched the magnifier from Angelo\'s crate. You're ready for your job in the museum.",
					[9] = "Indeed! One of the investigated small pictures is fake. Report to Gareth!",
					[10] = "After you told Gareth about the fake painting, he asked you to go to Angelo to get a new picture.",
					[11] = "Angelo was not willing to give you a new picture. \z
						However, they havent found any artefact in the sandy cave yet. Report to Gareth about your failure.",
					[12] = "Even though you weren't successful in getting a replacement for the fake picture, \z
						Gareth gave you access to the last floor of the museum. This area is for patrons only.",
					[13] = "INTERNAL MESSAGE: THIS NEED QUESTLOG INFORMATION",
					[14] = "The Denomintator opened the door for you after you answered his questions to the wanted number. \z
						In the end he mentioned the Druid of Conor. Maybe you should pay him a visit.",
					[15] = "In the end you told the Druid of Crunor about your experiences in the MoTA."
                }
                return descriptions[player:getStorageValue(Storage.CultsOfTibia.MotA.Mission)]
            end
        },
		{
            name = "Barkless",
            storageId = Storage.CultsOfTibia.Barkless.Mission,
            startValue = 1,
            endValue = 7,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "The members of the Barkless follow a rigid path of hardship and sacrifice. \z
						Their cult is located somewhere beneath Ab'dendriel. \z
						Whatever happened to their leader, only a true Barkless can find out.",
					[2] = "You survived the sulphur and tar trial. You accepted the stigma of misfortune and vanity. \z
						The hardest part, however, is yet to come. Give your life to the ice... to become true and purified.",
					[3] = function(player)
							return ("You survived the Trial. Barkless now have the right to see the cult leader but a \z
							powerful relic is sealing the path. Barkless markings broken to reverse the power of the cult object: \z %d of 10"):format(math.max(player:getStorageValue(Storage.CultsOfTibia.Barkless.Objects), 0))
						end,
					[4] = "You broke enough Barkless markings to now reverse the seal \z
						held up by the cult object in the ritual chamber. \z
						The power you gained feels unnatural and excessive but it seems ther is no other way.",
					[5] = 'Something far more powerful than the beliel of your Barkless brothers \z
						and sisters powered the seal to the leader. Whatever the case - find Leiden, \z
						or as he\'s known to his devotees: the "Penitent".',
					[6] = "The Leiden you confronted has strayed far from his own original vision of Barkless. \z
						What you encountered was more monster than elf and less virtuous than his devotees would have you believe.",
					[7] = "You returned to Gerimor after putting an end to the mischief of Leyden the Penitent. \z
						May the Barkless walk the true path again one day."
                }
                return descriptions[player:getStorageValue(Storage.CultsOfTibia.Barkless.Mission)]
            end
        },
        {
            name = "Misguided",
            storageId = Storage.CultsOfTibia.Misguided.Mission,
            startValue = 1,
            endValue = 5,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "ASD",
					[2] = "Below a ruin in the vicinity of the outlaw camp east of Thais a strange figure in ragged clothes \z
						hinted at something weird going on in a cave. He seemed too confused to decide whether to stop you.",
					[3] = function(player)
						return ("While rubbish, the amulet you equipe emits a strange aura of splendour. \z
						You feel an urge to fulfill the amulets hunger for especific deaths... Exorcisms: %d/5 "):format(math.max(player:getStorageValue(Storage.CultsOfTibia.Misguided.Exorcisms), 0))
					end,
					[4] = "You defeated the cult leader of Misguided by uncovering the true master to pull his strings \z
					and freeing this world from its malicious existance. Return to Gerimor to tell him about the victory.",
					[5] = "You have spoken to Gerimor about your victory."
                }
                return descriptions[player:getStorageValue(Storage.CultsOfTibia.Misguided.Mission)]
            end
        },
		{
            name = "The Orc Idol",
            storageId = Storage.CultsOfTibia.Orcs.Mission,
            startValue = 1,
            endValue = 3,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "ASD",
					[2] = "ASD",
					[3] = "You returned to Gerimor after facing the being the orcs worshipped. \z
					Whatever it was, it did not find the orcs by accident. \z
					A far more powerful force seems to have strategically place it here."
                }
                return descriptions[player:getStorageValue(Storage.CultsOfTibia.Orcs.Mission)]
            end
        },
		{
            name = "The Secret of the Sandy Cave",
            storageId = Storage.CultsOfTibia.Life.Mission,
            startValue = 1,
            endValue = 10,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "ASD",
					[2] = "ASD",
					[3] = "In the cave you haven't found one of the missing scientists. \z
						However, you have faced a lots of strange mummies and a green oasis at the end.",
					[4] = "After you informed Angelo about your experiences in the cave, \z
						he asked you to go back to analyse the water of the oasis. For that reason you got an analysis tool.",
					[5] = "You have analysed the water with the help of the analysis tool from Angelo.",
					[6] = "You informed Angelo about the analyzed water. \z
						He gave you a counteragent, wich you have to apply to the oasis.",
					[7] = "You applied the counteragent to the oasis, just like Angelo had asked you to. \z
						But the effect was different from what you had expected. \z
						A sandstorm approached and caused create damage to the oasis.",
					[8] = "You Killed the boss",
					[9] = "You reported your victory to Angelo",
					[10] = "You have told Gerimor about your stay in the sandy cave. \z
						He was not really surprised and felt vindicated that the rumors about a cult in the cave might be true."
                }
                return descriptions[player:getStorageValue(Storage.CultsOfTibia.Life.Mission)]
            end
        },
		{
            name = "Zathroth Remmants",
            storageId = Storage.CultsOfTibia.Humans.Mission,
            startValue = 1,
            endValue = 3,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = function(player)
							return ("A remnant cult of Zathroth has formed in a forbidden temple beneath Carlin. \z
						Find out what's behind this and stop it in time.\nTemporarily vaporised souls:\n%d Decaying\n%d Withering"):format(
								math.max(player:getStorageValue(18551), 0),
								math.max(player:getStorageValue(18550), 0)
							)
						end,
					[2] = "ASD",
					[3] = "You returned to Gerimor after encounter with the remnants of Zathroth. On one hand its is \z
						furtunate that Zathroth indeed wasn't behind all this, but on the other... what is going on there?"
                }
                return descriptions[player:getStorageValue(Storage.CultsOfTibia.Humans.Mission)]
            end
        },
    }
}):register()

Game.createQuest("A Father\'s Burden", {
    storageId = Storage.FathersBurden.QuestLog,
    storageValue = 1,

    missions = {
        {
            name = "The Birthday Presents",
            storageId = Storage.FathersBurden.Status,
            startValue = 1,
            endValue = 2,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Gather the material Tereban listed. \z
						Talk to him about your mission when you have given him everything he was looking for.",
					[2] = "You brought all the required materials to Tereban and guaranteed his sons a great birthday party."
                }
                return descriptions[player:getStorageValue(Storage.FathersBurden.Status)]
            end
        },
		{
            name = "The Magic Bow - Sinew",
            storageId = Storage.FathersBurden.Sinew,
            startValue = 1,
            endValue = 2,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Find the wyvern Heoni in the Edron mountains and take his sinew to Tereban.",
					[2] = "You delivered Heoni\'s sinew to Tereban."
                }
                return descriptions[player:getStorageValue(Storage.FathersBurden.Sinew)]
            end
        },
		{
            name = "The Magic Bow - Wood",
            storageId = Storage.FathersBurden.Wood,
            startValue = 1,
            endValue = 2,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Find the special wood in the barbarian camps of Hrodmir and bring it to Tereban. \z
						It might be a good idea to start looking in the northernmost camp.",
					[2] = "You delivered the Wood to Tereban."
                }
                return descriptions[player:getStorageValue(Storage.FathersBurden.Wood)]
            end
        },
		{
            name = "The Magic Robe - Cloth",
            storageId = Storage.FathersBurden.Cloth,
            startValue = 1,
            endValue = 2,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                   [1] = "Find the spectral cloth hidden deep in the crypts of the isle of the kings and bring it to Tereban. \z
						You might have to look for a secret entrance.",
					[2] = "You delivered the spectral cloth to Tereban."
                }
                return descriptions[player:getStorageValue(Storage.FathersBurden.Cloth)]
            end
        },
		{
            name = "The Magic Robe - Silk",
            storageId = Storage.FathersBurden.Silk,
            startValue = 1,
            endValue = 2,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Find exquisite silk in the spider caves of southern Zao and deliver it to Tereban.",
					[2] = "You brought Tereban the required silk."
                }
                return descriptions[player:getStorageValue(Storage.FathersBurden.Silk)]
            end
        },
		{
            name = "The Magic Rod - Crystal",
            storageId = Storage.FathersBurden.Crystal,
            startValue = 1,
            endValue = 2,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Find a magic crystal in the tomb buried under the sand east of Ankrahmun and bring it to Tereban.",
					[2] = "Tereban received the magic crystal he was looking for."
                }
                return descriptions[player:getStorageValue(Storage.FathersBurden.Crystal)]
            end
        },
		{
            name = "The Magic Rod - Root",
            storageId = Storage.FathersBurden.Root,
            startValue = 1,
            endValue = 2,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
					[1] = "Find the mystic root under the city of Banuta and bring it to Tereban.",
					[2] = "The magic root was delievered to Tereban."
                }
                return descriptions[player:getStorageValue(Storage.FathersBurden.Root)]
            end
        },
		{
            name = "The Magic Shield - Iron",
            storageId = Storage.FathersBurden.Iron,
            startValue = 1,
            endValue = 2,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Find some old iron in the mines of Kazordoon for Tereban. Don't get lost - \z
						start searching close to the city.",
					[2] = "Tereban got the old iron he required."
                }
                return descriptions[player:getStorageValue(Storage.FathersBurden.Iron)]
            end
        },
		{
            name = "The Magic Shield - Scale",
            storageId = Storage.FathersBurden.Scale,
            startValue = 1,
            endValue = 2,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
					[1] = "Find the dragon Glitterscale in the caves north of Thais and take its scale to Tereban.",
					[2] = "You handed the looted scale to Tereban."
                }
                return descriptions[player:getStorageValue(Storage.FathersBurden.Scale)]
            end
        },
    }
}):register()

Game.createQuest("The Paradox Tower", {
    storageId = Storage.Quest.U7_24.TheParadoxTower.QuestLine,
    storageValue = 1,

    missions = {
        {
            name = "The Feared Hugo",
            storageId = Storage.Quest.U7_24.TheParadoxTower.TheFearedHugo,
            startValue = 1,
            endValue = 4,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Oldrak told you that the fearsome Hugo was accidentally created by the mage Yenny the Gentle. Try to find out more about this.",
					[2] = "Zoltan told you about Crunor's Caress, a druid order originating from Carlin. Try to find out more about this.",
					[3] = "Padreia told you that Crunor's Caress founded the inn Crunor's Cottage south of Mt. Sternum. Try to find out more about this.",
					[4] = "Lubo told you about a magical experiment that went wrong and created a demonbunny. Someone might be interested in this...",
				}
                return descriptions[player:getStorageValue(Storage.Quest.U7_24.TheParadoxTower.TheFearedHugo)]
            end
        },
		{
            name = "Favorite colour: Green",
            storageId = Storage.Quest.U7_24.TheParadoxTower.FavoriteColour,
            startValue = 1,
            endValue = 2,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Favorite colour is the green.",
					[2] = "Favorite colour is the green."
				}
                return descriptions[player:getStorageValue(Storage.Quest.U7_24.TheParadoxTower.FavoriteColour)]
            end
        },
		{
            name = "The Secret of Mathemagics",
            storageId = Storage.Quest.U7_24.TheParadoxTower.Mathemagics,
            startValue = 1,
            endValue = 2,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "You learnt Mathemagics. Everything is based on the simple fact that 1+1=1.",
					[2] = "You learnt Mathemagics. Everything is based on the simple fact that 1+1=1."
				}
                return descriptions[player:getStorageValue(Storage.Quest.U7_24.TheParadoxTower.Mathemagics)]
            end
        },
    }
}):register()

Game.createQuest("The Inquisition", {
    storageId = Storage.TheInquisition.Questline,
    storageValue = 1,

    missions = {
        {
            name = "Mission 1: Interrogation",
            storageId = Storage.TheInquisition.Mission01,
            startValue = 1,
            endValue = 7,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Your mission is to investigate the 5 guards in Thais regarding the Heretic behavior. \z
						Tim, Kulag, Grof, Miles and Walter are their names. If you do well you see a holy sprite on you.",
					[2] = "You investigated 1 of 5 guards in Thais.",
					[3] = "You investigated 2 of 5 guards in Thais.",
					[4] = "You investigated 3 of 5 guards in Thais.",
					[5] = "You investigated 4 of 5 guards in Thais.",
					[6] = "You investigated 5 of 5 guards in Thais. Get back to Thais and report your mission to Henricus.",
					[7] = "You investigated all guards in Thais."
				}
                return descriptions[player:getStorageValue(Storage.TheInquisition.Mission01)]
            end
        },
		{
            name = "Mission 2: Eclipse",
            storageId = Storage.TheInquisition.Mission02,
            startValue = 1,
            endValue = 3,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Henricus tells you to get The Witches' Grimoire, he sends you to Femor Hills where you \z
						can fly to the witches' mountain, say Eclipse to Uzon and he will take you there. \z
						Use the vial of holy water that he gives you on the big cauldron and open the chest to your left, \z
						then bring the witches' grimoire to Henricus.",
					[2] = "Find the witches' grimoire and bring it to Henricus.",
					[3] = "You already brought the witches' grimoire to Henricus."
				}
                return descriptions[player:getStorageValue(Storage.TheInquisition.Mission02)]
            end
        },
		{
            name = "Mission 3: Vampire Hunt",
            storageId = Storage.TheInquisition.Mission03,
            startValue = 1,
            endValue = 6,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Henricus wants you to find the Dwarfish Vampire Hunter, Storkus, located west of the Dwarf Bridge. \z
						It\'s good idea bring your 20 Vampire Dusts with you to save some time.",
					[2] = "Go Back to Storkus the Dwarf and ask for Mission.",
					[3] = "Now Storkus wants you to kill a vampire lord, The Count in the Green Claw Swamp, \z
						The Count is located near to the Blood Herb Quest. To summon The Count, \z
						you must use the coffin in the center of the room. Kill it and bring The Ring of the Count to Storkus.",
					[4] = "Kill The Count and bring his ring to Storkus the Dwarf and ask for Mission.",
					[5] = "Return to Henricus and tell him that you finished your job here.",
					[6] = "Get back to Thais and report your mission to Henricus."
				}
                return descriptions[player:getStorageValue(Storage.TheInquisition.Mission03)]
            end
        },
		{
            name = "Mission 4: The Haunted Ruin",
            storageId = Storage.TheInquisition.Mission04,
            startValue = 1,
            endValue = 3,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Henricus will gave you a Special Flask (vial of holy water). Go to Liberty Bay \z
						and use the vial on an old house. Use this vial of holy water on that spot to drive out the evil being.",
					[2] = "Kill the Pirate Ghost and get back to Thais and report your mission to Henricus.",
					[3] = "You already cleaned the abandoned and haunted house in Liberty, ask Henricus for mission."
				}
                return descriptions[player:getStorageValue(Storage.TheInquisition.Mission04)]
            end
        },
		{
            name = "Mission 5: Essential Gathering",
            storageId = Storage.TheInquisition.Mission05,
            startValue = 1,
            endValue = 3,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Henricus wants 20 Demonic Essences as a proof of your accomplishments.",
					[2] = "Now ask Henricus for outfit to get the Demon Hunter Outfit.",
					[3] = "You got the Demon Hunter Outfit! Ask Henricus for mission to unlock more addons."
				}
                return descriptions[player:getStorageValue(Storage.TheInquisition.Mission05)]
            end
        },
		{
            name = "Mission 6: The Demon Ungreez",
            storageId = Storage.TheInquisition.Mission06,
            startValue = 1,
            endValue = 3,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Henricus wants you to kill a demon called Ungreez. Head to Edron Hero Cave and go down a few levels.",
					[2] = "You killed Ungreez, report your mission to Henricus.",
					[3] = "You got the the first addon of Demon Hunter Outfit! Ask Henricus for mission to unlock more addons."
				}
                return descriptions[player:getStorageValue(Storage.TheInquisition.Mission06)]
            end
        },
		{
            name = "Mission 7: The Shadow Nexus",
            storageId = Storage.TheInquisition.Mission07,
            startValue = 1,
            endValue = 5,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
					[1] = "Your mission is to go to the Demon Forge and slay seven of The Ruthless Seven Minions. \z
						The Demon Forge is located in the Edron Hero Cave, through a portal after the Vampire Shield Quest.",
					[2] = "You destroyed the shadow nexus! Get back to Thais and report your mission to Henricus.",
					[3] = "Now ask to Henricus for a outfit. He will give you the 2nd addon of the Demon Hunter Outfits.",
					[4] = "You got the the second addon of Demon Hunter Outfit! Go now to the reward room and choose one wisely!",
					[5] = "You have completed The Inquisition Quest! You can now buy the Blessing of the Inquisition!"
				}
                return descriptions[player:getStorageValue(Storage.TheInquisition.Mission07)]
            end
        },
    }
}):register()

Game.createQuest("Unnatural Selection", {
    storageId = Storage.UnnaturalSelection.Questline,
    storageValue = 1,

    missions = {
        {
            name = "Mission 1: Skulled",
            storageId = Storage.UnnaturalSelection.Mission01,
            startValue = 1,
            endValue = 3,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Your mission is to find the Holy Skull. It is in a cave in the northern orc settlement, \z
						which is located north-west on the Zao Steppe.",
					[2] = "You found the Holy Skull. Retrieve it to Lazaran in the Zao Mountains.",
					[3] = "You brought Lazaran the Holy Skull. Ask him for new mission!"
				}
                return descriptions[player:getStorageValue(Storage.UnnaturalSelection.Mission01)]
            end
        },
		{
            name = "Mission 2: All Around the World",
            storageId = Storage.UnnaturalSelection.Mission02,
            startValue = 1,
            endValue = 13,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "You received the Skull of a Caveman and need to explore the world, letting the skull see everything. \z
						You need to stand at the highest place of Edron.",
					[2] = "You received the Skull of a Caveman and need to explore the world, letting the skull see everything. \z
						You need to stand at the highest place of Ab'dendriel.",
					[3] = "You received the Skull of a Caveman and need to explore the world, letting the skull see everything. \z
						You need to stand at the highest place of Femor Hills.",
					[4] = "You received the Skull of a Caveman and need to explore the world, letting the skull see everything. \z
						You need to stand at the highest place of Darashia",
					[5] = "You received the Skull of a Caveman and need to explore the world, letting the skull see everything. \z
						You need to stand at the highest place of Ankrahmun",
					[6] = "You received the Skull of a Caveman and need to explore the world, letting the skull see everything. \z
						You need to stand at the highest place of Port Hope",
					[7] = "You received the Skull of a Caveman and need to explore the world, letting the skull see everything. \z
						You need to stand at the highest place of Liberty Bay",
					[8] = "You received the Skull of a Caveman and need to explore the world, letting the skull see everything. \z
						You need to stand at the highest place of Yalahar",
					[9] = "You received the Skull of a Caveman and need to explore the world, letting the skull see everything. \z
						You need to stand at the highest place of Svargrond",
					[10] = "You received the Skull of a Caveman and need to explore the world, letting the skull see everything. \z
						You need to stand at the highest place of Thais",
					[11] = "You received the Skull of a Caveman and need to explore the world, letting the skull see everything. \z
						You need to stand at the highest place of Carlin",
					[12] = "You visited all the highest places with the skull. \z
						Turn the skull back to Lazaran and report him your mission!",
					[13] = "You turned the skull already back to Lazaran. Ask him for new mission!"
				}
                return descriptions[player:getStorageValue(Storage.UnnaturalSelection.Mission02)]
            end
        },
		{
            name = "Mission 3: Dance Dance Evolution",
            storageId = Storage.UnnaturalSelection.Mission03,
            startValue = 1,
            endValue = 3,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Lazaran told you to go to Ulala, who is located above Lazaran.",
					[2] = "Ulala told you to dance to please their god Krunus. \z
						On the south mountain in the camp you will find the Krunus altar, there are lots of leaves on the ground.",
					[3] = "You solved the dance. Head back to Ulala and report your mission!"
				}
                return descriptions[player:getStorageValue(Storage.UnnaturalSelection.Mission03)]
            end
        },
		{
            name = "Mission 4: Bits and Pieces",
            storageId = Storage.UnnaturalSelection.Mission04,
            startValue = 1,
            endValue = 2,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Now the god Krunus is pleased, another god called Pandor needs to be pleased. \z
						Ulala wants you to collect 5 Orc Teeth, 5 Minotaur leathers and 5 Lizard Leathers. Bring them to her.",
					[2] = "You brought Ulala 5 Orc Teeth, 5 Minotaur leathers and 5 Lizard Leathers. Ask her for new mission!"
				}
                return descriptions[player:getStorageValue(Storage.UnnaturalSelection.Mission04)]
            end
        },
		{
            name = "Mission 5: Ray of Light",
            storageId = Storage.UnnaturalSelection.Mission05,
            startValue = 1,
            endValue = 3,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "The third god which needs to be pleased is called Fasuon. \z
						Find the great crystal on top of mountain of Fasuon and pray there for his support!",
					[2] = "You already prayed at the great crystal. Report it to Ulala",
					[3] = "You have reported back to Ulala that you have completed the mission."
				}
                return descriptions[player:getStorageValue(Storage.UnnaturalSelection.Mission05)]
            end
        },
		{
            name = "Mission 6: Firewater Burn",
            storageId = Storage.UnnaturalSelection.Mission06,
            startValue = 1,
            endValue = 3,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Speak with Lazaran and tell the gods are pleased now.",
					[2] = "Bring Lazaran a Pot of brown water for a party after the great hunt.",
					[3] = "You brought Lazaran the beer and got a Serpent Crest as reward!"
				}
                return descriptions[player:getStorageValue(Storage.UnnaturalSelection.Mission06)]
            end
        },
    }
}):register()

Game.createQuest("The New Frontier", {
    storageId = Storage.Quest.U8_54.TheNewFrontier.Questline,
    storageValue = 1,

    missions = {
        {
            name = "Mission 01: New Land",
            storageId = Storage.Quest.U8_54.TheNewFrontier.Mission01,
            startValue = 1,
            endValue = 3,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Explore the new land and reach the bottom of the mountain.",
					[2] = "You have found a passage from the mountains. You can report back to Ongulf.",
					[3] = "You have reported the scouted route to Ongulf."
				}
                return descriptions[player:getStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission01)]
            end
        },
		{
            name = "Mission 02: From Kazordoon With Love",
            storageId = Storage.Quest.U8_54.TheNewFrontier.Mission02[1],
            startValue = 1,
            endValue = 3,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Find Melfar of the imperial mining guild close to a mine entrance west of Kazordoon. \z
						Ask him to send more miners and wood.",
					[2] = "Prepare the three trees which Melfar marked on your map with the beaver bait. \z
						Once you've marked all three return to Melfar and tell him about your success.",
					[3] = "Melfar has finally promised to send more miners and wood. Report this to Ongulf in Farmine.",
					[4] = "You have reported that Melfar will send more miners and wood for Farmine.",
					[5] = "Report this to Melfar."
				}
                return descriptions[player:getStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission02[1])]
            end
        },
		{
            name = "Mission 03: Strangers in the Night",
            storageId = Storage.Quest.U8_54.TheNewFrontier.Mission03,
            startValue = 1,
            endValue = 3,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Find the unknown stalkers somewhere in the mountains. They apparently climbed up \z
						somewhere during their escape. Try to negotiate a peaceful agreement if possible.",
					[2] = "You have talked to the leader of the primitive humans and have assured their peacefulness. \z
						Report this to Ongulf back in the base.",
					[3] = "You have negotiated a peacful agreement between the dwarfs and the local primitives."
				}
                return descriptions[player:getStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission03)]
            end
        },
		{
            name = "Mission 04: The Mine Is Mine",
            storageId = Storage.Quest.U8_54.TheNewFrontier.Mission04,
            startValue = 1,
            endValue = 2,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Free the mine of the monstrous threat. Use a lift to reach the mines and look for a leader \z
						of the stone creatures. Slay this creature and report back to Ongulf.",
					[2] = "You have slain the monster that terrorised the mines."
				}
                return descriptions[player:getStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission04)]
            end
        },
		{
            name = "Mission 05: Getting Things Busy",
            storageId = Storage.Quest.U8_54.TheNewFrontier.Mission05[1],
            startValue = 1,
            endValue = 2,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Try getting the support of the people mentioned. Talk to them about \"farmine\", then \z
							choose the \"flatter\", \"threaten\", \"impress\", \"bluff\", \"reason\" or \"plea\" and report \z
							any progress to Ongulf.",
					[2] = "You have gained the necessary support for Farmine."
				}
                return descriptions[player:getStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission05[1])]
            end
        },
		{
            name = "Mission 5: Support of Kazordoon's Worm Tamer",
            storageId = Storage.Quest.U8_54.TheNewFrontier.Mission05.Humgolf,
            startValue = 1,
            endValue = 2,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Talk to the worm tamer in Kazordoon.",
					[2] = "Find an item that interests Humgolf to get another chance."
				}
                return descriptions[player:getStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission05.Humgolf)]
            end
        },
		{
            name = "Mission 5: Support of the Edron Academy",
            storageId = Storage.Quest.U8_54.TheNewFrontier.Mission05.Wyrdin,
            startValue = 1,
            endValue = 2,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Talk to the magician Wyrdin in the Edron Academy.",
					[2] = "Find an item that interests Wyrdin to get another chance."
				}
                return descriptions[player:getStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission05.Wyrdin)]
            end
        },
		{
            name = "Mission 5: Support of the Explorer Society",
            storageId = Storage.Quest.U8_54.TheNewFrontier.Mission05.Angus,
            startValue = 1,
            endValue = 2,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Talk to the representative of the Explorer Society in Port Hope.",
					[2] = "Find an item that interests Angus to get another chance."
				}
                return descriptions[player:getStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission05.Angus)]
            end
        },
		{
            name = "Mission 5: Support of the Inventor Telas",
            storageId = Storage.Quest.U8_54.TheNewFrontier.Mission05.Telas,
            startValue = 1,
            endValue = 2,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Talk to the inventor Telas in Edron.",
					[2] = "Find an item that interests Telas to get another chance."
				}
                return descriptions[player:getStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission05.Telas)]
            end
        },
		{
            name = "Mission 5: Support of the Thaian King",
            storageId = Storage.Quest.U8_54.TheNewFrontier.Mission05.KingTibianus,
            startValue = 1,
            endValue = 2,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
					[1] = "Talk to King Tibianus in the Thaian Castle.",
					[2] = "Find an item that interests King Tibianus to get another chance."
				}
                return descriptions[player:getStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission05.KingTibianus)]
            end
        },
		{
            name = "Mission 5: Support of the Venorean Traders",
            storageId = Storage.Quest.U8_54.TheNewFrontier.Mission05.Leeland,
            startValue = 1,
            endValue = 2,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
					[1] = "Talk to Leeland Slim, the representative of the Venorean Traders.",
					[2] = "Find an item that interests Leeland Slim to get another chance."
				}
                return descriptions[player:getStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission05.Leeland)]
            end
        },
		{
            name = "Mission 06: Days Of Doom",
            storageId = Storage.Quest.U8_54.TheNewFrontier.Mission06,
            startValue = 1,
            endValue = 5,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
					[1] = "Try to pacify the orcs of the steppe. It is probably necessary to find some leader of the orcish tribes.",
					[2] = "You have talked to the minotaur leaders of the orcs. They agreed to spare Farmine if you \z
						prove your worth in their arena. You will have to survive against Mooh'Tah master for 2 minutes, so prepare!",
					[3] = "You have survived the arena. Talk to Curos again about your mission.",
					[4] = "Your negotiations had moderate success. Your can report back to Ongulf.",
					[5] = "You have ensured a brittle peace between Farmine and the orcs."
				}
                return descriptions[player:getStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission06)]
            end
        },
		{
            name = "Mission 07: Messengers Of Peace",
            storageId = Storage.Quest.U8_54.TheNewFrontier.Mission07[1],
            startValue = 1,
            endValue = 2,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
					[1] = "Find a lizardman somewhere in the north and try to start a negotiation of peace.",
					[2] = "It seems that the lizardmen are not interested in peace and you will have to focus \z
						on other problems at hand."
				}
                return descriptions[player:getStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission07[1])]
            end
        },
		{
            name = "Mission 08: An Offer You Can't Refuse",
            storageId = Storage.Quest.U8_54.TheNewFrontier.Mission08,
            startValue = 1,
            endValue = 2,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
					[1] = "Captured by lizardmen trap you have to find a way out of the prison. Perhaps \z
						something in your cell might lead you to an opportunity for freedom.",
					[2] = "You managed to find a way of the captivity of the lizardmen - but for a price."
				}
                return descriptions[player:getStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission08)]
            end
        },
		{
            name = "Mission 09: Mortal Combat",
            storageId = Storage.Quest.U8_54.TheNewFrontier.Mission09[1],
            startValue = 1,
            endValue = 3,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
					[1] = "You are expected to participate in the great tournament of the lizard race. \z
						Travel to the Isle of Strife and brave the challenges there.",
					[2] = "You are the champion of the great tournament! Still the lizardmen are a menace to \z
						behold. You should report to Chrak before you leave the isle.",
					[3] = "You have reported your latest doings to Chrak. It seems you bought the dwarfs some \z
						time of peace. Only the dragon kings may know how long though."
				}
                return descriptions[player:getStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission09[1])]
            end
        },
		{
            name = "Mission 10: New Horizons",
            storageId = Storage.Quest.U8_54.TheNewFrontier.Mission10[1],
            startValue = 1,
            endValue = 2,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
					[1] = "Ongulf will be anxious to learn about your latest adventures. Travel back to Farmine \z
						for a final report.",
					[2] = "Ongulf got very satisfied with your journey, this land is yours to be taken. You can \z
						find now on top of the mountain a red carpet, it might offer you access to some cities." -- This last questlog message is not accurate, need to update.
				}
                return descriptions[player:getStorageValue(Storage.Quest.U8_54.TheNewFrontier.Mission10[1])]
            end
        },
		{
            name = "Tome of Knowledge Counter",
            storageId = Storage.Quest.U8_54.TheNewFrontier.TomeofKnowledge,
            startValue = 1,
            endValue = 12,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
					[1] = "You brought the fist Tome of Knowledge to Cael. He learnt more about the lizard culture. \z
						Pompan will sell you dragon tapestries from now on.",
					[2] = "You brought the second Tome of Knowledge to Cael. He learnt more about the minotaur culture. \z
						Pompan will sell you minotaur backpacks from now on.",
					[3] = "You brought the third Tome of Knowledge to Cael. \z
						He learnt more about the last stand of the draken culture. Esrik will sell you lizard weapon rack from now on.",
					[4] = "You brought the fourth Tome of Knowledge to Cael. \z
						He learnt something interesting about a certain food that the lizardmen apparently prepare. \z
						Swolt will trade you a bunch of ripe rice for 10 rice balls from now on.",
					[5] = "You brought the fifth Tome of Knowledge to Cael. \z
						He learnt more about the last stand of the lizards in the South, Zzaion. \z
						Pompan will sell you lizard backpacks from now on.",
					[6] = "You brought the sixth Tome of Knowledge to Cael. \z
						He learnt a few things about the primitive human culture on this continent. \z
						Cael will sell you War Drums and Didgeridoo from now on.",
					[7] = "You brought the seventh Tome of Knowledge to Cael. \z
						He learnt something interesting about the Zao steppe. \z
						Now you to use the snake teleport at the peak of the mountain.",
					[8] = "You brought the eighth Tome of Knowledge to Cael. \z
						He learnt a few things about an illness. \z
						Now you can enter a corruption hole in the north-eastern end of Zao.",
					[9] = "You brought the ninth Tome of Knowledge to Cael. \z
						He learnt something interesting about the Draken origin. \z
						Esrik will buy lizard equipment from you now.",
					[10] = "You brought the tenth Tome of Knowledge to Cael. \z
						He learnt more about the last stand of the lizard dynasty. \z
						Now you can enter the Zao Palace. It is situated deep underground, below the mountain base of the Lizards.",
					[11] = "You brought the eleventh Tome of Knowledge to Cael. \z
						He learnt something interesting about dragons and their symbolism. \z
						You can buy a Dragon Statue from NPC Cael after you bring him a Red Lantern.",
					[12] = "You brought the twelfth Tome of Knowledge to Cael. \z
						He learnt something about reveals some of the power structures in Zao. \z
						Cael will now make a Dragon Throne for you after you bring him a Red Piece of Cloth. \z
						He will reward you with 5000 experience points for each extra tome you give to him."
					}
                return descriptions[player:getStorageValue(Storage.Quest.U8_54.TheNewFrontier.TomeofKnowledge)]
            end
        },
    }
}):register()

Game.createQuest("The Secret Library", {
    storageId = Storage.TheSecretLibrary.FalconBastionAccess,
    storageValue = 1,

    missions = {
	
		{
            name = "Liquid Death",
            storageId = Storage.TheSecretLibrary.LiquidDeath,
            startValue = 1,
            endValue = 14,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "I need you to go to port hope and find a book in a sea cave.",
					[2] = "A large scout party of ancestors of the Njey have returned to fight the Deeplings. You have to deal with two enemy parties. Try to win the Deeplings over temporarily by restoring their idols: 0/9",
					[3] = "A large scout party of ancestors of the Njey have returned to fight the Deeplings. You have to deal with two enemy parties. Try to win the Deeplings over temporarily by restoring their idols: 1/9",
					[4] = "A large scout party of ancestors of the Njey have returned to fight the Deeplings. You have to deal with two enemy parties. Try to win the Deeplings over temporarily by restoring their idols: 2/9",
					[5] = "A large scout party of ancestors of the Njey have returned to fight the Deeplings. You have to deal with two enemy parties. Try to win the Deeplings over temporarily by restoring their idols: 3/9",
					[6] = "A large scout party of ancestors of the Njey have returned to fight the Deeplings. You have to deal with two enemy parties. Try to win the Deeplings over temporarily by restoring their idols: 4/9",
					[7] = "A large scout party of ancestors of the Njey have returned to fight the Deeplings. You have to deal with two enemy parties. Try to win the Deeplings over temporarily by restoring their idols: 5/9",
					[8] = "A large scout party of ancestors of the Njey have returned to fight the Deeplings. You have to deal with two enemy parties. Try to win the Deeplings over temporarily by restoring their idols: 6/9",
					[9] = "A large scout party of ancestors of the Njey have returned to fight the Deeplings. You have to deal with two enemy parties. Try to win the Deeplings over temporarily by restoring their idols: 7/9",
					[10] = "A large scout party of ancestors of the Njey have returned to fight the Deeplings. You have to deal with two enemy parties. Try to win the Deeplings over temporarily by restoring their idols: 8/9",
					[11] = "Now that the idols have been established, you now need to kill the boss Brokul.",
					[12] = "You have defeated the Brokul, now report the mission to Spectulus.",
					[13] = "Go to the Thais museum and talk to Gareth.",
					[14] = "Mission completed.",
                }
                return descriptions[player:getStorageValue(Storage.TheSecretLibrary.LiquidDeath)]
            end
        },
	
        {
            name = "Access to the Falcon Bastion",
            storageId = Storage.TheSecretLibrary.FalconBastionAccess,
            startValue = 1,
            endValue = 1,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "You have managed to reach the access to Falcon Bastion."
                }
                return descriptions[player:getStorageValue(Storage.TheSecretLibrary.FalconBastionAccess)]
            end
        },		
		{
            name = "Access to the Lower Bastion",
            storageId = Storage.TheSecretLibrary.LowerBastionAccess,
            startValue = 1,
            endValue = 1,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "You now have access to the Lower Bastion doors."
                }
                return descriptions[player:getStorageValue(Storage.TheSecretLibrary.LowerBastionAccess)]
            end
        },
		{
            name = "Access to the Underground Bastion",
            storageId = Storage.TheSecretLibrary.UndergroundBastionAccess,
            startValue = 1,
            endValue = 1,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "You now have access to the Underground Bastion doors."
                }
                return descriptions[player:getStorageValue(Storage.TheSecretLibrary.UndergroundBastionAccess)]
            end
        },
		{
            name = "Access to the Oberon Bastion",
            storageId = Storage.TheSecretLibrary.OberonAccess,
            startValue = 1,
            endValue = 1,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "You now have access to the Oberon Bastion."
                }
                return descriptions[player:getStorageValue(Storage.TheSecretLibrary.OberonAccess)]
            end
        },
		{
            name = "Discovered Shortcut to Bastion",
            storageId = Storage.TheSecretLibrary.ShortcutToBastion,
            startValue = 1,
            endValue = 1,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "You have discovered a shortcut to Falcon Bastion."
                }
                return descriptions[player:getStorageValue(Storage.TheSecretLibrary.ShortcutToBastion)]
            end
        },
    }
}):register()

Game.createQuest("Adventurers Guild", {
    storageId = Storage.AdventurersGuild.GreatDragonHunt.WarriorSkeleton,
    storageValue = 1,

    missions = {
        {
            name = "The Great Dragon Hunt",
            storageId = Storage.AdventurersGuild.GreatDragonHunt.WarriorSkeleton,
            startValue = 0,
            endValue = 2,
            ignoreEndValue = false,
            description = function(player)
				return ("You are exploring the Kha'zeel Dragon Lairs. Others obviously found a terrible end here. \z
					But the dragon hoards might justify the risks. You killed %d/50 dragons and dragon lords."):format(
				math.max(player:getStorageValue(Storage.AdventurersGuild.GreatDragonHunt.DragonCounter), 0)
				)
			end
        },
    }
}):register()

Game.createQuest("Wrath of the Emperor", {
    storageId = Storage.WrathoftheEmperor.Questline,
    storageValue = 1,

    missions = {
        {
            name = "Mission 01: Catering the Lions Den",
            storageId = Storage.WrathoftheEmperor.Mission01,
            startValue = 1,
            endValue = 3,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "You must bring Zalamon 3 nails and a piece of wood so that he can make a Marked Crate for you.",
					[2] = "Go to the tunnel in eastern Muggy Plains and reach the other side. \z
						Try to hide in the dark and avoid being seen at all by using the crate. \z
						After that you need to find the rebel hideout and talk to their leader Chartan.",
					[3] = "You passed the maintenance tunnel and successfully made contact with the resistance in their hideout north of the Great Gate."
					}
                return descriptions[player:getStorageValue(Storage.WrathoftheEmperor.Mission01)]
            end
        },
		{
            name = "Mission 02: First Contact",
            storageId = Storage.WrathoftheEmperor.Mission02,
            startValue = 1,
            endValue = 3,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Chartan needs you to reactivate the teleport to the Muggy Plains. \z
						Head downstairs and into the temple and craft material to repair the teleport. \z
						To do this you will need some tools to improvise.",
					[2] = "As you give the coal into the pool the corrupted fluid begins to dissolve, leaving purified, \z
						refreshing water. The teleporter is reactivated. Report back to Chartan.",
					[3] = "Report back to Zalamon for the next mission."
				}
                return descriptions[player:getStorageValue(Storage.WrathoftheEmperor.Mission02)]
            end
        },
		{
            name = "Mission 03: The Keeper",
            storageId = Storage.WrathoftheEmperor.Mission03,
            startValue = 1,
            endValue = 3,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Zalamon gives you a Flask of Plant Poison to destroy plants in the garden \z
						of the Emperor to lure out and kill The Keeper to get his tail. The garden is southeast of the rebel hideout.",
					[2] = "You killed the Keeper and got his tail. Bring it to Zalamon.",
					[3] = "You brought the tail of the Keeper to Zalamon and completed the mission. Ask for the next mission."
				}
                return descriptions[player:getStorageValue(Storage.WrathoftheEmperor.Mission03)]
            end
        },
		{
            name = "Mission 04: Sacrament of the Snake",
            storageId = Storage.WrathoftheEmperor.Mission04,
            startValue = 1,
            endValue = 3,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
					[1] = "Zalamon now wants you to go to Deeper Banuta and get an Ancient Sceptre \z
						that will help in the fight against the emperor. \z
						On each floor under Deeper Banuta you collect a sceptre part from a Ghost of a Priest. \z
						On the 4th and final floor you need to assemble the sceptre..",
					[2] = "After you've assembled the Snake Sceptre and fought your way back out, \z
						head back to Zalamon and give it to him.",
					[3] = "You have delievered the recreated sceptre to the rebels."
				}
                return descriptions[player:getStorageValue(Storage.WrathoftheEmperor.Mission04)]
            end
        },
		{
            name = "Mission 05: New in Town",
            storageId = Storage.WrathoftheEmperor.Mission05,
            startValue = 1,
            endValue = 3,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Enter the imperial city Razachai to the west and talk to your contact in the ministry there for further missions.",
					[2] = "Now you only have to walk west until you find Zlak inside the big green building.",
					[3] = "You went deep inside the city to find Zlak and completed the mission. Ask for the next mission."
				}
                return descriptions[player:getStorageValue(Storage.WrathoftheEmperor.Mission05)]
            end
        },
		{
            name = "Mission 06: The Office Job",
            storageId = Storage.WrathoftheEmperor.Mission06,
            startValue = 0,
            endValue = 4,
            ignoreEndValue = false,
            description = function(player)
				return string.format(
					"Kill four Magistrati in the office building. Then report back to Zlak. You have killed %d magistrati so far.",
				(math.max(player:getStorageValue(Storage.WrathoftheEmperor.Mission06), 0))
				)
			end
        },
		{
            name = "Mission 07: A Noble Cause",
            storageId = Storage.WrathoftheEmperor.Mission07,
            startValue = 0,
            endValue = 6,
            ignoreEndValue = false,
            description = function(player)
				return string.format(
					"Kill six nobles in the city and report back to Zlak. You have killed %d nobles so far.",
				(math.max(player:getStorageValue(Storage.WrathoftheEmperor.Mission07), 0))
				)
			end
        },
		{
            name = "Mission 08: Uninvited Guests",
            storageId = Storage.WrathoftheEmperor.Mission08,
            startValue = 1,
            endValue = 2,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Use the old escape tunnel in the northern basement of the ministry to enter the imperial palace. Fight your way to the basement to meet your new rebel contact.",
					[2] = "You have reached your rebel contact Zizzle in the imperial palace."
				}
                return descriptions[player:getStorageValue(Storage.WrathoftheEmperor.Mission08)]
            end
        },
		{
            name = "Mission 09: The Sleeping Dragon",
            storageId = Storage.WrathoftheEmperor.Mission09,
            startValue = 1,
            endValue = 2,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "To enter the inner realms of the Emperor you need to free the mind of a dragon. \z
						An interdimensional potion will help you to enter this dream and unleash his consciousness.",
					[2] = "You travelled through the Sleeping Dragon dreams and freed his mind."
				}
                return descriptions[player:getStorageValue(Storage.WrathoftheEmperor.Mission09)]
            end
        },
		{
            name = "Mission 10: A Message of Freedom",
            storageId = Storage.WrathoftheEmperor.Mission10,
            startValue = 1,
            endValue = 6,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
					[1] = "After solving the riddle, and talking again to the Sleeping Dragon you got a Spiritual Charm. \z
						Report back to Zizzle.",
					[2] = "You possess the key to enter the inner realms of the emperor. \z
						Start with the one in the north-west and work your way clockwise trough the room and kill those manifestation. \z
						Then use your sceptre on the remain to destroy the emperor\'s influence over the crystal.",
					[3] = "You possess the key to enter the inner realms of the emperor. \z
						You destroyed 1 of 4 emperor\'s influences.",
					[4] = "You possess the key to enter the inner realms of the emperor. \z
						You destroyed 2 of 4 emperor\'s influences.",
					[5] = "You possess the key to enter the inner realms of the emperor. \z
						You destroyed 3 of 4 emperor\'s influences.",
					[6] = "You possess the key to enter the inner realms of the emperor. \z
						You destroyed all emperor\'s influences."
				}
                return descriptions[player:getStorageValue(Storage.WrathoftheEmperor.Mission10)]
            end
        },
		{
            name = "Mission 11: Payback Time",
            storageId = Storage.WrathoftheEmperor.Mission11,
            startValue = 1,
            endValue = 2,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
					[1] = "Your Mission is to kill Zalamon. Step into the teleporter to confront him. \z
						Finally use your sceptre on the death body.",
					[2] = "Go back to Awareness Of The Emperor and report him your success!"
				}
                return descriptions[player:getStorageValue(Storage.WrathoftheEmperor.Mission11)]
            end
        },
		{
            name = "Mission 12: Just Rewards",
            storageId = Storage.WrathoftheEmperor.Mission12,
            startValue = 0,
            endValue = 1,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
					[0] = "The Emperor has promised you wealth beyond measure. Go claim it in the ministry.",
					[1] = "You completed this Quest!"
				}
                return descriptions[player:getStorageValue(Storage.WrathoftheEmperor.Mission12)]
            end
        },
    }
}):register()

Game.createQuest("Children of the Revolution", {
    storageId = Storage.ChildrenoftheRevolution.Questline,
    storageValue = 1,

    missions = {
        {
            name = "Prove Your Worzz!",
            storageId = Storage.ChildrenoftheRevolution.Mission00,
            startValue = 1,
            endValue = 2,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Your Mission is to go to a little camp of lizards at north-east of the Dragonblaze Peaks. \z
							You have to find and deliver the Tactical map complete the mission.",
					[2] = "You delivered the Tactical map to Zalamon."
				}
                return descriptions[player:getStorageValue(Storage.ChildrenoftheRevolution.Mission00)]
            end
        },
		{
            name = "Mission 1: Corruption",
            storageId = Storage.ChildrenoftheRevolution.Mission01,
            startValue = 1,
            endValue = 3,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Go to the Temple of Equilibrium (it\'s marked on your map) and find out what happened there.",
					[2] = "The temple has been corrupted and is lost. Zalamon should be informed about this as soon as possible.",
					[3] = "You already reported Zalamon about the Temple! Ask him for new mission!"
				}
                return descriptions[player:getStorageValue(Storage.ChildrenoftheRevolution.Mission01)]
            end
        },
		{
            name = "Mission 2: Imperial Zzecret Weaponzz",
            storageId = Storage.ChildrenoftheRevolution.Mission02,
            startValue = 1,
            endValue = 5,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Go into the small camp Chaochai to the north of the Dragonblaze Peaks \z
							(Zalamon marks the entrance on your map). There are 3 buildings which you have to spy",
					[2] = "You spied 1 of 3 buildings of the camp.",
					[3] = "You spied 2 of 3 buildings of the camp.",
					[4] = "You spied 3 of 3 buildings of the camp. Zalamon should be informed about this as soon as possible.",
					[5] = "You already reported Zalamon about the camp! Ask him for new mission!"
				}
                return descriptions[player:getStorageValue(Storage.ChildrenoftheRevolution.Mission02)]
            end
        },
		{
            name = "Mission 3: Zee Killing Fieldzz",
            storageId = Storage.ChildrenoftheRevolution.Mission03,
            startValue = 1,
            endValue = 3,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Get the poison from Zalamon\'s storage room. Then go to the teleporter to the Muggy Plains and head \z
						east from there to the rice fields. Go to the very top rice field and use the poison anywhere on the water.",
					[2] = "The rice has been poisoned. This will weaken the Emperor\'s army significantly. \z
						Return and tell Zalamon about your success.",
					[3] = "You already reported Zalamon about your success! Ask him for new mission!"
				}
                return descriptions[player:getStorageValue(Storage.ChildrenoftheRevolution.Mission03)]
            end
        },
		{
            name = "Mission 4: Zze Way of Zztonezz",
            storageId = Storage.ChildrenoftheRevolution.Mission04,
            startValue = 1,
            endValue = 6,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Your mission is to find a way to enter the north of the valley and find a \z
						passage to the great gate itself. Search any temples or settlements you come across for hidden passages.",
					[2] = "Report Zalamon about the strange symbols that you found.",
					[3] = "Get the greasy oil from Zalamon\'s storage room and put them on the levers that you found.",
					[4] = "Due to being extra greasy, the leavers can now be moved.",
					[5] = "You found the right combination for the puzzle in the mountains and triggered some kind of mechanism. \z
						You should head back to Zalamon to report your success.",
					[6] = "You already reported Zalamon about your success! You got a Tome of Knowledge as reward! \z
						Ask him for new mission!"
				}
                return descriptions[player:getStorageValue(Storage.ChildrenoftheRevolution.Mission04)]
            end
        },
		{
            name = "Mission 5: Phantom Army",
            storageId = Storage.ChildrenoftheRevolution.Mission05,
            startValue = 1,
            endValue = 4,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
					[1] = "Zalamon has sent you on a quest to find out what lies beneath the secret portal in the temple. Find it and explore the other side.",
					[2] = "Eternal guardians and lizard chosen has been awaken. Survive them and report it to Zalamon!",
					[3] = "You Survived the Waves and reported Zalamon about your success! You got a Serpent Crest as reward!",
					[4] = "Children of the Revolution has been completed, now ask for another quest to start Wrath of the Emperor."
				}
                return descriptions[player:getStorageValue(Storage.ChildrenoftheRevolution.Mission05)]
            end
        },
    }
}):register()

Game.createQuest("In Service of Yalahar", {
    storageId = Storage.InServiceofYalahar.Questline,
    storageValue = 1,

    missions = {
        {
            name = "Mission 01: Something Rotten",
            storageId = Storage.InServiceofYalahar.Mission01,
            startValue = 1,
            endValue = 6,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Palimuth asked you to help with some sewer malfunctions. \z
							You will need a Crowbar, there are 4 places where you need to go marked with an X on your map.",
					[2] = "You cleaned 1 pipe of 4 from the garbage.",
					[3] = "You cleaned 2 pipes of 4 from the garbage.",
					[4] = "You cleaned 3 pipes of 4 from the garbage.",
					[5] = "You cleaned 4 pipes of 4 from the garbage. Go back to Palimuth and report your mission",
					[6] = "You cleaned all pipes from the garbage! Go back to Palimuth and ask for mission."
				}
                return descriptions[player:getStorageValue(Storage.InServiceofYalahar.Mission01)]
            end
        },
		{
            name = "Mission 02: Watching the Watchmen",
            storageId = Storage.InServiceofYalahar.Mission02,
            startValue = 1,
            endValue = 8,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "You have to find all 7 guards and give a report to them. \z
						You should start by Foreign Quarter or by Trade Quarter and follow the order of the path..",
					[2] = "You reported to 1 of 7 guards",
					[3] = "You reported to 2 of 7 guards",
					[4] = "You reported to 3 of 7 guards",
					[5] = "You reported to 4 of 7 guards",
					[6] = "You reported to 5 of 7 guards",
					[7] = "You reported to 6 of 7 guards",
					[8] = "You reported to 7 of 7 guards! Go back to Palimuth and ask for mission."
				}
                return descriptions[player:getStorageValue(Storage.InServiceofYalahar.Mission02)]
            end
        },
		{
            name = "Mission 03: Death to the Deathbringer",
            storageId = Storage.InServiceofYalahar.Mission03,
            startValue = 1,
            endValue = 6,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Get the notes in Palimuths room and read them. Talk to Palimuth again when you've read the notes.",
					[2] = "Talk to Azerus the Yalahari in the city centre to get your next mission.",
					[3] = "Get the notes behind the Yalahari and read them. \z
						Talk to Azerus again and ask him for mission when you've read the notes.",
					[4] = "Ask Palimuth for mission.",
					[5] = "First you will need to kill the three plague bearers and then get The Alchemists' Formulas. \z
							When this have been done head back to either Palimuth (good side) or Yalahari (Azerus) (bad side).",
					[6] = "Ask Azerus the Yalahari for a mission."
				}
                return descriptions[player:getStorageValue(Storage.InServiceofYalahar.Mission03)]
            end
        },
		{
            name = "Mission 04: Good to be Kingpin",
            storageId = Storage.InServiceofYalahar.Mission04,
            startValue = 1,
            endValue = 6,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Ask Palimuth for mission.",
					[2] = "For this mission you are asked to go to the Trade Quarter and negotiate or threaten Mr. West. \z
						Once again you will gain access to the mechanism although if you \z
						choose to help Palimuth you should go through the sewers.",
					[3] = "You decided to help Palimuth, report him your mission.",
					[4] = "You decided to help Azerus, report him your mission. ",
					[5] = "Get back to Azerus and report him your mission.",
					[6] = "Ask Azerus for a mission."
				}
                return descriptions[player:getStorageValue(Storage.InServiceofYalahar.Mission04)]
            end
        },
		{
            name = "Mission 05: Food or Fight",
            storageId = Storage.InServiceofYalahar.Mission05,
            startValue = 1,
            endValue = 8,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Ask Palimuth for mission.",
					[2] = "On this mission you are asked to find a druid by the name of Tamerin, on the Arena Quarter. \z
						You now have permission to use the gates mechanism.",
					[3] = "The first is to bring Tamerin a flask of Animal Cure, \z
						you can buy this from Siflind on Nibelor (northeast of Svargrond).",
					[4] = "Now you have to kill Morik the Gladiator and bring his helmet to Tamerin as proof.",
					[5] = "Report back to Tamerin as he will listen to your request and you can now make your choice: \z
						Cattle for Palimuth (good side), Warbeasts for Yalahari (Azerus) (bad side). \z
						Then report the one you decided your mission.",
					[6] = "You decided to help Palimuth, report him your mission.",
					[7] = "You decided to help Azerus, report him your mission.",
					[8] = "Ask Azerus for a mission."
				}
                return descriptions[player:getStorageValue(Storage.InServiceofYalahar.Mission05)]
            end
        },
		{
            name = "Mission 06: Frightening Fuel",
            storageId = Storage.InServiceofYalahar.Mission06,
            startValue = 1,
            endValue = 5,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Ask Palimuth for mission.",
					[2] = "Yalahari (Azerus) orders you to travel to the Cemetery Quarter and find the Strange Carving. \z
						He gives you a Ghost Charm and tells you to charge it with the tormented souls of the ghosts there \z
						to be used as an energy source. Palimuth wants the Charged Ghost Charm in order to free those souls. \z
						You can new use the Cemetery Quarter mechanism now. Go to the big building in the Cemetery Quarter and \z
						use the Ghost Charm on the Strange Carving at the back of the room.",
					[3] = "Good side: Go to Palimuth, ask him about your mission, and hand in the charm. Bad side: \z
						Ask about your mission to Yalahari (Azerus) and give it back.",
					[4] = "Get back to Azerus and report him your mission.",
					[5] = "Ask Azerus for a mission."
				}
                return descriptions[player:getStorageValue(Storage.InServiceofYalahar.Mission06)]
            end
        },
		{
            name = "Mission 07: A Fishy Mission",
            storageId = Storage.InServiceofYalahar.Mission07,
            startValue = 1,
            endValue = 5,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Ask Palimuth for mission.",
					[2] = "Bad side: Yalahari (Azerus) will send you for a new mission to go to the Sunken Quarter and kill the \z
						Quara Leaders, Inky, Splasher and Sharptooth. Good side: Rather than fighting any Quara leaders Palimuth \z
						will instead send you to find the cause for the Quaras aggressive behavior. Find Maritima and talk to her \z
						about the Quara and she will explain what their problem is.",
					[3] = "Get back to Palimuth and report him your mission.",
					[4] = "You killed the Quarabosses. Ask Azerus for a mission.",
					[5] = "Ask Azerus for a mission."
				}
                return descriptions[player:getStorageValue(Storage.InServiceofYalahar.Mission07)]
            end
        },
		{
            name = "Mission 08: Dangerous Machinations",
            storageId = Storage.InServiceofYalahar.Mission08,
            startValue = 1,
            endValue = 4,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Ask Palimuth for mission.",
					[2] = "Bad side: For this mission the Yalahari requests you go to the Factory Quarter and \z
						find a pattern crystal, which will be used to supply weapons to help take control of the city. Good side: \z
						Palimuth will send you there to use the crystal to supply food for the city.",
					[3] = "Get back to Azerus and report him your mission.",
					[4] = "Ask Azerus for a mission."
				}
                return descriptions[player:getStorageValue(Storage.InServiceofYalahar.Mission08)]
            end
        },
		{
            name = "Mission 09: Decision",
            storageId = Storage.InServiceofYalahar.Mission09,
            startValue = 1,
            endValue = 2,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "You now need to decide between supporting Palimuth or the Yalahari\'s goal. \z
						To choose Palimuth\'s good side go to him, and simply ask him for a mission mission. \z
						Likewise, to join the Yalahari (Azerus) (bad side) go to him and say the same.",
					[2] = "You already decided!"
				}
                return descriptions[player:getStorageValue(Storage.InServiceofYalahar.Mission09)]
            end
        },
		{
            name = "Mission 10: The Final Battle",
            storageId = Storage.InServiceofYalahar.Mission10,
            startValue = 1,
            endValue = 5,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Palimuth told you that a circle of Yalahari is planning some kind of ritual. They plan to create \z
						a portal for some powerful demons and to unleash them in the city to 'purge' it once and for all.",
					[2] = "The entrance to their inner sanctum has been opened for you. \z
						Be prepared for a HARD battle! Better gather some friends to assist you.",
					[3] = "Report back to whichever principal you have chosen to help and you will receive Yalaharian Outfits.",
					[4] = "You got the access to the reward room. \z
						Choose carefully which reward you pick as you can only take one item.",
					[5] = "You have completed the Quest!"
				}
                return descriptions[player:getStorageValue(Storage.InServiceofYalahar.Mission10)]
            end
        },
    }
}):register()

Game.createQuest("The Explorer Society", {
    storageId = Storage.ExplorerSociety.QuestLine,
    storageValue = 1,

    missions = {
        {
            name = "Joining the Explorers",
            storageId = Storage.ExplorerSociety.JoiningTheExplorers,
            startValue = 1,
            endValue = 5,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "The mission should be simple to fulfil. You have to seek out Uzgod in \z
						Kazordoon and get the pickaxe for us. Or just find dwarven pickaxe on your own...",
					[2] = "Get into Dwacatra and get Uzgod's family brooch.",
					[3] = "Bring family brooch back to Uzgod",
					[4] = "Bring the pickaxe back to the Explorer Society representative.",
					[5] = "You have completed Joining the Explorers"
				}
                return descriptions[player:getStorageValue(Storage.ExplorerSociety.JoiningTheExplorers)]
            end
        },
		{
            name = "The Ice Delivery",
            storageId = Storage.ExplorerSociety.TheIceDelivery,
            startValue = 6,
            endValue = 8,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [6] = "Take this ice pick and use it on a block of ice in the caves beneath Folda. \z
						Get some ice and bring it here as fast as you can. \z
						If the ice melt away, report on your ice delivery mission anyway.",
					[7] = "You have 10 minutes before the icicle defrosts. Run back to the Explorer Society representative!",
					[8] = "You have completed The Ice Delivery."
				}
                return descriptions[player:getStorageValue(Storage.ExplorerSociety.TheIceDelivery)]
            end
        },
		{
            name = "The Butterfly Hunt",
            storageId = Storage.ExplorerSociety.TheButterflyHunt,
            startValue = 9,
            endValue = 17,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [9] = "This preparation kit will allow you to collect a PURPLE butterfly you have killed. \z
						Just use it on the fresh corpse of a PURPLE butterfly.",
					[10] = "Return the prepared butterfly to Explorer Society representative.",
					[11] = "Ask for another butterfly hunt.",
					[12] = "This preparation kit will allow you to collect a BLUE butterfly you have killed. \z
						Just use it on the fresh corpse of a BLUE butterfly.",
					[13] = "Return the prepared butterfly to Explorer Society representative.",
					[14] = "Ask for another butterfly hunt.",
					[15] = "This preparation kit will allow you to collect a RED butterfly you have killed. \z
						Just use it on the fresh corpse of a RED butterfly.",
					[16] = "Return the prepared butterfly to Explorer Society representative.",
					[17] = "You have completed The Butterfly Hunt."
				}
                return descriptions[player:getStorageValue(Storage.ExplorerSociety.TheButterflyHunt)]
            end
        },
		{
            name = "The Plant Collection",
            storageId = Storage.ExplorerSociety.ThePlantCollection,
            startValue = 18,
            endValue = 26,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [18] = "Take botanist\'s container. Use it on a jungle bells plant to collect a sample.",
					[19] = "Report about your plant collection to Explorer Society representative.",
					[20] = "Ask for plant collection when you are ready to continue.",
					[21] = "Use botanist\'s container on a witches cauldron to collect a sample.",
					[22] = "Report about your plant collection to Explorer Society representative.",
					[23] = "Ask for plant collection when you are ready to continue.",
					[24] = "Use this botanist\'s container on a giant jungle rose to obtain a sample.",
					[25] = "Report about your plant collection to Explorer Society representative.",
					[26] = "You have completed The Plant Collection."
				}
                return descriptions[player:getStorageValue(Storage.ExplorerSociety.ThePlantCollection)]
            end
        },
		{
            name = "The Lizard Urn",
            storageId = Storage.ExplorerSociety.TheLizardUrn,
            startValue = 27,
            endValue = 29,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [27] = "In the south-east of Tiquanda is a small settlement of the lizard people. \z
						Beneath the newly constructed temple there, the lizards hide the urn. \z
						Acquire an ancient urn which is some sort of relic to the lizard people of Tiquanda.",
					[28] = "Bring the Funeral Urn back to the Explorer Society.",
					[29] = "You have completed The Lizard Urn."
				}
                return descriptions[player:getStorageValue(Storage.ExplorerSociety.TheLizardUrn)]
            end
        },
		{
            name = "The Bonelord Secret",
            storageId = Storage.ExplorerSociety.TheBonelordSecret,
            startValue = 30,
            endValue = 32,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [30] = "Travel to the city of Darashia and then head north-east for the pyramid. \z
						If any documents are left, you probably find them in the catacombs beneath.",
					[31] = "Bring the Wrinkled Parchment back to the Explorer Society representative.",
					[32] = "You have completed The Bonelord Secret."
				}
                return descriptions[player:getStorageValue(Storage.ExplorerSociety.TheBonelordSecret)]
            end
        },
		{
            name = "The Orc Powder",
            storageId = Storage.ExplorerSociety.TheOrcPowder,
            startValue = 33,
            endValue = 35,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [33] = "As far as we can tell, the orcs maintain some sort of training facility \z
						in some hill in the north-east of their city. \z
						There you should find lots of their war wolves and hopefully also some of the orcish powder.",
					[34] = "Bring the Strange Powder to the Explorer Society representative to complete your mission.",
					[35] = "You have completed The Orc Powder."
				}
                return descriptions[player:getStorageValue(Storage.ExplorerSociety.TheOrcPowder)]
            end
        },
		{
            name = "The Elven Poetry",
            storageId = Storage.ExplorerSociety.TheElvenPoetry,
            startValue = 36,
            endValue = 38,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [36] = "This mission is easy but nonetheless vital. Travel Hellgate beneath Ab'Dendriel and get the book.",
					[37] = "Bring back an elven poetry book to the Explorer Society representative.",
					[38] = "You have completed The Elven Poetry."
				}
                return descriptions[player:getStorageValue(Storage.ExplorerSociety.TheElvenPoetry)]
            end
        },
		{
            name = "The Memory Stone",
            storageId = Storage.ExplorerSociety.TheMemoryStone,
            startValue = 39,
            endValue = 41,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [39] = "In the ruins of north-western Edron you should be able to find a memory stone. ",
					[40] = "Bring back a memory stone to the Explorer Society representative.",
					[41] = "You have completed The Memory Stone."
				}
                return descriptions[player:getStorageValue(Storage.ExplorerSociety.TheMemoryStone)]
            end
        },
		{
            name = "The Rune Writings",
            storageId = Storage.ExplorerSociety.TheRuneWritings,
            startValue = 42,
            endValue = 44,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
					[42] = "Somewhere under the ape infested city of Banuta, one can find dungeons \z
						that were once inhabited by lizards. Look there for an atypical structure that \z
						would rather fit to Ankrahmun and its Ankrahmun Tombs. Copy the runes you will find on this structure.",
					[43] = "Report back to the Explorer Society representative.",
					[44] = "You have completed The Rune Writings."
				}
                return descriptions[player:getStorageValue(Storage.ExplorerSociety.TheRuneWritings)]
            end
        },
		{
            name = "The Ectoplasm",
            storageId = Storage.ExplorerSociety.TheEctoplasm,
            startValue = 45,
            endValue = 47,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
					[45] = "Take ectoplasm container and use it on a ghost that was recently slain.",
					[46] = "Return back to the Explorer Society representative with the collected ectoplasm.",
					[47] = "You have completed The Ectoplasm."
				}
                return descriptions[player:getStorageValue(Storage.ExplorerSociety.TheEctoplasm)]
            end
        },
		{
            name = "The Spectral Dress",
            storageId = Storage.ExplorerSociety.TheSpectralDress,
            startValue = 48,
            endValue = 50,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
					[48] = "The queen of the banshees lives in the so called Ghostlands, south west of Carlin. \z
						Try to get a spectral dress from her.",
					[49] = "Report to the Explorer Society with the spectral dress.",
					[50] = "You have completed The Spectral Dress."
				}
                return descriptions[player:getStorageValue(Storage.ExplorerSociety.TheSpectralDress)]
            end
        },
		{
            name = "The Spectral Stone",
            storageId = Storage.ExplorerSociety.TheSpectralStone,
            startValue = 51,
            endValue = 55,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
					[51] = "Please travel to our second base and ask them to mail us their latest research reports. \z
							Then return here and ask about new missions.",
					[52] = "Tell our fellow explorer that the papers are in the mail already.",
					[53] = "Take the spectral essence and use it on the strange carving in this building \z
							as well as on the corresponding tile in our second base.",
					[54] = "Good! Now use the spectral essence on the strange carving in our second base.",
					[55] = "You have completed The Spectral Stone."
				}
                return descriptions[player:getStorageValue(Storage.ExplorerSociety.TheSpectralStone)]
            end
        },
		{
            name = "The Astral Portals",
            storageId = Storage.ExplorerSociety.TheAstralPortals,
            startValue = 56,
            endValue = 56,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
					[56] = "Both carvings are now charged and harmonised. You are able to travel in zero time from \z
						one base to the other, but you need to have an orichalcum pearl in your possession to use it as power source."
				}
                return descriptions[player:getStorageValue(Storage.ExplorerSociety.TheAstralPortals)]
            end
        },
		{
            name = "The Island of Dragons",
            storageId = Storage.ExplorerSociety.TheIslandofDragons,
            startValue = 57,
            endValue = 59,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
					[57] = "Travel to Okolnir and try to find a proof for the existence of dragon lords there in the old times. \z
						I think old Buddel might be able to bring you there.",
					[58] = "Report back to Lurik with the dragon scale.",
					[59] = "You have completed The Island of Dragons."
				}
                return descriptions[player:getStorageValue(Storage.ExplorerSociety.TheIslandofDragons)]
            end
        },
		{
            name = "The Ice Music",
            storageId = Storage.ExplorerSociety.TheIceMusic,
            startValue = 60,
            endValue = 62,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
					[60] = "There is a cave on Hrodmir, north of the southernmost barbarian camp Krimhorn. \z
						In this cave, there are a waterfall and a lot of stalagmites. \z
						Take the resonance crystal and use it on the stalagmites in the cave to record the sound of the wind.",
					[61] = "Report back to Lurik.",
					[62] = "Now you may use the Astral Bridge from Liberty Bay to Svargrond."
				}
                return descriptions[player:getStorageValue(Storage.ExplorerSociety.TheIceMusic)]
            end
        },
		{
            name = "The Undersea Kingdom",
            storageId = Storage.ExplorerSociety.CalassaQuest,
            startValue = 1,
            endValue = 3,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
					[1] = "Captain Max will bring you to Calassa whenever you are ready. \z
						Please try to retrieve the missing logbook which must be in one of the sunken shipwrecks.",
					[2] = "Report about your Calassa mission to Berenice in Liberty Bay.",
					[3] = "You have completed The Undersea Kingdom."
				}
                return descriptions[player:getStorageValue(Storage.ExplorerSociety.CalassaQuest)]
            end
        },	
    }
}):register()

Game.createQuest("The Ice Islands", {
    storageId = Storage.TheIceIslands.Questline,
    storageValue = 1,

    missions = {
        {
            name = "Befriending the Musher",
            storageId = Storage.TheIceIslands.Mission01,
            startValue = 1,
            endValue = 3,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Find Sniffler the husky of Iskan. He should be somewhere north west of the town. \z
						He is probably marking his territory so you should be able to find his trace. \z
						Call him sniffler and feed him with meat.",
					[2] = "Tell Iskan that you found and feed Sniffler",
					[3] = "You are now a friend of Iskan and can ask him for a passage to Nibelor. \z
						You should ask Hjaern in Nibelor if you can help him."
				}
                return descriptions[player:getStorageValue(Storage.TheIceIslands.Mission01)]
            end
        },
		{
            name = "Nibelor 1: Breaking the Ice",
            storageId = Storage.TheIceIslands.Mission02,
            startValue = 1,
            endValue = 5,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Chakoyas may use the ice for a passage to the west and attack Svargrond. Use the rocks at east \z
						of nibelor on at least three of these places and the chakoyas probably won't be able to pass the ice.",
					[2] = "You have broke 1 of 3 icepassages",
					[3] = "You have broke 2 of 3 icepassages",
					[4] = "You have broke 3 of 3 icepassages! Tell Hjaern your mission!",
					[5] = "You should ask Silfind if you can help her in some matters."
				}
                return descriptions[player:getStorageValue(Storage.TheIceIslands.Mission02)]
            end
        },
		{
            name = "Nibelor 2: Ecological Terrorism",
            storageId = Storage.TheIceIslands.Mission03,
            startValue = 1,
            endValue = 3,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Siflind send you to travel to a distant land to get ants from an Ant-Hill to \z
						perform ecological terrorism on some pirates on Tyrsung. Just use the jug on an anthill.",
					[2] = "Now head back to Svargrond and go to Buddel, the drunk sailor in southern Svargrond, \z
						and ask him to take you to Tyrsung. Now go all the way to the southern shores \z
						where you find a outpost. Go to the bottom deck and use the jug with the western mast",
					[3] = "Go tell Siflind that you released the ants and aks her for mission!"
				}
                return descriptions[player:getStorageValue(Storage.TheIceIslands.Mission03)]
            end
        },
		{
            name = "Nibelor 3: Artful Sabotage",
            storageId = Storage.TheIceIslands.Mission04,
            startValue = 1,
            endValue = 2,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Siflind gave you a Vial of Paint to use on some Baby Seals. \z
						Go back to Tyrsung and follow the shore from Buddel south. Use the Vial of Paint on three of these seals.",
					[2] = "Go tell Siflind that you painted the seals and aks her for mission!"
				}
                return descriptions[player:getStorageValue(Storage.TheIceIslands.Mission04)]
            end
        },
		{
            name = "Nibelor 4: Berserk Brewery",
            storageId = Storage.TheIceIslands.Mission05,
            startValue = 1,
            endValue = 6,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "The first things needed are 5 bat wings to brew a berserker elixir. Bring her them!",
					[2] = "The next items Siflind need are 4 bear paws. Bring her them!",
					[3] = "The next items Siflind need are 3 bonelord eyes. Bring her them!",
					[4] = "The next items Siflind need are 2 fish fins. Bring her them!",
					[5] = "The next item Siflind need is a green dragon scale. Bring her that!",
					[6] = "You helped Siflind to defend Svargrond. Now Nilsor need help, go ask him for mission."
				}
                return descriptions[player:getStorageValue(Storage.TheIceIslands.Mission05)]
            end
        },
		{
            name = "Nibelor 5: Cure the Dogs",
            storageId = Storage.TheIceIslands.Mission06,
            startValue = 1,
            endValue = 8,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "To cure Nilsor dogs, bring him the 1st of 7 ingredients: a Part of the Sun Adorer Cactus. \z
						Only an ordinary kitchen knife will be precise enough to produce the ingredient weneed.",
					[2] = "To cure Nilsor dogs, bring him the 2nd of 7 ingredients: Geyser Water in a Waterskin. \z
						Use it on a geyser that is NOT active. The water of active geysers is far too hot.",
					[3] = "To cure Nilsor dogs, bring him the 3rd of 7 ingredients: Fine Sulphur. \z
						Use an ordinary kitchen spoon on an inactive lava hole.",
					[4] = "To cure Nilsor dogs, bring him the 4th of 7 ingredients: the Frostbite Herb. \z
						You can find it on mountain peaks. You will need to cut it with a fine kitchen knife.",
					[5] = "To cure Nilsor dogs, bring him the 5th of 7 ingredients: Purple Kiss Blossom. \z
						The purple kiss is a plant that grows in a place called jungle. \z
						You will have to use a kitchen knife to harvest its blossom.",
					[6] = "To cure Nilsor dogs, bring him the 6th of 7 ingredients: the Hydra Tongue. \z
						The hydra tongue is a common pest plant in warmer regions. You might find one in a shop.",
					[7] = "To cure Nilsor dogs, bring him the 7th of 7 ingredients: Spores of a Giant Glimmercap Mushroom. \z
						The giant glimmercap mushroom exists in caves and other preferably warm and humid places. \z
						Use an ordinary kitchen spoon on a mushroom to collectits spores.",
					[8] = "You found all ingredients to cure Nilsor dogs, ask him for mission. \z
						You can now travel by Dog Sleds to Inukaya."
				}
                return descriptions[player:getStorageValue(Storage.TheIceIslands.Mission06)]
            end
        },
		{
            name = "The Secret of Helheim",
            storageId = Storage.TheIceIslands.Mission07,
            startValue = 1,
            endValue = 3,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Hjaern might have a mission for you. So maybe you go and talk to him.",
					[2] = "Hjaern send you to find someone in Svargrond who can give you a passage to \z
					Helheim and seek the reason for the unrest there.",
					[3] = "You discovered the necromantic altar and should report Hjaern about it."
				}
                return descriptions[player:getStorageValue(Storage.TheIceIslands.Mission07)]
            end
        },
		{
            name = "The Contact",
            storageId = Storage.TheIceIslands.Mission08,
            startValue = 1,
            endValue = 4,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
					[1] = "Get out of Nibelor and go to the Svargrond Explorer\'s Society. Ask Lurik for the mission.",
					[2] = "Get to the raider camp, then follow to the extreme south where you find lots of barbarians. \z
					Near the southern most coastline, try looking for the NPC Nor. Ask him about Memory Crystal.",
					[3] = "Go back to Lurik and deliver him the memory crystal.",
					[4] = "Give Lurik some time to evaluate the information (ca. 5min). \z
					Then talk to him again about your mission."
				}
                return descriptions[player:getStorageValue(Storage.TheIceIslands.Mission08)]
            end
        },
		{
            name = "Formorgar Mines 1: The Mission",
            storageId = Storage.TheIceIslands.Mission09,
            startValue = 1,
            endValue = 2,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
					[1] = "Find the entrance of the Formorgar Mines. \z
					Find some hint or someone who is willing to talk about what is going on there.",
					[2] = "You found a old and tattered written paper in a skeleton next to a Restless Soul, \z
					you can only make out a signature: Tylaf, apprentice of Hjaern. Ask Hjaern about Tylaf."
				}
                return descriptions[player:getStorageValue(Storage.TheIceIslands.Mission09)]
            end
        },
		{
            name = "Formorgar Mines 2: Ghostwhisperer",
            storageId = Storage.TheIceIslands.Mission10,
            startValue = 1,
            endValue = 2,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
					[1] = "Go back to the mine and ask the restless soul about his story.",
					[2] = "You already have listen to his story!"
				}
                return descriptions[player:getStorageValue(Storage.TheIceIslands.Mission10)]
            end
        },
		{
            name = "Formorgar Mines 3: The Secret",
            storageId = Storage.TheIceIslands.Mission11,
            startValue = 1,
            endValue = 2,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
					[1] = "The Cultists plan is to create a new demon army for their master to conquer the world. \z
					Hjaern and the other shamans must learn about it! Hurry before its too late.",
					[2] = "The Cultists plan is to create a new demon army for their master to conquer the world. \z
					Hjaern and the other shamans are already informed!"
				}
                return descriptions[player:getStorageValue(Storage.TheIceIslands.Mission11)]
            end
        },
		{
            name = "Formorgar Mines 4: Retaliation",
            storageId = Storage.TheIceIslands.Mission12,
            startValue = 1,
            endValue = 6,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
					[1] = "Hjaern gave you a spirit charm of cold. Travel to the mines and find four \z
						special obelisks to mark them with the charm.",
					[2] = "1 of 4 obelisks are marked.",
					[3] = "2 of 4 obelisks are marked.",
					[4] = "3 of 4 obelisks are marked.",
					[5] = "Once all 4 obelisks are marked report back to Hjaern.",
					[6] = "You got the Norseman outfit and you have access to the Yakchal room deep in the Formorgar Mines."
				}
                return descriptions[player:getStorageValue(Storage.TheIceIslands.Mission12)]
            end
        },
		{
            name = "Barbarian Test 1: Barbarian Booze",
            storageId = Storage.BarbarianTest.Mission01,
            startValue = 1,
            endValue = 3,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
					[1] = "You participate in the drinking challenge. Now you can get the permission for a few sips of barbarian mead in exchange for some honey.",
					[2] = "Now drink from the bucket until you drink 10 sips in a row without passing out",
					[3] = "You have mastered the first task of the barbarian test. If you haven't done so yet, talk to Sven about it."
				}
                return descriptions[player:getStorageValue(Storage.BarbarianTest.Mission01)]
            end
        },
		{
            name = "Barbarian Test 2: The Bear Hugging",
            storageId = Storage.BarbarianTest.Mission02,
            startValue = 1,
            endValue = 2,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
					[1] = "Somewhere north of Svargrond you will find a lonely bear which you have to hug. You wonder what you were thinking when accepting this quest...",
					[2] = "You passed the bear hugging test (and should take a bath). If you haven't done so yet, talk to Sven about it."
				}
                return descriptions[player:getStorageValue(Storage.BarbarianTest.Mission02)]
            end
        },
		{
            name = "Barbarian Test 3: The Mammoth Pushing",
            storageId = Storage.BarbarianTest.Mission03,
            startValue = 1,
            endValue = 2,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
					[1] = "Find a mammoth north-west of Svargrond and knock it over. You wonder whether your mission is becoming a barbarian or rather commiting suicide.",
					[2] = "You have knocked over a mammoth - though you wonder what this crushing noise at your spine was. If you haven't done so yet, talk to Sven about the mammoth pushing."
				}
                return descriptions[player:getStorageValue(Storage.BarbarianTest.Mission03)]
            end
        },
		{
            name = "The Honorary Barbarian",
            storageId = Storage.BarbarianTest.Questline,
            startValue = 8,
            endValue = 8,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
					[8] = "You are now a honorary barbarian and can become a citizen of Svargrond. If you haven't done so yet, you should look for a barbarian in need of help in the north of the town."
				}
                return descriptions[player:getStorageValue(Storage.BarbarianTest.Questline)]
            end
        },
    }
}):register()

Game.createQuest("The Ultimate Challenges", {
    storageId = Storage.SvargrondArena.QuestLogGreenhorn,
    storageValue = 1,

    missions = {
        {
            name = "Barbarian Arena - Greenhorn Mode",
            storageId = Storage.SvargrondArena.QuestLogGreenhorn,
            startValue = 1,
            endValue = 2,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "You have to defeat all enemies in this mode.",
					[2] = "You have defeated all enemies in this mode."
				}
                return descriptions[player:getStorageValue(Storage.SvargrondArena.QuestLogGreenhorn)]
            end
        },
		{
            name = "Barbarian Arena - Scrapper Mode",
            storageId = Storage.SvargrondArena.QuestLogScrapper,
            startValue = 1,
            endValue = 2,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "You have to defeat all enemies in this mode.",
					[2] = "You have defeated all enemies in this mode."
				}
                return descriptions[player:getStorageValue(Storage.SvargrondArena.QuestLogScrapper)]
            end
        },
		{
            name = "Barbarian Arena - Warlord Mode",
            storageId = Storage.SvargrondArena.QuestLogWarlord,
            startValue = 1,
            endValue = 2,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "You have to defeat all enemies in this mode.",
					[2] = "You have defeated all enemies in this mode."
				}
                return descriptions[player:getStorageValue(Storage.SvargrondArena.QuestLogWarlord)]
            end
        },
    }
}):register()

Game.createQuest("Factions", {
    storageId = Storage.Factions,
    storageValue = 1,

    missions = {
        {
            name = "The Marid and the Efreet - Djinn Greeting",
            storageId = Storage.DjinnWar.Faction.Greeting,
            startValue = 1,
            endValue = 2,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Melchior told you the word &quot;Djanni'hah&quot; which can be used to talk to Djinns. \z
						Be aware that once you become an ally of one Djinn race, you cannot switch sides anymore.",
					[2] = ""
				}
                return descriptions[player:getStorageValue(Storage.DjinnWar.Faction.Greeting)]
            end
        },
		{
            name = "The Marid and the Efreet - Djinn Greeting",
            storageId = Storage.DjinnWar.Faction.MaridDoor,
            startValue = 1,
            endValue = 2,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "You have joined the Marid. These friendly, blue Djinns are honest and fair allies. \z
						You have pledged eternal loyalty to King Gabel and may enter Asha'daramai freely. Djanni'hah!",
					[2] = ""
				}
                return descriptions[player:getStorageValue(Storage.DjinnWar.Faction.MaridDoor)]
            end
        },
		{
            name = "The Efreet and the Efreet - Efreet Faction",
            storageId = Storage.DjinnWar.Faction.EfreetDoor,
            startValue = 1,
            endValue = 2,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "You have joined the Efreet. These evil, green Djinns are always up to mischievous pranks. \z
						You have pledged eternal loyalty to King Malor and may enter Mal'ouquah freely. Djanni'hah!",
					[2] = ""
				}
                return descriptions[player:getStorageValue(Storage.DjinnWar.Faction.EfreetDoor)]
            end
        },
    }
}):register()

Game.createQuest("Lion's Rock", {
    storageId = Storage.LionsRock.Questline,
    storageValue = 1,

    missions = {
        {
            name = "Lion's Rock",
            storageId = Storage.LionsRock.Questline,
            startValue = 1,
            endValue = 11,
            ignoreEndValue = false,
            description = function(player)
				local descriptions = {
					[1] = function()
						return string.format(
							"You have discovered the Lion's Rock. If you pass the following tests you may enter the inner sanctum.\n\nThe Lion's Strength %d/1\nThe Lion's Beauty %d/1\nThe Lion's Tears %d/1",
							math.max(player:getStorageValue(Storage.LionsRock.OuterSanctum.LionsStrength), 0),
							math.max(player:getStorageValue(Storage.LionsRock.OuterSanctum.LionsBeauty), 0),
							math.max(player:getStorageValue(Storage.LionsRock.OuterSanctum.LionsTears), 0)
						)
					end,
					[2] = function()
						return string.format(
							"You have discovered the Lion's Rock. If you pass the following tests you may enter the inner sanctum.\n\nThe Lion's Strength %d/1\nThe Lion's Beauty %d/1\nThe Lion's Tears %d/1",
							math.max(player:getStorageValue(Storage.LionsRock.OuterSanctum.LionsStrength), 0),
							math.max(player:getStorageValue(Storage.LionsRock.OuterSanctum.LionsBeauty), 0),
							math.max(player:getStorageValue(Storage.LionsRock.OuterSanctum.LionsTears), 0)
						)
					end,
					[3] = function()
						return string.format(
							"You have discovered the Lion's Rock. If you pass the following tests you may enter the inner sanctum.\n\nThe Lion's Strength %d/1\nThe Lion's Beauty %d/1\nThe Lion's Tears %d/1",
							math.max(player:getStorageValue(Storage.LionsRock.OuterSanctum.LionsStrength), 0),
							math.max(player:getStorageValue(Storage.LionsRock.OuterSanctum.LionsBeauty), 0),
							math.max(player:getStorageValue(Storage.LionsRock.OuterSanctum.LionsTears), 0)
						)
					end,
					[4] = "You have passed the three tests of Lion's Rock and thus lit the three mystical pyramids. You may enter the inner sanctum now. - What other secrets could be hidden down there?",
					[5] = "You found a mysterious scroll in the debris of an old amphora. It seems it could help to translate the old temple inscriptions.",
					[6] = function()
						return string.format(
							"Lions' enemies in this area of the temple. What could be the resolution?\n\nBlood %d/1\nEgg %d/1\nEye %d/1\nPoison %d/1",
							math.max(player:getStorageValue(Storage.LionsRock.InnerSanctum.SnakeSign), 0),
							math.max(player:getStorageValue(Storage.LionsRock.InnerSanctum.LizardSign), 0),
							math.max(player:getStorageValue(Storage.LionsRock.InnerSanctum.ScorpionSign), 0),
							math.max(player:getStorageValue(Storage.LionsRock.InnerSanctum.HyenaSign), 0)
						)
					end,
					[7] = function()
						return string.format(
							"Lions' enemies in this area of the temple. What could be the resolution?\n\nBlood %d/1\nEgg %d/1\nEye %d/1\nPoison %d/1",
							math.max(player:getStorageValue(Storage.LionsRock.InnerSanctum.SnakeSign), 0),
							math.max(player:getStorageValue(Storage.LionsRock.InnerSanctum.LizardSign), 0),
							math.max(player:getStorageValue(Storage.LionsRock.InnerSanctum.ScorpionSign), 0),
							math.max(player:getStorageValue(Storage.LionsRock.InnerSanctum.HyenaSign), 0)
						)
					end,
					[8] = function()
						return string.format(
							"Lions' enemies in this area of the temple. What could be the resolution?\n\nBlood %d/1\nEgg %d/1\nEye %d/1\nPoison %d/1",
							math.max(player:getStorageValue(Storage.LionsRock.InnerSanctum.SnakeSign), 0),
							math.max(player:getStorageValue(Storage.LionsRock.InnerSanctum.LizardSign), 0),
							math.max(player:getStorageValue(Storage.LionsRock.InnerSanctum.ScorpionSign), 0),
							math.max(player:getStorageValue(Storage.LionsRock.InnerSanctum.HyenaSign), 0)
						)
					end,
					[9] = 'In the north-west area of the Inner Sanctum, find the southern rectangular room to the south-west. In this room you will find 4 "sun" floor inscriptions as well as a rock in the center. The sun inscriptions represent gem slots.',
					[10] = "By solving the gem puzzle you unveiled the last secret of the Lion's Rock. You drew a treasure out of the ornamented fountain in the lower temple areas.",
					[11] = "You have completed the Lion Rocks."
				}

				local descriptionKey = player:getStorageValue(Storage.LionsRock.Questline)
				local description = descriptions[descriptionKey]

				if type(description) == "function" then
					return description()
				else
					return description
				end
			end
        },	
    }
}):register()

Game.createQuest("The White Raven Monastery", {
    storageId = Storage.WhiteRavenMonastery.QuestLog,
    storageValue = 1,

    missions = {
        {
            name = "Access to the Isle of Kings",
            storageId = Storage.WhiteRavenMonastery.Passage,
            startValue = 1,
            endValue = 1,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "You are a friend of Dalbrect. Since you returned his family brooch he will sail you to the Isle of Kings unless you do something stupid."
                }
                return descriptions[player:getStorageValue(Storage.WhiteRavenMonastery.QuestLog)]
            end
        },
		{
            name = "The Investigation",
            storageId = Storage.WhiteRavenMonastery.Diary,
            startValue = 1,
            endValue = 1,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
                    [1] = "Investigate the catacombs. Abbot Costello should be interested in information about brother Fugio.",
					[2] = "You returned Fugio's Diary. Costello was very thankful about your help and gave you a blessed ankh as reward."
                }
                return descriptions[player:getStorageValue(Storage.WhiteRavenMonastery.QuestLog)]
            end
        },
    }
}):register()

Game.createQuest("Sea of Light", {
    storageId = Storage.SeaOfLight.Questline,
    storageValue = 1,

    missions = {
		{
            name = "Mission 1: The Plans",
            storageId = Storage.SeaOfLight.Mission1,
            startValue = 1,
            endValue = 4,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
					[1] = "Spectulus in Edron has sent you on a mission to find out the whereabouts of a certain inventor. \z
						A beggar in Edron seems to know more about this topic than he wants to tell.",
					[2] = "The beggar turned out to be the inventor himself. \z
						You successfully convinced him to give you the only remaining plans of his creation. \z
						You should return to Spectulus in Edron to tell him the news.",
					[3] = "You gave the plans to the astronomer. \z
						He began reconstructing the invention as soon as he got ahold of them. \z
						It will take a while for him to work out the problem which caused the initial failure.",
					[4] = "You returned to Speculus who finally worked out the failure of the initial construction. \z
						He recapitulated the plans and needs only one item before he can start building the magic device."
                }
                return descriptions[player:getStorageValue(Storage.SeaOfLight.Mission1)]
            end
        },
		{
            name = "Mission 2: The Collector",
            storageId = Storage.SeaOfLight.Mission2,
            startValue = 1,
            endValue = 3,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
					[1] = "Spectulus asked you to enter the Lost Mines beneath Edron and recover a rare crystal. In exchange for \z
						it you will gain access to the lair of the Collector who guards a vital component of the device.",
					[2] = "Luckily, you survived the horrors of the Lost Mines and recovered a rare crystal. \z
						You should visit Spectulus in Edron to seek counsel on what to do next.",
					[3] = "You returned to astronomer Spectulus and gave him the rare crystal."
                }
                return descriptions[player:getStorageValue(Storage.SeaOfLight.Mission2)]
            end
        },
		{
            name = "Mission 3: The Mirror Crystal",
            storageId = Storage.SeaOfLight.Mission3,
            startValue = 1,
            endValue = 4,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
					[1] = "In order to access the lair of the Collector, you will need to find the creature\'s well on \z
						an ice isle near Carlin. To donate the rare crystal overcome your greed and use it at the well\'s pedestal.",
					[2] = "You offered the rare crystal to the creature and can now enter the Collector\'s lair. \z
						Its crystal chamber cannot be accessed by outsiders. You need to find a way to snatch the Mirror Crystal.",
					[3] = "The Collector has been defeated. \z
						You packed the fragile Mirror Crystal into the device Spectulus gave you. \z
						All yo have to do now is to return to the astronomer and to present him your acquisition.",
					[4] = "It may have been the excitement or simple nervousness but as soon as Spectulus removed the crystal, \z
						it somehow slipped. Unfinishable for all eternity, the device left yet another scholar in despair."
                }
                return descriptions[player:getStorageValue(Storage.SeaOfLight.Mission3)]
            end
        },
	}
}):register()

Game.createQuest("The Ape City", {
    storageId = Storage.TheApeCity.Started,
    storageValue = 1,

    missions = {
		{
            name = "Hairycles' Missions",
            storageId = Storage.TheApeCity.Questline,
            startValue = 1,
            endValue = 18,
            ignoreEndValue = false,
            description = function(player)
                local descriptions = {
					[1] = "Find whisper moss in the dworc settlement south of Port Hope and bring it back to Hairycles.",
					[2] = "You have completed the first mission. Hairycles was happy about the whisper moss you gave to him. \z
						He might have another mission for you.",
					[3] = "Hairycles asked you to bring him cough syrup from a human settlement. \z
						A healer might know more about this medicine.",
					[4] = "You have completed the second mission. Hairycles was happy about the cough syrup you gave to him. \z
						He might have another mission for you.",
					[5] = "Hairycles asked you to bring him a magical scroll from the lizard settlement Chor.",
					[6] = "You have completed the third mission. Hairycles appreciated that you brought \z
						the scroll to him and will try to read it. Maybe he has another mission for you later.",
					[7] = "Since Hairycles was not able to read the scroll you brought him, he asked you dig for a tomb in the \z
						desert to the east. Proceed in this tomb until you find an obelisk between red stones and read it.",
					[8] = "You have completed the fourth mission. \z
						Hairycles read your mind and can now translate the lizard scroll. \z
						He might have another mission for you.",
					[9] = "Hairycles wants to create a life charm for the ape people. \z
						He needs a hydra egg since it has strong regenerating powers.",
					[10] = "You have completed the fifth mission. \z
						Hairycles attempts to create a might charm for the protection of the ape people. \z
						He might have another mission for you later.",
					[11] = "Hairycles need a witches' cap mushroom which is supposed to be hidden in a dungeon deep under Fibula.",
					[12] = "You have completed the sixth mission. You brought the witches' cap mushroom back to Hairycles. \z
						He might have another mission for you.",
					[13] = "Hairycles is worried about an ape cult which drinks some strange fluid that the lizards left behind. \z
						Go to the old lizard temple under Banuta and destroy three of the casks there with a crowbar.",
					[14] = "You have completed the seventh mission. \z
						You found the old lizard ruins under Banuta and destroyed three of the casks with snake blood. \z
						Hairycles might have another mission for you.",
					[15] = "The apes now need a symbol of their faith. \z
						Speak with the blind prophet in a cave to the northeast and go to the Forbidden Land. \z
						Find a hair of the giant, holy ape Bong and bring it back.",
					[16] = "You completed the eighth mission. Hairycles gladly accepted the hair of the ape \z
						god which you brought him. He told you to have one final mission for you.",
					[17] = "Go into the deepest catacombs under Banuta and destroy the monument of \z
						the snake god with the hammer that Hairycles gave to you.",
					[18] = "You successfully destroyed the monument of the snake god. \z
						As reward, you can buy sacred statues from Hairycles. \z
						If you haven't done so yet, you should also ask him for a shaman outfit."
                }
                return descriptions[player:getStorageValue(Storage.TheApeCity.Questline)]
            end
        },
	}
}):register()

Game.createQuest("The Queen of the Banshees", {
    storageId = Storage.Quest.U7_2.TheQueenOfTheBanshees.FirstSeal,
    storageValue = 1,

    missions = {
        {
            name = "The Hidden Seal",
            storageId = Storage.Quest.U7_2.TheQueenOfTheBanshees.FirstSeal,
            startValue = 1,
            endValue = 1,
            ignoreEndValue = false,
            description = "You broke the first seal."
        },
		{
            name = "The Plague Seal",
            storageId = Storage.Quest.U7_2.TheQueenOfTheBanshees.SecondSeal,
            startValue = 1,
            endValue = 1,
            ignoreEndValue = false,
            description = "You broke the second seal."
        },
		{
            name = "The Seal of Demonrage",
            storageId = Storage.Quest.U7_2.TheQueenOfTheBanshees.ThirdSeal,
            startValue = 1,
            endValue = 1,
            ignoreEndValue = false,
            description = "You broke the third seal."
        },
		{
            name = "The Seal of Sacrifice",
            storageId = Storage.Quest.U7_2.TheQueenOfTheBanshees.FourthSeal,
            startValue = 1,
            endValue = 1,
            ignoreEndValue = false,
            description = "You broke the fourth seal."
        },
		{
            name = "The Seal of True Path",
            storageId = Storage.Quest.U7_2.TheQueenOfTheBanshees.FifthSeal,
            startValue = 1,
            endValue = 1,
            ignoreEndValue = false,
            description = "You broke the fifth seal."
        },
		{
            name = "The Seal of Logic",
            storageId = Storage.Quest.U7_2.TheQueenOfTheBanshees.SixthSeal,
            startValue = 1,
            endValue = 1,
            ignoreEndValue = false,
            description = "You broke the sixth seal."
        },
		{
            name = "The Kiss of the Banshee Queen",
            storageId = Storage.Quest.U7_2.TheQueenOfTheBanshees.LastSeal,
            startValue = 1,
            endValue = 1,
            ignoreEndValue = false,
            description = "The Banshee Queen kissed you. This meant your death, and part of your soul always belongs to her now. You broke the last seal."
        },
		{
            name = "The Final Battle",
            storageId = Storage.Quest.U7_2.TheQueenOfTheBanshees.FinalBattle,
            startValue = 1,
            endValue = 1,
            ignoreEndValue = false,
            description = "You have braved all dangers of the Banshee Quest and escaped the dungeon alive. The end room is sealed for you from now on."
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
				Power %d/200.\nTreasure %d/5.\nKnowledge %d/1.\nLife %d/3\z
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
