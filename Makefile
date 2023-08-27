SHELL := bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

ifeq ($(origin .RECIPEPREFIX), undefined)
  $(error This Make does not support .RECIPEPREFIX. Please use GNU Make 4.0 or later)
endif
.RECIPEPREFIX = >

FILES=$(shell find . -name "*.go")

all: zerotv

clean:
> rm zerotv

zerotv: $(FILES)
> env GOARCH=arm GOARM=6 GOOS=linux CGO_ENABLED=0 go build -o zerotv zerotv.go

dist: zerotv
> scp zerotv zerotv:

.PHONY: cloudflared
cloudflared:
> pushd cloudflared ; rm -f built_artifacts/* ; ./build-packages.sh

dist-cloudflared:
> scp cloudflared/built_artifacts/*.deb zerotv:
