# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := ecasound
$(PKG)_WEBSITE  := https://ecasound.seul.org/
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.9.3
$(PKG)_CHECKSUM := 468bec44566571043c655c808ddeb49ae4f660e49ab0072970589fd5a493f6d4
$(PKG)_SUBDIR   := ecasound-$($(PKG)_VERSION)
$(PKG)_FILE     := ecasound-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := https://ecasound.seul.org/download/$($(PKG)_FILE)
$(PKG)_DEPS     := cc dlfcn-win32 ncurses libsamplerate libsndfile liboil jack

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://ecasound.seul.org/download/' | \
    $(SED) -n 's,.*href="ecasound-\([0-9][^"<>]*\)\.tar\.gz.*,\1,p' | \
    $(SORT) -V | \
    tail -1
endef

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && '$(SOURCE_DIR)'/configure \
        $(MXE_CONFIGURE_OPTS) \
	--enable-libsamplerate \
	--enable-sndfile \
	--enable-liboil \
	--enable-liblo \
	--enable-jack \
	LIBS="-lws2_32 -ldl"
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' $(MXE_DISABLE_CRUFT)
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install $(MXE_DISABLE_CRUFT)
endef
