{ config, lib, pkgs, ... }: {
  programs.plasma.configFile.kwinrc = {
    Effect-blur = {
      BlurStrength.value = 8;
      NoiseStrength.value = 0;
    };
    Effect-forceblur = {
      BlurStrength.value = 8;
      NoiseStrength.value = 0;
    };
    Plugins = {
      blurEnabled.value = true;
      forceblurEnabled.value = true;
    };
  };
}