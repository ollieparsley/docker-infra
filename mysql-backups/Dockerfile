FROM alpine:3
RUN apk update
RUN apk add --no-cache mysql-client python py-pip bash
RUN pip install awscli
COPY mysql-backups/backup.sh /backup.sh
RUN chmod +x /backup.sh
CMD ["/bin/bash","-c","/backup.sh"]