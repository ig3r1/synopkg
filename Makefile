export SRC_DIR:=$(realpath ./sources/)
export SPK_DIR:=$(realpath ./packages/)
export TCH_DIR:=$(realpath ./toolchains/)

all: build-all pack-all trsf-all
	@echo "Done for all"
	
down-tch: 
	@cd $(TCH_DIR) && make all

build-%: $(addsuffix .deps,$(wildcard $(SPK_DIR)/*-*))
	@echo "Make $(SPK_DIR)/$*"
	@cd $(SPK_DIR) && make $@

pack-%:
	@echo "Pack $(SPK_DIR)/$*"
	@test "$*" = "all" && rm -f *.spk || rm -f $*-*.spk
	@cd $(SPK_DIR) && make $@
	@mv $(SPK_DIR)/*.spk ./

trsf-%:
	@echo "Transfert $(SPK_DIR)/$*"

$(SPK_DIR)/%.deps: $(SPK_DIR)/%/INFO
	@echo "Make $* dependencies file..."
	@echo '$$(info Loading $* dependencies)' > $@
	@echo "$*-%-deps: $(shell grep install_dep_packages $(SPK_DIR)/$*/INFO |cut -d= -f2- | sed  -e 's/:/-%-deps /g' -e 's/=/-/g' -e 's/\(.\)$$/\1-%-deps/')" >> $@
	@echo "\t@cd $*" '&& make $$(DEBUG) arch-$$*' >> $@
	@cat $@


