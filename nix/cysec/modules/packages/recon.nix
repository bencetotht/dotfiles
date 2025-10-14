{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    cloudbrute
    dnsenum
    dnsrecon
    enum4linux
    hping
    masscan
    netcat
    nmap
    ntopng
    sn0int
    sslsplit
    theharvester
    wireshark
    bettercap
    dsniff
    mitmproxy
    rshijack
    sipp
    sniffglue
  ];
}
