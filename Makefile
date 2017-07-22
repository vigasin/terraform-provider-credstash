PACKAGES = $(shell go list ./... | grep -v vendor)

install:
	go install -v

build:
	go build -v -i -o terraform-provider-credstash

test:
	go test $(TESTOPTS) $(PACKAGES)

release:
	GOOS=darwin go build -v -o terraform-provider-credstash_darwin_amd64
	GOOS=linux go build -v -o terraform-provider-credstash_linux_amd64

deps:
	# We need to completely clean the vendor folder because of a bug in dep.
	# See https://github.com/golang/dep/issues/290 for more details.
	rm -rf vendor/
	dep ensure

.DEFAULT: build
