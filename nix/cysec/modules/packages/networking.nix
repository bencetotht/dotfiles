{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wireshark
    tcpdump
    nmap
    netcat
    socat
    traceroute
    ettercap
  ];
}
