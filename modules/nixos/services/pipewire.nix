{ ... }: {
  services.pipewire = {
    enable = true;
    pulse.enable = true; # PulseAudio compatibility

    audio.enable = true; # Explicitly set
    wireplumber.enable = true; # Explicitly set
  };
}
