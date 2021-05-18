# Makefile for the Atari Jaguar's libsmacker test application

# Parameters list
#
# support is used for Skunkboard usage but it is not supported yet
# env is used
# cmd sets the command / order to be used


# Base libsmacker directories
#
#C:\Projects\Smacker\libsmacker
DRIVER_BASE_SRC		=	../..
#C:\Projects\Smacker\libsmacker\AJaguar
AJAGUAR_PRJ	=	..
#C:\Projects\Smacker\libsmacker\AJaguar\tests
TESTS_AJAGUAR_PRJ	=	.
#C:\Projects\Smacker\libsmacker\AJaguar\lib
LIB_AJAGUAR_PRJ	=	$(AJAGUAR_PRJ)/lib


# Support detection
#
ifdef support
ifneq ($(support), NULL)
SUPPORT_D =	-D$(support)
SUPPORT_d = -d$(support)
SUPPORT_LIB = _$(support)
endif
else
$(error support is missing; must be either SKUNKBOARD, or NULL)
endif

# Environement detections
#
ifdef env
ifneq ($(env), Debug)
ifneq ($(env), Release)
ifneq ($(env), Profile)
ifneq ($(env), Retail)
$(error env is not recognised)
endif
endif
endif
endif
VERSION = $(shell echo $(env) | tr a-z A-Z)
else
$(error env is missing; must be either Debug, Profile, Release or Retail)
endif


# Configuration
include $(AJAGUAR_PRJ)/config.mk

# Libraries selection (lib-gcc, lib-m68k, null)
LIB_SELECT = lib-m68k
LIBC_SELECT = lib-m68k
LIBGCC_SELECT = lib-m68k
# Maths selection (cephes, fdlibm, libm-gcc, libm-m68k, null)
MATHS_SELECT = fdlibm
# fdlibm version (5.2-2_IEEE_LIBM, 5.3_IEEE_LIBM)
VER_FDLIBM = 5.2-2
VER_EFDLIBM = IEEE_LIBM
VERSIONFDLIBM = $(VER_FDLIBM)_$(VER_EFDLIBM)
# cephes math version (2.2_cmath-MIEEE)
VER_CEPHESMATH = 2.2
VER_ECEPHESMATH = cmath-MIEEE
VERSIONCEPHESMATH = $(VER_CEPHESMATH)_$(VER_ECEPHESMATH)
# Executable selection (elf, srec)
EXE_FORMAT = elf
# Libraries selection (lib-gcc, lib-m68k)
VERSION_LIB	= lib-m68k
# FDLIBM version (5.2-2, 5.3)
FDLIBMVer = 5.2-2
# Get asm from source C (yes, no)
GET_SFromC = no
# Audio support (yes, no)
AUDIO_SUPPORT = no
# Version
VERLIB = 1.1
VERLIBSMACKER = 1.1.1
# Verbose mode (yes, no)
VERBOSE = no
# Test filename
TESTNAME = driver


# Directories list
#
# Source C directories
C_DRIVER_DIR	= $(DRIVER_BASE_SRC)
# Runtime, arguments, OSJAG & crt directories
SR_ARGVS_DIR	= $(TESTS_AJAGUAR_PRJ)/$(TESTNAME)
OSJAGFILES_DIR	= $(TESTS_AJAGUAR_PRJ)/$(TESTNAME)
SR_DIR 			= $(TESTS_AJAGUAR_PRJ)/$(TESTNAME)/Runtime
# Out directories
TEST_DIR		= $(TESTS_AJAGUAR_PRJ)/$(TESTNAME)/$(env)
EXE_DIR			= $(TESTS_AJAGUAR_PRJ)/$(env)
# Objects directories
O_TEST_DIR			= $(TEST_DIR)/obj/$(FORMAT)
O_RUNTIME_DIR		= $(O_TEST_DIR)
O_OSJAGFILES_DIR	= $(O_TEST_DIR)
O_DRIVER_DIR		= $(O_TEST_DIR)/$(COMPILER_SELECT)
O_ARGVS_DIR			= $(O_TEST_DIR)/$(COMPILER_SELECT)/Runtime
# ASM sources (from C compilation) directories
S_TEST_DIR		= $(TEST_DIR)/s/$(FORMAT)
S_DRIVER_DIR	= $(S_TEST_DIR)/$(COMPILER_SELECT)
# Reports directories
DRIVER_DUMP_DIR		= $(TEST_DIR)/reports/$(FORMAT)/$(COMPILER_SELECT)
DRIVER_REPORTS_DIR	= $(TEST_DIR)/reports/$(FORMAT)/$(COMPILER_SELECT)
# Library directories
DIR_LIBS	= $(TEST_DIR)/Lib
# Executable filename
EXE_FILENAME	=	driver_$(env)_$(COMPILER_SELECT).$(ALNExt)

