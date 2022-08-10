FROM alpine:3.16.2 as build

RUN apk --no-cache add alpine-sdk bash clang cmake git

# For the time being lock the commit version until the new release.
ARG FLATBUFFERS_VERSION=b4647b
ARG FLATCC_VERSION=v0.6.1

RUN git clone https://github.com/google/flatbuffers && \
  cd /flatbuffers && \
  git reset --hard $FLATBUFFERS_VERSION && \
  CC=/usr/bin/clang \
  CXX=/usr/bin/clang++ \
  cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release && \
  make

RUN git clone --branch $FLATCC_VERSION https://github.com/dvidelabs/flatcc.git && \
  cd /flatcc && \
  scripts/initbuild.sh make && \
  scripts/build.sh

FROM alpine:3.16.2

# Required dependency for the binaries.
RUN apk --no-cache add libstdc++

COPY --from=build /flatbuffers/flatc /usr/local/bin/
COPY --from=build /flatcc/bin/flatcc /usr/local/bin/
