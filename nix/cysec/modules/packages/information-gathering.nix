{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nmap
    whois
    dnsutils
    theharvester
    whatweb
    wafw00f
    nikto
    dirb
    subfinder
  ];
}
