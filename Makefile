# Using bash
SHELL := /bin/bash

# One worker at the time
MAKEFLAGS = --jobs=1

.PHONY: init
init: ## 配置開發環境的相關套件
	pip3 install ansible-lint pre-commit
	pre-commit install
	$(MAKE) update

.PHONY: update
update: ## 更新源碼以及 roles
	git fetch --all
	git pull
	ansible-galaxy install --ignore-errors -r roles/requirements.yml
	ansible-galaxy collection install --ignore-errors -r collections/requirements.yml

.PHONY: docker
docker: ## 啟動擁有 ansible 的 docker 環境
	docker build -t ansible .
	docker run -it --rm -v ${PWD}:/devops -w /devops ansible bash

.PHONY: clean
clean: ## 清理 log 檔案
	rm -rvf *.log
	rm -rvf playbooks/*.retry
	rm -rvf playbooks/**/*.retry

# Absolutely awesome: http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help
