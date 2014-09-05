PROGRAM grow2
! calcs at 05-Sep-2014
call go('SAL', 2279.0, 2.04, 0.227, 1883.0)
call go('BSY', 1161.0, 1.88, 0.295, -1212.0)
call go('SMWH', 107.0, 2.30, 0.661, 31.0)
call go('TSCO', 2353.0, 2.99, 0.0915, -6597.0)


contains

subroutine go(epic, a0, dcov, roce, ncash)
character epic(*)
real :: a0, dcov, roce, ncash
theta1 = 1.0 - 1.0/dcov ! retention rate
g1 = roce * theta1 ! ROCE * retention rate
h1 = 0.1 ! just use Aswath's Twitter Aug-2014 valuation

r = (1+g1)/(1+h1)
p1 = a0 * (1- theta1) * r * (1- r**5) / (1-r)
!print *, "p1 = ", p1

gt = 0.025 ! per Aswath, again
ct = 0.08 
!a6 = a0 * (1 + g1) ** 5 * (1+ gt)
pt0 = a0 * r ** 5 * (1 + gt) /ct
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

