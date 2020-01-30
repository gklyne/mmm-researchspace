docker rm $(docker ps -a | awk 'NR > 1 {print $1;}')

