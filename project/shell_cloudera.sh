#!/bin/sh
konsole --separate --new-tab -e "docker exec -it $(docker ps -a -q -f name=quickstart.cloudera) bash"&
