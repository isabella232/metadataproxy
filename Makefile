# bash needed for pipefail
SHELL := /bin/bash
.PHONY: test test_lint test_unit build-image
IMAGE_NAME=metadataproxy

test: test_lint test_unit

test_lint:
	mkdir -p build
	set -o pipefail; flake8 | sed "s#^\./##" > build/flake8.txt || (cat build/flake8.txt && exit 1)

test_unit:
	# Disabled for now. We need to fully mock AWS calls.
	echo nosetests tests/unit

build-image:
	ike image/build ${IMAGE_NAME}

push-image:
	ike image/push ${IMAGE_NAME}
