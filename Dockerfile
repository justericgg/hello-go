FROM golang:1.11.4-alpine3.7 as builder
RUN apk update && apk add git
WORKDIR /hello-go
COPY go.mod .
COPY go.sum .
RUN go mod download
COPY ./ ./
WORKDIR /hello-go
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -installsuffix cgo -o /go/bin/app

FROM alpine:3.7
RUN apk add --no-cache ca-certificates && apk add tzdata
ENV TZ=Asia/Taipei
WORKDIR /go/bin
COPY --from=builder /go/bin/app /go/bin/app
EXPOSE 1216
ENTRYPOINT ["/go/bin/app"]