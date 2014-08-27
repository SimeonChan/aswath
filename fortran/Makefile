.PHONY: all clean

BINS = mmm sal tesla twitter

all: $(BINS)

mmm : mmm.f90
	gfortran mmm.f90 -o mmm

sal : sal.f90
	gfortran sal.f90 -o sal

tesla : tesla.f90
	gfortran tesla.f90 -o tesla

% : %.f90 common.f90
	gfortran $< -o $@

clean : 
	rm -f $(BINS)  a.out *.mod *.exe *~
