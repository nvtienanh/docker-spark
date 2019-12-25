#!/bin/bash

set -e

TAG=2.4.3-hadoop3.2.1

build() {
    NAME=$1
    IMAGE=nvtienanh/spark-$NAME:$TAG
    cd $([ -z "$2" ] && echo "./$NAME" || echo "$2")
    echo '--------------------------' building $IMAGE in $(pwd)
    docker build -t $IMAGE .
    cd -
}
if [ $# -eq 0 ]
    then
        BRANCH=$(git rev-parse --abbrev-ref HEAD)
    else
        BRANCH=$1
fi

if [ $BRANCH == "master" ]
then
    SPARK_VERSION="3.0.0"
    IMAGE_TAG="latest"
else
    SPARK_VERSION="$(echo $BRANCH | cut -d'-' -f1)"
    IMAGE_TAG=$BRANCH
fi

build() {
    NAME=$1
    IMAGE_TAG=$2
    SPARK_VERSION=$3
    HADOOP_TAG=$4
    IMAGE=nvtienanh/spark-$NAME:$IMAGE_TAG
    cd $([ -z "$1" ] && echo "./$NAME" || echo "$1")
    echo '--------------------------' building $IMAGE in $(pwd)
    docker build \
     -t $IMAGE \
     --build-arg IMAGE_TAG=$IMAGE_TAG \
     --build-arg HADOOP_TAG=$HADOOP_TAG \
     --build-arg SPARK_VERSION=$SPARK_VERSION .
    cd -
    # docker push $IMAGE
}

build base $IMAGE_TAG $SPARK_VERSION 3.2.1-alpine
# build master
# build worker
# build submit
# build java-template template/java
# build scala-template template/scala
# build python-template template/python
