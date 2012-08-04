PACK_LIST:=$(strip $(wildcard *-spk))
ARCH_LIST:=$(strip $(notdir $(wildcard $(TCH_DIR)/*-*)))

all: build-all pack-all
	@echo 'Done for $(PACKAGE)-$(VERSION) (all)'

%-all: $(addprefix %-,$(PACK_LIST))
	@echo '$* done for all'

build-%-spk: $(addsuffix -deps,$(addprefix %-,$(ARCH_LIST)))
	@echo 'build done for $* and dependencies'

build-%-spk-only: $*-spk
	@cd $*-spk && make $(addprefix arch-,$(ARCH_LIST)) $(DEBUG)
	@echo 'build done for $* only'

pack-%-spk: $*
	@rm -f $*-*.spk
	@cd $*-spk && make $(addsuffix .spk, $(addprefix $*-,$(ARCH_LIST))) $(DEBUG)
	@echo 'pack done for $*'
	@mv $*-spk/*.spk ./

clean-%-spk: $*
	@cd $*-spk && make $(addprefix clean-,$(ARCH_LIST)) $(DEBUG)
	@echo 'clean done for $* only'

include $(wildcard *.deps)
