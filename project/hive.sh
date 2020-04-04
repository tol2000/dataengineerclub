#!/bin/sh
CMD="beeline -u \"jdbc:hive2://localhost:10000/default\" --silent=true"
konsole --separate --new-tab -e "docker exec -it $(docker ps -a -q -f name=cdh1) $CMD"&
