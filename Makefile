.PHONY : clean

tesla : tesla.f90
	gfortran -o tesla tesla.f90

clean :
	rm tesla.exe
