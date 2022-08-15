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
    for (;;)
    {
        wait 0.05;
        if (getDvarIntDefault("sv_shieldbounces", 0) && isDefined(self.riotshieldretrievetrigger) && isDefined(self.riotshieldentity))
        {
            self.canBounce = 1;
            level thread Bounce(self.origin + (0, 0, 50), 25, self getxuid());
        }
        else if (!isDefined(self.riotshieldretrievetrigger) && !isDefined(self.riotshieldentity))
        {
            level notify(self getxuid());
        }
    }
}
onPlayerDisconnect()
{
    self waittill("disconnect");
    if (self.riotshieldretrievetrigger)
    {
        level notify(self getguid());
    }
}

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
    self.canBounce = 0;
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
    return 0;
}
