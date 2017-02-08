###################################################################
#  Makefile for linux lib.
#  Writen by dengguangyong (deng_joe@163.com) - 2016-12-18
#################################################################

ROOT = .
BASELIBNAME = test


obj_inc = $(ROOT)/src
obj_src = $(ROOT)/src

depend_inc = $(ROOT)/include
depend_lib = $(ROOT)/lib


obj = $(ROOT)/obj
libdst = $(ROOT)/bin

bin = $(libdst)/lib$(BASELIBNAME).a
sobin = $(libdst)/lib$(BASELIBNAME).so


#################################################################
#  Customization of the implicit rules

DEFS =  
IFLAGS = -I$(obj_inc) -I$(depend_inc)
CFLAGS = -Wall $(IFLAGS)
APPLIBS =
SYSLIBS = -lrt -lm -lpthread
APPLFLAGS = -L$(libdst) -L$(depend_lib)

ifeq ($(MAKECMDGOALS), debug)
  CFLAGS = -g -Wall $(DEFS) $(IFLAGS)
  sobin = $(libdst)/lib$(BASELIBNAME)dbg.so
endif

ifeq ($(MAKECMDGOALS), so)
  CFLAGS = -fPIC $(IFLAGS)
  sobin = $(libdst)/lib$(BASELIBNAME).so
endif

LIBS = $(APPLIBS) $(SYSLIBS)
LFLAGS = $(APPLFLAGS)

#################################################################
#  Customization of the implicit rules - BRAIN DAMAGED makes (HP)

include $(ROOT)/Makefile.common


#################################################################
#  Modules

obj_incs = $(wildcard $(obj_inc)/*.h)
obj_sources = $(wildcard $(obj_src)/*.c)
obj_objs = $(patsubst $(obj_src)/%.c,$(obj)/%.o,$(obj_sources))

objs =  $(obj_objs) 



#################################################################
#  Standard Rules

.PHONY: all clean debug show
 
all: clean $(bin)
so: clean $(sobin)
debug: clean $(sobin)
main: $(sobin) 
clean: 
	$(RM) $(objs)
 
main: $(obj) $(sobin)
	gcc -o $@ -L. -ltest


 
$(sobin): $(objs) 
	$(SOLINK) $@ $? $(LIBS)

$(bin): $(objs) 
	$(AR) $(ARFLAGS) $@ $?
	$(RANLIB) $(RANLIBFLAGS) $@

#################################################################
#  Additional Rules

 
$(obj)/%.o: $(obj_src)/%.c $(obj_incs)
	$(COMPILE.c) $< -o $@



