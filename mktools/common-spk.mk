
SPK_TMPL:=scripts WIZARD_UIFILES LICENCE PACKAGE_ICON.PNG
TAR_OPTS:=--owner=root --group=root --numeric-owner --exclude-vcs

$(PACKAGE)-$(VERSION)-%.spk: %/package.tgz %/INFO
	@echo 'Making $@...'
	@rm -f $@
	@for file in $^ $(SPK_TMPL); do if test -s $$file; then tar ${TAR_OPTS} -rhf $@ -C $$(dirname $$file) $$(basename $$file) && echo "$$file added"; fi; done

%/package.tgz: 
	@echo 'Making $@...'
	@tar ${TAR_OPTS} -zcvf $@ -C $* $$(ls $*)

arm-none-linux-gnueabi/INFO: ARCH=88f6281 88f6258
%/INFO:
	@echo 'Making $@...'
	@sed -e 's/$$arch/\"$(ARCH)\"/' \
		 -e 's/$$model/\"$(MODEL)\"/' \
		 -e 's/^#.*$$//' INFO | tr -s "\n" > $@
