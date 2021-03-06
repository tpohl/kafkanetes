#!/bin/bash -e

PROPERTIES=/deployments/data/tmp/zookeeper/zookeeper.properties

mkdir -p /deployments/data/tmp/zookeeper

echo "# Zookeeper Configuration" > $PROPERTIES
echo $MYID >/deployments/data/tmp/zookeeper/myid
echo 
for ((i=1; i<=$MAXID; i++)); do
  echo server.$i=$PREFIX-$i:2888:3888
done >>$PROPERTIES
cat >>$PROPERTIES <<EOF
quorumListenOnAllIPs=true
tickTime=2000
initLimit=10
syncLimit=5
dataDir=/deployments/data/tmp/zookeeper
# the port at which the clients will connect
clientPort=2181
# disable the per-ip limit on the number of connections since this is a non-production config
maxClientCnxns=0
EOF

echo "properties"
cat $PROPERTIES
echo "MY ID"
cat /deployments/data/tmp/zookeeper/myid

exec bin/zookeeper-server-start.sh $PROPERTIES
