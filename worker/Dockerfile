ARG IMAGE_TAG=2.4.4.alpine
FROM nvtienanh/spark-base:${IMAGE_TAG}

ARG SPARK_VERSION
ARG BUILD_DATE
ARG VCS_REF

LABEL org.label-schema.build-date=$BUILD_DATE \
        org.label-schema.name="Apache Spark" \
        org.label-schema.description="Apache Spark docker image based on Alpine Linux" \
        org.label-schema.vcs-ref=$VCS_REF \
        org.label-schema.vcs-url="https://github.com/nvtienanh/docker-spark/tree/$IMAGE_TAG/worker" \
        org.label-schema.vendor="nvtienanh" \
        org.label-schema.version=$SPARK_VERSION \
        org.label-schema.schema-version="1.0"

HEALTHCHECK CMD curl -f http://localhost:8081/ || exit 1
COPY worker.sh /

ENV SPARK_WORKER_WEBUI_PORT 8081
ENV SPARK_WORKER_LOG /spark/logs
ENV SPARK_MASTER "spark://spark-master:7077"

EXPOSE 8081

CMD ["/bin/bash", "/worker.sh"]
