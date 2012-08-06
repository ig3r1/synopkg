
include ../../common/packages.mk

configure-arm-none-linux-gnueabi: TARGET=qws/linux-arm-gnueabi-g++
configure-%: 
	@cd $(SRC_DIR)/$(SRC_NAME) &&\
	 QTDIR=$(SPK_DIR)/qt/arch-$* &&\
	 PATH=$(TCH_DIR)/$*/bin:$$QTDIR/bin:$(PATH) &&\
	 qmake "PREFIX=$(CURDIR)/arch-$*" -spec $$QTDIR/mkspecs/$(TARGET) -o Makefile
