#!/bin/sh

~/spark-2.4.4-bin-hadoop2.7/bin/spark-submit \
  --master local[*] \
  --class org.kliusa.otusde201911hex5.jsonreader.JsonProcessor \
  /home/tolic/gitrepo/github/dataengineerclub/project/jsonprocessor/target/scala-2.11/jsonprocessor-assembly-1.jar \
  /home/tolic/gitrepo/github/dataengineerclub/project/sdc-data/out/bronze/weather/file_50ab416c-97aa-4c1e-b5d4-49e95a34f4c8.json \
  /home/tolic/gitrepo/github/dataengineerclub/project/sdc-data/out/test/parquet1
