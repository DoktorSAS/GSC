#include common_scripts\utility;
#include maps\_utility;

/*
    Mod: Black ops I and Black ops II chat bank
    Developed by @DoktorSAS

    IMPORTANT:
    The code do not work it is a base code for the chatbank ported from T6 to T5.
    Don't consider this code as working.

    Requirements:
        t5-gsc-utils.dll for Black ops I
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
        self waittill("say", message, hidden);
        message = toLower(message);
        if(!level.intermission && message[0] == ".")
        {
            args = strtok(message, " ");
            command = getSubStr(args[0], 1);
            switch(command) {
                case "deposit":
                case "d":
                    if( getDvarIntDefault("sv_allowchatbank", 1) == 0){ }
                    else
                        if(isDefined(args[1]))
                        {
                            if(args[1] == "all")
                            {
                                self.pers["bank"] = self.pers["bank"] + self.score;
                                self.score = 0;
                                self updateBankValue(self.pers["bank"]);
                                self tell("^2$^7" + valueToString(self.score) + " deposited");
                            }
                            else
                            {
                                if(isInteger(args[1]) && player.score >= int(args[1]))
                                {
                                    self.pers["bank"] = int(self.pers["bank"]) + int(args[1]);
                                    self.score = self.score - int(args[1]);
                                    self updateBankValue(self.pers["bank"]);
                                    self tell("^2$^7" + valueToString(args[1]) + " deposited");
                                }
                                else
                                {
                                    self tell("Invalid ammount");
                                }
                            }
                        }
                        else
                        {
                            self tell("Missing ammount");
                        }

                    break;
            
                case "withdraw":
                case "w":
                    if( getDvarIntDefault("sv_allowchatbank", 1) == 0 ){ }
                    else
                        if(isDefined(args[1]))
                        {
                            if(args[1] == "all")
                            {
                                self.pers["bank"] = 0;
                                self.score = self.score + self.pers["bank"];
                                self updateBankValue( 0 );
                                self tell("^2$^7" + valueToString(self.pers["bank"]) + " withdrawn");
                            }
                            else
                            {
                                if(isInteger(args[1]) && self.pers["bank"] >= int(args[1]))
                                {
                                    self.pers["bank"] = int(self.pers["bank"]) - int(args[1]);
                                    self.score = self.score + int(args[1]);
                                    self updateBankValue( self.pers["bank"] );
                                    self tell("^2$^7" + valueToString(args[1]) + " withdrawn");
                                }
                                else
                                {
                                    self tell("Invalid ammount");
                                }
                            }
                        }
                        else
                        {
                            self tell("Missing ammount");
                        }

                    break;
            
                case "balance":
                case "b":
                case "money":
                    self tell("Your balance is ^2$^7" + valueToString(self.pers["bank"]) );
                    break;
                case "p":
                case "pay":
                    if( getDvarIntDefault("sv_allowchatpayments", 1) == 0 ) { }
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
                                        if(issubstr(self.name, target.name))
                                        {
                                            self.score -= int(args[1]);
                                            target.score += int(args[1]);
                                            self tell("Paid ^2$^7" + args[1] + " to " + targetname);
                                        }
                                    }
                                }
                                else
                                {
                                    self tell("Invalid ammount");
                                }
                            }
                            else
                            {
                                self tell("Missing player name");
                            }
                        }
                        else
                        {
                            self tell("Missing ammount");
                        }
                break;
            }
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

valueToString( value ) // Convert an integer to a better intger rappresentation, like 10025 to 10'025
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

isInteger( value ) // Check if the value contains only numbers
{
    new_int = int(value);
    
    if (value != "0" && new_int == 0) // 0 means its invalid
        return 0;
    
    return 1;
}
