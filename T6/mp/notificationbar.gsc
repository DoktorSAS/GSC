#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

init()
{
    precacheshader("menu_background_fade");
}

NotificationBannerNotificate(text, time)
{
    self.text hideelem();
    padding = [[self.calcPadding]](text, self.text.fontscale);
    self.text.x = self.startTextX + padding;
    self.text showelem();

    self.text setTextUnlimited(text);
    
    self.text moveOverTime(time);
    self.text.x = self.endTextX - padding;
}

NotificationBannerPadding(text, fontscale)
{
    padding = 0;
    if(text.size >= 20)
    {
        padding = (fontscale) * text.size;
    }
    return padding;
}

CreateNotificationBanner(id, shader, x, y, height, font, fontscale)
{
    banner = spawnstruct();

    banner.background = DrawShader(shader, x, -16, 1000, 25, undefined, 1, 2, "TOP", undefined, 1);

    banner.startTextX = banner.background.x + 500;
    banner.endTextX = banner.background.x - 500;

    banner.text = createServerFontString(font, fontscale);
    banner.text setPoint("TOP", undefined, banner.startTextX, banner.background.y/1.8 - fontscale);
    banner.text.sort = 999;

    banner.calcPadding = ::NotificationBannerPadding;
    banner.notificate = ::NotificationBannerNotificate;

    return banner;
}

exemple_of_usage()
{
    banner = CreateNotificationBanner("test_ads", "menu_background_fade", -16, 25, "objective", 1.4);
    
    textAnimationTime = 10;
    banner [[banner.notificate]]("Consider supporting with a donation at ^8patreon.com/^3DoktorSAS", textAnimationTime);
    wait textAnimationTime;
    banner [[banner.notificate]]("Follow me on my socials at @^3DoktorSAS", textAnimationTime);
    wait textAnimationTime;
    banner.background destroyElem();
    banner.text destroyElem();
}
