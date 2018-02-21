# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := ecasound
$(PKG)_WEBSITE  := https://ecasound.seul.org/
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.9.1
$(PKG)_CHECKSUM := 39fce8becd84d80620fa3de31fb5223b2b7d4648d36c9c337d3739c2fad0dcf3
$(PKG)_SUBDIR   := ecasound-$($(PKG)_VERSION)
$(PKG)_FILE     := ecasound-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := https://ecasound.seul.org/download/$($(PKG)_FILE)
$(PKG)_DEPS     := cc libsamplerate libsndfile liboil jack

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://ecasound.seul.org/download/' | \
    $(SED) -n 's,.*href="ecasound-\([0-9][^"<>]*\)\.tar\.gz.*,\1,p' | \
    $(SORT) -V | \
    tail -1
endef

define $(PKG)_BUILD
    cd '$(1)' && ./configure \
        $(MXE_CONFIGURE_OPTS) \
	--enable-libsamplerate \
	--enable-sndfile \
	--enable-liboil \
	--enable-liblo \
	--enable-jack
    $(MAKE) -C '$(1)' -j '$(JOBS)' install $(MXE_DISABLE_CRUFT)
endef
