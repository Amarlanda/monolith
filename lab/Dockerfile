FROM golang
RUN apk add --no-cache bash
RUN mkdir /app
ADD . /app
WORKDIR /app
RUN go build -o main . 
RUN adduser -S -D -H -h /app appuser
USER appuser
EXPOSE 3000
CMD ["./main"]
