
INFODATA=$(strip $(shell awk -F=  '/^$(1)/ { print $$2; }' INFO | tr -d '"' ))

PACKAGE=$(call INFODATA,package)
VERSION=$(call INFODATA,version)
DEPENDS=$(call INFODATA,install_dep_packages)

SRC_FILE=$(call INFODATA,src_file)
SRC_SITE=$(call INFODATA,src_repo)
SRC_NAME=$(basename $(SRC_FILE))

SPK_FILES:=scripts WIZARD_UIFILES LICENCE PACKAGE_ICON.PNG
SPK_FLAGS:=--owner=root --group=root --numeric-owner --exclude-vcs

PREFIX=$(CURDIR)/arch-$*

$(info Ready for $(PACKAGE)-$(VERSION))

$(PACKAGE)-$(VERSION)-%.spk: %/package.tgz %/INFO
	@echo 'Making $@...'
	@rm -f $@
	@for file in $^ $(SPK_FILES); do if test -s $$file; then tar ${SPK_FLAGS} -rhf $@ -C $$(dirname $$file) $$(basename $$file) && echo "$$file added"; fi; done

%/package.tgz: arch-%
	@echo 'Making $@...'
	@tar ${SPK_FLAGS} -zcvf $@ -C $< $$(ls $<)

arm-none-linux-gnueabi/INFO: ARCH=88f6281 88f6258
%/INFO:
	@echo 'Making $@...'
	@sed -e 's/$$arch/\"$(ARCH)\"/' \
		 -e 's/$$model/\"$(MODEL)\"/' \
		 -e 's/^#.*$$//' INFO | tr -s "\n" > $@
		 
arch-%: configure-% build-% install-%
	@echo 'Done for $(PACKAGE)-$(VERSION) ($*)'

build-%: 
	@cd $(SRC_DIR)/$(SRC_NAME) &&\
	 PATH=$(TCH_DIR)/$*/bin:$(PATH) &&\
	 make all

install-%:
	@cd $(SRC_DIR)/$(SRC_NAME) &&\
	 PATH=$(TCH_DIR)/$*/bin:$(PATH) &&\
	 make install
	
patch-%:
	@test -f $(CURDIR)/patch/$@ &&\
	 rm -f $(FILE) &&\
	 ln -s $(CURDIR)/patch/$@ $(FILE) &&\
	 echo '$* Patched!'

clean-%:
	@rm -r $*
