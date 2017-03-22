#!/bin/bash -e

PROPERTIES=$1
PREFIX=$2
MYID=$3
MAXID=$4

echo $MYID >/data/deployments/tmp/zookeeper/myid
for ((i=1; i<=$MAXID; i++)); do
  echo server.$i=$PREFIX-$i:2888:3888
done >>$PROPERTIES
cat >>$PROPERTIES <<EOF
quorumListenOnAllIPs=true
tickTime=2000
initLimit=10
syncLimit=5
dataDir=/data/deployments/tmp/zookeeper
# the port at which the clients will connect
clientPort=2181
# disable the per-ip limit on the number of connections since this is a non-production config
maxClientCnxns=0
EOF

exec bin/zookeeper-server-start.sh $PROPERTIES
