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
