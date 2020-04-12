package org.kliusa.otusde201911.project.jsonprocessor

import java.text.SimpleDateFormat
import java.util.{Calendar, TimeZone}

import org.apache.log4j._
import org.apache.spark.sql.{SaveMode, SparkSession}

object JsonProcessor extends App{

  val jsonName = args(0)
  val outPath = args(1)

  val currDateStr = new SimpleDateFormat("yyyy-MM-dd-HH-mm-ss").format(
    Calendar.getInstance( TimeZone.getTimeZone("Europe/Kiev") ).getTime()
  )

  BasicConfigurator.configure()

  Logger.getRootLogger
    .setLevel( Level.ERROR )

  val sparkSession = SparkSession.builder()
    .getOrCreate()

  val jsonDf = sparkSession.read.format("json")
    .load(jsonName)

  jsonDf.createOrReplaceTempView("json")

  val jsonSql = sparkSession.sql(
    "select name as f_area, count(*) as f_records" +
      " from json" +
      " group by name"
  )

  val coal = jsonSql.coalesce(1)

  coal.write.format("avro").mode(SaveMode.Append).save(outPath+"/"+currDateStr)
  //+"/"+currDateStr

}
