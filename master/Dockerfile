ARG IMAGE_TAG
FROM nvtienanh/spark-base:${IMAGE_TAG}

ARG SPARK_VERSION
ARG BUILD_DATE
ARG VCS_REF

LABEL org.label-schema.build-date=$BUILD_DATE \
        org.label-schema.name="Apache Spark" \
        org.label-schema.description="Apache Spark docker image based on Debian Linux" \
        org.label-schema.vcs-ref=$VCS_REF \
        org.label-schema.vcs-url="https://github.com/nvtienanh/docker-spark/tree/$IMAGE_TAG/master" \
        org.label-schema.vendor="nvtienanh" \
        org.label-schema.version=$SPARK_VERSION \
        org.label-schema.schema-version="1.0"

HEALTHCHECK CMD curl -f http://localhost:8080/ || exit 1
COPY master.sh /

ENV SPARK_MASTER_PORT 7077
ENV SPARK_MASTER_WEBUI_PORT 8080
ENV SPARK_MASTER_LOG /opt/spark/logs

EXPOSE 8080 7077 6066

CMD ["/bin/bash", "/master.sh"]
