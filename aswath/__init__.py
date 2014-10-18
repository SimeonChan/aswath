"""
Aswath Damodaran valuation models

Default values are as at 18-Oct-2014
"""

ct_default = 0.0791
gt_default = 0.0295
h1_default = ct_default
taxr_default = 0.21

def grow2b(op, dcov, roce, ncash, h1 = None, gt = None, ct = None, 
           taxr = None):
    """2 stage growth model
    """

    global h1_default, gt_default, ct_default, taxr_default
    if h1 is None: h1 = h1_default
    if gt is None: gt = gt_default
    if ct is None: ct = ct_default
    if taxr is None: taxr = taxr_default

    theta1 = 1-1/dcov
    g1 = roce * theta1
    r = (1+g1)/(1+h1)
    a0 = op * (1 - taxr)
    p_1 = a0 *(1- theta1) * r * (1-r**5)/(1-r)
    p_t0 = a0 * r**5 * (1+gt)/ct
    vc = p_1 + p_t0 + ncash
    return vc

