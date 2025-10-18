{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    hashcat
    john
    gpg
    openssl
  ];
}
