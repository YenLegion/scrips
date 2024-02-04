@echo off

echo Restarting to UEFI...

bcdedit /set {fwbootmgr} bootsequence {bootmgr}
shutdown /r /fw