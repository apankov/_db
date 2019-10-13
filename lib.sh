docker_run() {
    cmd=$1
    mapping=$2
    network=''
    if [ $DOCKER_NETWORK ]; then
        network="--net $DOCKER_NETWORK"
    fi
    docker run -it --link $DOCKER_MYSQLD_CONTAINER:mysql $network $mapping --rm mysql sh -c "exec ${cmd}"
}

run_mysql_cmd() {
    cmd=$1
    mapping=$2
    if [ $DOCKER_MYSQLD_CONTAINER ]; then
        docker_run "${cmd}" "${mapping}"
    elif [ $DOCKER_COMPOSE_SERVICE ]; then
        fullcmd="docker-compose exec $DOCKER_COMPOSE_SERVICE $cmd"
        sh -c "$fullcmd"
    else
        bash -c "$cmd"
    fi
}

port=''
if [ "${DBPORT}" ]; then
    port=" -P${DBPORT}"
fi
MYSQL_CMD="mysql -h${DBHOST} ${port} -u${DBUSER} -p${DBPASS} --default-character-set=utf8"
