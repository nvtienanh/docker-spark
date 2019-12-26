[![Build Status](https://travis-ci.org/nvtienanh/docker-spark.svg?branch=master)](https://travis-ci.org/nvtienanh/docker-spark)

# Docker image: Apache Spark

Thông tin về Docker image:
* Linux: alphine 3.9
* Spark 2.4.4
* Hadoop 3.2.1
* Miniconda 4.7.12.1
* Python 3.7 hỗ trợ Pyspark


## Using Docker Compose

Copy template mẫu dưới đây vào `docker-compose.yml` để sử dụng
```yml
spark-master:
  image: nvtienanh/spark-master:2.4.4-alpine
  container_name: spark-master
  ports:
    - "8080:8080"
    - "7077:7077"
  environment:
    - INIT_DAEMON_STEP=setup_spark
    - "constraint:node==<yourmasternode>"
spark-worker-1:
  image: nvtienanh/spark-worker:2.4.4-alpine
  container_name: spark-worker-1
  depends_on:
    - spark-master
  ports:
    - "8081:8081"
  environment:
    - "SPARK_MASTER=spark://spark-master:7077"
    - "constraint:node==<yourmasternode>"
spark-worker-2:
  image: nvtienanh/spark-worker:2.4.4-alpine
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

    docker run --name spark-master -h spark-master -e ENABLE_INIT_DAEMON=false -d nvtienanh/spark-master:2.4.4-alpine

### Spark Worker
To start a Spark worker:

    docker run --name spark-worker-1 --link spark-master:spark-master -e ENABLE_INIT_DAEMON=false -d nvtienanh/spark-worker:2.4.4-alpine

## Launch a Spark application
Building and running your Spark application on top of the Spark cluster is as simple as extending a template Docker image. Check the template's README for further documentation.
* [Java template](template/java)
* [Python template](template/python)
* [Scala template](template/scala)
