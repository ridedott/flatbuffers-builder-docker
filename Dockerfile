# Move to latest alpine on the next flatbuffers release.
FROM alpine:3.16.0 as build

RUN apk --no-cache add alpine-sdk bash clang cmake git

ARG FLATBUFFERS_VERSION=v1.12.0
ARG FLATCC_VERSION=v0.6.0

RUN git clone --branch $FLATBUFFERS_VERSION https://github.com/google/flatbuffers && \
  cd /flatbuffers && \
  CC=/usr/bin/clang \
  CXX=/usr/bin/clang++ \
  cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release && \
  make

RUN git clone --branch $FLATCC_VERSION https://github.com/dvidelabs/flatcc.git && \
  cd /flatcc && \
  scripts/initbuild.sh make && \
  scripts/build.sh

# Move to latest alpine on the next flatbuffers release.
FROM alpine:3.16.0

# Required dependency for the binaries.
RUN apk --no-cache add libstdc++

COPY --from=build /flatbuffers/flatc /usr/local/bin/
COPY --from=build /flatcc/bin/flatcc /usr/local/bin/
