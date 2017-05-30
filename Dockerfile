FROM registry.access.redhat.com/redhat-openjdk-18/openjdk18-openshift

RUN mkdir -p $JAVA_DATA_DIR/opt/kafka \
  && cd $JAVA_DATA_DIR/opt/kafka \
  && curl -s  http://www.mirrorservice.org/sites/ftp.apache.org/kafka/0.10.0.0/kafka_2.11-0.10.0.0.tgz | tar -xz --strip-components=1 
COPY zookeeper-server-start-multiple.sh $JAVA_DATA_DIR/opt/kafka/bin/


#RUN chmod -R a=u $JAVA_DATA_DIR/opt/kafka
WORKDIR $JAVA_DATA_DIR/opt/kafka
VOLUME /tmp/kafka-logs /tmp/zookeeper
EXPOSE 2181 2888 3888 9092
