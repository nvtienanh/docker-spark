ARG HADOOP_TAG

FROM nvtienanh/oracle-jdk:1.8-alpine3.9

ARG IMAGE_TAG
ARG SPARK_VERSION
ARG BUILD_DATE
ARG VCS_REF

LABEL org.label-schema.build-date=$BUILD_DATE \
        org.label-schema.name="Apache Spark" \
        org.label-schema.description="Apache Spark docker image based on Alpine Linux" \
        org.label-schema.vcs-ref=$VCS_REF \
        org.label-schema.vcs-url="https://github.com/nvtienanh/docker-spark/tree/$IMAGE_TAG/base" \
        org.label-schema.vendor="nvtienanh" \
        org.label-schema.version=$SPARK_VERSION \
        org.label-schema.schema-version="1.0"

## INSTALL APACHE SPARK

ENV ENABLE_INIT_DAEMON true
ENV INIT_DAEMON_BASE_URI http://identifier/init-daemon
ENV INIT_DAEMON_STEP spark_master_init
ENV SPARK_HOME /opt/spark/

COPY wait-for-step.sh /
COPY execute-step.sh /
COPY finish-step.sh /
#COPY bde-spark.css /css/org/apache/spark/ui/static/timeline-view.css3.0.0-preview2

RUN apk add --no-cache nss bash
RUN \
      chmod +x *.sh \
      && wget https://archive.apache.org/dist/spark/spark-$SPARK_VERSION-preview2/spark-$SPARK_VERSION-preview2-bin-hadoop2.7.tgz \
      && tar -xvzf spark-$SPARK_VERSION-preview2-bin-hadoop2.7.tgz \
      && mv spark-$SPARK_VERSION-preview2-bin-hadoop2.7 /opt/spark \
      && rm spark-$SPARK_VERSION-preview2-bin-hadoop2.7.tgz \
      #&& cd /css \
      #&& jar uf /spark/jars/spark-core_2.11-${SPARK_VERSION}.jar org/apache/spark/ui/static/timeline-view.css \
      && cd / \
      && rm -rf /var/cache/apk/*

#Give permission to execute scripts
RUN chmod +x /wait-for-step.sh && chmod +x /execute-step.sh && chmod +x /finish-step.sh

# Fix the value of PYTHONHASHSEED
# Note: this is needed when you use Python 3.3 or greater
ENV PYTHONHASHSEED 1

COPY hive-site.xml /opt/spark/conf/
COPY spark-env.sh /opt/spark/conf/

COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

## INSTALL MINICONDA3
ENV PATH /opt/conda/bin:$PATH
ENV PYSPARK_PYTHON /opt/conda/bin/python
ENV PYSPARK_DRIVER_PYTHON /opt/conda/bin/python
ENV PYTHONPATH /opt/conda/bin/python

ARG CONDA_VERSION="4.7.12.1"
ARG CONDA_MD5="81c773ff87af5cfac79ab862942ab6b3"
ARG CONDA_DIR="/opt/conda"

ENV PYTHONDONTWRITEBYTECODE=1

# Install conda
RUN echo "**** install dev packages ****" && \
    apk add --no-cache --virtual .build-dependencies ca-certificates wget && \
    \
    echo "**** get Miniconda ****" && \
    mkdir -p "$CONDA_DIR" && \
    wget "http://repo.continuum.io/miniconda/Miniconda3-${CONDA_VERSION}-Linux-x86_64.sh" -O miniconda.sh && \
    echo "$CONDA_MD5  miniconda.sh" | md5sum -c && \
    \
    echo "**** install Miniconda ****" && \
    bash miniconda.sh -f -b -p "$CONDA_DIR" && \
    echo "export PATH=$CONDA_DIR/bin:\$PATH" > /etc/profile.d/conda.sh && \
    \
    echo "**** setup Miniconda ****" && \
    conda update --all --yes && \
    conda config --set auto_update_conda False && \
    \
    echo "**** cleanup ****" && \
    apk del --purge .build-dependencies && \
    rm -f miniconda.sh && \
    conda clean --all --force-pkgs-dirs --yes && \
    find "$CONDA_DIR" -follow -type f \( -iname '*.a' -o -iname '*.pyc' -o -iname '*.js.map' \) -delete && \
    \
    echo "**** finalize ****" && \
    mkdir -p "$CONDA_DIR/locks" && \
    chmod 777 "$CONDA_DIR/locks"


RUN conda install -y numpy matplotlib pyspark py4j

ENTRYPOINT ["entrypoint.sh"]
