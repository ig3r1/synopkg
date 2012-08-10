export SRC_DIR:=$(realpath ./sources/)
export SPK_DIR:=$(realpath ./packages/)
export TCH_DIR:=$(realpath ./toolchains/)

export SRC_LST:=$(notdir $(wildcard $(SRC_DIR)/*-*))
export SPK_LST:=$(notdir $(wildcard $(SPK_DIR)/*-*))
export TCH_LST:=$(notdir $(wildcard $(TCH_DIR)/*-*))

all: down-all build-all pack-all trsf-all
	@echo "Done for all"
	
down-%: 
	@cd $(TCH_DIR) && make all $(DEBUG) ARCH=$(ARCH)

build-%: $(addsuffix .deps,$(wildcard $(SPK_DIR)/*-*))
	@cd $(SPK_DIR) && make $@ ARCH=$(ARCH)

pack-%:
	@cd $(SPK_DIR) && make $@ ARCH=$(ARCH)

trsf-%:
	@echo "Transfert $(SPK_DIR)/$*"

$(SPK_DIR)/%.deps: $(SPK_DIR)/%/INFO
	@echo "Make $* dependencies file..."
	@echo '$$(info Loading $* dependencies)' > $@
	@echo "$*-%-deps: $(shell grep install_dep_packages $(SPK_DIR)/$*/INFO |cut -d= -f2- | sed  -e 's/:/-%-deps /g' -e 's/=/-/g' -e 's/\(.\)$$/\1-%-deps/')" >> $@
	@echo "\t@cd $*" '&& make $$(DEBUG) arch-$$*' >> $@

clean-%:
	@cd $(SPK_DIR) && rm -rf *.deps
	@cd $(SPK_DIR) && make $@

