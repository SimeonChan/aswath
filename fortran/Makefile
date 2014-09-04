.PHONY: all clean

BINS = mmm sal vdgfs

all: $(BINS)

aswath.o aswath.mod  : aswath.f90
	gfortran -c aswath.f90

#aswath.o : aswath.mod
#	gfortran  aswath.mod

mmm : mmm.f90
	gfortran mmm.f90 -o mmm

sal : sal.f90
	gfortran sal.f90 -o sal

#tesla : tesla.f90
#	gfortran tesla.f90 -o tesla

vdgfs.o : vdgfs.f90 aswath.mod
	gfortran -c $< 

vdgfs : vdgfs.o aswath.mod
	gfortran vdgfs.o aswath.o    -o vdgfs 

#twitter : twitter.f90 aswath.mod
#	gfortran twitter.f90 aswath.f90 -o twitter

twitter : twitter.o aswath.o 
	gfortran twitter.o aswath.o -o twitter

%.o : %.f90 
	gfortran -c $< 

clean : 
	rm -f $(BINS)  a.out *.mod  *.o *.exe *~
