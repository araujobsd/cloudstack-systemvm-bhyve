ifconfig tap0 up
ifconfig bridge0 up

echo "Start Grub"
grub-bhyve -m ./device.map -r host -M 2048 -d /z/vms/debian/grub/ Debian

echo "Start VM"
bhyve -A -H -w -c 1 -m 2048 -s 0:0,hostbridge -s 31,lpc -l com1,/dev/nmdm150A -s 3,e1000,tap0,mac=00:a0:98:56:38:b8 -s 4,ahci-hd,/z/vms/debian/debian.raw Debian