# C compiler information
#
# GCC
#
ifeq ($(COMPILER_C_TYPE), gcc)
# Verbose configuration
ifeq ($(VERBOSE), yes)
CCOpt += -v
endif
# .aout / coff format
ifeq ($(FORMAT), aout)
else
# elf format
ifeq ($(FORMAT), elf)
CCOpt_D += -gdwarf-2
else
$(error FORMAT is not set or wrongly dispatched for $(COMPILER_SELECT))
endif
endif
CCOpt += -c -m68000 -Wall -MD -MP -Wno-unused-variable
#-fno-align-functions
#Debug
ifeq ($(env), Debug)
CCOpt += -g $(CCOpt_D) -O0
# -mno-align-int -mstrict-align
# -gdwarf-2 -Werror -msoft-float -malign-int -fno-leading-underscore -MD -MP -fstack-usage -pedantic-errors -Wfatal-errors
else
#Release
ifeq ($(env), Release)
CCOpt += -fomit-frame-pointer -Ofast -DNDEBUG
# -Werror -Wfatal-errors
else
# Profile
ifeq ($(env), Profile)
CCOpt += -pg -g $(CCOpt_D) -O0 -fstack-usage -DDEBUG
# -pedantic-errors -Wfatal-errors
else
$(error env is not recognised, must be either Debug, Profile or Release)
endif
endif
endif
ifeq ($(AUDIO_SUPPORT), no)
CCDefine += -DNO_AUDIO_SUPPORT
endif
CCDefine += -D$(VERSION) -DNO_EXPORT_BMP -DNO_LOG_SUPPORT -DAJAGUAR
#-D NO_LIBGCC_A -D INT_8_BITS -D _SUPPORT_ARGS -D_USE_STDINT 
#SDK_INC = -IC:/SDK/Jaguar/jlibc-0.5.8/include
#-I./src/OSJag -I./src/DirectJag
#-IC:/SDK/Jaguar/jlibc-0.5.10/include -IC:/SDK/Jaguar/glibc-2.20/include
#OPENGL_INC = -IC:/Projects/TinyGL/JaGL/include
#WARP_INC = -IC:/SDK/Jaguar/jlibc-0.5.8/include
CC_INC = -I$(CCINC1) -I$(CCINC2)
H_INC = -I$(DRIVER_BASE_SRC) -IC:/SDK/AJaguar/OfficialJaguarKit/include
WARP_INC = -IC:/Projects/Lib-M68K/include
#WIN_INC = -I./src/WinJag
#-IC:/Projects/mingw32/include
#-I./Sys
GET_SFromC_Option = -S
else
#
# VBcc
#
ifeq ($(COMPILER_C_TYPE), vbcc)
CCOpt = +vc$(COMPILER_C_VERSION)_$(env).cfg
CCDefine =
SDK_INC =
OPENGL_INC =
CC_INC =
H_INC =
WIN_INC =
GET_SFromC_Option = -S
else
#
# Compiler not set
#
$(error C compiler type is not set or wrongly dispatched)
endif
endif

# ASM information
#
ifeq ($(ASM), smac)
ASMOpt = -fb -rp -v -iC:/SDK/Jaguar/OfficialJaguarKit/Include -d$(VERSION) -d$(ASM) -s
#C:\SDK\Jaguar\ATARIJaguarSDK\INCLUDE
ifneq ($(FORMAT), aout)
$(error FORMAT is not recognised, must be aout)
endif
else
ifeq ($(ASM), vasm)
ASMOpt = -m68000 -F$(FORMAT) -D$(VERSION)=1 -D$(ASM) -IC:\SDK\AJaguar\OfficialJaguarKit\Include
ifeq ($(VERSION), RELEASE)
ASMOpt += -DDEBUG=0 -DPROFILE=0
endif
ifeq ($(VERSION), DEBUG)
ASMOpt += -DRELEASE=0 -DPROFILE=0
# -dwarf=3
endif
ifeq ($(VERSION), PROFILE)
ASMOpt += -dwarf=3 -DDEBUG=1 -DRELEASE=0
endif
else
$(error ASM is not recognised, must be either smac, vasm)
endif
endif

