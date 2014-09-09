PROGRAM grow2
! calcs at 07-Sep-2014
call go2('SAL', 2279.0, 2.04, 0.227, 1883.0) ! => 31253
call go2('BSY', 1161.0, 1.88, 0.295, -1212.0) ! => 15424
call go2('SMWH', 107.0, 2.30, 0.661, 31.0) !=> 3695
call go2('TSCO', 2353.0, 2.99, 0.0915, -6597.0) ! => 16069
call go2('SN. ', 490.9, 2.81, 0.20, -153.3) ! => 6247
call go2('PAY ', 44.3, 1.50, 0.427, 41.6) ! => 714
call go2('DPLM', b0 = 48.9, dcov = 2.0, roce = 0.264, ncash = 8.0)
call go2('CGS ', 21.6, 2.5, 0.154, 209.4-181.7)
call go2('HIK', 245.8, 7.09, 0.305, -158.0)

fadj = 2476 + 778 - 5297 - 1215
call go1("MMM ", a0 = 3586.0 , theta1 = 0.3, g1 = 0.075, ncash = fadj, h1 = 0.0863, gt = 0.03, ct = 0.0676)

contains

subroutine go1(epic, a0, theta1, g1, ncash, h1, gt, ct)
character epic(*)
real :: ncash

r = (1+g1)/(1+h1)
p1 = a0 * (1- theta1) * r * (1- r**5) / (1-r)
pt0 = a0 * r ** 5 * (1 + gt) /ct
voa = p1 + pt0
voe = voa + ncash 

print *, epic(1:4), voe

end subroutine


subroutine go2(epic, b0, dcov, roce, ncash, h1, gt, ct, taxr)
implicit none
character epic(*)
real :: b0 ! operating profits BEFORE tax
real :: a0, dcov, roce, ncash, g1, p1, pt0, r, theta1, voa, voe
real, optional :: h1, gt, ct, taxr

! Use defaults from Aswath's Twitter Aug-2014 valuation
real :: h1_aux = 0.1, gt_aux = 0.025, ct_aux = 0.08
real :: taxr_aux = 0.21 ! http://www.hmrc.gov.uk/rates/corp.htm as at 07-Sep-2014

if(present(h1)) h1_aux = h1
if(present(gt)) gt_aux = gt
if(present(ct)) ct_aux = ct
if(present(taxr)) taxr_aux = taxr

a0 = b0 * (1.0-taxr_aux)
theta1 = 1.0 - 1.0/dcov ! retention rate
g1 = roce * theta1 ! ROCE * retention rate
call go1(epic, a0, theta1, g1, ncash, h1_aux, gt_aux, ct_aux)

end subroutine



end program 

