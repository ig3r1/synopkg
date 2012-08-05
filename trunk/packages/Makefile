PACK_LIST:=$(strip $(subst .deps,,$(wildcard *.deps)))
ARCH_LIST:=$(strip $(notdir $(wildcard $(TCH_DIR)/*-*)))

all: build-all pack-all
	@echo 'Done for $(PACKAGE)-$(VERSION) (all)'

build-all: $(addprefix build-,$(PACK_LIST))
	@echo 'build done for all ($^)'

build-%: $(addsuffix -deps,$(addprefix %-,$(ARCH_LIST)))
	@echo 'build done for $* and dependencies ($^)'

build-%-only: 
	@cd $* && make $(addprefix arch-,$(ARCH_LIST)) $(DEBUG)
	@echo 'build done for $* only'

pack-all: $(addprefix pack-, $(PACK_LIST))
	@echo 'pack done for all ($^)'

pack-%: 
	@rm -f $*.spk
	@cd $* && make $(addsuffix .spk, $(addprefix $*-,$(ARCH_LIST))) $(DEBUG)
	@echo 'pack done for $*'
	@cd $* && mv $(addsuffix .spk, $(addprefix $*-,$(ARCH_LIST))) .. 

clean-%-spk: $*
	@cd $*-spk && make $(addprefix clean-,$(ARCH_LIST)) $(DEBUG)
	@echo 'clean done for $* only'

include $(wildcard *.deps)
