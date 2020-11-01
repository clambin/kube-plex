FROM golang:1.14 as builder

WORKDIR /build
COPY . /build
#COPY pkg pkg/
#COPY *.go go.mod go.sum *.toml *.lock ./

RUN CGO_ENABLED=0 GOOS=linux GOOARCH=arm go build -mod=mod -a -installsuffix cgo -o kube-plex_linux_arm ./

FROM arm32v7/alpine

COPY --from=builder /build/kube-plex_linux_arm /kube-plex
