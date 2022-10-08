#include common_scripts\utility;
#include maps\_utility;

/*
    Mod: Black ops I and Black ops II chat bank
    Developed by @DoktorSAS

    Requirements:
        t6-gsc-utils.dll for Black ops II 

    dedicated.cfg:
    Add to your server cfg file the dvar sv_allowchatpayments and
    the dvar sv_allowchatbank to enable payments and to enable the 
    bank commands. Like
        set sv_allowchatbank 1
        set sv_allowchatpayments 1
*/
init()
{
    level thread onPlayerConnect();
    level thread onPlayerSay();
}

onPlayerConnect()
{
    for (;;)
    {
        level waittill("connecting", player);
        player thread setupBank();
    }
}

setupBank() // Initialize bank value
{
    self endon("disconnect");
    level endon("end_game");
    
    path = "bank/" + self getGuid() + ".txt";
    if (!fileExists(path))
    {
        /*
            Each player will have his or her own file containing the value of the bank
            This system decreases the search for an O(1) time information. 
            Direct access to information without use of any search algortim.
        */
        writeFile(path, "");
        while(!fileExists(path)) wait 0.5;

        // Set default bank value to 0
        file = fopen(path, "a");
        fwrite(file, "0");
        fclose(file);
        self.pers["bank"] = 0;  
    }
    else
    {
        self.pers["bank"] = int(readFile(path)); // Read value from the file
    }
}

onPlayerSay()
{
    level endon("end_game");
   
    prefix = ".";
    for (;;)
    {
        level waittill("say", message, player);
        message = toLower(message);
        if(!level.intermission && message[0] == prefix)
        {
            args = strtok(message, " ");
            command = getSubStr(args[0], 1);
            switch(command) {
                case "deposit":
                case "d":
                    doDeposit(player, args);
                    break;

                case "withdraw":
                case "w":
                    doWhitdraw(player, args);
                    break;
            
                case "balance":
                case "b":
                case "money":
                    if (getDvarIntDefault("sv_allowchatbank", 1) == 1 && isDefined(player.pers["bank"]))
                    {
                        player tell("Your balance is ^2$^7" + valueToString(player.pers["bank"]));
                    }
                    break;
                case "p":
                case "pay":
                    doPay(player, args);
                break;
            }
        }
    }
}

doWhitdraw(player, args)
{
    if (getDvarIntDefault("sv_allowchatbank", 1) == 0)
    {
    }
    else if ((isDefined(player.whos_who_effects_active) && player.whos_who_effects_active) || player.fake_death)
    {
        player tell("Command disable during last stand with WhosWho perk");
    }
    else
    {
        if (isDefined(args[1]))
        {
            if (args[1] == "all")
            {
                player.score = player.score + player.pers["bank"];
                player tell("^2$^7" + valueToString(player.pers["bank"]) + " withdrawn");
                player.pers["bank"] = 0;
                player updateBankValue(0);
            }
            else
            {
                if (isInteger(args[1]) && player.pers["bank"] >= int(args[1]))
                {
                    player.score = player.score + int(args[1]);
                    player.pers["bank"] = int(player.pers["bank"]) - int(args[1]);
                    player updateBankValue(player.pers["bank"]);
                    player tell("^2$^7" + valueToString(args[1]) + " withdrawn");
                }
                else
                {
                    player tell("Invalid ammount");
                }
            }
        }
        else
        {
            player tell("Missing ammount");
        }
    }
}
doDeposit(player, args)
{
    if (getDvarIntDefault("sv_allowchatbank", 1) == 0)
    {
    }
    else
    {
        if (isDefined(args[1]))
        {
            if (args[1] == "all")
            {
                player.pers["bank"] = player.pers["bank"] + player.score;
                player.score = 0;
                player updateBankValue(player.pers["bank"]);
                player tell("^2$^7" + valueToString(player.score) + " deposited");

            }
            else
            {
                if (isInteger(args[1]) && player.score >= int(args[1]))
                {
                    player.pers["bank"] = int(player.pers["bank"]) + int(args[1]);
                    player.score = player.score - int(args[1]);
                    player updateBankValue(player.pers["bank"]);
                    player tell("^2$^7" + valueToString(args[1]) + " deposited");
                }
                else
                {
                    player tell("Invalid ammount");
                }
            }
        }
        else
        {
            player tell("Missing ammount");
        }
    }
}
doPay(player, args)
{
    if (getDvarIntDefault("sv_allowchatpayments", 1) == 0)
    {
    }
    else if ((isDefined(player.whos_who_effects_active) && player.whos_who_effects_active) || player.fake_death) // Prevent money dupe
    {
        player tell("Command disable during last stand with WhosWho perk");
    }
    else
    {
        if (isDefined(args[1]))
        {
            if (isDefined(args[2]))
            {
                if (isInteger(args[1]))
                {
                    money = int(args[1]);
                    if (player.score >= money)
                    {
                        targetname = args[2];
                        for (i = 3; i < args.size; i++)
                        {
                            targetname = targetname + " " + args[i];
                        }
                        foundTarget = player;
                        foreach (target in level.players)
                        {
                            if (issubstr(target.name, targetname) && foundTarget != player)
                            {
                                foundTarget = target;
                            }
                        }
                        if (foundTarget != player)
                        {
                            player.score = player.score - money;
                            player tell("Paid ^2$^7" + args[1] + " to " + targetname);
                            wait 0.5;
                            foundTarget.score = foundTarget.score + money;
                            wait 0.5;
                            foundTarget tell("Received ^2$^7" + args[1] + " from " + player.name);
                        }
                        else
                        {
                            wait 0.2;
                            foundTarget tell("You ^1can't ^7pay yourself");
                        }
                    }
                    else
                    {
                        player tell("Invalid ammount");
                    }
                }
                else
                {
                    player tell("Invalid ammount");
                }
            }
            else
            {
                player tell("Missing player name");
            }
        }
        else
        {
            player tell("Missing ammount");
        }
    }
}

updateBankValue( value ) // Update bank value into the file
{
    path = "bank/" + self getGuid() + ".txt";

    // Overwrite the bank value
    file = fopen( path, "w" );
    fwrite(file, value + "");
    fclose(file);
}

valueToString(value) // Convert an integer to a better intger rappresentation, like 10025 to 10'025
{
    return value;
    // The conversion generate issue
    /*value = value + "";
    str = "";
    for (i = value.size - 1; i >= 0; i--)
    {
        index = value.size - i - 1;
        str = str + value[index];
        if (i % 3 == 0 && i > 2)
        {
             str = str + "'";
        }
    }
    return str;*/
}


getDvarIntDefault(dvar, value)
{
    if(dvar == "")
        return getDvarInt(dvar);
    else
        return value;
}

isInteger( value ) // Check if the value contains only numbers
{
    new_int = int(value);
    
    if (value != "0" && new_int == 0) // 0 means its invalid
        return 0;
    
    if(new_int > 0)
        return 1;
    else
        return 0;
}
