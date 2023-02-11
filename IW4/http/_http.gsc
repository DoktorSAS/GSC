/*
    Mod: _http.gsc
    Developed by DoktorSAS

    Description:
    The mod allow the server to connect the client to the otuside to make http request to website.
*/
init()
{
    net_port = getDvar("net_port"); // Handle the request of the current server, its used to support multiple servers

    // Junks files just to generate the folders. They will not be considered by the python script
    FileWrite(net_port + "/requests/junk.txt", "generate folder if missing", "write");
    FileWrite(net_port + "/responses/junk.txt", "generate folder if missing", "write");

    level thread onPlayerConnect();
    level thread notifyResponses(); // Needed to handle the requests
    level thread onEndGame();
}

isentityabot()
{
    return (isSubStr(self.guid, "bot"));
}

onEndGame()
{
    net_port = getDvar("net_port");
    level waittill("game_ended"); // Clean up on endgame/endround
    foreach (player in level.players)
    {
        if (!player isentityabot())
        {
            r_id = player.guid + "_" + player._requests;
            if (FileExists(net_port + "/responses/" + r_id))
            {
                FileRemove(net_port + "/responses/" + r_id);
            }

            if (FileExists(net_port + "/requests/" + r_id))
            {
                FileRemove(net_port + "/requests/" + r_id);
            }
            player._response delete ();
        }
    }
}

notifyResponses()
{
    level endon("game_ended");
    for (;;)
    {
        foreach (player in level.players)
        {
            if (!player isentityabot())
            {
                net_port = getDvar("net_port");
                r_id = player.guid + "_" + player._requests;
                if (FileExists(net_port + "/responses/" + r_id)) // Check if the response got generated
                {
                    player notify("done", 1, FileRead(net_port + "/responses/" + r_id));           // To support 'self waittill("done", success, content);'
                    player._response notify("done", 1, FileRead(net_port + "/responses/" + r_id)); // to support 'req = httpRequest("doktorsas.xyz"); req waittill("done", success, content);'
                    player._requests++;
                    player._response.request = undefined;
                    FileRemove(net_port + "/responses/" + r_id);
                }
            }
        }
        wait 0.05;
    }
}

httpRequestHandle(player, id) // If there no response it will send failed as response
{
    level endon("game_ended");
    player endon("disconnect");
    player._response endon("done");
    wait 15;
    net_port = getDvar("net_port");
    r_id = player.guid + "_" + id;
    if (player._requests == id)
    {
        if (FileExists(net_port + "/requests/" + r_id))
        {
            FileRemove(net_port + "/requests/" + r_id);
        }
        player notify("done", 0, "failed");
        player._response notify("done", 0, "failed");
        player._requests++;
        player._response.request = undefined;
    }
}

httpRequest(data)
{
    net_port = getDvar("net_port");
    while (isDefined(self._response.request)) // Allow one request at the time, prevent flood of requets
    {
        wait 0.05;
    }

    // Check for duplicated request and responses
    r_id = self.guid + "_" + self._requests;
    if (FileExists(net_port + "/responses/" + r_id))
    {
        FileRemove(net_port + "/responses/" + r_id);
    }

    if (FileExists(net_port + "/requests/" + r_id))
    {
        FileRemove(net_port + "/requests/" + r_id);
    }

    r_id = self.guid + "_" + self._requests;
    FileWrite(net_port + "/requests/" + r_id, data, "write");
    self._response.request = self._requests;
    thread httpRequestHandle(self, self._requests);
    return self._response;
}

handleHttpResponses()
{
    level endon("game_ended");
    self endon("disconnect");
    for (;;)
    {
        self waittill("done", success, content);
        // self iPrintLnBold(content);
    }
}

onPlayerConnect()
{
    once = 1;
    for (;;)
    {
        level waittill("connected", player);
        if (!player isentityabot())
        {
            player._requests = 0; // Counter used to know how many request get sended for each client (could be used for debug)
            player._response = spawnStruct();
            player thread onPlayerDisconnect();

            // Exemple of usage
            /*
                player thread onPlayerSpawned();
                player thread handleHttpResponses();
            */
        }
    }
}

onPlayerDisconnect() // Clear the folders of useless requests
{
    self waittill("disconnect");
    self._response delete ();
    net_port = getDvar("net_port");
    r_id = self.guid + "_" + self._requests;
    if (FileExists(net_port + "/responses/" + r_id))
    {
        FileRemove(net_port + "/responses/" + r_id);
    }

    if (FileExists(net_port + "/requests/" + r_id))
    {
        FileRemove(net_port + "/requests/" + r_id);
    }
}
// Exemple of usage
/*
    onPlayerSpawned()
    {
        level endon("game_ended");
        for (;;)
        {
            self waittill("spawned_player");
            req = httpRequest("https://doktorsas.xyz");
            req waittill("done", success, content);
            self iPrintLnBold("^1"+content);
        }
    }
*/
