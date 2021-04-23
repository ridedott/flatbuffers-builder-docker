# Move to latest alpine on the next flatbuffers release.
FROM alpine:3.11 as build

RUN apk --no-cache add alpine-sdk bash clang cmake git

ARG FLATBUFFERS_VERSION=v1.12.0
ARG FLATCC_VERSION=v0.6.0
ARG FLATBUFFERS_LATEST_COMMIT=b82fe07384790cbe977fc1ab6cbe85ce478cac12

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

# Latest version is temporarily needed to build bfbs files.
RUN git clone https://github.com/google/flatbuffers flatbuffers_master && \
  cd /flatbuffers_master && \
  git checkout $FLATBUFFERS_LATEST_COMMIT && \
  CC=/usr/bin/clang \
  CXX=/usr/bin/clang++ \
  cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release && \
  make

# Move to latest alpine on the next flatbuffers release.
FROM alpine:3.11

# Required dependency for the binaries.
RUN apk --no-cache add libstdc++

COPY --from=build /flatbuffers/flatc /usr/local/bin/
COPY --from=build /flatbuffers/flatc /usr/local/bin/flatc_master
COPY --from=build /flatcc/bin/flatcc /usr/local/bin/
