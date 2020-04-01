#!/bin/sh
konsole --separate --new-tab -e "docker exec -it $(docker ps -a -q -f name=sdc1) bash"&
konsole --separate --new-tab -e "docker exec -it $(docker ps -a -q -f name=cdh1) bash"&
