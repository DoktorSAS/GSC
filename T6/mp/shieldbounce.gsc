#include maps\mp\_utility;
#include common_scripts\utility;

/*
    Mod: Ritoshield Bounces
    Developed by DoktorSAS


    Copyright: The script was created by DoktorSAS and no one else can
               say they created it. The script is free and accessible to
               everyone, it is not possible to sell the script.
*/

init()
{
    _setDvarIfNotUnizialized("sv_enablebounces", 1);
    level.isDepatcedBounceON = getDvarInt("sv_enablebounces");
    level thread onPlayerConnect();
}

_setDvarIfNotUnizialized(dvar, value)
{
    if (getDvar(dvar) == "")
        setDvar(dvar, value);
}

onPlayerConnect()
{
    for (;;)
    {
        level waittill("connected", player);
        player thread onPlayerDisconnect();
        player thread onRiotShield();
    }
}
onRiotShield()
{
    self endon("disconnect");
    level endon("game_ended");
    self.riotshield = [];
    self.riotshield["status"] = 0;
    self.riotshield["type"] = level.isDepatcedBounceON;
    for (;;)
    {
        wait 0.05;
        if (isDefined(self.riotshieldretrievetrigger) && isDefined(self.riotshieldentity) && !self.riotshield["status"])
        {
            self.riotshield["status"] = 1;
            self.canBounce = 1;
            if (level.isDepatcedBounceON)
                level thread DepeatchedBounce(self.origin + (0, 0, 50), 25, self getxuid());
            else
                level thread Bounce(self.origin + (0, 0, 50), 25, self getxuid());
        }
        else if (!isDefined(self.riotshieldretrievetrigger) && !isDefined(self.riotshieldentity) && self.riotshield["status"])
        {
            self.riotshield["status"] = false;
            level notify(self getxuid());
        }
    }
}
onPlayerDisconnect() // This function is to disable bounce when player disconnect (It should not be necessary)
{
    self waittill("disconnect");
    if (self.riotshield["status"])
        level notify(self getguid());
}

/*
    When there No Depatched Bounce the velocity is differnet, thats why there 2 bounces functions
    if something go wrong just change the number (INT) in the NegateBounceDepatched function
*/
DepeatchedBounce(bounceOrigin, range, guid)
{
    level endon("game_ended");
    level endon(guid);
    for (;;)
    {
        foreach (player in level.players)
        {
            if (!player isOnGround())
            {
                player.vel = player GetVelocity();
                if (player isInPosition(bounceOrigin, range) && player.vel[2] < 0 && !player isOnGround())
                {
                    player.newVel = (player.vel[0], player.vel[1], NegateBounce(player.vel[2]));
                    player SetVelocity(player.newVel);
                }
            }
        }
        wait .01;
    }
}
playerDepatchedBounce()
{
    level endon("game_ended");
    self.canBounce = false;
    wait 1;
    self.canBounce = 1;
}
NegateBounceDepatched(vector)
{                                          // Credits go to CodJumper.
    negative = vector - (vector * 80.125); // Change the number there if something go wrong
    return (negative);
}
/*
    When there Depatched Bounce the velocity is differnet, thats why there 2 bounces functions
    if something go wrong just change the number (INT) in the NegateBounce function
*/
Bounce(bounceOrigin, range, guid)
{
    level endon("game_ended");
    level endon(guid);
    for (;;)
    {
        foreach (player in level.players)
        {
            if (!player isOnGround())
            {
                player.vel = player GetVelocity();
                if (player isInPosition(bounceOrigin, range) && player.vel[2] < 0 && !player isOnGround())
                {
                    player.newVel = (player.vel[0], player.vel[1], NegateBounceDepatched(player.vel[2]));
                    player SetVelocity(player.newVel * 2);
                }
            }
        }
        wait .01;
    }
}
playerBounce()
{
    level endon("game_ended");
    self.canBounce = false;
    wait 1;
    self.canBounce = 1;
}

NegateBounce(vector) // Credits go to CodJumper.
{
    negative = vector - (vector * 2); // Change the number there if something go wrong
    return (negative);
}

isInPosition(sP, range)
{
    if (distance(self.origin, sP) < range)
        return 1;
    return false;
}
