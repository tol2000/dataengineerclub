package org.kliusa.otusde201911project.jsonreader

//import org.apache.log4j._
//import org.apache.spark.SparkSession

import org.apache.spark.sql

import org.apache.spark.SparkContext
import org.apache.spark.SparkConf
import org.apache.spark.sql._

object JsonProcessor extends App {

  val sc = new SparkContext(new SparkConf().setAppName("JsonProcessor"))
  val sqc = new org.apache.spark.sql.SQLContext(sc)

  import sqc.implicits._

  //System.out.println("Hello!!!")

//  BasicConfigurator.configure()

//  Logger.getRootLogger
//    .setLevel( Level.ERROR )

  //val sparkSession = SparkSession.builder()
  //  // define in batch sh .master("spark://localhost:7077")
  //  //.master("local[*]")
  //  .getOrCreate()

  //  .appName("JsonProcessor")
  //  .master("yarn")
    
  val jsonName = args(0)

  val outPath = args(1)

  val jsonDf = sqc.read.format("json")
    .load(jsonName)

  jsonDf.registerTempTable("json")

  val jsonSql = sqc.sql("select 'Record in json' as name, count(*) as qnty from json")

  jsonSql
    .write
    .mode(SaveMode.Append)
    .json(outPath)

}
