{
  imports = [
    ./nixos/secrets/secrets.nix
    ./nixos/base/base.nix
    ./nixos/boot/boot.nix
    ./nixos/net/net.nix
    ./nixos/ssh/ssh.nix
    ./nixos/locale/locale.nix
    ./nixos/audio/audio.nix
    ./nixos/gaming/gaming.nix
    ./pkgs/system-packages.nix
  ];
}
