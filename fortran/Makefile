.PHONY: all clean

BINS = mmm sal tesla twitter

all: $(BINS)

aswath.o aswath.mod : aswath.f90
	gfortran -c aswath.f90

mmm : mmm.f90
	gfortran mmm.f90 -o mmm

sal : sal.f90
	gfortran sal.f90 -o sal

tesla : tesla.f90
	gfortran tesla.f90 -o tesla

twitter.o : twitter.f90 aswath.o
	gfortran -c twitter.f90

#twitter : twitter.f90 aswath.mod
#	gfortran twitter.f90 aswath.f90 -o twitter

twitter : twitter.o aswath.o 
	gfortran twitter.o aswath.o -o twitter

% : %.f90 common.f90
	gfortran $< -o $@

clean : 
	rm -f $(BINS)  a.out *.mod  *.o *.exe *~
