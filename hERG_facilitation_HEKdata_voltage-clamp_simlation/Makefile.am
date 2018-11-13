#INCLUDES = syspara.h

bin_PROGRAMS = HERG 
#HERG_CFLAGS = -O2 -Wall -axsse4.2 -mkl -parallel -par-report2 -Winline -inline-level=2 -ip -vec-report2 -opt-mem-layout-trans=3 -pg
HERG_CFLAGS = -O2 -Wall -axsse4.2 -mkl -parallel -par-report2 -vec-report2 -pg

HERG_INCLUDE = -I./include
HERG_LDADD = -L/HOME/opt/intel/mkl/lib/intel64 -liomp5 -lmkl_intel_lp64 -lmkl_intel_thread -lmkl_core ./lib/xhplot.o

HERG_SOURCES = ./src/herg.c ./src/val_constants.c ./src/mem.c\
	./src/win_out.c ./src/eular.c ./src/input_para.c ./src/system.c\
	./src/eventloop.c ./src/data_out.c ./src/syspara.h

