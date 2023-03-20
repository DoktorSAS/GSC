init()
{
    addCommand(0, "guid", ::printGuid);
    addCommand(0, "test", ::printTest);
    level thread commandListner();
}

printGuid()
{
    self tell("Guid:" + self.guid);
}
printTest( message )
{
    self tell( message );
}

addCommand( role, command, invoke, args)
{
    if(!isDefined(level.commands))
    {
        level.commands = [];
    }

    if(!isDefined(level.commands[command])) // Check command overwrite
    {
        level.commands[command] = spawnStruct();
        level.commands[command].invoke= invoke;
        level.commands[command].args = args;
        level.commands[command].role = role;
    }
}

commandListner()
{
    self endon("game_ended"); // mp
    self endon("end_game"); // zm
    for(;;)
    {
        level waittill("say", message, player);
        if(isDefined(level.commands[command]) 
            && isDefined(player.role) && player.role >= level.commands[command].role) 
        {
            player [[level.commands[command].invoke]]( level.commands[command].args );
        }
        else
        {
            player tell("Unknown command");
        }      
    }
}