# Linker information
#
## Vlink linker information
ifeq ($(LINKER_SELECT),vlink)
ifeq ($(FORMAT), elf)
ALNFLAGS = -b elf32jag -T mwELFls_$(VERSION_LIB)_$(env) -EB -e _start -M
ALNFLAGS_DRAM8MB = -b elf32jag -T mwELFls_$(VERSION_LIB)_$(env)_DRAM8MB -EB -e _start -M
# -M -t
# elf32m68k
ALNExt=elf
else
STADDR = 4000
ALNFLAGS = -M -b aoutjaguar -t -sc -sd -EB -e _start -Ttext 0x$(STADDR)
# -C gnu
ALNExt=bin
endif
endif

# Libraries information
#
# libgcc selection
ifeq ($(LIBGCC_SELECT), lib-gcc)
LIB_GCC	= $(DIRLIBGCC)/libgcc.a
else
ifeq ($(LIBGCC_SELECT), lib-m68k)
LIB_GCC	= $(DIR_LIBS)/libgcc-$(VERLIB)_$(env)-M68K.$(FORMAT).a
endif
endif
#
# libc selection
ifeq ($(LIBC_SELECT), lib-gcc)
LIB_C = $(DIRLIBC)/libc.a $(DIRLIBC)/libbcc.a
else
ifeq ($(LIBC_SELECT), lib-m68k)
LIB_C = $(DIR_LIBS)/libc-$(VERLIB)_$(env)-M68K.$(FORMAT).a
endif
endif
#
# Maths funtions library selection
ifeq ($(MATHS_SELECT), cephes)
LIB_MATHS = $(DIR_LIBS)/cephes/cephes-$(VERSIONCEPHESMATH)_$(env)_m68k-$(COMPILER_SELECT).$(FORMAT).a
else
ifeq ($(MATHS_SELECT), fdlibm)
LIB_MATHS = $(DIR_LIBS)/fdlibm/$(VERSIONFDLIBM)/fdlibm-$(VERSIONFDLIBM)_$(env)_m68k-$(COMPILER_SELECT).$(FORMAT).a
else
ifeq ($(MATHS_SELECT), libm-gcc)
LIB_MATHS = $(DIRLIBC)/libm.a
else
ifeq ($(MATHS_SELECT), libm-m68k)
LIB_MATHS = $(DIR_LIBS)/libm-$(VERLIB)_$(env)-M68K.$(FORMAT).a
else
ifeq ($(MATHS_SELECT), null)
LIB_MATHS =
else
$(error MATHS_SELECT is not set or wrongly dispatched)
endif
endif
endif
endif
endif

# External libraries information
LIB_OS		= $(TEST_DIR)/Lib/OSJag/mwinOSJag-$(VERLIB)_$(env)_$(COMPILER_SELECT).$(FORMAT).a
LIB_LIBSMACKER	=	$(LIB_AJAGUAR_PRJ)/$(env)/libsmacker-$(VERLIBSMACKER)_$(env)_m68k-$(COMPILER_SELECT).$(FORMAT).a


# Tools information
TODOS_OPT	=	-o -u -v


