PROGRAM mmm
implicit none

!real, parameter:: rf = 0.0295, beta = 0.2114, erp = 0.0791
real :: rf = 0.0295, beta = 0.2114, erp = 0.0791

real omega, rho
real a0, theta1, g1, h1

! sensible defaults
real, parameter::  n = 5.0

real ct

real p1, pt0, p0



p1 = a0 *(1-theta1)*t * (1-r**n)
pt0 = a0 * r**n * (1+gt)/ct
p0 = p1+pt0
print *, p1, pt0, p0




!data rf, beta, erp / 0.0295, 0.2114,  0.0791/

data omega, rho / 2.1, 0.01968/


!data n / 5.0/
!a0, theta1, g1, h1, 
end program 

