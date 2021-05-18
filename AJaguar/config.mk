# Assembler selection (smac, vasm, rmac)
ASM = vasm
# VASM information (madmac)
ifeq ($(ASM), vasm)
VASM_SUPPORT = madmac
endif
# Format selection (elf, aout, coff)
FORMAT = elf
# Compiler C type (gcc, vbcc)
COMPILER_C_TYPE	= gcc
# Compiler C version depend his type
COMPILER_C_VERSION = 5.5.0
# Compiler selection based on type and version
COMPILER_C = $(COMPILER_C_TYPE)$(COMPILER_C_VERSION)
# Compiler selection based on type, and version
COMPILER_SELECT	= $(COMPILER_C_TYPE)-$(COMPILER_C_VERSION)
# Linker selection (jlinker, vlink, rln, sln)
LINKER_SELECT =	vlink


# Linker information
#
ifeq ($(LINKER_SELECT), vlink)
LNKProg = C:/VB/Vlink/vlink0.16h
else
ifeq ($(LINKER_SELECT), rln)
LNKProg = C:/AJaguar/RlnRmac/rln
else
ifeq ($(LINKER_SELECT), sln)
LNKProg = C:/AJaguar/SlnSmac/sln
else
ifeq ($(LINKER_SELECT),jlinker)
LNKProg = C:/AJaguar/Jlinker/jlinker
else
$(error LINKER_SELECT is not set or wrongly dispatched)
endif
endif
endif
endif


# ASM information
#
ifeq ($(ASM), vasm)
ASMProg	= C:/VB/Vasmm68k/vasmm68k_$(VASM_SUPPORT)_win32_1.8k
else
ifeq ($(ASM), smac)
ASMProg	= C:/AJaguar/SlnSmac/smac
else
ifeq ($(ASM), smac)
ASMProg	= C:/AJaguar/RlnRmac/rmac
else
$(error ASM is not set or wrongly dispatched)
endif
endif
endif


# Tools information
TODOS = C:\Tools\tfd1713\todos


