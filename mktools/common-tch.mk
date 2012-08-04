
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
