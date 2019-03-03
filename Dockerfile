FROM ubuntu
# FROM alpine:3.7

WORKDIR devpkg

RUN apt-get update && apt-get install -y apt-utils && apt-get install -y  binutils gcc make autoconf git curl libapr1-dev libaprutil1
RUN dpkg -L libapr1-dev
# RUN apk add --no-cache build-base gcc abuild binutils apr apr-util git curl
COPY . .
RUN make
