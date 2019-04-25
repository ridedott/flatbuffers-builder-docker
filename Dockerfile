FROM ubuntu:18.04 as build

ARG FLATBUFFERS_VERSION=v1.10.0
ARG FLATCC_VERSION=v0.5.3

RUN apt-get update && apt-get install -y git-core clang cmake

RUN mkdir /build

# Install flatbuffers, move the binary and cleanup the repo
RUN git clone --branch $FLATBUFFERS_VERSION https://github.com/google/flatbuffers && \
    cd /flatbuffers && cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release && make && \
    mv /flatbuffers/flatc /build && rm -rf /flatbuffers

# Install flatcc, move the binary and cleanup the repo
RUN git clone --branch $FLATCC_VERSION https://github.com/dvidelabs/flatcc.git && \
    cd /flatcc && scripts/initbuild.sh make && scripts/build.sh && \
    mv /flatcc/bin/flatcc /build && rm -rf /flatcc

FROM ubuntu:18.04

COPY --from=build /build/flatc /usr/local/bin/
COPY --from=build /build/flatcc /usr/local/bin/
