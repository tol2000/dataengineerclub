#!/bin/sh

# There was problems with --packages org.apache.spark:spark-avro_2.12:2.4.4 \
# So after a long time googling I found --packages org.apache.spark:spark-avro_2.11:2.4.3
# https://issues.apache.org/jira/browse/SPARK-27623

/spark/bin/spark-submit \
  --packages org.apache.spark:spark-avro_2.11:2.4.3 \
  --master local[*] \
  --class org.kliusa.otusde201911.project.jsonprocessor.JsonProcessor \
  /data/spark_local/jsonprocessor-assembly-1.jar \
  hdfs://quickstart.cloudera:8020$FILEPATH \
  hdfs://quickstart.cloudera:8020/out/bronze/weather2hive
