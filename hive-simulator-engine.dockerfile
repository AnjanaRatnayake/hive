# This simulation runs Engine API tests.
FROM golang:1.23-alpine as builder
ARG GOPROXY
ENV GOPROXY=${GOPROXY}

RUN apk add --update gcc musl-dev linux-headers

# Build the simulator executable.
COPY ./ /hive
WORKDIR /hive/simulators/ethereum/engine
RUN go build -v .

# Build the simulator run container.
# FROM alpine:latest
# ADD . /hive
# WORKDIR /hive/simulators/ethereum/engine/
# COPY --from=builder /hive/simulators/ethereum/engine/ .
# ENV HIVE_LOGLEVEL=3
# ENV HIVE_PARALLELISM:1 
# ENV HIVE_RANDOM_SEED:0 
# ENV HIVE_SIMULATOR:http://10.88.1.12:8081
# COPY --from=geth    /ethash /ethash
ENTRYPOINT ["./engine"]
