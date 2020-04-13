package org.kliusa.otusde201911.project.jsonprocessor

import java.text.SimpleDateFormat
import java.util.{Calendar, TimeZone}

import org.apache.log4j._
import org.apache.spark.sql.{SaveMode, SparkSession}

/*
* Модуль загружает из бронзового слоя в серебряный
* данные по каждому безнес-кейсу.
* Код, относящийся к каждому кейсу, помечен соотв. комментарием
*
* // CASE OdessaWatch - Кейс для отслеживания параметров погоды в Одессе.
* 
*/

object JsonProcessor extends App{

  val jsonName = args(0)
  val outPath = args(1)

  val currDateStr = new SimpleDateFormat("yyyy-MM-dd-HH-mm-ss").format(
    Calendar.getInstance( TimeZone.getTimeZone("Europe/Kiev") ).getTime()
  )

  // CASE OdessaWatch
  // Запрос для бизнес-кейса
  val sqlOdessaWatch =
    "select" +
    "    '"+currDateStr+"' as date_string, " +
    "    name," +
    "    main_feels_like," +
    "    main_pressure, main_humidity," +
    "    wind_speed, wind_deg," +
    "    rain, snow, clouds_all" +
    "  from json" +
    "  where id = 698740" +
    "  group by" +
    "    name," +
    "    main_feels_like," +
    "    main_pressure, main_humidity," +
    "    wind_speed, wind_deg," +
    "    rain, snow, clouds_all"

  BasicConfigurator.configure()

  Logger.getRootLogger
    .setLevel( Level.ERROR )

  val sparkSession = SparkSession.builder()
    .config("hive.metastore.uris", "thrift://quickstart.cloudera:9083")
    .enableHiveSupport()
    .getOrCreate()

  val jsonDf = sparkSession.read.format("json")
    .load(jsonName) // Датафрейм, в который загружаем исходный джейсон

  jsonDf.createOrReplaceTempView("json")  // Представление по датафрейму исходного джейсона для запросов

  // CASE OdessaWatch
  val dfOdessaWatch = sparkSession.sql(
    sqlOdessaWatch // Запрос по исходному джейсону для формирования целевого датасета
  ) // Целевой датафрейм для загрузки в БД

  // CASE OdessaWatch
  // Пишем целевой датасет в промежуточный авро (может использоваться в стримсетс)
  dfOdessaWatch.coalesce(1)
    .write.format("avro").mode(SaveMode.Append).save(outPath+"/OdessaWatch/"+currDateStr)

  // CASE OdessaWatch
  // Создаем представление для целевого датасета.
  // Из него потом запросом выгрузим в БД
  dfOdessaWatch.createOrReplaceTempView("viewOdessaWatch")  // на основе выборки

  // CASE OdessaWatch
  // Создаем таблицу в хайве, если ее вдруг нет
  val hiveCreateSql = sparkSession.sql("create table if not exists odessawatch as select * from viewOdessaWatch where 0=1")

  // CASE OdessaWatch
  // Заливаем туда данные
  val hiveInsertSql = sparkSession.sql("insert into odessawatch select * from viewOdessaWatch")

}
