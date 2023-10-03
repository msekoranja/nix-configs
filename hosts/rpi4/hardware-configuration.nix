{
  # TODO filesystems, boot?

  hardware = {
    raspberry-pi."4".apply-overlays-dtmerge.enable = true;
    deviceTree = {
      enable = true;
      filter = "*rpi-4-*.dtb";
    };
  };

  console.enable = false;

  environment.systemPackages = with pkgs; [
    libraspberrypi
    raspberrypi-eeprom
  ];

  # GPU support
  #hardware.raspberry-pi."4".fkms-3d.enable = true;

  # Audio support
  #sound.enable = true;
  #hardware.pulseaudio.enable = true;
  #hardware.raspberry-pi."4".audio.enable = true;
}
