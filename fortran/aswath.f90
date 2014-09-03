module aswath
!type array11
!real, dimension(0:11) :: 

real, dimension(0:11) :: rgr, rev, eom, eoi, taxr, eat, nol, rin, fcf
real, dimension(0:11) :: coc, cdf, pvf

real :: nol_0 = 0.0

!public :: linin

contains

subroutine linin(a, i, j)
real, dimension(0:11) :: a
real :: delta
!j = ubound(a, 1)
delta = (a(j) - a(i))/(j-i)
!print *, "delta=", delta, "i=", i, "j=", j
do k=i+1, j-1
a(k) = a(i) + delta*(k-i)
!print *, "k=", k, "a(k)=", a(k)
end do
!print *, a
end subroutine

subroutine assign1(a, v1, v2)
real, dimension(0:11) :: a
a(0) = 1
a(1:5) = v1
a(6:11) = v2
call linin(a, 5, 10)
end subroutine

subroutine assign2(a, v1, v2)
real, dimension(0:11) :: a
call assign1(a, v1, v2)
a(0) = v1
end subroutine

subroutine cumprod(a)
real, dimension(0:11) :: a
!j = ubound(a,1)
do 100 i = 1, 11
a(i) = a(i-1) * a(i)
100 continue
end subroutine

subroutine cumsum(a)
real, dimension(0:11) :: a
!j = ubound(a,1)
do 100 i = 1, 11
a(i) = a(i-1) + a(i)
100 continue
end subroutine




end module aswath
