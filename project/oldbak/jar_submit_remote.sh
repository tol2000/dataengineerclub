#!/bin/sh

# hdfs://quickstart.cloudera:8020/

#  --driver-memory 1000m \
#  --executor-memory 1000m \
#  --executor-cores 1 \

export HADOOP_CONF_DIR=./sdc-data/hive/conf

~/spark-2.4.4-bin-hadoop2.7/bin/spark-submit \
  --master yarn \
  --deploy-mode cluster \
  --class org.kliusa.otusde201911hex5.jsonreader.JsonProcessor \
  /home/tolic/gitrepo/github/dataengineerclub/project/jsonprocessor/target/scala-2.10/jsonprocessor-assembly-1.jar \
  hdfs://quickstart.cloudera:8020/out/bronze/weather/file_a57c1888-a734-4f59-93bc-accdf30fa92f.json \
  hdfs://quickstart.cloudera:8020/out/test/parquet1
