! Reproduction of Aswath's Twitter valuation for Aug 2014
! http://www.stern.nyu.edu/~adamodar/pc/blog/TwitterAug2014.xls
program twitter
real, dimension(0:11) :: rgr, rev

call hello() ! test call of common import
call linin(rgr(5:10))
write (*, 2001) "RGRS=",  rgr
call cumprod(rgr)
rev = 973.93 * rgr
write (*, 2000) "REVS=", rev

2000 format(A5, 12F10.2)
2001 format(A5, 12F10.3)

data rgr /1, 5 * 1.45, 6 * 1.025/
!end program

contains
include "common.f90"
subroutine linin(a)
real, dimension(:) :: a
real :: delta
j = ubound(a, 1)
delta = (a(2) - a(1))/(j-1)
forall(i=2:j-1) a(i) = a(1) + delta*(i-1)
end subroutine

subroutine cumprod(a)
real, dimension(:) :: a
j = ubound(a,1)
do 100 i = 2, j
a(i) = a(i-1) * a(i)
100 continue
end subroutine

end program
