FROM alpine as build

ARG FLATBUFFERS_VERSION=v1.10.0
ARG FLATCC_VERSION=v0.5.3

RUN apk update && apk add git clang cmake alpine-sdk bash

RUN git clone --branch $FLATBUFFERS_VERSION https://github.com/google/flatbuffers && \
    cd /flatbuffers && \
    cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release && \
    make

RUN git clone --branch $FLATCC_VERSION https://github.com/dvidelabs/flatcc.git && \
    cd /flatcc && \
    scripts/initbuild.sh make && \
    scripts/build.sh

FROM alpine

# Tracked down this required package for the binaries to work
RUN apk update && apk add libstdc++

COPY --from=build /flatbuffers/flatc /usr/local/bin/
COPY --from=build /flatcc/bin/flatcc /usr/local/bin/
