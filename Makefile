include $(ARMNLIB)/include/$(BASE_ARCH)$(ABI)/Makefile_addons

.SUFFIXES : 

.SUFFIXES : .ftn90 .f .c .o 

SHELL = /bin/sh

CPP = /lib/cpp

REC_UTILLIB = $(HOME)/userlibs/$(EC_ARCH)$(ABI)/librec_util.a

FFLAGS = 

CFLAGS = -I/usr/X11R6/include -I$(ARMNLIB)/include -I../include -DX_WGL  

CFLAGS = -I/opt/xm/include -I/usr/X11R6/include -I$(ARMNLIB)/include -I../include -DX_WGL  


OPTIMIZ = -O 2
OPTIMIZ = -O 0 -debug

CPPFLAGS = -I$(ARMNLIB)/include =-I$(REC)/include -DX_WGL

.PRECIOUS:

VER = 2.1

LIBRMN = rmn_014

default: xvoir

.ftn90.o:
	s.compile -abi $(ABI) $(OPTIMIZ) -opt "=$(FFLAGS)" -src $<

.c.o:
	s.compile -abi $(ABI) $(OPTIMIZ) -opt "=$(CFLAGS)" -src $<

.f.o:
	s.compile -abi $(ABI) $(OPTIMIZ) -opt "=$(FFLAGS)" -src $<

.c.a:
	s.compile $(EC_ARCH) -abi $(ABI) $(OPTIMIZ) -opt "=$(CFLAGS)" -src $<
	ar rv $@ $*.o
	rm -f $*.o

.f.a:
	s.compile -abi $(ABI) $(OPTIMIZ) -opt "=$(FFLAGS)" -src $<
	ar rv $@ $*.o
	rm -f $*.o

FTNDECKS=  get_nbrecs_actifs.ftn90 xfsl-xvoir-2000.ftn90 xvoir.ftn90

CDECKS= aux.c flush.c langue.c  parent.c  strutil.c  xinit.c  xrecsel.c widgets-util.c


OBJECTS= aux.o get_nbrecs_actifs.o xfsl-xvoir-2000.o xvoir.o  \
flush.o langue.o  parent.o  strutil.o  xinit.o  xrecsel.o widgets-util.o

COMDECKS= xfsl-voir.cdk   xfsl.cdk

xvoir-AIX: $(OBJECTS)
	s.compile -obj $(OBJECTS) -o xvoir_$(VER)-$(BASE_ARCH) -libappl  Xm Mrm Xmu Xp Xt Xext X11 m jpeg png -librmn $(LIBRMN) -libpath /opt/lib

xvoir-IRIX64: $(OBJECTS)
	s.compile -obj $(OBJECTS) -o xvoir_$(BASE_ARCH) -libappl  Xm Mrm Xmu Xt Xext X11 m jpeg png -librmn $(LIBRMN) -libpath /opt/lib

xvoir: $(OBJECTS)
	s.compile -obj $(OBJECTS) -o xvoir_$(VER)-$(BASE_ARCH) -libappl  Xm Mrm Xp Xt Xext X11 Xft Xrender m jpeg png -librmn $(LIBRMN) -libpath /opt/xm/lib /usr/lib

xvoir-IRIX: $(OBJECTS)
	s.compile -obj $(OBJECTS) -o xvoir_$(BASE_ARCH) -libappl Xm Xt X11 -librmn $(LIBRMN)

clean:
	/bin/rm -f *.f90 *.o xvoir_$(VER)-$(BASE_ARCH)
