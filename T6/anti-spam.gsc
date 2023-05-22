#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\_utility;

/*
    Mod: Prevent cheat spam system
    Developed by @DoktorSAS

    Requirements:
        t6-gsc-utils.dll for Black ops II

    note:
    The "Prevent cheat spam system" its just a script to prevent the spam of cheats or scam links
    used to do to don't get banned esaily from server moderators.
*/

init()
{
    level thread onPlayerSay();
}

validateMessage(player, message)
{
    state = 0;
    if(player.last_message == message)
    {
        state++;
    }
    
    words = strtok(message, " ");
    for(i = 0; i < words.size; i++)
    {
        word = words[i];
        // Check for discord user
        if(issubstr("#", word) || issubstr(word, "#"))
        {
            state++;
            continue;
        }

        // Check for add me, dm me, pm me or private me
        if(issubstr("add", word) || issubstr(word, "add")
            || issubstr("dm", word) || issubstr(word, "dm")
            || issubstr("private", word) || issubstr(word, "private")
            || issubstr("pm", word) || issubstr(word, "pm"))
        {
            state++;
            if(i < words.size)
            {
                for(i = i+1; i < words.size; i++)
                {
                    if(issubstr("me", word) || issubstr(word, "me"))
                    {
                        state++;
                    }
                }
            }
            continue;
        }

    }
    return state;
}


onPlayerSay()
{
    for(;;)
    {
        level waittill("say", message, player);
        message = toLower(message);
        if(!isDefined(player.last_message))
        {
            player.last_message = last_message;
        }
        else
        {
            state = validateMessage(player, message);
            printf("suspect: " + player.name + " - " + player.guid + " state level of " + state);
            if(state > 2)
            {
                kick(player GetEntityNumber());
            }
        }

    }
}

onPlayerConnect()
{
    once = 1;
    for (;;)
    {
        level waittill("connected", player);  
        if(!isDefined(player.pers["isBot"]) && player.pers["isBot"])
        {
            player thread onPlayerSpawned();
        }   
    }
}

onPlayerSpawned()
{
    self waittill("spawned_player");
    
}

