CC = /usr/local/clang6/bin/clang
SUFFIX = 
CFLAGS = -Wall -g -O2  -I../../inst/include -fPIC -DR_PACKAGE=1 -DHAVE_CONFIG_H -DREALSIZE=8 -I$(common) -I. -I$(srcdir)
MCFLAGS = 
FC = gfortran
FCFLAGS = -g -O2 -DREALSIZE=8
LIBS = -lm
INSTALL = /usr/bin/install -c
INSTALL_DATA = ${INSTALL} -m 644
INSTALL_PROGRAM = ${INSTALL}
RANLIB = ranlib
EXE = 

prefix = /usr/local
exec_prefix = ${prefix}
srcdir = .
bindir = ${exec_prefix}/bin
libdir = ${exec_prefix}/lib
includedir = ${prefix}/include
datarootdir = ${prefix}/share
datadir = ${datarootdir}

MATH_DEFAULT = 
TOOLS_DEFAULT = 
DEMO_FORTRAN_DEFAULT = demo-fortran$(EXE)

MCC = CC="$(tools)/fcc" CXX="$(tools)/fcc -stdlib=libstdc++" \
  REALCC="$(CC)" PATH="$(PATH):$(tools)" mcc

TARDIR = Cuba-4.2
TARFILE = $(TARDIR).tar.gz


HEADERS = cuba$(SUFFIX).h
LIB = libcuba$(SUFFIX).a
MATH = Vegas$(SUFFIX)$(EXE) Suave$(SUFFIX)$(EXE) Divonne$(SUFFIX)$(EXE) Cuhre$(SUFFIX)$(EXE)
TOOLS = partview$(EXE)


all: lib demos $(MATH_DEFAULT) $(TOOLS_DEFAULT)

lib: $(LIB) $(HEADERS)

demos: demo-c$(EXE) $(DEMO_FORTRAN_DEFAULT)

math: $(MATH)

tools: $(TOOLS)


install: lib $(TOOLS_DEFAULT)
	$(INSTALL) -m 755 -d $(DESTDIR)$(libdir) \
	                     $(DESTDIR)$(includedir) \
	                     $(DESTDIR)$(bindir) \
	                     $(DESTDIR)$(datadir)
	$(INSTALL_DATA) $(LIB) $(DESTDIR)$(libdir)
	for f in $(HEADERS) ; do \
	  $(INSTALL_DATA) `test -f $$f || echo $(srcdir)/`$$f $(DESTDIR)$(includedir); \
	done
	for f in $(MATH) $(TOOLS) ; do \
	  test -f $$f && $(INSTALL_PROGRAM) $$f $(DESTDIR)$(bindir) || : ; \
	done
	$(INSTALL_DATA) $(srcdir)/cuba.pdf $(DESTDIR)$(datadir)


check: demo-c
	./demo-c | grep RESULT > demo-c.out
	@echo diff demo-c.out $(demo)/demo-c.out
	@diff demo-c.out $(demo)/demo-c.out || \
	echo "Note: This is serious only if the results deviate significantly."

.SUFFIXES:
.SUFFIXES: .c .f .tm

common = $(srcdir)/src/common
vegas = $(srcdir)/src/vegas
suave = $(srcdir)/src/suave
divonne = $(srcdir)/src/divonne
cuhre = $(srcdir)/src/cuhre
demo = $(srcdir)/demo
tools = $(srcdir)/tools


COMMON_DEPS = $(common)/stddecl.h $(common)/ChiSquare.c $(common)/Erf.c
COMMON_CDEPS = $(COMMON_DEPS) $(common)/CSample.c $(common)/Parallel.c $(common)/sock.h
COMMON_TMDEPS = $(COMMON_DEPS) $(common)/MSample.c

VEGAS_C = $(vegas)/Vegas.c
VEGAS_TM = $(vegas)/Vegas.tm
VEGAS_DEPS = $(common)/Random.c \
  $(vegas)/decl.h $(vegas)/common.c \
  $(vegas)/Grid.c $(vegas)/Integrate.c
VEGAS = $(VEGAS_C) $(VEGAS_TM) $(VEGAS_DEPS)

$(LIB)(Vegas.o): config.h $(VEGAS_C) $(VEGAS_DEPS) $(COMMON_CDEPS) 
	$(CC) $(CFLAGS) -I$(vegas) -DNOUNDERSCORE -c -o Vegas.o $(VEGAS_C)
	$(AR) $(ARFLAGS) $(LIB) Vegas.o
	$(RM) Vegas.o

