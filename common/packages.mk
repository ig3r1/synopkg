
INFODATA=$(strip $(shell awk -F=  '/^$(1)/ { print $$2; }' INFO | tr -d '"' ))
VALIDDIR=$(filter-out $(wildcard $(1)), $(1))


PACKAGE=$(call INFODATA,package)
VERSION=$(call INFODATA,version)
DEPENDS=$(call INFODATA,install_dep_packages)

SRC_TYPE=$(call INFODATA,src_type)
SRC_SITE=$(call INFODATA,src_site)
SRC_NAME=$(call INFODATA,src_name)

SPK_FILES:=scripts WIZARD_UIFILES LICENCE PACKAGE_ICON.PNG
SPK_FLAGS:=--owner=root --group=root --numeric-owner --exclude-vcs

ifeq ($(SRC_DIR),)
SRC_DIR:=..
endif

PREFIX=$(CURDIR)/arch-$*
SOURCE=$(SRC_DIR)/$(PACKAGE)-$(VERSION)

$(info Making $(SOURCE) to $(CURDIR)...)

$(PACKAGE)-$(VERSION)-%.spk: arch-%/package.tgz arch-%/INFO
	@echo 'Making $@...'
	@rm -f $@
	@for file in $^ $(SPK_FILES); do if test -s $$file; then tar $(SPK_FLAGS) -rhf $@ -C $$(dirname $$file) $$(basename $$file) && echo "$$file added"; fi; done

arch-%/package.tgz: arch-%
	@echo 'Making $@...'
	@tar $(SPK_FLAGS) -zcvf $@ -C $< $$(ls $<)

arch-arm-none-linux-gnueabi/INFO: ARCH=88f6281 88f6258
arch-%/INFO:
	@echo 'Making $@...'
	@sed -e 's/$$arch/\"$(ARCH)\"/' \
		 -e 's/$$model/\"$(MODEL)\"/' \
		 -e 's/^#.*$$//' INFO | tr -s "\n" > $@

arch-%: build-%
	@cd $(SOURCE) &&\
	 PATH=$(TCH_DIR)/$*/bin:$(PATH) &&\
	 make install

build-%: configure-%
	@cd $(SOURCE) &&\
	 PATH=$(TCH_DIR)/$*/bin:$(PATH) &&\
	 make all
	
patch-%: 
	@test -f $(CURDIR)/patch/$@ &&\
	 rm -f $(FILE) &&\
	 ln -s $(CURDIR)/patch/$@ $(FILE) &&\
	 echo '$* Patched!'

clean-%:
	@rm -rf arch-$* *$**.spk


ifneq ($(SRC_SITE),)

$(SRC_DIR)/$(PACKAGE)-$(VERSION): $(SRC_DIR)/$(SRC_NAME)
	cd $(SRC_DIR) && ln -s $(SRC_NAME) $(PACKAGE)-$(VERSION)

$(SRC_DIR)/$(SRC_NAME): $(SRC_DIR)/$(SRC_NAME).$(SRC_TYPE)
	@echo '$(SRC_NAME) uncompressed and ready'
	
$(SRC_DIR)/$(SRC_NAME).tar.gz:UNCOMPRESS=tar -zxvf
$(SRC_DIR)/$(SRC_NAME).tgz: UNCOMPRESS=tar -zxvf
$(SRC_DIR)/$(SRC_NAME).tgz: UNCOMPRESS=tar -xvf
$(SRC_DIR)/$(SRC_NAME).%: 
	@test -n "$(UNCOMPRESS)" && cd $(SRC_DIR) && wget $(SRC_SITE)/$(SRC_NAME).$* && $(UNCOMPRESS) $(SRC_NAME).$*

endif
