#
#  Copyright (c) 2018 - Present  European Spallation Source ERIC
#
#  The program is free software: you can redistribute
#  it and/or modify it under the terms of the GNU General Public License
#  as published by the Free Software Foundation, either version 2 of the
#  License, or any newer version.
#
#  This program is distributed in the hope that it will be useful, but WITHOUT
#  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
#  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
#  more details.
#
#  You should have received a copy of the GNU General Public License along with
#  this program. If not, see https://www.gnu.org/licenses/gpl-2.0.txt
#
# 
# Author  : Joao Paulo Martins
# email   : joaopaulo.martins@esss.se
# Date    : 2019Mar05-1610-35CET
# version : 0.0.0 
#
# template file is generated by ./e3TemplateGenerator.bash with c396a4d
# Please look at many other _module_.Makefile in e3-* repository
# 

## The following lines are mandatory, please don't change them.
where_am_I := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
include $(E3_REQUIRE_TOOLS)/driver.makefile
include $(E3_REQUIRE_CONFIG)/DECOUPLE_FLAGS



# If one would like to use the module dependency restrictly,
# one should look at other modules makefile to add more
# In most case, one should ignore the following lines:

ifneq ($(strip $(FASTACQUISITION_DEP_VERSION)),)
fastacquisition_VERSION=$(FASTACQUISITION_DEP_VERSION)
endif

ifneq ($(strip $(SCANNING_DEP_VERSION)),)
scanning_VERSION=$(SCANNING_DEP_VERSION)
endif

ifneq ($(strip $(SEQUENCER_DEP_VERSION)),)
sequencer_VERSION=$(SEQUENCER_DEP_VERSION)
endif

ifneq ($(strip $(SSCAN_DEP_VERSION)),)
sscan_VERSION=$(SSCAN_DEP_VERSION)
endif

## Exclude linux-ppc64e6500
##EXCLUDE_ARCHS = linux-ppc64e6500

# APP:=calcApp
APPDB:=db
APPSRC:=src

# USR_INCLUDES += -I$(where_am_I)$(APPSRC)

# USR_CFLAGS   += -Wno-unused-variable
# USR_CFLAGS   += -Wno-unused-function
# USR_CFLAGS   += -Wno-unused-but-set-variable
# USR_CPPFLAGS += -Wno-unused-variable
# USR_CPPFLAGS += -Wno-unused-function
# USR_CPPFLAGS += -Wno-unused-but-set-variable

