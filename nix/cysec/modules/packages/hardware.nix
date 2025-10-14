{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    apktool
  ];
}
