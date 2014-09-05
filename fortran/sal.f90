PROGRAM mmm
! calcs at 05-Sep-2014
a0 = 2279 ! operating profit y/e 31-Dec-2014
theta1 = 1.0 - 1.0/2.04 ! retention rate
g1 = 0.227 * theta1 ! ROCE * retention rate
h1 = 0.1 ! just use Aswath's Twitter Aug-2014 valuation

r = (1+g1)/(1+h1)
p1 = a0 * (1- theta1) * r * (1- r**5) / (1-r)
print *, "p1 = ", p1

gt = 0.025 ! per Aswath, again
ct = 0.08 
!a6 = a0 * (1 + g1) ** 5 * (1+ gt)
pt0 = a0 * r ** 5 * (1 + gt) /ct
print *, "pt0 = ", pt0
voa = p1 + pt0
print *, "voa = ", voa
cash = 1883 ! actually net cash
cross = 0.0
debt = 0.0
voo = 0.0
voe = voa + cash + cross - debt-voo
print *, "voe = ", voe ! value of equity
end program 

