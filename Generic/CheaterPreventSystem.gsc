#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\_utility;

/*
    Mod: Cheater prevent system
    Developed by @DoktorSAS

    note:
    The "Cheater prevent system" its just a script to prevent common tricks that cheaters
    used to do to don't get banned esaily from server moderators.
*/

init()
{
    level thread onPlayerConnect();
}

onPlayerConnect()
{
    for (;;)
    {
        level waittill("connected", player);
        thread validatePlayerName(player);
    }
}

validatePlayerName(player)
{
    if (!player hasValidName())
    {
        printLn(player.name + " kicked for ^1INVALID NAME");
        kick(player getentitynumber(), "EXE_PLAYERKICKED");
    }
}

hasValidName()
{
    nameSubStr = getSubStr(self.name, 0, self.name.size);
    validChars = 0;
    notValidChars = 0;
    for (i = 0; i < nameSubStr.size; i++)
    {
        if (nameSubStr[i] == "I" || nameSubStr[i] == "i" || nameSubStr[i] == "1" || nameSubStr[i] == "l" || nameSubStr[i] == "|")
        {
            notValidChars = notValidChars + 1;
        }
        else
        {
            validChars = validChars + 1;
        }
    }

    if (notValidChars > (self.name.size / 2) && validChars < 3)
    {
        return 0;
    }

    return 1;
}
