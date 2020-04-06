#!/bin/sh
CMD="impala-shell"
konsole --separate --new-tab -e "docker exec -it $(docker ps -a -q -f name=quickstart.cloudera) $CMD"&
