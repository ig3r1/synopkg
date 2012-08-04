export SRC_DIR:=$(realpath ./sources/)
export SPK_DIR:=$(realpath ./spk/)
export TCH_DIR:=$(realpath ./toolchains/)

all: build-all pack-all trsf-all
	@echo "Done for all"

build-%: $(addprefix $(SRC_DIR)/,$(addsuffix deps,$(notdir $(wildcard $(SRC_DIR)/*-spk))))
	@echo "Make $(SRC_DIR)/$*"
	@cd $(SRC_DIR) && make $@

pack-%:
	@echo "Pack $(SRC_DIR)/$*"
	@test "$*" = "all" && rm -f *.spk || rm -f $*-*.spk
	@cd $(SRC_DIR) && make $@
	@mv $(SRC_DIR)/*.spk ./

trsf-%:
	@echo "Transfert $(SRC_DIR)/$*"



$(SRC_DIR)/%-spkdeps: $(SRC_DIR)/%-spk/INFO
	@echo "Make $* dependencies file..."
	@echo '$$(info Loading $* dependencies)' > $@
	@echo "$*-%-deps: $(shell grep install_dep_packages ./$*-spk/INFO |cut -d= -f2- | sed  -e 's/:/-%-deps /g' -e 's/=/-/g' -e 's/\(.\)$$/\1-%-deps/')" >> $@
	@echo '\t@cd $*-spk && make $$(DEBUG) arch-$$*' >> $@

clean: $(addprefix clean-,$(SRC_LIST))
	@echo Clean dependency files...
	@rm -f $(SRC_DIR)/*.mk

clean-%:
	@cd $(SRC_DIR)/$* && make clean

