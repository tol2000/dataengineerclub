#!/bin/sh

BATDIR=/media/shared_from_local/bat/

echo $(date) - autostart begin >> $BATDIR/autostart.out

# beeline -u "jdbc:hive2://localhost:10000/default" --silent=true -f $BATDIR/hive.sql > $BATDIR/hive.sql.out

echo $(date) - autostart end >> $BATDIR/autostart.out
