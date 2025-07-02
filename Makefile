VERSION = $(shell git tag --sort=version:refname  | tail -1)
VERSION_PLAIN = $(shell git tag --sort=version:refname  | tail -1 | cut -c2-)
OS = $(shell uname -s | tr A-Z a-z)
ARCH = $(shell uname -m | sed 's/x86_64/amd64/' | sed 's/aarch64/arm64/')

build:
	go build -v -i -o terraform-provider-credstash

build-current:
	go build -v -o terraform-provider-credstash_$(OS)_$(ARCH)

test:
	go test ./...

install: build
	mkdir -p ~/.terraform.d/plugins/hdw.mx/terraform/credstash/$(VERSION_PLAIN)/$(OS)_$(ARCH)
	cp terraform-provider-credstash ~/.terraform.d/plugins/hdw.mx/terraform/credstash/$(VERSION_PLAIN)/$(OS)_$(ARCH)/terraform-provider-credstash_$(VERSION)

release:
	GOOS=darwin go build -v -o terraform-provider-credstash_darwin_amd64
	GOOS=linux go build -v -o terraform-provider-credstash_linux_amd64
