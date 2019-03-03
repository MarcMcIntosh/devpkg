FROM alpine:3.7

WORKDIR devpkg

RUN apk add --no-cache build-base gcc abuild binutils apr-dev apr-util-dev git curl tar

COPY . .

RUN make
