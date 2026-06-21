FROM golang:1.26-alpine AS builder
MAINTAINER xtaci <daniel820313@gmail.com>

WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o server ./server/ && CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o client ./client/

FROM alpine:3.18
COPY --from=builder /app/server /bin
COPY --from=builder /app/client /bin
#CMD ["/bin/server"]
CMD ["/bin/client"] 
