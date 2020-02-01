#!/usr/bin/env bash
include .env
export $(shell sed 's/=.*//' .env)


help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

.PHONY: help build run stop destroy

# DOCKER TASKS
build: ## build the project image.     
	@docker build -t $(IMAGE_NAME) --rm --target $(APP_ENV) .\
	 --build-arg NODE_VERSION=${NODE_VERSION} \
	 --build-arg NGINX_VERSION=${NGINX_VERSION}


run: ## Run an already built project
	@docker-compose up -d

stop: ## Stop an already running project
	@docker-compose stop

destroy: ## Destroy an already built project
	@docker-compose down
	@docker-compose rm -f
