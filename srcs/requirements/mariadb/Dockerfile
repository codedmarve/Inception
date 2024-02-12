FROM alpine:3.18

ARG DB_NAME \
    DB_USER \
    DB_PASS

ENV DB_NAME=${DB_NAME}
ENV DB_USER=${DB_USER}
ENV DB_PASS=${DB_PASS}

RUN apk update && apk add --no-cache mariadb mariadb-client \
	&& mkdir /var/run/mysqld && chmod 777 /var/run/mysqld


COPY ./requirements/mariadb/conf/docker.cnf /etc/my.cnf.d/docker.cnf;

RUN sed -i "s|skip-networking|skip-networking=0|g" \
      /etc/my.cnf.d/mariadb-server.cnf

RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

EXPOSE 3306

COPY requirements/mariadb/conf/create_db.sh .

RUN chmod +x create_db.sh \
	&& sh create_db.sh && rm create_db.sh

USER mysql

CMD ["/usr/bin/mysqld", "--skip-log-error"]
