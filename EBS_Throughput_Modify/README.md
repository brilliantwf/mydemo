## 修改EBS吞吐

EBS 在启动时选择大吞吐可以显著提升数据加载速度,尤其在ML训练场景加载模型,Pull Image等

此脚本用于在EC2启动后,等待一段时间后将EBS 吞吐修改为指定值,用以降低成本.

Arch:

EC2 booting(running) --> Eventbridge rule  --> Stepfunction (with Timer) --> Lambda

部署时需要指定:

1. TimerDuration 等待的时间
2. ModifiedThroughputValue 期望修改到的吞吐值
3. ThresholdThroughputValue 修改动作的EBS的阈值(如果在此值之下则不会触发修改动作)