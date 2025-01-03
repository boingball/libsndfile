#!/usr/bin/make -f

# This is probably only going to work with GNU Make.
# This in a separate file instead of in Makefile.am because Automake complains
# about the GNU Make-isms.

EXEEXT = 

PACKAGE_VERSION = 1.2.2

HOST_TRIPLET = m68k-unknown-amigaos

SRC_BINDIR = src/.libs/
TEST_BINDIR = tests/.libs/

LIBRARY := $(SRC_BINDIR)libsndfile.so.$(LIB_VERSION)

LIB_VERSION := $(shell echo $(PACKAGE_VERSION) | sed -e 's/[a-z].*//')

TESTNAME = libsndfile-testsuite-$(HOST_TRIPLET)-$(PACKAGE_VERSION)

TARBALL = $(TESTNAME).tar.gz

# Find the test programs by grepping the script for the programs it executes.
testprogs := $(shell grep '^\./' tests/test_wrapper.sh | sed -e "s|./||" -e "s/ .*//" | sort | uniq)
# Also add the programs not found by the above.
testprogs += tests/sfversion$(EXEEXT) tests/stdin_test$(EXEEXT) tests/stdout_test$(EXEEXT) \
				tests/cpp_test$(EXEEXT) tests/win32_test$(EXEEXT)

libfiles := $(shell if test ! -z $(EXEEXT) ; then echo "src/libsndfile-1.def src/.libs/libsndfile-1.dll" ; elif test -f $(LIBRARY) ; then echo $(LIBRARY) ; fi  ; fi)

testbins := $(testprogs) $(libfiles)

all : $(TARBALL)

clean :
	rm -rf $(TARBALL) $(TESTNAME)/

check : $(TESTNAME)/test_wrapper.sh
	(cd ./$(TESTNAME)/ && ./test_wrapper.sh)

$(TARBALL) : $(TESTNAME)/test_wrapper.sh
	tar zcf $@ $(TESTNAME)
	rm -rf $(TESTNAME)
	@echo
	@echo "Created : $(TARBALL)"
	@echo

$(TESTNAME)/test_wrapper.sh : tests/test_wrapper.sh tests/pedantic-header-test.sh
	rm -rf $(TESTNAME)
	mkdir -p $(TESTNAME)/tests/
	echo
	echo $(testbins)
	echo
	cp $(testbins) $(TESTNAME)/tests/
	cp tests/test_wrapper.sh $(TESTNAME)/
	cp tests/pedantic-header-test.sh $(TESTNAME)/tests/
	chmod u+x $@

tests/test_wrapper.sh : tests/test_wrapper.sh.in
	make $@
