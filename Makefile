SHELL=/bin/bash
#vars
UBIDOTS_PYPI_SERVER=http://169.53.160.59:8080
UBIDOTS_PYPI_USERNAME=ubidots_dev
CELERY_LOG_LEVEL=info

.PHONY: help validate_code

help:
	    @echo "Makefile commands:"
	    @echo "test: run tests for mercury."
	    @echo "add_pypi_repo: adds ubidots private repo to poetry. Requires UBIDOTS_PYPI_PASSWORD env variable to be defined."
		@echo "build: allows to build the mercury code for publish."
		@echo "publish: publishes a new version of the code to the pypi server."

.DEFAULT_GOAL := validate_code


test:
	poetry run pytest


add_pypi_repo:
	poetry config repositories.ubidots ${UBIDOTS_PYPI_SERVER}
	@poetry config http-basic.ubidots ${UBIDOTS_PYPI_USERNAME} ${UBIDOTS_PYPI_PASSWORD}

build:
	poetry build

publish: build
	poetry publish -r ubidots

