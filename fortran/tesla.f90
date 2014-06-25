! Reproduces Aswath's Tesla valuation from Sep-13
module pars
	integer, parameter :: N1 = 5, N2 = 10
	real :: RGR1 = 0.7, RGR2 = 0.0275
	real :: EOM2 = 0.125
	real :: SCR = 1.41 ! sales to captial ratio
end module pars

program tesla
use pars
! N1 = initial growth phase (in years)
! N2 = last year of normalisation phase ( in years)
!integer, parameter :: N1 = 5, N2 = 10
!real, parameter :: RGR1 = 0.7 ! revenue growth rate in growth phase
!real, parameter :: RGR2 = 0.0275 ! terminal growth rate (usually risk-free rate)!real rgr

real :: revs(0:N2) ! revenues
real :: rgr(0:N2) ! revenue growth rates
real :: eom(0:N2) ! EBIT operating margin
real :: eoi(0:N2) ! EBIT operating income
real :: tr(0:N2) ! tax rate
real :: eat(0:N2) ! ebit after tax
real :: nol(0:N2) ! net operating loss
real :: nolu ! net operating loss utilised during year
real :: reinv(0:N2)
real :: fcff(0:N2)
real :: coc(0:N2) ! cost of capital
real :: cdf(0:N2) ! cumulated discount factor
real :: pv(0:N2)  ! present value of FCFF

real :: lini !, linia
revs(0) = 1328.7
eom(0) = -0.0164
nol(0) = 1070

call linia(rgr, 0.7, 0.0275)
do i= 1,N2
	revs(i) = revs(i-1) * (1 + rgr(i))
end do
!	eom(i) = lini(i, eom(0), EOM2)
!end do
call linib(eom, eom(0), EOM2)
eoi = revs * eom
call linia(tr, 0.0, 0.35)
eat(0) = min(eoi(0), eoi(0) * (1-tr(0)))
reinv(0) = 0
do i = 1, N2
	if(eoi(i).lt.0) then
		eat(i) = eoi(i)
		nol(i) = nol(i-1) - eat(i)
	else
		nolu = min(nol(i-1), eoi(i))
		eat(i) = eoi(i) - (eoi(i) - nolu) * tr(i)
		nol(i) = nol(i-1) - nolu
	endif

	reinv(i) = (revs(i) - revs(i-1))/SCR
end do
reinv(0) = 0
fcff = eat-reinv
fcff(0) = 0
call linia(coc, 0.1003, 0.08)
coc(0) = 0
cdf(0) = 1
do i = 1, N2
	cdf(i) = cdf(i-1) /(1+coc(i))
end do
pv = fcff * cdf


write (*,*) "I   RGR       REV   EOM%       EOI   TR%       EAT", &
	&"       NOL     REINV      FCFF       COC      CDF     PVFCFF"
do i = 0, N2
	write(*,1000) i, rgr(i), revs(i), eom(i) * 100, eoi(i), tr(i)* 100,&
		& eat(i), nol(i), reinv(i), fcff(i), coc(i), cdf(i), pv(i)
end do
1000 format (i2,f6.2,f10.2,f7.2,f10.2,f6.1, f10.2, f10.2, f10.2, f10.2, &
	& f10.5, f10.5, f10.2)
end program

subroutine linia(arr, a, b)
use pars
real :: arr(0:N2)
do i=0, N2
	if(i.le.N1) then
		arr(i) = a
	else if (i.le.N2) then
		arr(i) = a - (a - b) * (i-N1) / (N2 - N1)
	else 
		arr(i) = b
	end if
end do
end subroutine

subroutine linib(arr, a, b)
use pars
real :: arr(0:N2)
do i = 0, N2
	if(i.gt.N2) then
		arr(i) = b
	else
		arr(i) = a + i * (b-a) / N2
	end if
end do
end subroutine
