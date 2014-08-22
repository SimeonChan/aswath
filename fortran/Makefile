.PHONY: all clean

all: mmm tesla

mmm : mmm.f90
	gfortran mmm.f90 -o mmm

tesla : tesla.f90
	gfortran tesla.f90 -o tesla

clean : 
	rm -f mmm tesla  *.mod *.exe *~
