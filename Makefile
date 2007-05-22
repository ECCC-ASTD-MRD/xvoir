include /usr/local/env/armnlib/include/$(ARCH)$(ABI)/Makefile_addons

.SUFFIXES : 

.SUFFIXES : .ftn90 .f .c .o 

SHELL = /bin/sh

CPP = /lib/cpp

REC_UTILLIB = $(HOME)/userlibs/$(ARCH)$(ABI)/librec_util.a

FFLAGS = 

CFLAGS = -I/usr/X11R6/include -I$(ARMNLIB)/include -I../include -DX_WGL -Wall -Wno-trigraphs

#CFLAGS = -I/usr/include/Motif1.2R6 -I/usr/X11R6/include -I$(ARMNLIB)/include -I$(HOME)/../yrc/src/include -DX_WGL

OPTIMIZ = -O 0 -debug
OPTIMIZ = -O 2

CPPFLAGS = -I$(ARMNLIB)/include =-I$(REC)/include -DX_WGL

.PRECIOUS:

default: xvoir

.ftn90.o:
	r.compile -arch $(ARCH) -abi $(ABI) $(OPTIMIZ) -opt "=$(FFLAGS)" -src $<

.c.o:
	r.compile -arch $(ARCH) -abi $(ABI) $(OPTIMIZ) -opt "=$(CFLAGS)" -src $<

.f.o:
	r.compile -arch $(ARCH) -abi $(ABI) $(OPTIMIZ) -opt "=$(FFLAGS)" -src $<

.c.a:
	r.compile -arch $(ARCH) -abi $(ABI) $(OPTIMIZ) -opt "=$(CFLAGS)" -src $<
	ar rv $@ $*.o
	rm -f $*.o

.f.a:
	r.compile -arch $(ARCH) -abi $(ABI) $(OPTIMIZ) -opt "=$(FFLAGS)" -src $<
	ar rv $@ $*.o
	rm -f $*.o

FTNDECKS=  get_nbrecs_actifs.ftn90 xfsl-xvoir-2000.ftn90 xvoir.ftn90

CDECKS= flush.c langue.c  parent.c  strutil.c  xinit.c  xrecsel.c widgets-util.c


OBJECTS= get_nbrecs_actifs.o xfsl-xvoir-2000.o xvoir.o  \
flush.o langue.o  parent.o  strutil.o  xinit.o  xrecsel.o widgets-util.o

COMDECKS= xfsl-voir.cdk   xfsl.cdk

xvoir: $(OBJECTS)
	r.build -obj $(OBJECTS) -o xvoir -libappl  StaticXm StaticMrm Xmu Xp Xt Xext X11 m -librmn rmn_008

xvoir-IRIX: $(OBJECTS)
	r.build -obj $(OBJECTS) -o xvoir -libappl Xm Xt X11 -librmn rmn_008

clean:
	/bin/rm -f *.f90 *.o xvoir
