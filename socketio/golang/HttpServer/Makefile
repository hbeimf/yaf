GOPATH := $(shell pwd)

all: HttpServer

HttpServer:
	@GOPATH=$(GOPATH) go get -d
	@GOPATH=$(GOPATH) go build -o $@

clean:
	@GOPATH=$(GOPATH) go clean
	@${RM} -r pkg/ src/

.PHONY: HttpServer
