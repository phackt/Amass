FROM golang:alpine as build
RUN apk --no-cache add git
RUN go get github.com/phackt/Amass; exit 0
ENV GO111MODULE on
WORKDIR /go/src/github.com/phackt/Amass
RUN go install ./...

FROM alpine:latest
RUN apk --no-cache add ca-certificates
COPY --from=build /go/bin/amass /bin/amass
COPY --from=build /go/src/github.com/phackt/Amass/examples/wordlists/ /wordlists/
ENV HOME /
ENTRYPOINT ["/bin/amass"]
