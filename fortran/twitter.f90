! Reproduction of Aswath's Twitter valuation for Aug 2014
! http://www.stern.nyu.edu/~adamodar/pc/blog/TwitterAug2014.xls
! agrees as at 01-Sep-2014
program twitter
real, dimension(0:11) :: rgr, rev, eom, eoi, taxr, eat, nol, rin, fcf, coc, cdf, pvf
real :: icap, nolu

call hello() ! test call of common import
data rgr /1, 5 * 1.45, 6 * 1.025/
call linin(rgr(5:10))
write (*, 2001) "RGRS=",  rgr
!call cumprod(rgr)
!rev = 973.93 * rgr
rev = rgr
rev(0) = 973.93
call cumprod(rev)
write (*, 2000) "REVS=", rev
eom(0) = -33.94 / rev(0)
eom(10:11) = 0.25
call linin(eom(0:10))
write (*, 2001) "EOMS=", eom
eoi = rev * eom
write (*, 2000) "EOIS=", eoi
data taxr / 6 * 0.30 , 6 * 0.40 /
call linin(taxr(5:10))
write (*, 2000) "TAXR=", taxr


nol(0) = 0.0 ! always non-negative
do i= 1, 11
   nolu = merge(eoi(i), min(eoi(i), nol(i-1)), eoi(i).lt.0)
   eat(i) = eoi(i) - (eoi(i) - nolu) * taxr(i)
   nol(i) = nol(i-1) - nolu
   rin(i) = (rev(i) - rev(i-1)) / 2.5
end do
!icap = 2857.0 + sum(rin(1:10))
print *, "rgr(11)", rgr(11)
rin(11) = (rgr(11)-1) / 0.12 *eat(11)
print *, "icap=", icap
write (*, 2000) "NOLS=", nol
write (*, 2000) "EATS=", eat
write (*, 2000) "RINS=", rin
!print *, "RINS TERMINAL IS WRONG"
fcf = eat - rin
write (*, 2000) "FCFS=", fcf
data coc / 1.0, 6 * 1.109, 5 * 1.08 /
call linin(coc(5:10))
write(*, 2001) "COCS=", coc
cdf = coc
call cumprod(cdf)
cdf = 1/ cdf
write (*, 2001) "CDFS=", cdf
pvf = fcf * cdf

tva = fcf(11) / (coc(11) - rgr(11)) ! terminal value
print *, "Terminal Value = ", tva
pvt = tva * cdf(10)
print *, "PV (term val)  = ", pvt
pvd = sum(pvf(1:10))
print *, "PV (CF decade) = ", pvd
pvs = pvt + pvd
print *, "PV Sum         = ", pvs
voe = pvs + 2097.04 - 783.76
print *, "Val of equity  = ", voe
voo = 1381.39
voc = voe - voo
print *, "Val of common  = ", voc
nsh = 595.61
vps = voc/nsh
print *, "Est val per shr= ", vps
spr = 42.94
ppv = spr / vps
print *, "SP as % val    = ", ppv * 100.0

   

2000 format(A5, 12F10.2)
2001 format(A5, 12F10.4)


!end program

contains
include "common.f90"
subroutine linin(a)
real, dimension(:) :: a
real :: delta
j = ubound(a, 1)
delta = (a(j) - a(1))/(j-1)
forall(i=2:j-1) a(i) = a(1) + delta*(i-1)
end subroutine

subroutine cumprod(a)
real, dimension(:) :: a
j = ubound(a,1)
do 100 i = 2, j
a(i) = a(i-1) * a(i)
100 continue
end subroutine

subroutine cumsum(a)
real, dimension(:) :: a
j = ubound(a,1)
do 100 i = 2, j
a(i) = a(i-1) + a(i)
100 continue
end subroutine

end program
