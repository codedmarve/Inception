
FROM alpine:3.18

ARG FTP_USR
ARG FTP_PWD

ENV FTP_USR=${FTP_USR}
ENV FTP_PWD=${FTP_PWD}

RUN apk update && \
    apk upgrade && \
    apk add --no-cache vsftpd

RUN adduser --h /var/www -s /bin/false -D ${FTP_USR} && \
    echo "${FTP_USR}:${FTP_PWD}" | /usr/sbin/chpasswd && \
    adduser ${FTP_USR} root && \
    echo ${FTP_USR} >> /etc/vsftpd.userlist


RUN mkdir -p /etc/vsftpd && touch /etc/vsftpd/vsftpd.conf

RUN chown -R ${FTP_USR}:${FTP_USR} /var/www
RUN chmod -R u+w /var/www

RUN chmod -R 777 /var/www



# Configure vsftpd
COPY ./requirements/bonus/vsftpd/vsftpd.conf /etc/vsftpd/vsftpd.conf

WORKDIR /var/www
EXPOSE 21 20

CMD ["/usr/sbin/vsftpd", "/etc/vsftpd/vsftpd.conf"]