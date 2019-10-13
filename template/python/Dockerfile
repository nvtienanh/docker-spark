ARG SPARK_BASE=2.4.3-hadoop3.2.1
FROM nvtienanh/spark-submit:${SPARK_BASE}

LABEL MAINTAINER = "Anh Nguyen <nvtienanh@gmail.com>" 

COPY template.sh /

# Copy the requirements.txt first, for separate dependency resolving and downloading
ONBUILD COPY requirements.txt /app/
ONBUILD RUN cd /app \
      && pip3 install -r requirements.txt

# Copy the source code
ONBUILD COPY . /app

CMD ["/bin/bash", "/template.sh"]
