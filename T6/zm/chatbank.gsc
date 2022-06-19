#include common_scripts\utility;
#include maps\_utility;

/*
    Mod: Black ops I and Black ops II chat bank
    Developed by @DoktorSAS

    Requirements:
        t6-gsc-utils.dll for Black ops II 
*/
init()
{
    level thread onPlayerConnect();
    level thread onPlayerSay();
}

updateBankValue( value )
{
    path = "bank/" + self getGuid() + ".txt";

    // Overwrite the bank value
    file = fopen( path, "w" );
    fwrite(file, value + "");
    fclose(file);

}

valueToString( value )
{
    str = "";
    for(i = value.size-1; i >= 0; i--)
    {
        str = str + value[ value.size-i-1 ];
        if( i%3==0 && i > 2)
            str = str + "'";
    }
    return str;
}

getDvarIntDefault(dvar, value)
{
    if(dvar == "")
        return value;
    else
        return getDvarInt(dvar);
}
onPlayerSay()
{
    level endon("end_game");

   
    prefix = ".";
    for (;;)
    {
        level waittill("say", message, player);
        message = toLower(message);
        if(!level.intermission && message[0] == ".")
        {
            args = strtok(message, " ");
            command = getSubStr(args[0], 1);
            switch(command) {
                case "deposit":
                case "d":
                    if( getDvarIntDefault("sv_allowchatbank", 1) == 0)
                    {
                       
                    }
                    else
                        if(isDefined(args[1]))
                        {
                            if(args[1] == "all")
                            {
                                player.pers["bank"] = player.pers["bank"] + player.score;
                                player.score = 0;
                                player updateBankValue(player.pers["bank"]);
                                player tell("^2$^7" + valueToString(player.score) + " deposited");
                            }
                            else
                            {
                                if(isInteger(args[1]) && player.score >= int(args[1]))
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

                    break;
            
                case "withdraw":
                case "w":
                    if( getDvarIntDefault("sv_allowchatbank", 1) == 0 )
                    {
                        
                    }
                    else
                        if(isDefined(args[1]))
                        {
                            if(args[1] == "all")
                            {
                                player.pers["bank"] = 0;
                                player.score = player.score + player.pers["bank"];
                                player updateBankValue( 0 );
                                player tell("^2$^7" + valueToString(player.pers["bank"]) + " withdrawn");
                            }
                            else
                            {
                                if(isInteger(args[1]) && player.pers["bank"] >= int(args[1]))
                                {
                                    player.pers["bank"] = int(player.pers["bank"]) - int(args[1]);
                                    player.score = player.score + int(args[1]);
                                    player updateBankValue( player.pers["bank"] );
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

                    break;
            
                case "balance":
                case "b":
                case "money":
                    player tell("Your balance is ^2$^7" + valueToString(player.pers["bank"]) );
                    break;
                case "p":
                case "pay":
                    if( getDvarIntDefault("sv_allowchatpayments", 1) == 0 )
                    {
                        
                    }
                    else
                        if(isDefined(args[1]))
                        {
                            if(isDefined(args[2]))
                            {
                                if(isInteger(args[1]))
                                {
                                    targetname = args[2];
                                    for(i = 3; i < args.size;i++)
                                    {
                                        targetname = targetname + " " + args[i];
                                    }
                                    foreach(target in level.players) 
                                    {
                                        if(issubstr(player.name, target.name))
                                        {
                                            player.score -= int(args[1]);
                                            target.score += int(args[1]);
                                            player tell("Paid ^2$^7" + args[1] + " to " + targetname);
                                            break;
                                        }
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
                break;
            }
        }
    }
}

onPlayerConnect()
{
    for (;;)
    {
        level waittill("connecting", player);
        player thread setupBank();
    }
}

setupBank()
{
    self endon("disconnect");
    level endon("game_ended");
    
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
        file = fopen(path, "a");
        fwrite(file, "0");
        fclose(file);
        self.pers["bank"] = 0;
    }
    else
    {
        self.pers["bank"] = readFile(path);
    }
}

isInteger( value )
{
    for(i = 0; i < value.size; i++)
    {
        if(value[ i ] != "0"
            && value[ i ] != "1"
            && value[ i ] != "2"
            && value[ i ] != "3"
            && value[ i ] != "4"
            && value[ i ] != "5"
            && value[ i ] != "6"
            && value[ i ] != "7"
            && value[ i ] != "8"
            && value[ i ] != "9")
            return 0;
    }
    return 1;
}
