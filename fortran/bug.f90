! actually, bug doesn't exist
program bug

real :: rev(0:11), nol_0, nsh

namelist /pars/ rgr_0, rgr_t, rev, eoi_0, eom_t, taxr_0, taxr_t, scr, nol_0, &
     roc_t, coc_0, coc_t, cash,  voo
namelist /parb/ nsh, spr, debt

read(5, nml = pars)
read(5, nml = parb)

write(*, nml = pars)

end program

