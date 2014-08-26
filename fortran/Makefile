.PHONY: all clean

BINS = mmm sal tesla

all: $(BINS)

mmm : mmm.f90
	gfortran mmm.f90 -o mmm

sal : sal.f90
	gfortran sal.f90 -o sal

tesla : tesla.f90
	gfortran tesla.f90 -o tesla

clean : 
	rm -f $(BINS)  *.mod *.exe *~
