FROM golang:alpine as builder

WORKDIR /hiit
COPY go.mod .
COPY go.sum .
# Get dependancies - will also be cached if we won't change mod/sum
RUN go mod download
# COPY the source code as the last step
COPY . .

# Build the binary
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -installsuffix cgo -o /go/bin/hiit

FROM alpine
COPY --from=builder /go/bin/hiit /go/bin/hiit

ENTRYPOINT ["/go/bin/hiit"]