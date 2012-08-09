
TCH_LIST:=Toolchains.csv
TCH_SITE:=http://downloads.sourceforge.net/project/dsgpl/DSM 4.0 Tool Chains

down-all: $(shell cat $(TCH_LIST) | cut -d":" -f2 ) expand
	@echo "All toolchains downloaded!"

%.tgz:
	@wget -O "$@" "$(TCH_SITE)/$(shell grep '$@' $(TCH_LIST) | tr ':' '/')" && tar -zxvf $@

%.tar.gz:
	@wget -O "$@" "$(TCH_SITE)/$(shell grep '$@' $(TCH_LIST) | tr ':' '/')" && tar -zxvf $@

%.tar:
	@wget -O "$@" "$(TCH_SITE)/$(shell grep '$@' $(TCH_LIST) | tr ':' '/')" && tar -xvf $@

%.zip:
	@wget -O "$@" "$(TCH_SITE)/$(shell grep '$@' $(TCH_LIST) | tr ':' '/')" && gunzip $@

expand:
	@for file in $$(ls *.tgz *.tar.gz); do tar -zxvf $$file; done
	@for file in $$(ls *.tar); do tar -xvf $$file; done
	@for file in $$(ls *.zip); do gunzip $$file; done
