include Makefile_$(ARCH)$(ABI)

.SUFFIXES : 

.SUFFIXES : .ftn .f .c .o 

SHELL = /bin/sh

CPP = /lib/cpp

RECLIB = $(REC)/lib/$(ARCH)$(ABI)/librec.a

FFLAGS = 

CFLAGS = -I/usr/include/Motif1.2R6 -I/usr/X11R6/include -I$(ARMNLIB)/include -I$(HOME)/../yrc/src/include -DX_WGL

OPTIMIZ = -O 2

CPPFLAGS = -I$(ARMNLIB)/include =-I$(HOME)/src/include -DX_WGL

.PRECIOUS:

default: xvoir

.ftn.o:
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

FTNDECKS=  xfsl-voir.ftn     xvoir.ftn

FDECKS= xfsl-voir.f     xvoir.f

CDECKS= aux.c   flush.c   langue.c   parent.c    strutil.c   widgets-util.c   xinit.c   xrecsel.c

OBJECTS= aux.o  flush.o  langue.o  parent.o  strutil.o widgets-util.o  xfsl-voir.o xinit.o xrecsel.o  xvoir.o

COMDECKS= xfsl-voir.cdk   xfsl.cdk

xfsl-voir.o: 	xfsl-voir.ftn xfsl-voir.cdk 
xvoir.o:	xvoir.ftn 


obj: $(CDECKS) $(FDECKS) $(OBJECTS)
#Produire les fichiers objets (.o) pour tous les fichiers

xvoir: $(OBJECTS)
	r.build -obj $(OBJECTS) -o xvoir -libpath $(REC)/lib/$(ARCH)$(ABI) /usr/lib/Motif1.2_R6 /usr/lib/X11R6	/usr/X11R6/lib -libappl wglx Xm Xt X11 m -librmn

clean:
	/bin/rm -f *.f *.o xvoir
