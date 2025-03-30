{

  programs.plasma = {    
    # Power management settings
    powerdevil = {
      AC = {
        # Never sleep on AC power
        autoSuspend = {
          action = "nothing";
        };
        # Dim display after 5 minutes on AC
        dimDisplay = {
          enable = true;
          idleTimeout = 300; # 5 minutes in seconds
        };
        # Turn off display after 10 minutes on AC
        turnOffDisplay = {
          idleTimeout = 600; # 10 minutes in seconds
        };
      };
      
      battery = {
        # Sleep after 15 minutes on battery
        autoSuspend = {
          action = "sleep";
          idleTimeout = 1200; # 15 minutes in seconds
        };
        # Turn off display after 5 minutes on battery
        turnOffDisplay = {
          idleTimeout = 300; # 5 minutes in seconds
        };
      };
      
      # Optional additional power settings
      batteryLevels = {
        lowLevel = 25;
        criticalLevel = 5;
        criticalAction = "hibernate";
      };
    };
    
    # Screen locking settings
    kscreenlocker = {
      # Enable auto lock
      autoLock = true;
      
      timeout = 15; # This is in minutes
      
      # Optional but recommended screen locking settings
      lockOnResume = true;
      passwordRequired = true;
      passwordRequiredDelay = 0; # Require password immediately
      
      # Optional appearance settings
      appearance = {
        showMediaControls = true;
        alwaysShowClock = true;
      };
    };
  };


}