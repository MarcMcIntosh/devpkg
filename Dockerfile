FROM archlinux/base:latest

WORKDIR devpkg

RUN pacman -Sy --noconfirm base-devel tar git curl apr apr-util

COPY . .

RUN make clean && make && make install
RUN devpkg -L
RUN ./test.sh
