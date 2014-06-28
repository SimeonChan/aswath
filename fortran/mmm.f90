PROGRAM mmm
implicit none

!real, parameter:: rf = 0.0295, beta = 0.2114, erp = 0.0791
real :: rf = 0.0295, beta = 0.2114, erp = 0.0791
real, parameter :: roe = 0.1968, dcov = 2.1, eps0 = 8.98

!real omega, rho
!real a0, theta1, g1, h1

! sensible defaults
real, parameter::  n = 5.0

! intermediate calculations
real, parameter :: theta1 = 1 - 1/dcov,  g1 = roe *theta1
real :: gt, r
integer :: i
real ct

real p1, pt0, p0

real :: h1
h1 = rf + beta * erp



r = (1+g1)/(1+h1)
print *, 'r', r, 1/r
do i = 1, 5
	print *, eps0 * r ** i * theta1
end do
p1 = eps0 *(1-theta1)*r * (1-r**n)

gt = rf
pt0 = eps0 * r**n * (1+gt)/ct
p0 = p1+pt0
print *, p1, pt0, p0




!data rf, beta, erp / 0.0295, 0.2114,  0.0791/

!data omega, rho / 2.1, 0.01968/


!data n / 5.0/
!a0, theta1, g1, h1, 
end program 