# C compiler & library information
#
# GCC
#
ifeq ($(COMPILER_C_TYPE), gcc)
#
# ELF format
ifeq ($(FORMAT), elf)
# ELF gcc compiler
ifneq ("$(wildcard C:/GNU/m68k-elf-$(COMPILER_C_VERSION)/m68k-elf/bin)","")
CCProg = C:/GNU/m68k-elf-$(COMPILER_C_VERSION)/m68k-elf/bin/m68k-elf-gcc
ARProg = C:/GNU/m68k-elf-$(COMPILER_C_VERSION)/m68k-elf/bin/m68k-elf-ar
ARANProg = C:/GNU/m68k-elf-$(COMPILER_C_VERSION)/m68k-elf/bin/m68k-elf-ranlib
readelf	= C:/GNU/m68k-elf-$(COMPILER_C_VERSION)/m68k-elf/bin/m68k-elf-readelf
stripelf = C:/GNU/m68k-elf-gcc-$(COMPILER_C_VERSION)/bin/m68k-elf-strip
objdump = C:/GNU/m68k-elf-$(COMPILER_C_VERSION)/m68k-elf/bin/m68k-elf-objdump
else
ifneq ("$(wildcard C:/GNU/m68k-elf-gcc$(COMPILER_C_VERSION)/bin)","")
CCProg = C:/GNU/m68k-elf-gcc$(COMPILER_C_VERSION)/bin/m68k-elf-gcc
ARProg = C:/GNU/m68k-elf-gcc$(COMPILER_C_VERSION)/bin/m68k-elf-ar
ARANProg = C:/GNU/m68k-elf-gcc$(COMPILER_C_VERSION)/bin/m68k-elf-ranlib
readelf	= C:/GNU/m68k-elf-gcc$(COMPILER_C_VERSION)/bin/m68k-elf-readelf
stripelf = C:/GNU/m68k-elf-gcc$(COMPILER_C_VERSION)/bin/m68k-elf-strip
objdump = C:/GNU/m68k-elf-gcc$(COMPILER_C_VERSION)/bin/m68k-elf-objdump
else
ifneq ("$(wildcard C:/GNU/MinGW-m68k-elf-glo-$(COMPILER_C_VERSION)/bin)","")
CCProg = C:/GNU/MinGW-m68k-elf-glo-$(COMPILER_C_VERSION)/bin/m68k-elf-gcc
ARProg = C:/GNU/MinGW-m68k-elf-glo-$(COMPILER_C_VERSION)/bin/m68k-elf-ar
ARANProg = C:/GNU/MinGW-m68k-elf-glo-$(COMPILER_C_VERSION)/bin/m68k-elf-ranlib
readelf	= C:/GNU/MinGW-m68k-elf-glo-$(COMPILER_C_VERSION)/bin/m68k-elf-readelf
stripelf = C:/GNU/MinGW-m68k-elf-glo-$(COMPILER_C_VERSION)/bin/m68k-elf-strip
objdump = C:/GNU/MinGW-m68k-elf-glo-$(COMPILER_C_VERSION)/bin/m68k-elf-objdump
else
ifneq ("$(wildcard C:/GNU/m68k-elf-gcc-$(COMPILER_C_VERSION)/bin)","")
CCProg = C:/GNU/m68k-elf-gcc-$(COMPILER_C_VERSION)/bin/m68k-elf-gcc
ARProg = C:/GNU/m68k-elf-gcc-$(COMPILER_C_VERSION)/bin/m68k-elf-ar
ARANProg = C:/GNU/m68k-elf-gcc-$(COMPILER_C_VERSION)/bin/m68k-elf-ranlib
readelf	= C:/GNU/m68k-elf-gcc-$(COMPILER_C_VERSION)/bin/m68k-elf-readelf
stripelf = C:/GNU/m68k-elf-gcc-$(COMPILER_C_VERSION)/bin/m68k-elf-strip
objdump = C:/GNU/m68k-elf-gcc-$(COMPILER_C_VERSION)/bin/m68k-elf-objdump
else
$(error COMPILER_C_VERSION is not set or wrongly dispatched)
endif
endif
endif
endif
# ELF gcc headers library
ifneq ("$(wildcard C:/GNU/MinGW-m68k-elf-glo-$(COMPILER_C_VERSION)/m68k-elf/include)","")
CCINC1 = C:/GNU/MinGW-m68k-elf-glo-$(COMPILER_C_VERSION)/m68k-elf/include
CCINC2 = C:/GNU/MinGW-m68k-elf-glo-$(COMPILER_C_VERSION)/lib/gcc/m68k-elf/$(COMPILER_C_VERSION)/include
else
ifneq ("$(wildcard C:/GNU/m68k-elf-gcc$(COMPILER_C_VERSION)/m68k-elf/include)","")
CCINC1 = C:/GNU/m68k-elf-gcc$(COMPILER_C_VERSION)/m68k-elf/include
CCINC2 = C:/GNU/m68k-elf-gcc$(COMPILER_C_VERSION)/lib/gcc/m68k-elf/$(COMPILER_C_VERSION)/include
else
ifneq ("$(wildcard C:/GNU/m68k-elf-$(COMPILER_C_VERSION)/m68k-elf/m68k-elf/include)","")
CCINC1 = C:/GNU/m68k-elf-$(COMPILER_C_VERSION)/m68k-elf/m68k-elf/include
CCINC2 = C:/GNU/m68k-elf-$(COMPILER_C_VERSION)/m68k-elf/lib/gcc/m68k-elf/$(COMPILER_C_VERSION)/include
else
ifneq ("$(wildcard C:/GNU/m68k-elf-gcc-$(COMPILER_C_VERSION)/m68k-elf/include)","")
CCINC1 = C:/GNU/m68k-elf-gcc-$(COMPILER_C_VERSION)/m68k-elf/include
CCINC2 = C:/GNU/m68k-elf-gcc-$(COMPILER_C_VERSION)/lib/gcc/m68k-elf/$(COMPILER_C_VERSION)/include
else
CCINC1 = C:/GNU/m68k-elf-gcc-9.2.0/m68k-elf/include
CCINC2 = C:/GNU/m68k-elf-gcc-9.2.0/lib/gcc/m68k-elf/9.2.0/include
endif
endif
endif
endif
# ELF gcc libraries
ifneq ("$(wildcard C:/GNU/m68k-elf-gcc-$(COMPILER_C_VERSION)/lib/gcc/m68k-elf/$(COMPILER_C_VERSION)/mcpu32)", "")
DIRLIBGCC = C:/GNU/m68k-elf-gcc-$(COMPILER_C_VERSION)/lib/gcc/m68k-elf/$(COMPILER_C_VERSION)/mcpu32
DIRLIBC = C:/GNU/m68k-elf-gcc-$(COMPILER_C_VERSION)/m68k-elf/lib/mcpu32
else
DIRLIBGCC = C:/GNU/m68k-elf-gcc4.9.3/lib/gcc/m68k-elf/4.9.3/mcpu32
DIRLIBC = C:/GNU/m68k-elf-gcc4.9.3/m68k-elf/lib/mcpu32
endif
#
# aout format
else
ifeq ($(FORMAT), aout)
# aout gcc compiler
ifneq ("$(wildcard C:/GNU/xgcc-$(COMPILER_C_VERSION)-m68k/cygwin/usr/local/m68k-aout/bin)","")
CCProg = C:/GNU/xgcc-$(COMPILER_C_VERSION)-m68k/cygwin/usr/local/m68k-aout/bin/m68k-aout-gcc
else
$(error COMPILER_C_VERSION is not set or wrongly dispatched)
endif
# aout gcc headers library
ifneq ("$(wildcard C:/GNU/xgcc-$(COMPILER_C_VERSION)-m68k/cygwin/usr/local/m68k-aout/lib/gcc-lib/m68k-aout/$(COMPILER_C_VERSION)/include)","")
CCINC1 = C:/GNU/xgcc-$(COMPILER_C_VERSION)-m68k/cygwin/usr/local/m68k-aout/lib/gcc-lib/m68k-aout/$(COMPILER_C_VERSION)/include
endif
#
# coff format
else
ifeq ($(FORMAT), coff)
# coff gcc compiler
ifeq ($(COMPILER_C_VERSION), 2.91.66)
CCProg = C:/GNU/gcc-m68k-win32-r6/gcc-m68k/bin/m68k-coff-gcc
else
$(error COMPILER_C_VERSION is not set or wrongly dispatched)
endif
# coff gcc headers library
ifeq ($(COMPILER_C_VERSION), 2.91.66)
CCINC1 = C:/GNU/gcc-m68k-win32-r6/gcc-m68k/m68k-coff/include
endif
#
# Unknown format
else
$(error FORMAT is not set or wrongly dispatched for $(COMPILER_SELECT))
endif
endif
endif
#
# VBCC
#
else
ifeq ($(COMPILER_C_TYPE), vbcc)
#
# ELF format
ifeq ($(FORMAT), elf)
# ELF vbcc compiler
CCProg = C:/VB/vbcc$(COMPILER_C_VERSION)/bin/vc
# CCProg = C:/VB/vbcc$(COMPILER_C_VERSION)/bin/vbccm68k
#
# Unknown format
else
$(error FORMAT is not set or wrongly dispatched for $(COMPILER_SELECT))
endif
#
# Compiler not set
#
else
$(error COMPILER_C_TYPE is not set or wrongly dispatched)
endif
endif
