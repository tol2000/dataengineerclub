#!/bin/sh

export FILEPATH=/out/bronze/weather/file_25ba3a7e-2aec-4b0d-b007-2fd71d40e111.json

/spark/bin/spark-submit \
  --packages org.apache.spark:spark-avro_2.11:2.4.3 \
  --master local[*] \
  --class org.kliusa.otusde201911.project.jsonprocessor.JsonProcessor \
  /data/spark_local/jsonprocessor-assembly-1.jar \
  hdfs://quickstart.cloudera:8020$FILEPATH \
  hdfs://quickstart.cloudera:8020/out/bronze/weather2hive
