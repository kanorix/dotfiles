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
	@./${PROFILE}/setup.sh
	@./scripts/create_link.sh ${PROFILE}
	@echo "End setup!"

.PHONY: check
check:
	@echo "Start check for ${PROFILE}"
	@./scripts/check_app.sh ${PROFILE}
