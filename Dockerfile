# Building the binary of the App
FROM golang:1.19 AS build

WORKDIR /go/src/tasky
COPY . .
RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /go/src/tasky/tasky

FROM alpine:3.17.0 as release

WORKDIR /app
COPY --from=build  /go/src/tasky/tasky .
COPY --from=build  /go/src/tasky/assets ./assets
COPY wizexercise.txt /app/wizexercise.txt
EXPOSE 8080

# Set environment variables
ENV MONGODB_URI="mongodb://myUserAdmin:password@ip-172-31-36-87.eu-west-2.compute.internal:27017/tasky"
ENV SECRET_KEY="secret123"

ENTRYPOINT ["/app/tasky"]


