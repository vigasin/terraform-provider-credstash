# Terraform provider for credstash secrets

[![CircleCI](https://circleci.com/gh/sspinc/terraform-provider-credstash.svg?style=svg)](https://circleci.com/gh/sspinc/terraform-provider-credstash)

Read secrets stored with [credstash][credstash].

## Install

1. [Download the binary][provider_binary]
2. Create a terraformrc file

        # ~/.terraformrc
        providers {
            credstash = "/path/to/bin/terraform-provider-credstash"
        }
3. Profit

### From source

    $ go get -v -u github.com/sspinc/terraform-provider-credstash

## Usage

```hcl
provider "credstash" {
    table  = "credential-store"
    region = "us-east-1"
}

data "credstash_secret" "rds_password" {
    name = "rds_password"
}

data "credstash_secret" "my_secret" {
    name    = "some_secret"
    version = "0000000000000000001"
}

resource "aws_db_instance" "postgres" {
    password = "${data.credstash_secret.rds_password.value}"

    # other important attributes
}
```

## AWS credentials

AWS credentials are not directly set. Use one of the methods discussed
[here][awscred].

You can set a specific profile to use:

```hcl
provider "credstash" {
    region  = "us-east-1"
    profile = "my-profile"
}
```

## Dependencies

[dep][] is used for dependency management.

Vendored files are not included in the repo. Before making any changes:

1. Install dep: `go get -u github.com/golang/dep/cmd/dep`
2. Run `make deps`

[credstash]: https://github.com/fugue/credstash
[awscred]: https://github.com/aws/aws-sdk-go#configuring-credentials
[provider_binary]: https://github.com/sspinc/terraform-provider-credstash/releases/latest
[dep]: https://github.com/golang/dep
