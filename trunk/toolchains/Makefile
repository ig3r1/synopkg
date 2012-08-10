
VALIDDIR=$(filter-out $(wildcard $(1)), $(1))
TCH_INFO=$(strip $(shell echo $(1) | tr " " "\n" | join -t"," --nocheck-order - $(TCH_CONF) | cut -d"," -f$(2) | tr -d "\t"))
TCH_FIND=$(strip $(shell grep $(1) $(TCH_CONF) | cut -d"," -f$(2) | tr -d "\t"))

TCH_CONF:=Toolchains.csv
TCH_SITE:=http://downloads.sourceforge.net/project/dsgpl

ifeq ($(ARCH),)
ARCH=$(shell cat $(TCH_CONF) | tr -s "\t" | cut -f1)
endif

expand: down-all expand-tgz expand-tar.gz expand-tar expand-zip

expand-tar.gz: CMD=tar -zxvf
expand-tgz: CMD=tar -zxvf
expand-tar: CMD=tar -xvf
expand-zip: CMD=gunzip
expand-%:
	@test -n "$(wildcard *.$*)" && (for file in $(wildcard *.$*); do $(CMD) $$file; done) || return 0

down-all: $(call TCH_INFO,$(ARCH),3)
	@echo "All toolchains downloaded!"

%.tar: down-%.tar
	@echo $@ downloaded!

%.tgz: down-%.tgz
	@echo $@ downloaded!

%.tar.gz:down-%.tar.gz
	@echo $@ downloaded!

%.zip:down-%.zip
	@echo $@ downloaded!

down-%:
	@wget -O "$*" "$(TCH_SITE)/$(call TCH_FIND,$*,2)/$*"




