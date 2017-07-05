GOPATH := $(shell pwd)

all: HttpServer

test: Test

Test:
	@GOPATH=$(GOPATH) go get -d
	@GOPATH=$(GOPATH) go test -v ../DbSet/Redis_test.go ../DbSet/Redis.go

HttpServer:
	@GOPATH=$(GOPATH) go get -d
	@GOPATH=$(GOPATH) go build -o $@

clean:
	@GOPATH=$(GOPATH) go clean
	@${RM} -r pkg/ src/

.PHONY: HttpServer
