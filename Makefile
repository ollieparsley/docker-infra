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
	@echo "make build-infra"
	@echo "make build-infra"
	@echo ""

build-infra:
	cd building && docker build -t hootware/infrastructure:$(VERSION) -t hootware/infrastructure:latest .

build-mysql-backup:
	cd mysql-backup && docker build -t hootware/mysql-backup:$(VERSION) -t hootware/mysql-backup:latest .
