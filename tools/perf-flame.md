# 火焰图
```
git clone https://github.com/brendangregg/FlameGraph
cd FlameGraph
perf record -a -F 999 -g -p 19660
perf script > out.perf
./stackcollapse-perf.pl out.perf > out.folded
./flamegraph.pl out.folded > kernel.svg
```

unmangle
```
wget http://alinux-oss.oss-cn-hangzhou-zmf.aliyuncs.com/test%2Frust-unmangle
mv test%2Frust-unmangle rust-unmangle
chmod +x rust-unmangle

perf record -a -g -p 111342
perf script | ./stackcollapse-perf.pl | ./rust-unmangle | ./flamegraph.pl > perf.svg
```