# Check directory existence
#
ifeq ("$(wildcard $(O_DRIVER_DIR))","")
ifneq ($(cmd), makedirs)
$(error the directories to create the application don't exist, please use makedirs command)
endif
endif


#			
all:			assemble \
				compile \
				link
#
assemble:		Runtime
#
compile:		compile_test
#
# Link test executable
link:			link_tests
#
rebuild:		clean \
				all
#
# Reports creation
reports:		report_stack \
				report_debug_dump


# Runtime objects list
ObjRuntime		=	$(O_RUNTIME_DIR)/STARTUP.o \
					$(O_ARGVS_DIR)/$(TESTNAME)_Argvs.o \
					$(O_OSJAGFILES_DIR)/$(TESTNAME)_OSJAG_Directory.o
#
ObjRuntime_d	=	$(O_ARGVS_DIR)/$(TESTNAME)_Argvs.d
#
# test driver objects list
ObjDRIVER		=	$(O_DRIVER_DIR)/driver.o
#
ifeq ($(GET_SFromC),yes)
ObjDRIVER_s		=	$(S_DRIVER_DIR)/driver.s
endif
#
ObjDRIVER_d		=	$(O_DRIVER_DIR)/driver.d


# All tests executables list
#
ExeTESTS	=	$(EXE_DIR)/driver_$(env)_$(COMPILER_SELECT).$(ALNExt)


# Runtime
Runtime:	$(ObjRuntime)
#
include $(ObjRuntime_d)
#
$(O_RUNTIME_DIR)/STARTUP.o: $(SR_DIR)/STARTUP.s $(TESTS_AJAGUAR_PRJ)/makefile
	$(ASMProg) $< $(ASMOpt) -o $@
#
$(O_ARGVS_DIR)/$(TESTNAME)_Argvs.d:
$(O_ARGVS_DIR)/$(TESTNAME)_Argvs.o: $(SR_ARGVS_DIR)/$(TESTNAME)_Argvs.c $(O_ARGVS_DIR)/$(TESTNAME)_Argvs.d $(TESTS_AJAGUAR_PRJ)/makefile
	$(CCProg) $< $(CCOpt) $(CCDefine) $(SDK_INC) $(CC_INC) $(H_INC) $(WIN_INC) -o $@
#
$(O_OSJAGFILES_DIR)/$(TESTNAME)_OSJAG_Directory.o: $(OSJAGFILES_DIR)/$(TESTNAME)_OSJAG_Directory.asm $(TESTS_AJAGUAR_PRJ)/makefile
	$(ASMProg) $< $(ASMOpt) -o $@


# test driver
#
compile_test:	$(ObjDRIVER) $(ObjDRIVER_s)
#
# Include the dependence file
include $(ObjDRIVER_d)
#
$(O_DRIVER_DIR)/driver.d:
$(O_DRIVER_DIR)/driver.o: $(C_DRIVER_DIR)/driver.c $(O_DRIVER_DIR)/driver.d makefile build.bat
	$(CCProg) $< $(CCOpt) $(CCDefine) $(SDK_INC) $(CC_INC) $(H_INC) $(WIN_INC) -o $@
$(S_DRIVER_DIR)/driver.s: $(C_DRIVER_DIR)/driver.c $(O_DRIVER_DIR)/driver.d makefile build.bat
	$(CCProg) $< $(CCOpt) $(GET_SFromC_Option) $(CCDefine) $(SDK_INC) $(CC_INC) $(H_INC) $(WIN_INC) -o $@
	
	
# tests link
#
link_tests:		$(ExeTESTS)
#
$(EXE_DIR)/driver_$(env)_$(COMPILER_SELECT).$(ALNExt):	$(O_DRIVER_DIR)/driver.o mwELFls_$(VERSION_LIB)_$(env) build.bat makefile $(ObjRuntime) $(LIB_LIBSMACKER) $(LIB_MATHS) $(LIB_C) $(LIB_GCC) $(LIB_OS)
		$(LNKProg) $(ALNFLAGS) $< $(ObjRuntime) $(LIB_LIBSMACKER) $(LIB_MATHS) $(LIB_C) $(LIB_GCC) $(LIB_OS) -o $@ > $@.map


# Stack usage reports
report_stack:	$(DRIVER_REPORTS_DIR)/$(EXE_FILENAME).StackReport.txt \
#
# Reports list
$(DRIVER_REPORTS_DIR)/$(EXE_FILENAME).StackReport.txt: $(EXE_DIR)/$(EXE_FILENAME) $(ObjDRIVER) Build.bat
	perl.exe avstack.pl $(ObjDRIVER) > $@
#
# Debug dump executables reports
#
report_debug_dump:	$(DRIVER_DUMP_DIR)/$(EXE_FILENAME).ReadElf.txt \
					$(DRIVER_DUMP_DIR)/$(EXE_FILENAME).rawline.txt \
					$(DRIVER_DUMP_DIR)/$(EXE_FILENAME).decodedline.txt \
					$(DRIVER_DUMP_DIR)/$(EXE_FILENAME).info.txt \
					$(DRIVER_DUMP_DIR)/$(EXE_FILENAME).abbrev.txt \
					$(DRIVER_DUMP_DIR)/$(EXE_FILENAME).pubnames.txt \
					$(DRIVER_DUMP_DIR)/$(EXE_FILENAME).aranges.txt \
					$(DRIVER_DUMP_DIR)/$(EXE_FILENAME).macro.txt \
					$(DRIVER_DUMP_DIR)/$(EXE_FILENAME).frames.txt \
					$(DRIVER_DUMP_DIR)/$(EXE_FILENAME).frames-interp.txt \
					$(DRIVER_DUMP_DIR)/$(EXE_FILENAME).str.txt \
					$(DRIVER_DUMP_DIR)/$(EXE_FILENAME).loc.txt \
					$(DRIVER_DUMP_DIR)/$(EXE_FILENAME).Ranges.txt \
					$(DRIVER_DUMP_DIR)/$(EXE_FILENAME).pubtypes.txt \
					$(DRIVER_DUMP_DIR)/$(EXE_FILENAME).gdb_index.txt \
					$(DRIVER_DUMP_DIR)/$(EXE_FILENAME).trace_info.txt \
					$(DRIVER_DUMP_DIR)/$(EXE_FILENAME).trace_abbrev.txt \
					$(DRIVER_DUMP_DIR)/$(EXE_FILENAME).trace_aranges.txt \
					$(DRIVER_DUMP_DIR)/$(EXE_FILENAME).addr.txt \
					$(DRIVER_DUMP_DIR)/$(EXE_FILENAME).cu_index.txt \
					$(DRIVER_DUMP_DIR)/$(EXE_FILENAME).links.txt \
					$(DRIVER_DUMP_DIR)/$(EXE_FILENAME).follow-links.txt
# Dump list
ifeq	($(FORMAT), elf)
$(DRIVER_DUMP_DIR)/$(EXE_FILENAME).ReadElf.txt:	$(EXE_DIR)/$(EXE_FILENAME) makefile Build.bat
	$(readelf) -W -a $(EXE_DIR)/$(EXE_FILENAME) > $@
	$(TODOS) $(TODOS_OPT) $@
$(DRIVER_DUMP_DIR)/$(EXE_FILENAME).rawline.txt:	$(EXE_DIR)/$(EXE_FILENAME) makefile Build.bat
	$(readelf) -W --debug-dump=rawline $(EXE_DIR)/$(EXE_FILENAME) > $@
	$(TODOS) $(TODOS_OPT) $@
$(DRIVER_DUMP_DIR)/$(EXE_FILENAME).decodedline.txt:	$(EXE_DIR)/$(EXE_FILENAME) makefile Build.bat
	$(readelf) -W --debug-dump=decodedline $(EXE_DIR)/$(EXE_FILENAME) > $@
	$(TODOS) $(TODOS_OPT) $@
$(DRIVER_DUMP_DIR)/$(EXE_FILENAME).info.txt:	$(EXE_DIR)/$(EXE_FILENAME) makefile Build.bat
	$(readelf) -W --debug-dump=info $(EXE_DIR)/$(EXE_FILENAME) > $@
	$(TODOS) $(TODOS_OPT) $@
$(DRIVER_DUMP_DIR)/$(EXE_FILENAME).abbrev.txt:	$(EXE_DIR)/$(EXE_FILENAME) makefile Build.bat
	$(readelf) -W --debug-dump=abbrev $(EXE_DIR)/$(EXE_FILENAME) > $@
	$(TODOS) $(TODOS_OPT) $@
$(DRIVER_DUMP_DIR)/$(EXE_FILENAME).pubnames.txt:	$(EXE_DIR)/$(EXE_FILENAME) makefile Build.bat
	$(readelf) -W --debug-dump=pubnames $(EXE_DIR)/$(EXE_FILENAME) > $@
	$(TODOS) $(TODOS_OPT) $@
$(DRIVER_DUMP_DIR)/$(EXE_FILENAME).aranges.txt:	$(EXE_DIR)/$(EXE_FILENAME) makefile Build.bat
	$(readelf) -W --debug-dump=aranges $(EXE_DIR)/$(EXE_FILENAME) > $@
	$(TODOS) $(TODOS_OPT) $@
$(DRIVER_DUMP_DIR)/$(EXE_FILENAME).macro.txt:	$(EXE_DIR)/$(EXE_FILENAME) makefile Build.bat
	$(readelf) -W --debug-dump=macro $(EXE_DIR)/$(EXE_FILENAME) > $@
	$(TODOS) $(TODOS_OPT) $@
$(DRIVER_DUMP_DIR)/$(EXE_FILENAME).frames.txt:	$(EXE_DIR)/$(EXE_FILENAME) makefile Build.bat
	$(readelf) -W --debug-dump=frames $(EXE_DIR)/$(EXE_FILENAME) > $@
	$(TODOS) $(TODOS_OPT) $@
$(DRIVER_DUMP_DIR)/$(EXE_FILENAME).frames-interp.txt:	$(EXE_DIR)/$(EXE_FILENAME) makefile Build.bat
	$(readelf) -W --debug-dump=frames-interp $(EXE_DIR)/$(EXE_FILENAME) > $@
	$(TODOS) $(TODOS_OPT) $@
$(DRIVER_DUMP_DIR)/$(EXE_FILENAME).str.txt:	$(EXE_DIR)/$(EXE_FILENAME) makefile Build.bat
	$(readelf) -W --debug-dump=str $(EXE_DIR)/$(EXE_FILENAME) > $@
	$(TODOS) $(TODOS_OPT) $@
$(DRIVER_DUMP_DIR)/$(EXE_FILENAME).loc.txt:	$(EXE_DIR)/$(EXE_FILENAME) makefile Build.bat
	$(readelf) -W --debug-dump=loc $(EXE_DIR)/$(EXE_FILENAME) > $@
	$(TODOS) $(TODOS_OPT) $@
$(DRIVER_DUMP_DIR)/$(EXE_FILENAME).Ranges.txt:	$(EXE_DIR)/$(EXE_FILENAME) makefile Build.bat
	$(readelf) -W --debug-dump=Ranges $(EXE_DIR)/$(EXE_FILENAME) > $@
	$(TODOS) $(TODOS_OPT) $@
$(DRIVER_DUMP_DIR)/$(EXE_FILENAME).pubtypes.txt:	$(EXE_DIR)/$(EXE_FILENAME) makefile Build.bat
	$(readelf) -W --debug-dump=pubtypes $(EXE_DIR)/$(EXE_FILENAME) > $@
	$(TODOS) $(TODOS_OPT) $@
$(DRIVER_DUMP_DIR)/$(EXE_FILENAME).gdb_index.txt:	$(EXE_DIR)/$(EXE_FILENAME) makefile Build.bat
	$(readelf) -W --debug-dump=gdb_index $(EXE_DIR)/$(EXE_FILENAME) > $@
	$(TODOS) $(TODOS_OPT) $@
$(DRIVER_DUMP_DIR)/$(EXE_FILENAME).trace_info.txt:	$(EXE_DIR)/$(EXE_FILENAME) makefile Build.bat
	$(readelf) -W --debug-dump=trace_info $(EXE_DIR)/$(EXE_FILENAME) > $@
	$(TODOS) $(TODOS_OPT) $@
$(DRIVER_DUMP_DIR)/$(EXE_FILENAME).trace_abbrev.txt:	$(EXE_DIR)/$(EXE_FILENAME) makefile Build.bat
	$(readelf) -W --debug-dump=trace_abbrev $(EXE_DIR)/$(EXE_FILENAME) > $@
	$(TODOS) $(TODOS_OPT) $@
$(DRIVER_DUMP_DIR)/$(EXE_FILENAME).trace_aranges.txt:	$(EXE_DIR)/$(EXE_FILENAME) makefile Build.bat
	$(readelf) -W --debug-dump=trace_aranges $(EXE_DIR)/$(EXE_FILENAME) > $@
	$(TODOS) $(TODOS_OPT) $@
$(DRIVER_DUMP_DIR)/$(EXE_FILENAME).addr.txt:	$(EXE_DIR)/$(EXE_FILENAME) makefile Build.bat
	$(readelf) -W --debug-dump=addr $(EXE_DIR)/$(EXE_FILENAME) > $@
	$(TODOS) $(TODOS_OPT) $@
$(DRIVER_DUMP_DIR)/$(EXE_FILENAME).cu_index.txt:	$(EXE_DIR)/$(EXE_FILENAME) makefile Build.bat
	$(readelf) -W --debug-dump=cu_index $(EXE_DIR)/$(EXE_FILENAME) > $@
	$(TODOS) $(TODOS_OPT) $@
$(DRIVER_DUMP_DIR)/$(EXE_FILENAME).links.txt:	$(EXE_DIR)/$(EXE_FILENAME) makefile Build.bat
	$(readelf) -W --debug-dump=links $(EXE_DIR)/$(EXE_FILENAME) > $@
	$(TODOS) $(TODOS_OPT) $@
$(DRIVER_DUMP_DIR)/$(EXE_FILENAME).follow-links.txt:	$(EXE_DIR)/$(EXE_FILENAME) makefile Build.bat
	$(readelf) -W --debug-dump=follow-links $(EXE_DIR)/$(EXE_FILENAME) > $@
	$(TODOS) $(TODOS_OPT) $@
endif					


# Project clean-up
#
clean:	clean_obj \
		clean_su \
		clean_d \
		clean_s \
		clean_tests \
		clean_maps \
		clean_Runtime \
		clean_reports
#
# Delete the demos executable
clean_tests:
		rm -f $(EXE_DIR)/driver_$(env)_$(COMPILER_SELECT).$(ALNExt)
#
# Delete the map files from demos executable
clean_maps:
		rm -f $(EXE_DIR)/driver_$(env)_$(COMPILER_SELECT).$(ALNExt).map
#
# Delete the object files
clean_obj:
		rm -f $(O_DRIVER_DIR)/*.o
		rm -f $(O_DRIVER_DIR)/*.o
#
# Delete the stack usage files
clean_su:
		rm -f $(O_DRIVER_DIR)/*.su
#
# Delete the dependence files
clean_d:
		rm -f $(O_DRIVER_DIR)/*.d
#
# Delete the asm files generated by compilation		
clean_s:
		rm -f $(S_DRIVER_DIR)/*.s
#
# Delete the Runtime's object, stack usage, asm generated and dependence files
clean_Runtime:
		rm -f $(O_RUNTIME_DIR)/STARTUP.o
		rm -f $(O_ARGVS_DIR)/*.o
		rm -f $(O_OSJAGFILES_DIR)/*.o
#
# Delete reports
clean_reports:
		rm -f $(DRIVER_REPORTS_DIR)/*.txt
		rm -f $(DRIVER_DUMP_DIR)/*.txt
		

# Create directories
#
makedirs:	mkdir_reports \
			mkdir_Runtime \
			mkdir_exes \
			mkdir_obj \
			mkdir_su \
			mkdir_d \
			mkdir_s
#
# Create the Runtime's object, stack usage and dependence files directories
mkdir_Runtime:
		mkdir -p $(O_RUNTIME_DIR)
		mkdir -p $(O_ARGVS_DIR)
		mkdir -p $(O_OSJAGFILES_DIR)
#
# Create the reports files directories
mkdir_reports:
		mkdir -p $(DRIVER_DUMP_DIR)
		mkdir -p $(DRIVER_REPORTS_DIR)
#
#
mkdir_exes:
		mkdir -p $(EXE_DIR)
#
# Create the object, stack usage and dependence files directories
mkdir_obj:
mkdir_su:
mkdir_d:
		mkdir -p $(O_DRIVER_DIR)
#
# Create the asm files, generated by compilation, directories		
mkdir_s:
		mkdir -p $(S_DRIVER_DIR)

		
# Display configuration
#
config:	config_command \
		config_generic \
		config_test
#
# Display the command from batch
config_command:
	$(info -------------- Command)
	$(info Environement : $(env))
	$(info Support      : $(support))	
#
# Display the command for the test
config_test:
	$(info -------------- Library)
	$(info fdlibm       : $(FDLIBMVer))
	$(info lib c        : $(VERSION_LIB))
#
# Display generic information
config_generic:
	$(info -------------- Generic)
	$(info Format       : $(FORMAT))
	$(info Assembler    : $(ASM))
	$(info Compiler     : $(COMPILER_C_TYPE) $(COMPILER_C_VERSION))
