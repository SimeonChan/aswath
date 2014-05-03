#!/usr/bin/env python3


import argparse
import configparser
from operator import *

params = None
def pnum(key): global params ; return float(params[key])

def stepping(a, b, n): return [ a + (b-a)*i/(n-1) for i in range(n)]
	
def linia(phase1, phase2):
	return [phase1] * 4 + stepping(phase1, phase2, 6) + [phase2]

def liniap(p):
	global params
	p1 = p + ".0"
	p2 = p + ".t"
	return linia(pnum(p1), pnum(p2))

def linib(a,b): return stepping(a, b, 11)[1:] + [b]
def accuma(a, ar):
	v = a
	res = []
	for el in ar:
		v *=(1+el)
		res.append(v)
	return res

#def amult(ar1, ar2):
#	return map( , ar1, ar2)
#	for e1, e2 in 

def printl(hdr, vals):
	print("{0:<6}".format(hdr) , end ='')
	for v in vals: print("{0:>8.2f}".format(v), end=' ')
	print("")
	


def compute_eat(eoi, taxr, nol0 = 0):
	eats = []
	nols = []
	nol = nol0
	#print("eoi=", eoi, "taxr=", taxr)
	for e, t in zip(eoi, taxr): 
		#print(e, t)
		if e < 0 :
			eat, nol = e, nol - e
		else:
			nolu = min(nol, e)
			eat, nol = e - (e-nolu)*t, nol - nolu
		eats.append(eat)
		nols.append(nol)
	return eats, nols
		

def compute_reinv(rev0, revs, scr, roict, rgrt, eatt):
	res = []
	for r in revs[:-1]:
		v = (r - rev0)/ scr
		rev0 = r
		res.append(v)
	res.append(rgrt/roict *eatt)
	return res


def listmul(a, b): return list(map(mul, a, b))
def listsub(a, b): return list(map(sub, a, b))


def compute_cdf(coc):
	cdf = 1
	res = []
	for c in coc:
		cdf = cdf/(1+c)
		res.append(cdf)
	return res

def printv(hdr, val): print("{0:<20} {1:10.2f}".format( hdr, val))

def main(filename):
	global params
	cfg = configparser.ConfigParser()
	cfg.read_file(open(filename))
	#params = { p[0] : float(p[1]) for p in cfg['DEFAULT'].items() }
	#print(params)
	params = cfg['DEFAULT']

	nos = pnum('nos')

	rgr = liniap('rgr')
	printl("RGR", rgr)
	revs = accuma(pnum('rev.0'), rgr)
	printl("REVS", revs)
	eom = linib(pnum('eom.0'), pnum('eom.t'))
	printl("EOM", eom)
	eoi = list(map(mul, revs, eom)) # amult(revs, eom)
	printl("EOI", eoi)

	taxr = liniap('taxr')
	printl("TAXR", taxr)
	eat, nols = compute_eat(eoi, taxr, pnum('nol.0'))
	printl("EAT", eat)
	printl("NOLS", nols)


	coc_t = pnum('coc.t')

	reinv = compute_reinv(pnum('rev.0'), revs, pnum('scr'), coc_t , rgrt= rgr[-1], eatt = eat[-1])
	printl("REINV", reinv)

	fcff = listsub( eat, reinv)
	printl("FCFF", fcff)
	coc = liniap("coc")
	printl("COC", coc)

	cdf = compute_cdf(coc)
	printl("CDF", cdf)

	pvfcff = listmul( cdf, fcff)
	printl("PVFCFF", pvfcff)

	print("\nVALUATION")


	pvtv = fcff[-1] / (coc_t-pnum('rf')) * cdf[-2]
	printv("PV(terminal value)", pvtv)
	#print(fcff[-1], cdf[-2], pvtv)
	pv10 = sum(pvfcff[:-1])
	printv("PV (CF 10)", pv10)
	pv = pvtv + pv10
	printv("Sum of PV", pv)

	fail_p = pnum('fail.p')
	printv("Prob of fail", fail_p)
	fail_m = params['fail.m']
	if fail_m == "B":
		raise NotImplementedError
	if fail_m == "V":
		fail_gross = pv
	fail_proceeds = fail_gross * pnum('fail.dp')
	printv("Fail proceeds", fail_proceeds)

	#nos = 19.5 # number of shares
	vps = pv/nos
	printv("Est value/share", vps)


if __name__ == "__main__" :
	p = argparse.ArgumentParser("DCF")
	p.add_argument("files", nargs = '+')
	args = p.parse_args()
	#print(args)
	for fname in args.files:
		main(fname)

