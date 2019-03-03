FROM ubuntu
WORKDIR devpkg
COPY . ./devpkg
RUN apt-get update && apt-get install -y apt-utils && apt-get install -y  binutils gcc make autoconf git curl libaprutil1