SUAVE_C = $(suave)/Suave.c
SUAVE_TM = $(suave)/Suave.tm
SUAVE_DEPS = $(common)/Random.c \
  $(suave)/decl.h $(suave)/common.c \
  $(suave)/Grid.c $(suave)/Fluct.c $(suave)/Sample.c \
  $(suave)/Integrate.c
SUAVE = $(SUAVE_C) $(SUAVE_TM) $(SUAVE_DEPS)

$(LIB)(Suave.o): config.h $(SUAVE_C) $(SUAVE_DEPS) $(COMMON_CDEPS)
	$(CC) $(CFLAGS) -I$(suave) -DNOUNDERSCORE -c -o Suave.o $(SUAVE_C)
	$(AR) $(ARFLAGS) $(LIB) Suave.o
	$(RM) Suave.o

DIVONNE_C = $(divonne)/Divonne.c
DIVONNE_TM = $(divonne)/Divonne.tm
DIVONNE_DEPS = $(common)/Random.c \
  $(divonne)/decl.h $(divonne)/common.c \
  $(divonne)/KorobovCoeff.c $(divonne)/Rule.c $(divonne)/Sample.c \
  $(divonne)/FindMinimum.c $(divonne)/Iterate.c $(divonne)/Explore.c \
  $(divonne)/Split.c $(divonne)/Integrate.c
DIVONNE = $(DIVONNE_C) $(DIVONNE_TM) $(DIVONNE_DEPS)

$(LIB)(Divonne.o): config.h $(DIVONNE_C) $(DIVONNE_DEPS) $(COMMON_CDEPS)
	$(CC) $(CFLAGS) -I$(divonne) -DNOUNDERSCORE -c -o Divonne.o $(DIVONNE_C)
	$(AR) $(ARFLAGS) $(LIB) Divonne.o
	$(RM) Divonne.o

CUHRE_C = $(cuhre)/Cuhre.c
CUHRE_TM = $(cuhre)/Cuhre.tm
CUHRE_DEPS = \
  $(cuhre)/decl.h $(cuhre)/common.c \
  $(cuhre)/Rule.c $(cuhre)/Integrate.c
CUHRE = $(CUHRE_C) $(CUHRE_TM) $(CUHRE_DEPS)

$(LIB)(Cuhre.o): config.h $(CUHRE_C) $(CUHRE_DEPS) $(COMMON_CDEPS)
	$(CC) $(CFLAGS) -I$(cuhre) -DNOUNDERSCORE -c -o Cuhre.o $(CUHRE_C)
	$(AR) $(ARFLAGS) $(LIB) Cuhre.o
	$(RM) Cuhre.o


$(LIB)(Fork.o): $(common)/Fork.c $(common)/stddecl.h $(common)/sock.h
	$(CC) $(CFLAGS) -DNOUNDERSCORE -c -o Fork.o $(common)/Fork.c
	$(AR) $(ARFLAGS) $(LIB) Fork.o
	$(RM) Fork.o

$(LIB)(Fork_.o): $(common)/Fork.c $(common)/stddecl.h $(common)/sock.h
	$(CC) $(CFLAGS) -c -o Fork_.o $(common)/Fork.c
	$(AR) $(ARFLAGS) $(LIB) Fork_.o
	$(RM) Fork_.o


$(LIB)(Global.o): $(common)/Global.c $(common)/stddecl.h
	$(CC) $(CFLAGS) -DNOUNDERSCORE -c -o Global.o $(common)/Global.c
	$(AR) $(ARFLAGS) $(LIB) Global.o
	$(RM) Global.o

$(LIB)(Global_.o): $(common)/Global.c $(common)/stddecl.h
	$(CC) $(CFLAGS) -c -o Global_.o $(common)/Global.c
	$(AR) $(ARFLAGS) $(LIB) Global_.o
	$(RM) Global_.o


$(LIB)(Data.o): $(common)/Data.c $(common)/stddecl.h
	$(CC) $(CFLAGS) -c -o Data.o $(common)/Data.c
	$(AR) $(ARFLAGS) $(LIB) Data.o
	$(RM) Data.o


$(LIB): $(LIB)(Vegas.o)     \
	$(LIB)(Suave.o)     \
	$(LIB)(Divonne.o)   \
	$(LIB)(Cuhre.o)     \
	$(LIB)(Fork.o)      \
	$(LIB)(Global.o)    \
	$(LIB)(Data.o)
	-$(RANLIB) $(LIB)


clean:
	-$(RM) $(TARFILE) $(TARDIR) demo-c.out \
	  partview.moc partview.o makefile.partview \
	  cubal.h cubaq.h *.o */*.o */*.tm.c *.tm

distclean: clean
	-$(RM) $(LIB) demo-c demo-fortran $(MATH) $(TOOLS) \
	  config.h config.log config.status makefile

