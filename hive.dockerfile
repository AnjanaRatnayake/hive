FROM ubuntu:latest
RUN apt update
RUN apt install -y wget ca-certificates
ENV GO_VERSION="1.23.0"
ENV GO_URL="https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz"
RUN wget -q -O /tmp/go.tar.gz ${GO_URL} &&     tar -C /usr/local -xzf /tmp/go.tar.gz &&     rm /tmp/go.tar.gz
ENV GOROOT=/usr/local/go
ENV PATH=$GOROOT/bin:$PATH
COPY ../hive /hive
WORKDIR /hive
RUN go build
ENTRYPOINT /hive/geth_hive.sh