FROM archlinux/base:latest

WORKDIR devpkg

RUN pacman -Sy --noconfirm gcc glibc make tar git curl apr apr-util

COPY . .

RUN make clean && make && make install && ./test.sh
