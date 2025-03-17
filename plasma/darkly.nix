{ config, ... }:

{
  programs.plasma.configFile = {
    darklyrc = {
      Common.CornerRadius.value = 8;
      Style = {
        AdjustToDarkThemes.value = true;
        DolphinSidebarOpacity.value = 50;
        MenuOpacity.value = 80;
        TabBGColor.value = "0,0,0,50";
        TabUseHighlightColor.value = true;
        # Additional customization options
        MenuBarOpacity.value = 90;
        MenuOpacity.value = 80;
        ToolTipOpacity.value = 90;
        ScrollBarOpacity.value = 70;
        ScrollBarWidth.value = 12;
        ScrollBarGrooveOpacity.value = 50;
        ScrollBarButtonOpacity.value = 70;
        ScrollBarButtonIconOpacity.value = 100;
        ScrollBarButtonHoverOpacity.value = 90;
        ScrollBarButtonPressedOpacity.value = 100;
        ScrollBarSliderOpacity.value = 70;
        ScrollBarSliderHoverOpacity.value = 90;
        ScrollBarSliderPressedOpacity.value = 100;
        ScrollBarAddLineOpacity.value = 70;
        ScrollBarSubLineOpacity.value = 70;
        ScrollBarAddLineHoverOpacity.value = 90;
        ScrollBarSubLineHoverOpacity.value = 90;
        ScrollBarAddLinePressedOpacity.value = 100;
        ScrollBarSubLinePressedOpacity.value = 100;
        ScrollBarAddPageOpacity.value = 70;
        ScrollBarSubPageOpacity.value = 70;
        ScrollBarAddPageHoverOpacity.value = 90;
        ScrollBarSubPageHoverOpacity.value = 90;
        ScrollBarAddPagePressedOpacity.value = 100;
        ScrollBarSubPagePressedOpacity.value = 100;
      };
    };
    kdeglobals.KDE.widgetStyle.value = "Darkly";
  };
} 