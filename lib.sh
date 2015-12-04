docker_run() {
    cmd=$1
    mapping=$2
    docker run -it --link $DOCKER_MYSQLD_CONTAINER:mysql $mapping --rm mysql sh -c "exec ${cmd}"
}

run_mysql_cmd() {
    cmd=$1
    mapping=$2
    if [ $DOCKER_MYSQLD_CONTAINER ]; then
        docker_run "${cmd}" "${mapping}"
    else
        `$cmd`
    fi
}

MYSQL_CMD="mysql -h${DBHOST} -u${DBUSER} -p${DBPASS} --default-character-set=utf8"
