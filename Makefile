MINOR_VERSION = 0
ifdef CIRCLE_BUILD_NUM
  MINOR_VERSION = $(CIRCLE_BUILD_NUM)
endif
VERSION=$(shell cat VERSION).$(MINOR_VERSION)

# Display general help about this command
help:
	@echo ""
	@echo "Welcome to infra-terraform make"
	@echo ""

build:
	docker build -t hootware/infrastructure:$(VERSION) -t hootware/infrastructure:latest .
