ARG SPARK_BASE=2.4.3-hadoop3.2.1
FROM nvtienanh/spark-base:${SPARK_BASE}

LABEL MAINTAINER = "Anh Nguyen <nvtienanh@gmail.com>" 

HEALTHCHECK CMD curl -f http://localhost:8080/ || exit 1
COPY master.sh /

ENV SPARK_MASTER_PORT 7077
ENV SPARK_MASTER_WEBUI_PORT 8080
ENV SPARK_MASTER_LOG /spark/logs

EXPOSE 8080 7077 6066

CMD ["/bin/bash", "/master.sh"]
