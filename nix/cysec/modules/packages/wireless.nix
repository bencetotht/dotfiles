{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    aircrack-ng
    reaver
    kismet
    wavemon
  ];
}
