PROGRAM mmm
implicit none

!real, parameter:: rf = 0.0295, beta = 0.2114, erp = 0.0791
real :: rf , erp 
real :: beta 

real :: roe, dcov
real :: eps0 
!real, parameter :: roe = 0.1968, dcov = 2.1, eps0 = 8.98

!real omega, rho
!real a0, theta1, g1, h1

! sensible defaults
!real, parameter::  n = 5.0
integer :: n 
character :: dummy



! intermediate calculations
real :: theta1, g1
real :: gt, r
integer :: i
real ct

real p1, pt0, p0

real :: h1
real :: divs(1:100) ! dividends
read (*,*) dummy
read (*,*) roe
read (*,*) dcov
read (*,*) beta
read (*,*) rf
read (*,*) erp
read (*,*) eps0
read (*,*) n

theta1 = 1-1/dcov
g1 = roe *theta1

! set these intitial values
!beta = 0.2114
!beta = 1.2
h1 = rf + beta * erp


print *, 'g1', g1
r = (1+g1)/(1+h1)
print *, 'r', r, 1/r
do i = 1, n
	divs(i) = eps0 * r ** real(i) * (1-theta1)
	print *, divs(i)
end do
print *, 'p1: sum of divs 1:n', sum(divs(1:5)) ! should equal p1
p1 = eps0 *(1-theta1)*r * (1-r**n)/(1-r)

gt = rf
ct = rf + erp
pt0 = eps0 * r**n * (1+gt)/ct

! calculate pt0 the hard way
!div(n) = div(n-1) / (1-theta1) * (1-gt/ct)
!for i = int(n)+1, 100
!	divs(i) = divs(i-1) * 

p0 = p1+pt0
print *, 'p1', p1, 'pt0', pt0, 'p0', p0




!data rf, beta, erp / 0.0295, 0.2114,  0.0791/

!data omega, rho / 2.1, 0.01968/


!data n / 5.0/
!a0, theta1, g1, h1, 
end program 

