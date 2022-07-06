## run
```
/disk1/qemu/build/x86_64-softmmu/qemu-system-x86_64 -machine pc,accel=kvm,kernel_irqchip=on,nvdimm=on -cpu host -m 8G,slots=2,maxmem=100G -smp 2,sockets=1,cores=2,threads=1 -numa node,nodeid=0,cpus=0-1,memdev=mem1 -object memory-backend-file,id=mem1,size=8G,mem-path=/dev/shm,share=on -kernel /disk1/kernel/arch/x86/boot/bzImage -append 'tsc=reliable no_timer_check rcupdate.rcu_expedited=1 i8042.direct=1 i8042.dumbkbd=1 i8042.nopnp=1 i8042.noaux=1 noreplace-smp reboot=k console=hvc0 console=hvc1 cryptomgr.notests net.ifnames=0 root=/dev/pmem0 rootflags=dax,data=ordered,errors=remount-ro rw rootfstype=ext4 quiet systemd.show_status=false panic=1 nr_cpus=96 cgwb_v1' -no-user-config -nodefaults -object memory-backend-file,id=mem0,share=on,mem-path=./debian_testing.img,size=21474836480 -device virtio-pmem-pci,memdev=mem0,id=nv0 -device virtio-serial-pci,id=virtio-serial0 -chardev socket,id=charconsole0,path=/run/serial.sock,wait=off,server=on -device virtconsole,chardev=charconsole0,id=console0 -nographic -qmp unix:/tmp/qemu,server,nowait -device virtio-blk-pci,scsi=off,drive=drive-virtio-disk1,id=virtio-dsk1,num-queues=4,iothread=iothread0,queue-size=128 -drive file=/dev/nullb0,if=none,id=drive-virtio-disk1,cache=none -object iothread,id=iothread0 -netdev tap,ifname=tap3,id=hostnet0,downscript=no,vhost=on,queues=3 -device virtio-net-pci,netdev=hostnet0,id=vent0,mac=aa:6f:1d:0e:26:37,vectors=8,event_idx=off,mq=on
```

```
IMAGE=/home/root/aliyun_2_1903_x64_20G_nocloud_alibase_20220525.qcow2
BZKERNEL=/disk1/kernel/arch/x86/boot/bzImage
sudo src/gitlab.com/qemu/build/qemu-system-x86_64 \
	-kernel $BZKERNEL \
	-append "console=ttyS0 quiet=1 root=/dev/vda1 rw vsyscall=emulate panic=1 reboot=k nokaslr" \
    -drive id=rootfs,file="$IMAGE",format=qcow2,if=none,cache=none \
    -device virtio-blk-pci,scsi=off,num-queues=1,config-wce=off,vectors=2,bus=pci.0,addr=0x3,drive=rootfs,id=virtio-disk0,bootindex=1 \
    -device virtio-net-pci,netdev=tap1 \
    -netdev tap,id=tap1,script=no,downscript=no \
    -chardev socket,path=/tmp/qga.sock,server,nowait,id=qga0 \
    -device virtio-serial \
    -device virtserialport,chardev=qga0,name="org.qemu.guest_agent.0" \
    -device virtio-rng-pci \
	-nographic \
	-smp 2 \
	-machine dump-guest-core=on \
	-m 8192 \
	-qmp tcp:localhost:4444,server,nowait

```

## qmp
```
$(qmp)
{"execute":"qmp_capabilities"}
{"execute":"dump-guest-memory","arguments":{"paging":false,"protocol":"file:/home/root/qmp-vmocre","format":"kdump-zlib"}}
{"execute":"quit"}
```