# TEMPLATES += $(wildcard $(APPDB)/*.db)
# TEMPLATES += $(wildcard $(APPDB)/*.db)
# TEMPLATES += $(wildcard $(APPDB)/*.proto)
TEMPLATES += $(wildcard $(APPDB)/*.template)


# DBDINC_SRCS += $(APPSRC)/swaitRecord.c
# DBDINC_SRCS += $(APPSRC)/sseqRecord.c
# DBDINC_SRCS += $(APPSRC)/aCalcoutRecord.c
# DBDINC_SRCS += $(APPSRC)/sCalcoutRecord.c
# DBDINC_SRCS += $(APPSRC)/transformRecord.c

# DBDINC_DBDS = $(subst .c,.dbd,   $(DBDINC_SRCS:$(APPSRC)/%=%))
# DBDINC_HDRS = $(subst .c,.h,     $(DBDINC_SRCS:$(APPSRC)/%=%))
# DBDINC_DEPS = $(subst .c,$(DEP), $(DBDINC_SRCS:$(APPSRC)/%=%))


# HEADERS += $(APPSRC)/sCalcPostfix.h
# HEADERS += $(APPSRC)/aCalcPostfix.h
# HEADERS += $(DBDINC_HDRS)


SOURCES += $(APPSRC)/EMU_CALCULS.c
SOURCES += $(APPSRC)/EMU_REPORT_FILE.c
#SOURCES += $(APPSRC)/EMU_MTR-CHECKBRAKE.st
#SOURCES += $(APPSRC)/EMU_MTR-HOME_AUTO.st

# SOURCES += $(APPSRC)/aCalcPostfix.c
# SOURCES += $(APPSRC)/aCalcPerform.c

# SOURCES += $(APPSRC)/calcUtil.c
# SOURCES += $(APPSRC)/myFreeListLib.c
# SOURCES += $(APPSRC)/devsCalcoutSoft.c
# SOURCES += $(APPSRC)/devaCalcoutSoft.c
# SOURCES += $(APPSRC)/subAve.c
# SOURCES += $(APPSRC)/swaitRecord.c
# SOURCES += $(APPSRC)/editSseq.st
# SOURCES += $(APPSRC)/interp.c
# SOURCES += $(APPSRC)/arrayTest.c
# SOURCES += $(APPSRC)/aCalcMonitorMem.c
# # DBDINC_SRCS should be last of the series of SOURCES
# SOURCES += $(DBDINC_SRCS)

DBDS += $(APPSRC)/emu.dbd
# DBDS += $(APPSRC)/calcSupport_withSNCSEQ.dbd
# DBDS += $(APPSRC)/calcSupport_withSSCAN.dbd

#
# $(DBDINC_DEPS): $(DBDINC_HDRS)
#
# .dbd.h:
# 	$(DBTORECORDTYPEH)  $(USR_DBDFLAGS) -o $@ $<
#
# .PHONY: $(DBDINC_DEPS) .dbd.h
#
#

# ## xxxRecord.dbd Local Codes 
# DBDINC_SUFF = cpp
# DBDINC_PATH = $(OPCUASRC)
# DBDINC_SRCS = $(DBDINC_PATH)/opcuaItemRecord.$(DBDINC_SUFF)

# ## xxxRecord.dbd Generic Codes : BEGIN
# DBDINC_DBDS = $(subst .$(DBDINC_SUFF),.dbd,   $(DBDINC_SRCS:$(DBDINC_PATH)/%=%))
# DBDINC_HDRS = $(subst .$(DBDINC_SUFF),.h,     $(DBDINC_SRCS:$(DBDINC_PATH)/%=%))
# DBDINC_DEPS = $(subst .$(DBDINC_SUFF),$(DEP), $(DBDINC_SRCS:$(DBDINC_PATH)/%=%))

# HEADERS += $(DBDINC_HDRS)
# SOURCES += $(DBDINC_SRCS)

# $(DBDINC_DEPS): $(DBDINC_HDRS)

# .dbd.h:
# 	$(DBTORECORDTYPEH)  $(USR_DBDFLAGS) -o $@ $<

# .PHONY: $(DBDINC_DEPS) .dbd.h
# ## Record.dbd Generic codes : END

# The following lines could be useful if one uses the external lib
#
# Examples...
# 
# USR_CFLAGS += -fPIC
# USR_CFLAGS   += -DDEBUG_PRINT
# USR_CPPFLAGS += -DDEBUG_PRINT
# USR_CPPFLAGS += -DUSE_TYPED_RSET
# USR_INCLUDES += -I/usr/include/libusb-1.0
# USR_LDFLAGS += -lusb-1.0
# USR_LDFLAGS += -L /opt/etherlab/lib
# USR_LDFLAGS += -lethercat
# USR_LDFLAGS += -Wl,-rpath=/opt/etherlab/lib

## SYSTEM LIBS 
##
# USR_LIBS += boost_regex
# USR_LIBS += readline
# USR_LIBS += xml2

#

#
# ifeq ($(T_A),linux-x86_64)
# USR_LDFLAGS += -Wl,--enable-new-dtags
# USR_LDFLAGS += -Wl,-rpath=$(E3_MODULES_VENDOR_LIBS_LOCATION)
# USR_LDFLAGS += -L$(E3_MODULES_VENDOR_LIBS_LOCATION)
# USR_LDFLAGS += -lflycapture
# endif

# According to its makefile
# VENDOR_LIBS += $(SUPPORT)/os/linux-x86_64/libflycapture.so.2.8.3.1
# VENDOR_LIBS += $(SUPPORT)/os/linux-x86_64/libflycapture.so.2
# VENDOR_LIBS += $(SUPPORT)/os/linux-x86_64/libflycapture.so



SCRIPTS += $(wildcard ../iocsh/*.iocsh)


## This RULE should be used in case of inflating DB files 
## db rule is the default in RULES_DB, so add the empty one
## Please look at e3-mrfioc2 for example.

# db: 

# .PHONY: db 


USR_DBFLAGS += -I . -I ..
USR_DBFLAGS += -I $(EPICS_BASE)/db
USR_DBFLAGS += -I $(APPDB)

SUBS=$(wildcard $(APPDB)/*.substitutions)
TMPS=$(wildcard $(APPDB)/*.template)

db: $(SUBS) $(TMPS)

$(SUBS):
	@printf "Inflating database ... %44s >>> %40s \n" "$@" "$(basename $(@)).db"
	@rm -f  $(basename $(@)).db.d  $(basename $(@)).db
	@$(MSI) -D $(USR_DBFLAGS) -o $(basename $(@)).db -S $@  > $(basename $(@)).db.d
	@$(MSI)    $(USR_DBFLAGS) -o $(basename $(@)).db -S $@

$(TMPS):
	@printf "Inflating database ... %44s >>> %40s \n" "$@" "$(basename $(@)).db"
	@rm -f  $(basename $(@)).db.d  $(basename $(@)).db
	@$(MSI) -D $(USR_DBFLAGS) -o $(basename $(@)).db $@  > $(basename $(@)).db.d
	@$(MSI)    $(USR_DBFLAGS) -o $(basename $(@)).db $@


.PHONY: db $(SUBS) $(TMPS)

vlibs:

.PHONY: vlibs

# vlibs: $(VENDOR_LIBS)

# $(VENDOR_LIBS):
# 	$(QUIET)$(SUDO) install -m 555 -d $(E3_MODULES_VENDOR_LIBS_LOCATION)/
# 	$(QUIET)$(SUDO) install -m 555 $@ $(E3_MODULES_VENDOR_LIBS_LOCATION)/

# .PHONY: $(VENDOR_LIBS) vlibs



