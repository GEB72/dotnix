{ ... }:
{
  # Enable pipewire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Adjust latency
  services.pipewire.extraConfig.pipewire."92-low-latency" = {
    "context.properties" = {
      "default.clock.rate" = 48000;
      "default.allowed-rates" = [
        44100
        48000
      ];
      "default.clock.quantum" = 128;
      "default.clock.min-quantum" = 32;
      "default.clock.max-quantum" = 256;
      "default.clock.quantum-limit" = 256;
    };
  };

  # Fix audio popping
  services.pipewire.wireplumber.extraConfig."99-low-latency" = {
    "monitor.alsa.rules" = [
      {
        matches = [
          {
            "node.name" = "alsa_output.*";
          }
        ];
        actions = {
          update-props = {
            "session.suspend-timeout-seconds" = 0;
            "device.profile" = "pro-audio";
          };
        };
      }
    ];
  };

  # Enable musnix for realtime audio
  musnix = {
    enable = true;
    alsaSeq.enable = true;
  };
}
