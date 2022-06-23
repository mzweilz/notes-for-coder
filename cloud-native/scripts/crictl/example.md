## Basic
c.json
```
{
    "metadata": {
      "name": "container_d6754d8f_1"
    },
    "image": {
      "image": "centos"
    },
    "command": [
      "/bin/bash"
    ],
    "log_path": "busybox.0.log",
    "linux": {
    }
}
```
s.json
```
{
        "metadata": {
          "name": "ce214491ad544b94a3293f4adcfa3398",
          "namespace": "test_default",
          "attempt": 1,
          "uid": "ce214491ad544b94a3293f4adcfa3398"
        },
        "log_directory": "/tmp",
        "linux": {
          "security_context": {
            "namespace_options": {
              "network": 2
            }
          }
        },
        "annotations": {
          "io.alibaba.pouch.vm.passthru.cpus": "1",
          "io.alibaba.pouch.vm.passthru.memory": "32Gi",
          "io.alibaba.pouch.vm.env.diskquota": "10Gi",
          "io.alibaba.pouch.vm.ulimit.nofile": "98304"
        }
}
```
test.sh
```
#!/bin/bash

cleanupPods(){
    echo ""
    # 删除创建的容器
    echo "===cleanup all containers===="
    sudo crictl ps -a | awk 'NR>1 {print $1}' | while read line; do sudo crictl stop $line; sudo crictl rm $line; done;
    # 删除创建的pod
    echo "===cleanup all pods===="
    sudo crictl pods | awk 'NR>1 {print $1}' | while read line; do sudo crictl stopp $line; sudo crictl rmp $line; done;
    echo ""
}


crictlRunTest(){
    # 创建pod和容器
    echo "===create pod and container===="
    s_json=s1.json # s1.json - #42574169, s.json - no appear
    c_json=c.json
    sid=$(sudo crictl runp -r runc ${s_json})
    cid=$(sudo crictl create $sid ${c_json} ${s_json})
    sudo crictl start $cid
    sudo crictl ps
    echo ""

    # host上新增网卡
    #ip tuntap add name tap0 mode tap
    #ip tuntap add name tap0 mode tap multi_queue
    #ip a | grep tap0
    #ip route
    #ip link show

    echo ""
}

for((i=1;i<=10;i++));
do
    echo "=========================round $i========================"
    cleanupPods
    crictlRunTest

    # 检查日志
    echo "check error..."
    err=$(grep "failed to find link by device" containerd.log)
done

```
