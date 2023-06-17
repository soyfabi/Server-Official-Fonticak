#include "otpch.h"
#include "protocolspectator.h"
#include "iologindata.h"
#include "chat.h"
#include "game.h"
#include "configmanager.h"

extern Chat* g_chat;
extern Game g_game;
extern ConfigManager g_config;

void ProtocolSpectator::setBroadcast(bool value)
{
    if (broadcast == value)
        return;

    if (!value)
        return clear();

    sendCastChannel();
    broadcast = true;
}

void ProtocolSpectator::addSpectator(ProtocolGame_ptr spectator)
{
    spectators.insert(spectator);
    setUpdateStatus(true); // update spectators count
    sendCastMessage("", spectator->getSpectatorName() + ": has joined to your cast.", TALKTYPE_CHANNEL_O);

    TextMessage message;
    message.type = MESSAGE_INFO_DESCR;
    message.text = "You are now spectating " + owner->getPlayer()->getName() + ".\nPlayers watching: " + std::to_string(spectators.size()) + ".\nYou can move between cast with CTRL+ARROW < - >.";
    spectator->sendTextMessage(message);
}

void ProtocolSpectator::removeSpectator(ProtocolGame_ptr spectator)
{
    spectators.erase(spectator);
    setUpdateStatus(true); // update spectators count
    sendCastMessage("", spectator->getSpectatorName() + ": has left from your cast.", TALKTYPE_CHANNEL_R1);
}

void ProtocolSpectator::kick(const DataList& _kicks)
{
    for (auto& it : _kicks)
        for (auto& spectator : spectators)
            if (it.second == spectator->getIP())
                spectator->disconnect();
}

void ProtocolSpectator::ban(const DataList& _bans)
{
    bans = _bans;
    for (auto& it : bans)
        for (auto& spectator : spectators)
            if (it.second == spectator->getIP())
                spectator->disconnect();
}

bool ProtocolSpectator::isBanned(uint32_t ip) const
{
    for (auto& it : bans)
        if (it.second == ip)
            return true;
    return false;
}

void ProtocolSpectator::spectatorSay(ProtocolGame_ptr spectator, const std::string& text)
{
    if (text[0] == '/') {
        auto t = explodeString(text.substr(1, text.length()), " ", 1);
        toLowerCaseString(t[0]);
        if (t[0] == "list" || t[0] == "show" || t[0] == "spectators")
        {
            std::stringstream s;
            s << spectators.size() << " spectators.";
            for (const auto& it : spectators)
                s << " " << it->getSpectatorName() << ",";
            s.seekp(-1, s.cur);
            s << ".";
            sendCastMessage("", s.str().substr(0, 255), TALKTYPE_CHANNEL_O, spectator);
        }
        else if (t[0] == "name" || t[0] == "nick")
        {
            if (t.size() == 1)
                return sendCastMessage("", "Usage: /nick new name.", TALKTYPE_CHANNEL_O, spectator);

            trimString(t[1]);
            if (t[1].size() < 3 || t[1].size() > 30)
                return sendCastMessage("", "Wrong name.", TALKTYPE_CHANNEL_O, spectator);

            if (g_game.getPlayerByName(t[1]) ||
                ProtocolGame::spectatorNames.find(asLowerCaseString(t[1])) != ProtocolGame::spectatorNames.end())
                return sendCastMessage("", "This name is already being used.", TALKTYPE_CHANNEL_O, spectator);

            ProtocolGame::spectatorNames.erase(asLowerCaseString(spectator->getSpectatorName()));
            sendCastMessage("", spectator->getSpectatorName() + " has changed name to " + t[1] + ".", TALKTYPE_CHANNEL_O);
            spectator->setSpectatorName(t[1]);
            ProtocolGame::spectatorNames.insert(asLowerCaseString(spectator->getSpectatorName()));

        }
        else if (t[0] == "help") {
            sendCastMessage("", "Commands list:", TALKTYPE_CHANNEL_O, spectator);
            sendCastMessage("", "/help - print this message", TALKTYPE_CHANNEL_O, spectator);
            sendCastMessage("", "/list - print spectators list", TALKTYPE_CHANNEL_O, spectator);
            sendCastMessage("", "/name - change your name", TALKTYPE_CHANNEL_O, spectator);
        }
        else
            sendCastMessage("", "Command not found. Use /help for commands list.", TALKTYPE_CHANNEL_O, spectator);

        return;
    }

    bool muted = false;
    for (auto& it : mutes)
        if (it.second == spectator->getIP())
            muted = true;

    if (muted) {
        sendCastMessage("", "You are muted.", TALKTYPE_CHANNEL_O, spectator);
        return;
    }

    sendCastMessage(spectator->getSpectatorName(), text, TALKTYPE_CHANNEL_O);
}

void ProtocolSpectator::sendCastMessage(const std::string& author, const std::string& text, SpeakClasses type, ProtocolGame_ptr target /*=nullptr*/)
{
    if (!target)
        return sendChannelMessage(author, text, type, CHANNEL_CAST);

    target->sendChannelMessage(author, text, type, CHANNEL_CAST);
}