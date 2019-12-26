ARG IMAGE_TAG=2.4.4-alpine
FROM nvtienanh/spark-base:${IMAGE_TAG}

LABEL MAINTAINER = "Anh Nguyen <nvtienanh@gmail.com>" 

ENV SPARK_MASTER_NAME spark-master
ENV SPARK_MASTER_PORT 7077
ENV SPARK_APPLICATION_JAR_LOCATION /app/application.jar
ENV SPARK_APPLICATION_PYTHON_LOCATION /app/app.py
ENV SPARK_APPLICATION_MAIN_CLASS my.main.Application
ENV SPARK_APPLICATION_ARGS ""

COPY submit.sh /

CMD ["/bin/bash", "/submit.sh"]
