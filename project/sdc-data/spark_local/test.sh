#!/bin/sh

export FILEPATH=/out/bronze/weather/file_470dea81-2cba-4fb2-85a3-07d191430696.json

/spark/bin/spark-submit \
  --packages org.apache.spark:spark-avro_2.11:2.4.3 \
  --master local[*] \
  --class org.kliusa.otusde201911.project.jsonprocessor.JsonProcessor \
  /data/spark_local/jsonprocessor-assembly-1.jar \
  hdfs://quickstart.cloudera:8020$FILEPATH \
  hdfs://quickstart.cloudera:8020/out/bronze/weather2hive
