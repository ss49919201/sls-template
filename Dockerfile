FROM golang:1.21.0 as build
WORKDIR /app
COPY . .
RUN GOOS=linux GOARCH=amd64 go build -o main main.go

FROM public.ecr.aws/lambda/provided:al2
COPY --from=build /app/main /main
ENTRYPOINT ["/usr/local/bin/aws-lambda-rie"]
CMD ["/main"]
