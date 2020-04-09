package org.kliusa.otusde201911hex5.jsonreader

import org.apache.log4j._
import org.apache.spark.sql.{SaveMode, SparkSession}

object JsonProcessor extends App{

  val jsonName = args(0)

  val outPath = args(1)

  BasicConfigurator.configure()

  Logger.getRootLogger
    .setLevel( Level.ERROR )

  val sparkSession = SparkSession.builder()
    .master("spark://localhost:7077")
    .getOrCreate()

  val jsonDf = sparkSession.read.format("json")
    .load(jsonName)

  jsonDf.createOrReplaceTempView("json")

  val jsonSql = sparkSession.sql("select 'Record in json' as name, count(*) as qnty from json")

  jsonSql
    .write
    .mode(SaveMode.Append)
    .parquet(outPath)

}
