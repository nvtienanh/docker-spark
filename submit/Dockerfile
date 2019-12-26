ARG IMAGE_TAG=2.4.4-alpine
FROM nvtienanh/spark-base:${IMAGE_TAG}

ARG SPARK_VERSION
ARG BUILD_DATE
ARG VCS_REF

LABEL org.label-schema.build-date=$BUILD_DATE \
        org.label-schema.name="Apache Spark" \
        org.label-schema.description="Apache Spark docker image based on Alpine Linux" \
        org.label-schema.vcs-ref=$VCS_REF \
        org.label-schema.vcs-url="https://github.com/nvtienanh/docker-spark/tree/$IMAGE_TAG/submit" \
        org.label-schema.vendor="nvtienanh" \
        org.label-schema.version=$SPARK_VERSION \
        org.label-schema.schema-version="1.0"

ENV SPARK_MASTER_NAME spark-master
ENV SPARK_MASTER_PORT 7077
ENV SPARK_APPLICATION_JAR_LOCATION /app/application.jar
ENV SPARK_APPLICATION_PYTHON_LOCATION /app/app.py
ENV SPARK_APPLICATION_MAIN_CLASS my.main.Application
ENV SPARK_APPLICATION_ARGS ""

COPY submit.sh /

CMD ["/bin/bash", "/submit.sh"]
