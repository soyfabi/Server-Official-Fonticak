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
