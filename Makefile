# Help command adapted from https://gist.github.com/prwhite/8168133#gistcomment-2749866
SHELL=bash

# Formating
GREEN  := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
WHITE  := $(shell tput -Txterm setaf 7)
RESET  := $(shell tput -Txterm sgr0)
COLUMNS := $(shell tput cols)

.DEFAULT_GOAL := help
## Print this help
.PHONY: help
help:
	@printf "ZshFiles\n\n"
	@printf "USAGE:\n"
	@printf "┌"
	@printf "%.0s━" {4..$(COLUMNS)}
	@printf "┐\n"

	@awk '{ \
			if ($$0 ~ /^.PHONY: [a-zA-Z\-\_0-9]+$$/) { \
				helpCommand = substr($$0, index($$0, ":") + 2); \
				if (helpMessage) { \
					printf "│\033[36m  %-17s\033[0m│ %-56s│\n", \
						helpCommand, helpMessage; \
					helpMessage = ""; \
				} \
			} else if ($$0 ~ /^[a-zA-Z\-\_0-9.]+:/) { \
				helpCommand = substr($$0, 0, index($$0, ":")); \
				if (helpMessage) { \
					printf "\033[36m%-20s\033[0m %s\n", \
						helpCommand, helpMessage; \
					helpMessage = ""; \
				} \
			} else if ($$0 ~ /^##/) { \
				if (helpMessage) { \
					helpMessage = helpMessage"\n                     "substr($$0, 3); \
				} else { \
					helpMessage = substr($$0, 3); \
				} \
			} else { \
				if (helpMessage) { \
					print "\n                     "helpMessage"\n" \
				} \
				helpMessage = ""; \
			} \
		}' \
		$(MAKEFILE_LIST)
	@printf "└"
	@printf "%.0s━" {4..$(COLUMNS)}
	@printf "┘"

## Link .zshenv to ~/.zshenv
.PHONY: link
link:
	@scripts/link-zshenv

install: link

## Install plugins
.PHONY: install-plugins
install-plugins:
	git submodule update --init --recursive

## Update plugins (all submodules)
.PHONY: update-plugins
update-plugins:
	@scripts/update-submodules

