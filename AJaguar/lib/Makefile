# Makefile for the Atari Jaguar's libsmacker

# Parameters list
#
# support is used for Skunkboard usage but it is not supported yet
# env is used
# cmd sets the command / order to be used


# Base libsmacker directories
#
#C:\Projects\Smacker\libsmacker
LIB_LIBSMACK_BASE_SRC		=	./../..
#C:\Projects\Smacker\libsmacker\AJaguar
LIBSMACK_AJAGUAR_PRJ	=	./..


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
include $(LIBSMACK_AJAGUAR_PRJ)/config.mk

# Verbose (yes, no)
VERBOSE = no
# Get asm from source C (yes, no)
GET_SFromC = no
# Get FILE support (yes, no)
FILE_SUPPORT = yes
# Log support (yes, no)
LOG_SUPPORT = no
# Report support (yes, no)
REPORT_SUPPORT = no
# Audio support (yes, no)
AUDIO_SUPPORT = yes
# Assert support (yes, no)
ASSERT_SUPPORT = no
# Version
VERLIB = 1.1.1


# Directories list
#
# Source C directories
C_LIBSMACKER_DIR	= $(LIB_LIBSMACK_BASE_SRC)
# Out directories list
LIB_DIR	= $(LIBSMACK_AJAGUAR_PRJ)/lib/$(env)
# Objects (from C compilation) directories
O_LIB_DIR			= $(LIB_DIR)/obj/$(FORMAT)
O_LIBSMACKER_DIR	= $(O_LIB_DIR)/$(COMPILER_SELECT)
# ASM sources (from C compilation) directories
S_LIB_DIR			= $(LIB_DIR)/s/$(FORMAT)
S_LIBSMACKER_DIR	= $(S_LIB_DIR)/$(COMPILER_SELECT)
# Reports directories
REPORTS_DIR				= $(LIB_DIR)/reports/$(FORMAT)
REPORTS_LIBSMACKER_DIR	= $(REPORTS_DIR)/$(COMPILER_SELECT)


# C compiler information
#
# GCC
#
ifeq	($(COMPILER_C_TYPE), gcc)
# Verbose configuration
ifeq ($(VERBOSE), yes)
CCOpt += -v
endif
# .aout / coff format
ifeq	($(FORMAT), aout)
else
# elf format
ifeq	($(FORMAT), elf)
CCOpt_D += -gdwarf-2
else
$(error FORMAT is not set or wrongly dispatched for $(COMPILER_SELECT))
endif
endif
CCOpt += -c -m68000 -Wall -MD -MP -Wno-unused-label -Wno-unused-variable
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
ifeq ($(ASSERT_SUPPORT), no)
CCDefine += -DNO_SMK_ASSERT
else
ifeq ($(VERSION), Release)
$(error assert request is not supported in Release)
endif
endif
ifeq ($(AUDIO_SUPPORT), no)
CCDefine += -DNO_AUDIO_SUPPORT
endif
ifeq ($(FILE_SUPPORT), no)
CCDefine += -DNO_FILE_SUPPORT
endif
ifeq ($(LOG_SUPPORT), no)
CCDefine += -DNO_LOG_SUPPORT
endif
ifeq ($(REPORT_SUPPORT), no)
CCDefine += -DNO_REPORT_SUPPORT
endif
CCDefine += -D$(VERSION) -DAJAGUAR
#-D NO_LIBGCC_A -D INT_8_BITS -D _SUPPORT_ARGS -D_USE_STDINT 
#SDK_INC = -IC:/SDK/Jaguar/jlibc-0.5.8/include
#-I./src/OSJag -I./src/DirectJag
#-IC:/SDK/Jaguar/jlibc-0.5.10/include -IC:/SDK/Jaguar/glibc-2.20/include
#OPENGL_INC = -IC:/Projects/TinyGL/JaGL/include
#WARP_INC = -IC:/SDK/Jaguar/jlibc-0.5.8/include
CC_INC = -I$(CCINC1) -I$(CCINC2)
H_INC = -I$(LIB_LIBSMACK_BASE_SRC)
SDK_INC = -IC:/SDK/Jaguar/OfficialJaguarKit/INCLUDE
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

# Lib information
#
## GNU library information
AR_OPT		= cru
ARAN_OPT	=
LIBExt		= a
#
# Library name
LIBSMACKER_FILENAME		= libsmacker-$(VERLIB)_$(env)_m68k-$(COMPILER_SELECT).$(FORMAT).$(LIBExt)


# Tools information
TODOS_OPT	=	-o -u -v


