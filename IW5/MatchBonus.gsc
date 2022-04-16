#include maps\mp\_utility;
#include common_scripts\utility;

/*
    Mod: Fix Matchbonus
    Developed by DoktorSAS
*/

init()
{
    level thread onPlayerConnected();
    level.original_onDeadEvent = level.onDeadEvent;
    level.onDeadEvent = ::onDeadEvent;
    level.winningTeam = "tie";
}

onDeadEvent(team)
{
    switch (getDvar("g_gametype"))
    {
    case "gtnw":
        if ((isDefined(level.nukeIncoming) && level.nukeIncoming) || (isDefined(level.nukeDetonated) && level.nukeDetonated))
            return;

        if (team == game["attackers"])
        {
            level.winningTeam = game["defenders"];
        }
        else if (team == game["defenders"])
        {
            level.winningTeam = game["attackers"];
        }
        break;

    case "arena":
        if (team == game["attackers"])
        {
            level.winningTeam = game["defenders"];
        }
        else if (team == game["defenders"])
        {
            level.winningTeam = game["attackers"];
        }
        break;

    case "sd":
    case "dd":
        if (team == "all")
        {
            if (level.bombPlanted)
                level.winningTeam = game["attackers"];
            else
                level.winningTeam = game["defenders"];
        }
        else if (team == game["attackers"])
        {
            if (level.bombPlanted)
                return;

            level.winningTeam = game["defenders"];
        }
        else if (team == game["defenders"])
        {
            level.winningTeam = game["attackers"];
        }
        break;

    default:
        level.winningTeam = "team";
        if (team == "allies")
        {
            level.winningTeam = "axis";
        }
        else if (team == "axis")
        {
            level.winningTeam = "allies";
        }
        else
        {
            if (level.teamBased)
                level.winningTeam = "tie";
            else
                level.winningTeam = undefined;
        }
        break;
    }

    [[level.original_onDeadEvent]] (team);
}

onPlayerConnected()
{
    level endon("exitLevel_called");
    for (;;)
    {
        level waittill("connected", player);
        player thread updatePlayerMatchBonus();
    }
}

updatePlayerMatchBonus()
{
    level waittill("game_ended");
    gameLength = float(getDvarFloat("scr_"+getDvar("g_gametype")+"_timelimit") * 60);

    if (level.teamBased)
    {
        if (level.winningTeam != "tie")
        {
            winnerScale = maps\mp\gametypes\_rank::getScoreInfoValue("win");
            loserScale = maps\mp\gametypes\_rank::getScoreInfoValue("loss");
            setWinningTeam(level.winningTeam);
        }
        else
        {
            winnerScale = maps\mp\gametypes\_rank::getScoreInfoValue("tie");
            loserScale = maps\mp\gametypes\_rank::getScoreInfoValue("tie");
        }

        spm = self maps\mp\gametypes\_rank::getSPM();
        if (level.winningTeam == "tie")
        {
            playerScore = int((winnerScale * ((gameLength / 60) * spm)) * (self.timePlayed["total"] / gameLength));
            self.matchBonus = playerScore;
        }
        else if (isDefined(self.pers["team"]) && self.pers["team"] == level.winningTeam)
        {
            playerScore = int((winnerScale * ((gameLength / 60) * spm)) * (self.timePlayed["total"] / gameLength));
            self.matchBonus = playerScore;
        }
        else if (isDefined(self.pers["team"]) && self.pers["team"] == getOtherTeam(level.winningTeam))
        {
            playerScore = int((loserScale * ((gameLength / 60) * spm)) * (self.timePlayed["total"] / gameLength));
            self.matchBonus = playerScore;
        }
    }
    else
    {
        isWinner = 0;
        for (pIdx = 0; pIdx < min(level.placement["all"].size, 3); pIdx++)
        {
            if (level.placement["all"][pIdx] != self)
                continue;
            isWinner = 1;
        }

        spm = int(self maps\mp\gametypes\_rank::getSPM());
        if (isWinner)
        {
            playerScore = int((1 * ((gameLength / 60) * spm)) * (self.timePlayed["total"] / gameLength));
            self.matchBonus = playerScore;
        }
        else
        {
            playerScore = int((1 * ((gameLength / 60) * spm)) * (self.timePlayed["total"] / gameLength));
            self.matchBonus = playerScore;
        }
    }
}
