
VALIDDIR=$(filter-out $(wildcard $(1)), $(1))
TCH_INFO=$(strip $(shell echo $(1) | tr " " "\n" | join -t"," --nocheck-order - $(TCH_CONF) | cut -d"," -f$(2) | tr -d "\t"))
TCH_FIND=$(strip $(shell grep $(1) $(TCH_CONF) | cut -d"," -f$(2) | tr -d "\t"))

TCH_CONF:=Toolchains.csv
TCH_SITE:=http://downloads.sourceforge.net/project/dsgpl

ifeq ($(ARCH),)
ARCH=$(shell cat $(TCH_CONF) | cut -d"," -f1| tr -s "\t")
endif

TCH_LIST:=$(foreach a,$(ARCH), $(call TCH_INFO,$(filter-out $(wildcard $(a)), $(a)),3))

all: $(TCH_LIST) $(addprefix expand-,$(TCH_LIST))
	@echo "All toolchains available! $(ARCH) $^"

expand-%.tar.gz: CMD=tar -zxvf
expand-%.tgz: CMD=tar -zxvf
expand-%.tar: CMD=tar -xvf
expand-%.zip: CMD=gunzip
expand-%:
	@$(CMD) $*

%.tar: down-%.tar
	@echo "$@ downloaded!"

%.tgz: down-%.tgz
	@echo "$@ downloaded!"

%.tar.gz:down-%.tar.gz
	@echo "$@ downloaded!"

%.zip:down-%.zip
	@echo "$@ downloaded!"

down-%:
	@wget -O "$*" "$(TCH_SITE)/$(call TCH_FIND,$*,2)/$*"




