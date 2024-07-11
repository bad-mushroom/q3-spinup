FROM alpine:latest

LABEL Maintainer="g0dzuki99 <chris@chaoscontrol.org>" \
    Description="An ioquake3 dedicated server compiled from source."

RUN adduser --system ioq3

RUN apk update \
    && apk upgrade \
    && apk add \
    curl g++ gcc make git sdl2-dev

RUN git clone https://github.com/ioquake/ioq3.git /ioq3 \
    && cd ioq3 \
    && make release

USER ioq3

EXPOSE 27960/udp

# Mac M1
#ENTRYPOINT [ "/ioq3/build/release-linux-arm64/ioq3ded.arm64" ]

# Linux 64
ENTRYPOINT [ "/ioq3/build/release-linux-x86_64/ioq3ded.x86_64" ]
