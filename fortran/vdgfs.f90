! Reproduction of Aswath's Twitter valuation for Aug 2014
! http://www.stern.nyu.edu/~adamodar/pc/blog/TwitterAug2014.xls
! agrees as at 01-Sep-2014

program vdgfs
use aswath
integer :: scenario = -1
real :: icap, nolu, scr, spr, nsh, pfail = 0.0, fproc = 0.0

namelist /config/ scenario

namelist /pars/ rgr_0, rgr_t, rev, eoi_0, eom_t, taxr_0, taxr_t, scr, nol_0, &
     roc_t, coc_0, coc_t, pfail, fproc, cash, voo, debt, nsh, spr
namelist /output/ rgr, rev
namelist /test/ foo

read(5, nml = config)
read(5, nml = pars)
if(scenario.eq.1) call scenario1()

contains

subroutine scenario1()


call assign1(rgr, rgr_0, rgr_t)
eom(0) = eoi_0 / rev(0)
eom(10:11) = eom_t
call assign2(taxr, taxr_0, taxr_t)
nol(0) = nol_0
call assign1(coc, coc_0, coc_t)
ncash = cash - debt



rev(1:11) = rgr(1:11)
call cumprod(rev)
call linin(eom, 0, 10)

eoi = rev * eom



!nol(0) = 0.0 ! always non-negative
if(nol(0).lt.0) call abort
do i= 1, 11
   nolu = merge(eoi(i), min(eoi(i), nol(i-1)), eoi(i).lt.0)
   eat(i) = eoi(i) - (eoi(i) - nolu) * taxr(i)
   nol(i) = nol(i-1) - nolu
   rin(i) = (rev(i) - rev(i-1)) / scr
end do
rin(11) = (rgr(11)-1) / roc_t *eat(11)
fcf = eat - rin



cdf = coc
call cumprod(cdf)
cdf = 1/ cdf

pvf = fcf * cdf


tva = fcf(11) / (coc(11) - rgr(11)) ! terminal value
pvt = tva * cdf(10)
pvd = sum(pvf(1:10))

pvs = pvt + pvd
voa = pvs * (1.0-pfail) + fproc * pfail



ncash = cash - debt
voe = voa + ncash
voc = voe - voo
vps = voc/nsh
ppv = spr / vps


! printout
write (*, 2001) "RGRS=",  rgr
write (*, 2000) "REVS=", rev
write (*, 2001) "EOMS=", eom
write (*, 2000) "EOIS=", eoi
write (*, 2000) "TAXR=", taxr
write (*, 2000) "NOLS=", nol(0:11)
write (*, 2000) "EATS=", eat
write (*, 2000) "RINS=", rin
write (*, 2000) "FCFS=", fcf
write (*, 2001) "COCS=", coc
write (*, 2001) "CDFS=", cdf
write (*, 2000) "PVFS=", pvf

print *, "Terminal Value = ", tva
print *, "PV (term val)  = ", pvt
print *, "PV (CF decade) = ", pvd
print *, "PV Sum         = ", pvs
print *, "Prob failure   = ", pfail
print *, "Failure proceed= ", fproc
print *, "Val Oper Ass   = ", voa
print *, "Val of equity  = ", voe
print *, "Val of options = ", voo
print *, "Val of common  = ", voc
print *, "Num shares     = ", nsh
print *, "Est val per shr= ", vps
print *, "Share price    = ", spr
print *, "SP as % val    = ", ppv * 100.0

   

2000 format(A5, 12F10.2)
2001 format(A5, 12F10.4)

end subroutine

end program
