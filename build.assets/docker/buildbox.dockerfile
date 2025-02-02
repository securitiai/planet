ARG GOVERSION=1.17.5

# TODO: currently defaulting to stretch explicitly to work around
# a breaking change in buster (with GLIBC 2.28) w.r.t fcntl() implementation.
# See https://forum.rebol.info/t/dynamic-linking-static-linking-and-the-march-of-progress/1231/1
FROM quay.io/gravitational/debian-venti:go${GOVERSION}-stretch

ENV PATH $PATH:$GOPATH/bin:$GOROOT/bin
ENV GOCACHE ${GOPATH}/.gocache-${GOVERSION}

RUN apt-get update && apt-get install -y libc6-dev libudev-dev

RUN mkdir -p $GOPATH/src $GOPATH/bin ${GOCACHE}
RUN GO111MODULE=off go get github.com/tools/godep
RUN GO111MODULE=off go get github.com/gravitational/version/cmd/linkflags
RUN chmod a+w $GOPATH -R
RUN chmod a+w $GOROOT -R
