{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    sleuthkit
    autopsy
    binwalk
    foremost
    volatility3
    capstone
    ddrescue
    ext4magic
    extundelete
    ghidra-bin
    p0f
    pdf-parser
    binutils
    elfutils
    jd
    jd-gui
    patchelf
    radare2
    radare2-cutter
    retdec
    snowman
    valgrind
    yara
  ];
}
