PROGRAM mmm
!implicit none

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

! for testing purposes
real :: eps(1:100), divs(1:100), df(1:100), pts(1:100) ! dividends

!!$read (*,*) dummy
!!$read (*,*) roe
!!$read (*,*) dcov
!!$read (*,*) beta
!!$read (*,*) rf
!!$read (*,*) erp
!!$read (*,*) eps0
!!$read (*,*) n


a0 = 3586
theta1 = 0.30
g1 = 0.075
h1 = 0.0863

r = (1+g1)/(1+h1)
p1 = a0 * (1- theta1) * r * (1- r**5) / (1-r)
print *, "p1 = ", p1

gt = 0.03
ct = 0.0676
!a6 = a0 * (1 + g1) ** 5 * (1+ gt)
pt0 = a0 * r ** 5 * (1 + gt) /ct
print *, "pt0 = ", pt0
voa = p1 + pt0
print *, "voa = ", voa
cash = 2475
cross = 778
debt = 5297
voo = 1216
voe = voa + cash + cross - debt-voo
print *, "voe = ", voe
print *, "Agrees closely with Dark p 52, and Little p 56"
stop



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
eps(n) = divs(n) / (1-theta1) * (1+h1) **n
!div(n) = div(n-1) / (1-theta1) * (1-gt/ct)
df(n) = 1
do i = n+1, 100
	eps(i) = eps(i-1) * (1+gt)
	df(i) = df(i-1) /(1+ct)
!	divs(i) = divs(i-1) * 
enddo
print *, 'terminal eps', eps(n+1: n+6)
divs = eps * (1- gt/ct)
print *, 'divs in terminal', divs(n+1:n+6)
df = df / (1+h1) ** n
print *, "discount factors terminal", df(n+1:n+6)
pts = divs * df 
print *, "pts terminal", pts(n+1:n+6)
print *, 'pt0 as a sum', sum(pts(n+1:100))

p0 = p1+pt0
print *, 'p1', p1, 'pt0', pt0, 'p0', p0




!data rf, beta, erp / 0.0295, 0.2114,  0.0791/

!data omega, rho / 2.1, 0.01968/


!data n / 5.0/
!a0, theta1, g1, h1, 
end program 

