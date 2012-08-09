
all: build-all pack-all
	@echo 'Done for $(PACKAGE)-$(VERSION) (all)'

build-all: $(addprefix build-,$(SPK_LST))
	@echo 'build done for all ($^)'

build-%: $(addsuffix -deps,$(addprefix %-,$(TCH_LST)))
	@echo 'build done for $* and dependencies ($^)'

build-%-only: 
	@cd $* && make $(addprefix arch-,$(TCH_LST)) $(DEBUG)
	@echo 'build done for $* only'

pack-all: $(addprefix pack-, $(SPK_LST))
	@echo 'pack done for all ($^)'

pack-%: 
	@cd $* && make $(addsuffix .spk, $(addprefix $*-,$(TCH_LST))) $(DEBUG)
	@echo 'pack done for $*'

clean-all: $(addprefix clean-, $(SPK_LST))
	@echo 'clean done for all ($^)'

clean-%:
	@cd $* && make $(addprefix clean-,$(TCH_LST)) $(DEBUG)
	@echo 'clean done for $* only'

include $(wildcard *.deps)
