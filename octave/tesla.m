format free

function r = lin11( a, b) ; r =[linspace(a, a, 4), linspace(a, b, 6), b] ; end;

rgr1 = 0.7 ; rgrt = 0.0275;
#rgr = 1+[linspace(.7, .7, 4), linspace(0.7, 0.0275, 6)] # T/over growth rate pa
rgr = 1 + [0, lin11(rgr1, rgrt)]
rev0 = 1328.7 ; revs = rev0 * cumprod(rgr) # revenues
eoi0 = -21.86; eoit = 0.125; 
eom  =[linspace(eoi0/rev0, eoit, 11), eoit]
eoi = eom .* revs
tax0 = 0 ; taxt = 0.35 ; taxr = [0, lin11(tax0, taxt)]
tax = eoi .* taxr
eat = eoi .- tax

revinc = revs -  [rev0, revs](1:end-1) # incremental revenues
#reinv = revinc/ 1.41;
#icap = cumsum([1698, revinc/1.41])(1:end-1) # invested capital
icap = 1698 + cumsum(revinc/1.41)(1:end-1)
#icap11 = 1698 + sum(reinv) # invested capital in yr 11
#roic11 = eat(10) /icap11
roic = eat(1:end-1) ./ icap
reinv(11) = revs(11) / roic11 * eat(11)
disp(reinv)
fcff = eat - reinv


coc = [linspace(0.1003, 0.1003, 4), linspace(0.1003, .08, 6)]
coci = ones(1, 10) ./ (1+coc)
cdf = cumprod(coci)
pv = fcff .* cdf


