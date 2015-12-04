FROM ubuntu:14.04
MAINTAINER Zonesan <chaizs@asiainfo.com>


ENV GOPATH /go
ENV PATH $PATH:$GOPATH/bin:/usr/local/go/bin
ENV SRCPATH $GOPATH/src/svc-broker



RUN apt-get install -y wget git && \
     mkdir -p $SRCPATH  && \
	 wget https://s3.cn-north-1.amazonaws.com.cn/asiainfoldp-file-backup/golang.tar.gz -O /usr/local/golang.tar.gz && \
    tar -xzf /usr/local/golang.tar.gz -C /usr/local/ && \
	rm /usr/local/golang.tar.gz && \
	go get github.com/tools/godep

ADD . $SRCPATH

WORKDIR $SRCPATH

RUN godep get && \
    go build

EXPOSE 3000

CMD ["./svc-broker"]
