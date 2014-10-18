# -*- coding: latin-1 -*-
"""
screen20141018.py
Screen run on 18-Oct-2014
"""

import operator
from pprint import pprint as prin

from tabulate import tabulate

import aswath
import mython.csvmc


def floatm(x):
    x = x.replace(',', '')
    return float(x)

def calc(d):
    #print(d['Name'])
    del d['']

    dcov = d['Div Cover']
    if dcov == '-': dcov = "inf"
    dcov = floatm(dcov)
    roce = floatm(d['ROCE %'])/100
    op = floatm(d['Op Profit'])
    mkt = floatm(d['Mkt Cap £m'])
    ncash = mkt - floatm(d['EV'] )
    vc = aswath.grow2b(op, dcov, roce, ncash)
    d['upside'] = vc/mkt

    return d

def upside(d): return d['upside']

def main():
    inp = mython.csvmc.read_dict('~/Downloads/stocko.csv')
    calcs = map(calc, inp)
    calcs = filter(lambda x: upside(x) > 1.5, calcs)
    calcs = list(calcs)
    calcs.sort(key = upside)
    prin(len(calcs))
    prin(calcs)

    tab =[ [i+1, d['Ticker'], d['upside'], d['P/E'],  d['Name']] 
           for i, d in enumerate(calcs)]
    print(tabulate(tab, headers= 
                   ['#', 'EPIC', 'Upside', 'P/E', 'Name']))

if __name__ == "__main__" :
    main()
