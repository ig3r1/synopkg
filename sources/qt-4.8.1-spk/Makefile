
include ../../mktools/common-inf.mk

SRC_NAME:=${PACKAGE}-everywhere-opensource-src-${VERSION}
SRC_FILE:=${SRC_NAME}.tar.gz 
SRC_REPO:=http://download.qt.nokia.com/qt/source/${SRC_FILE}

include ../../mktools/common-tch.mk
include ../../mktools/common-spk.mk

configure-arm-none-linux-gnueabi: TARGET=-embedded arm -xplatform qws/linux-arm-gnueabi-g++ -little-endian
configure-%: patch-qmutex_unix.cpp 
	@cd $(SRC_DIR)/$(SRC_NAME) &&\
	 PATH=${TCH_DIR}/$*/bin:$(PATH) &&\
	 ./configure -prefix $(CURDIR)/$* $(TARGET) -host-little-endian \
	    -nomake demos -nomake tools -nomake examples -optimized-qmake -shared -fast \
		-no-qt3support -no-mmx -no-3dnow -no-sse -no-sse2 -no-glib -no-cups -no-largefile \
		-no-accessibility -no-openssl -no-gtkstyle -no-xsync -no-xrandr -no-opengl \
		-qt-freetype -qt-gfx-linuxfb -qvfb -qt-gfx-vnc\
		-release -opensource -confirm-license
	 

patch-qmutex_unix.cpp: FILE=$(SRC_DIR)/$(SRC_NAME)/src/corelib/thread/qmutex_unix.cpp

