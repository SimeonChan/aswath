! Reproduction of Aswath's Twitter valuation for Aug 2014
! http://www.stern.nyu.edu/~adamodar/pc/blog/TwitterAug2014.xls
! agrees as at 01-Sep-2014

program twitter
use aswath
real :: icap, nolu, scr, spr, nsh, pfail = 0.0, fproc = 0.0

namelist /pars/ rgr_0, rgr_t, rev, eoi_0, eom_t, taxr_0, taxr_t, scr, nol_0, &
     roc_t, coc_0, coc_t, pfail, fproc, cash, voo, debt, nsh, spr
namelist /output/ rgr, rev

!namelist /test/ n
!read (5, nml=test)
!write(6, nml = test)

read(5, nml = pars)
!read(5, nml = parb)
!call assign1(rgr, 1.45, 1.025)
call assign1(rgr, rgr_0, rgr_t)
!rev(0) = 973.93
eom(0) = eoi_0 / rev(0)
eom(10:11) = eom_t
call assign2(taxr, taxr_0, taxr_t)
!scr = 2.5
nol(0) = nol_0
!roc_t = 0.12
call assign1(coc, coc_0, coc_t)
ncash = cash - debt
!voo = 1381.39
!nsh = 595.61
!spr = 42.94




write (*, 2001) "RGRS=",  rgr
rev(1:11) = rgr(1:11)
call cumprod(rev)
write (*, 2000) "REVS=", rev
!write (*, nml = output)
call linin(eom, 0, 10)
write (*, 2001) "EOMS=", eom
eoi = rev * eom
write (*, 2000) "EOIS=", eoi

write (*, 2000) "TAXR=", taxr


!nol(0) = 0.0 ! always non-negative
if(nol(0).lt.0) call abort
do i= 1, 11
   nolu = merge(eoi(i), min(eoi(i), nol(i-1)), eoi(i).lt.0)
   eat(i) = eoi(i) - (eoi(i) - nolu) * taxr(i)
   nol(i) = nol(i-1) - nolu
   rin(i) = (rev(i) - rev(i-1)) / scr
end do
rin(11) = (rgr(11)-1) / roc_t *eat(11)
!print *, "icap=", icap
write (*, 2000) "NOLS=", nol
write (*, 2000) "EATS=", eat
write (*, 2000) "RINS=", rin
fcf = eat - rin
write (*, 2000) "FCFS=", fcf

write(*, 2001) "COCS=", coc
cdf = coc
call cumprod(cdf)
cdf = 1/ cdf
write (*, 2001) "CDFS=", cdf
pvf = fcf * cdf
write (*, 2000) "PVFS=", pvf

tva = fcf(11) / (coc(11) - rgr(11)) ! terminal value
print *, "Terminal Value = ", tva
pvt = tva * cdf(10)
print *, "PV (term val)  = ", pvt
pvd = sum(pvf(1:10))
print *, "PV (CF decade) = ", pvd
pvs = pvt + pvd
print *, "PV Sum         = ", pvs
print *, "Prob failure   = ", pfail
print *, "Failure proceed= ", fproc
voa = pvs * (1.0-pfail) + fproc * pfail
print *, "Val Oper Ass   = ", voa


ncash = cash - debt
voe = voa + ncash
print *, "Val of equity  = ", voe
!voo = 1381.39
print *, "Val of options = ", voo
voc = voe - voo
print *, "Val of common  = ", voc
print *, "Num shares     = ", nsh
!nsh = 595.61
vps = voc/nsh
print *, "Est val per shr= ", vps
print *, "Share price    = ", spr
!spr = 42.94
ppv = spr / vps
print *, "SP as % val    = ", ppv * 100.0

   

2000 format(A5, 12F10.2)
2001 format(A5, 12F10.4)


!contains


end program
