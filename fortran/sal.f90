program sal
implicit double precision (A-H, L-Z)

df = 1
ebit = 22.7

pv   = 0

do 100 i=1, 5
      roce = linter(0.227, 0.0614, i)
      print *, "roce=", roce
      dcov = linter(2.28, 1.5, i)
      ebit = ebit * (1 - 1/dcov)
      print *, "ebit=", ebit
      div  = ebit / dcov
      df = df * (1.0791)
      pv   = pv + div/df
100   continue
print *, pv
pvt = div * (1+ 0.0295)/ 0.0496 /df ! is df out by one?
print *, pvt
print *, "the calcs are certainly worng!"
end program sal

double precision function linter(a, b, i)
      linter = a * (6-i)/5 + b * (i-1)/5
end function



