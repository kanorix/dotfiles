# OS判定
# https://zenn.dev/atsushifx/articles/devtools-make-mutiplatform
ifeq ($(OS),Windows_NT)
    PROFILE := windows
else
    UNAME_OS := $(shell uname -s)
    ifeq ($(UNAME_OS),Linux)
        PROFILE := linux
    else ifeq ($(UNAME_OS),Darwin)
        PROFILE := macos
    else
        PROFILE := unknown
    endif
endif

.PHONY: setup
setup:
	@echo "Start setup for ${PROFILE}"
	@zsh ./scripts/install_app.sh ${PROFILE}
	@zsh ./scripts/create_link.sh ${PROFILE}
	@zsh ./${PROFILE}/setup.sh

.PHONY: check
check:
	@echo "Start check for ${PROFILE}"
	@zsh ./scripts/check_app.sh ${PROFILE}
