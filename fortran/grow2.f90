PROGRAM grow2
! calcs at 05-Sep-2014
call go('SAL', 2279.0, 2.04, 0.227, 1883.0) ! => 39060
call go('BSY', 1161.0, 1.88, 0.295, -1212.0) ! => 19846
call go('SMWH', 107.0, 2.30, 0.661, 31.0) !=> 4669
call go('TSCO', 2353.0, 2.99, 0.0915, -6597.0) ! => 22094
call go('SN. ', 490.9, 2.81, 0.20, -153.3) ! => 7949
call go('PAY ', 44.3, 1.50, 0.427, 41.6) ! => 892

!call go("MMM ", a0 = 3586.0 , dcov = 1.0/0.7, h1 = , gt = , ct = )

contains

subroutine go(epic, a0, dcov, roce, ncash, h1, gt, ct)
implicit none
character epic(*)
real :: a0, dcov, roce, ncash, g1, p1, pt0, r, theta1, voa, voe
real, optional :: h1, gt, ct

! Use defaults from Aswath's Twitter Aug-2014 valuation
real :: h1_aux = 0.1, gt_aux = 0.025, ct_aux = 0.08

if(present(h1)) h1_aux = h1
if(present(gt)) gt_aux = gt
if(present(ct)) ct_aux = ct
theta1 = 1.0 - 1.0/dcov ! retention rate
g1 = roce * theta1 ! ROCE * retention rate
!h1 = 0.1 ! just use Aswath's Twitter Aug-2014 valuation

r = (1+g1)/(1+h1_aux)
p1 = a0 * (1- theta1) * r * (1- r**5) / (1-r)
!print *, "p1 = ", p1

!gt = 0.025 ! per Aswath, again
!ct = 0.08 
!a6 = a0 * (1 + g1) ** 5 * (1+ gt)
pt0 = a0 * r ** 5 * (1 + gt_aux) /ct_aux
!print *, "pt0 = ", pt0
voa = p1 + pt0
!print *, "voa = ", voa
!cash = 1883 ! actually net cash
!cross = 0.0
!debt = 0.0
!voo = 0.0
voe = voa + ncash 
!print *, "voe = ", voe ! value of equity

print *, epic(1:4), voe
end subroutine



end program 