# Check directory existence
#
ifeq ("$(wildcard $(O_LIBSMACKER_DIR))","")
ifneq ($(cmd), makedirs)
$(error the directories to create $(LIBSMACKER_FILENAME) don't exist, please use makedirs command)
endif
endif


# Project commands
#
all:			compile \
				library
#
clean:			clean_obj \
				clean_su \
				clean_d \
				clean_s \
				clean_libs \
				clean_reports
#
compile:		compile_libsmacker
#
config:			config_command \
				config_library \
				config_generic
#
library:		library_libsmacker
#
makedirs:		mkdir_reports \
				mkdir_obj \
				mkdir_su \
				mkdir_d \
				mkdir_s
#
rebuild:		clean \
				all
#
reports:		report_stack


# libsmacker objects list
ObjLIBSMACKER	=	$(O_LIBSMACKER_DIR)/smacker.o \
					$(O_LIBSMACKER_DIR)/smk_bitstream.o \
					$(O_LIBSMACKER_DIR)/smk_hufftree.o
#
ObjLIBSMACKER_d	=	$(O_LIBSMACKER_DIR)/smacker.d \
					$(O_LIBSMACKER_DIR)/smk_bitstream.d \
					$(O_LIBSMACKER_DIR)/smk_hufftree.d
#
ifeq ($(GET_SFromC),yes)	
ObjLIBSMACKER_s	=	$(S_LIBSMACKER_DIR)/smacker.s \
					$(S_LIBSMACKER_DIR)/smk_bitstream.s \
					$(S_LIBSMACKER_DIR)/smk_hufftree.s
endif


compile_libsmacker:		$(ObjLIBSMACKER) $(ObjLIBSMACKER_s)
#
# Include the dependence file
include $(ObjLIBSMACKER_d)
#
$(O_LIBSMACKER_DIR)/smacker.d:
$(O_LIBSMACKER_DIR)/smacker.o: $(C_LIBSMACKER_DIR)/smacker.c $(O_LIBSMACKER_DIR)/smacker.d Makefile build.bat
	$(CCProg) $< $(CCOpt) $(CCDefine) $(SDK_INC) $(CC_INC) $(H_INC) -o $@
$(S_LIBSMACKER_DIR)/smacker.s: $(C_LIBSMACKER_DIR)/smacker.c $(O_LIBSMACKER_DIR)/smacker.d Makefile build.bat
	$(CCProg) $< $(CCOpt) $(GET_SFromC_Option) $(CCDefine) $(SDK_INC) $(CC_INC) $(H_INC) -o $@
#
$(O_LIBSMACKER_DIR)/smk_bitstream.d:
$(O_LIBSMACKER_DIR)/smk_bitstream.o: $(C_LIBSMACKER_DIR)/smk_bitstream.c $(O_LIBSMACKER_DIR)/smk_bitstream.d Makefile build.bat
	$(CCProg) $< $(CCOpt) $(CCDefine) $(SDK_INC) $(CC_INC) $(H_INC) -o $@
$(S_LIBSMACKER_DIR)/smk_bitstream.s: $(C_LIBSMACKER_DIR)/smk_bitstream.c $(O_LIBSMACKER_DIR)/smk_bitstream.d Makefile build.bat
	$(CCProg) $< $(CCOpt) $(GET_SFromC_Option) $(CCDefine) $(SDK_INC) $(CC_INC) $(H_INC) -o $@
#
$(O_LIBSMACKER_DIR)/smk_hufftree.d:
$(O_LIBSMACKER_DIR)/smk_hufftree.o: $(C_LIBSMACKER_DIR)/smk_hufftree.c $(O_LIBSMACKER_DIR)/smk_hufftree.d Makefile build.bat
	$(CCProg) $< $(CCOpt) $(CCDefine) $(SDK_INC) $(CC_INC) $(H_INC) -o $@
$(S_LIBSMACKER_DIR)/smk_hufftree.s: $(C_LIBSMACKER_DIR)/smk_hufftree.c $(O_LIBSMACKER_DIR)/smk_hufftree.d Makefile build.bat
	$(CCProg) $< $(CCOpt) $(GET_SFromC_Option) $(CCDefine) $(SDK_INC) $(CC_INC) $(H_INC) -o $@


library_libsmacker:	$(LIB_DIR)/$(LIBSMACKER_FILENAME)
#
# Library creation
$(LIB_DIR)/$(LIBSMACKER_FILENAME):	$(ObjLIBSMACKER) Makefile build.bat
	$(ARProg) $(AR_OPT) $(LIB_DIR)/$(LIBSMACKER_FILENAME) $(ObjLIBSMACKER)
	$(ARANProg) $(ARAN_OPT) $(LIB_DIR)/$(LIBSMACKER_FILENAME)


# Stack usage reports
report_stack:	$(REPORTS_LIBSMACKER_DIR)/$(LIBSMACKER_FILENAME).StackReport.txt
#
# Reports list
$(REPORTS_LIBSMACKER_DIR)/$(LIBSMACKER_FILENAME).StackReport.txt: $(LIB_DIR)/$(LIBSMACKER_FILENAME) $(ObjLIBSMACKER) Build.bat Makefile
	perl.exe avstack.pl $(ObjLIBSMACKER) > $@


# Delete the libraries
clean_libs:
		rm -f $(LIB_DIR)/$(LIBSMACKER_FILENAME)
#
# Delete the object files
clean_obj:
		rm -f $(O_LIBSMACKER_DIR)/*.o
#
# Delete the stack usage files
clean_su:
		rm -f $(O_LIBSMACKER_DIR)/*.su
#
# Delete the dependence files
clean_d:
		rm -f $(O_LIBSMACKER_DIR)/*.d
#
# Delete the asm files generated by compilation		
clean_s:
		rm -f $(S_LIBSMACKER_DIR)/*.s
#
# Delete reports
clean_reports:
		rm -f $(REPORTS_LIBSMACKER_DIR)/*.txt
		

# Create the reports files directories
mkdir_reports:
		mkdir -p $(REPORTS_LIBSMACKER_DIR)
#
# Create the object, stack usage and dependence files directories
mkdir_obj:
mkdir_su:
mkdir_d:
		mkdir -p $(O_LIBSMACKER_DIR)
#
# Create the asm files, generated by compilation, directories		
mkdir_s:
		mkdir -p $(S_LIBSMACKER_DIR)

		
# Display the command from batch
config_command:
	$(info -------------- Command)
	$(info Environement : $(env))
	$(info Support      : $(support))
#
# Display the library information
config_library:
	$(info -------------- Library)
	$(info Version      : $(VERLIB))
#
# Display generic information
config_generic:
	$(info -------------- Generic)
	$(info Format       : $(FORMAT))
	$(info Compiler     : $(COMPILER_C_TYPE) $(COMPILER_C_VERSION))
