#!/bin/sh

# hdfs://quickstart.cloudera:8020/

export HADOOP_CONF_DIR=./sdc-data/hive/conf

~/spark-2.4.4-bin-hadoop2.7/bin/spark-submit \
  --master yarn \
  --deploy-mode cluster \
  --driver-memory 100m \
  --executor-memory 100m \
  --executor-cores 1 \
  --queue thequeue \
  --class org.kliusa.otusde201911hex5.jsonreader.JsonProcessor \
  /home/tolic/gitrepo/github/dataengineerclub/project/jsonprocessor/target/scala-2.11/jsonprocessor-assembly-1.jar \
  hdfs://quickstart.cloudera:8020/out/bronze/weather/file_a57c1888-a734-4f59-93bc-accdf30fa92f.json \
  hdfs://quickstart.cloudera:8020/out/test/parquet1
