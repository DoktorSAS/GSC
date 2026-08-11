#include maps\mp\gametypes\_menus;

init()
{
    game["strings"]["change_class"] = "";
}

main()
{
    replaceFunc(maps\mp\gametypes\_menus::watchforclasschange, ::watchforclasschange);
}

watchforclasschange()
{
    self endon( "disconnect" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "luinotifyserver", menu, class );

        if ( menu != "class_select" )
            continue;

        if ( getdvarint( "systemlink" ) && getdvarint( "xblive_competitionmatch" ) && self ismlgspectator() )
        {
            self setclientomnvar( "ui_options_menu", 0 );
            continue;
        }

        var_2 = isai( self ) || issubstr( self.name, "tcBot" );

        if ( !var_2 )
        {
            if ( !isai( self ) && "" + class != "callback" )
                self setclientomnvar( "ui_loadout_selected", class );
        }

        if ( isdefined( self.waitingtoselectclass ) && self.waitingtoselectclass )
            continue;

        if ( !maps\mp\_utility::allowclasschoice() || maps\mp\_utility::showfakeloadout() )
            continue;

        if ( "" + class != "callback" )
        {
            if ( isdefined( self.pers["isBot"] ) && self.pers["isBot"] )
            {
                self.pers["class"] = class;
                self.class = class;
            }
            else
            {
                classIndex = class + 1;
                classIndex = getclasschoice( classIndex );

                if ( !isdefined( self.pers["class"] ) || classIndex == self.pers["class"] )
                    continue;

                self.pers["class"] = classIndex;
                self.class = classIndex;

                //if ( level.ingraceperiod && !self.hasdonecombat )
                //{
                    maps\mp\gametypes\_class::setclass( self.pers["class"] );
                    self.tag_stowed_back = undefined;
                    self.tag_stowed_hip = undefined;
                    maps\mp\gametypes\_class::giveloadout( self.pers["team"], self.pers["class"] );
                //}
                //else if ( isalive( self ) )
                //    self iprintlnbold( game["strings"]["change_class"] );
            }

            continue;
        }

        menuclass( "callback" );
    }
}