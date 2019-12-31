# Apache Spark
[![CI status](https://github.com/nvtienanh/docker-spark/workflows/CI/badge.svg?branch=master)](https://github.com/nvtienanh/docker-spark/actions?query=branch%3Amaster++)

Docker image infomation:
* Linux: debian 9
* Spark `2.4.3`
* Hadoop `3.2.1`
* Miniconda3 `4.7.12.1`
* Python `3.7` supports Pyspark, Matplotlib, ...

**spark-base**

[![Docker Version](https://images.microbadger.com/badges/version/nvtienanh/spark-base:master.svg)](https://hub.docker.com/r/nvtienanh/spark-base/)
[![Docker Pulls](https://img.shields.io/docker/pulls/nvtienanh/spark-base)](https://hub.docker.com/r/nvtienanh/spark-base/)
[![Docker Layers](https://img.shields.io/microbadger/layers/nvtienanh/spark-base/master)](https://hub.docker.com/r/nvtienanh/spark-base/)

**spark-master**

[![Docker Version](https://images.microbadger.com/badges/version/nvtienanh/spark-master:master.svg)](https://hub.docker.com/r/nvtienanh/spark-master/)
[![Docker Pulls](https://img.shields.io/docker/pulls/nvtienanh/spark-master)](https://hub.docker.com/r/nvtienanh/spark-master/)
[![Docker Layers](https://img.shields.io/microbadger/layers/nvtienanh/spark-master/master)](https://hub.docker.com/r/nvtienanh/spark-master/)

**spark-worker**

[![Docker Version](https://images.microbadger.com/badges/version/nvtienanh/spark-worker:master.svg)](https://hub.docker.com/r/nvtienanh/spark-worker/)
[![Docker Pulls](https://img.shields.io/docker/pulls/nvtienanh/spark-worker)](https://hub.docker.com/r/nvtienanh/spark-worker/)
[![Docker Layers](https://img.shields.io/microbadger/layers/nvtienanh/spark-worker/master)](https://hub.docker.com/r/nvtienanh/spark-worker/)


## Using Docker Compose

Copy template mẫu dưới đây vào `docker-compose.yml` để sử dụng
```yml
spark-master:
  image: nvtienanh/spark-master:2.4.3-debian
  container_name: spark-master
  ports:
    - "8080:8080"
    - "7077:7077"
  environment:
    - INIT_DAEMON_STEP=setup_spark
    - "constraint:node==<yourmasternode>"
spark-worker-1:
  image: nvtienanh/spark-worker:2.4.3-debian
  container_name: spark-worker-1
  depends_on:
    - spark-master
  ports:
    - "8081:8081"
  environment:
    - "SPARK_MASTER=spark://spark-master:7077"
    - "constraint:node==<yourmasternode>"
spark-worker-2:
  image: nvtienanh/spark-worker:2.4.3-debian
  container_name: spark-worker-2
  depends_on:
    - spark-master
  ports:
    - "8081:8081"
  environment:
    - "SPARK_MASTER=spark://spark-master:7077"
    - "constraint:node==<yourworkernode>"  
```
Make sure to fill in the `INIT_DAEMON_STEP` as configured in your pipeline.

## Running Docker containers without the init daemon
### Spark Master
To start a Spark master:

    docker run --name spark-master -h spark-master -e ENABLE_INIT_DAEMON=false -d nvtienanh/spark-master:2.4.3-debian

### Spark Worker
To start a Spark worker:

    docker run --name spark-worker-1 --link spark-master:spark-master -e ENABLE_INIT_DAEMON=false -d nvtienanh/spark-worker:2.4.3-debian

## Launch a Spark application
Building and running your Spark application on top of the Spark cluster is as simple as extending a template Docker image. Check the template's README for further documentation.
* [Java template](template/java)
* [Python template](template/python)
* [Scala template](template/scala)
