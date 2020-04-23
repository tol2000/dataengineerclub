#!/bin/sh
pushd jsonprocessor
sbt assembly
cp ~/gitrepo/github/dataengineerclub/project/jsonprocessor/target/scala-2.11/jsonprocessor-assembly-1.jar \
   ~/gitrepo/github/dataengineerclub/project/sdc-data/spark_local/
popd
