ARG HADOOP_TAG
FROM nvtienanh/hadoop-base:${HADOOP_TAG}

ARG IMAGE_TAG
ARG SPARK_VERSION
ARG BUILD_DATE
ARG VCS_REF

LABEL org.label-schema.build-date=$BUILD_DATE \
        org.label-schema.name="Apache Spark" \
        org.label-schema.description="Apache Spark docker image based on Debian Linux" \
        org.label-schema.vcs-ref=$VCS_REF \
        org.label-schema.vcs-url="https://github.com/nvtienanh/docker-spark/tree/$IMAGE_TAG/base" \
        org.label-schema.vendor="nvtienanh" \
        org.label-schema.version=$SPARK_VERSION \
        org.label-schema.schema-version="1.0"

ENV ENABLE_INIT_DAEMON true
ENV INIT_DAEMON_BASE_URI http://identifier/init-daemon
ENV INIT_DAEMON_STEP spark_master_init

COPY wait-for-step.sh /
COPY execute-step.sh /
COPY finish-step.sh /

#COPY bde-spark.css /css/org/apache/spark/ui/static/timeline-view.css

ADD https://raw.githubusercontent.com/guilhem/apt-get-install/master/apt-get-install /usr/bin/
RUN chmod +x /usr/bin/apt-get-install

# COPY spark-2.4.3-bin-without-hadoop.tgz /tmp/spark.tgz
# RUN tar -xvzf /tmp/spark.tgz -C / \
#     && mv spark-${SPARK_VERSION}-bin-without-hadoop spark \
#     && rm /tmp/spark.tgz \
#     && cd /

RUN apt-get-install -y curl wget \
      && chmod +x *.sh \
      && wget https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-without-hadoop.tgz \
      && tar -xvzf spark-${SPARK_VERSION}-bin-without-hadoop.tgz \
      && mv spark-$SPARK_VERSION-bin-without-hadoop /opt/spark \
      && rm spark-${SPARK_VERSION}-bin-without-hadoop.tgz \
      #&& cd /css \
      #&& jar uf /spark/jars/spark-core_2.11-${SPARK_VERSION}.jar org/apache/spark/ui/static/timeline-view.css \
      && cd /

ENV SPARK_HOME /opt/spark/

# RUN apt-get-install -y python3 python3-setuptools python3-pip
ARG CONDA_VERSION="4.7.12.1"

ENV PATH /opt/conda/bin:$PATH
ENV PYSPARK_PYTHON /opt/conda/bin/python
ENV PYSPARK_DRIVER_PYTHON /opt/conda/bin/python
ENV PYTHONPATH /opt/conda/bin/python
RUN apt-get update --fix-missing && \
    apt-get install -y wget bzip2 ca-certificates curl git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN wget --quiet http://repo.continuum.io/miniconda/Miniconda3-${CONDA_VERSION}-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    /opt/conda/bin/conda clean -tipsy && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc

ENV TINI_VERSION v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini
RUN conda install -y numpy matplotlib pyspark py4j

#Give permission to execute scripts
RUN chmod +x /wait-for-step.sh && chmod +x /execute-step.sh && chmod +x /finish-step.sh

# Fix the value of PYTHONHASHSEED
# Note: this is needed when you use Python 3.3 or greater
ENV PYTHONHASHSEED 1

COPY hive-site.xml /opt/spark//spark/conf/
COPY spark-env.sh /opt/spark//spark/conf/

COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
