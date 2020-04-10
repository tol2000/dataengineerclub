#!/bin/sh

# hdfs://quickstart.cloudera:8020/

#  --driver-memory 1000m \
#  --executor-memory 1000m \
#  --executor-cores 1 \

export HADOOP_CONF_DIR=/media/shared_from_local/hive/conf

spark-submit \
  --master yarn \
  --deploy-mode cluster \
  --queue thequeue \
  --class org.kliusa.otusde201911hex5.jsonreader.JsonProcessor \
  /media/shared_from_local/jsonprocessor-assembly-1.jar \
  hdfs://quickstart.cloudera:8020/out/bronze/weather/file_a57c1888-a734-4f59-93bc-accdf30fa92f.json \
  hdfs://quickstart.cloudera:8020/out/test/parquet1
