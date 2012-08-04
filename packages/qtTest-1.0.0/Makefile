
include ../../tools/packages.mk

configure-arm-none-linux-gnueabi: TARGET=qws/linux-arm-gnueabi-g++
configure-%: 
	@cd $(SRC_DIR)/$(SRC_NAME) &&\
	 PATH=$(TCH_DIR)/$*/bin:$(PATH) &&\
	 ../qt/$*/bin/qmake "PREFIX=$(CURDIR)/$*" -spec ../qt/$*/mkspecs/$(TARGET) -o Makefile
