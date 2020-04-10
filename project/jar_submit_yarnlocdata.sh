#!/bin/sh

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
  /media/shared_from_local/out/file_50ab416c-97aa-4c1e-b5d4-49e95a34f4c8.json \
  /media/shared_from_local/out/parquet1
