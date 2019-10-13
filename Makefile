SPARK_TAG := 2.4.3-hadoop3.2.1

build:
	docker build -t nvtienanh/spark-base:$(SPARK_TAG) ./base
	docker build -t nvtienanh/spark-master:$(SPARK_TAG) ./master
	docker build -t nvtienanh/spark-worker:$(SPARK_TAG) ./worker
	# docker build -t nvtienanh/spark-submit:$(SPARK_TAG ) ./submit

push:
	docker push nvtienanh/spark-base:$(SPARK_TAG)
	docker push nvtienanh/spark-master:$(SPARK_TAG)
	docker push nvtienanh/spark-worker:$(SPARK_TAG)
	# docker push nvtienanh/spark-submit:$(SPARK_TAG)
