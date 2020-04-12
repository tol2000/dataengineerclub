package org.kliusa.otusde201911.project.jsonprocessor

import java.text.SimpleDateFormat
import java.util.{Calendar, TimeZone}

import org.apache.log4j._
import org.apache.spark.sql.{SaveMode, SparkSession}

object JsonProcessor extends App{

  val jsonName = args(0)
  val outPath = args(1)

  val sql1 =
    "select name as f_area, count(*) as f_records" +
    "  from json" +
    "  group by name"

  //val sql2 = "select * from json"

  val sql3 =
    "select" +
    "  name," +
    "  coord.lat, coord.lon," +
    "  main.temp, main.feels_like," +
    "  main.temp_min, main.temp_max," +
    "  main.pressure, main.humidity," +
    "  dt, wind.speed, wind.deg," +
    "  sys.country, rain, snow, clouds.all," +
    "  count(*) qnty"
    //+ "  weather.0.id, weather.0.main, weather.0.description" +
    "  from json" +
    "  group by"
    "    name," +
    "    coord.lat, coord.lon," +
    "    main.temp, main.feels_like," +
    "    main.temp_min, main.temp_max," +
    "    main.pressure, main.humidity," +
    "    dt, wind.speed, wind.deg," +
    "    sys.country, rain,snow, clouds.all"
    //+ "    weather.0.id, weather.0.main, weather.0.description"
  
    val sql4 = "select name, dt, count(*) as qnty from json group by name, dt"


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
    sql4
  )

  val coal = jsonSql.coalesce(1)

  coal.write.format("avro").mode(SaveMode.Append).save(outPath+"/"+currDateStr)
  //+"/"+currDateStr

}
