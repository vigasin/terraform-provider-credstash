VERSION = $(shell git tag --sort=version:refname  | tail -1)
VERSION_PLAIN = $(shell git tag --sort=version:refname  | tail -1 | cut -c2-)
OS = $(shell uname -s | tr A-Z a-z)

build:
	go build -v -i -o terraform-provider-credstash

test:
	go test ./...

install: build
	mkdir -p ~/.terraform.d/plugins/hdw.mx/terraform/credstash/$(VERSION_PLAIN)/$(OS)_amd64
	cp terraform-provider-credstash  ~/.terraform.d/plugins/hdw.mx/terraform/credstash/$(VERSION_PLAIN)/$(OS)_amd64/terraform-provider-credstash_$(VERSION)

release:
	GOOS=darwin go build -v -o terraform-provider-credstash_darwin_amd64
	GOOS=linux go build -v -o terraform-provider-credstash_linux_amd64
