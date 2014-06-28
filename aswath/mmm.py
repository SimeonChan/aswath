class Mmm:
	def __init__(self):
		pass

	def defaults01(self):
		"""Defaults for 22-Jun-2014"""
		self.rf = 0.0295
		self.p  = 0.0496
		self.beta = 1.0

		#self.a0 = 1.0 # this allows you to calculate a PE ratio
		

	def sal_precalcs(self):
		"""Precalculations for example 2"""
		self.n = 5
		self.theta1 = 1 - 1/self.omega
		self.g1 = self.rho * self.theta1
		self.h1 = self.rf + self.beta * self.rho
		self.r = (1+self.g1)/(1+self.h1)

		#self.a0 = 1/self.omega
		self.ct = self.rf + self.p
		self.gt = self.rf # set terminal growth rate to the same as the risk-free rate

	def calc(self):
		self.p1 = self.a0 *(1-self.theta1) * self.r * (1-self.r**self.n) / (1-self.r)
		self.pt0 = self.a0* self.r**self.n * (1+self.gt)/self.ct
		self.p0 = self.p1 + self.pt0


class Param: pass


def prcldic(c):
	"""Print class dictionary"""
	d = c.__dict__
	keys = sorted(d.keys())
	for k in keys:
		print(k, d[k])

def example1():
	"""Valuation of MMM from the documentation
Gives the right answer at 21-Jun-2014
"""
	m = Mmm()
	m.a0 = 3586
	m.theta1 = 0.3
	g1 = 0.075
	h1 = 0.0863
	m.r = (1+g1)/(1+h1)
	print(m.r)
	m.n = 5.0

	m.gt = 0.03
	m.ct = 0.0676

	#p1 = p1(p)
	#pt0 = pt0(p)
	m.calc()
	print(m.p1, m.pt0, m.p0)
	prcldic(m)


def example2():
	"""Valuation of SAL in the document"""
	m = Mmm()
	m.defaults01()
	m.beta = 0.2114 # per Investors Chronicle 22-Jun-2014
	m.omega = 2.1 # dividend cover
	m.rho = 0.1968
	m.sal_precalcs()
	m.a0 = 8.98 #/m.omega
	m.calc()
	print(m.p1, m.pt0, m.p0)
	prcldic(m)


if __name__ == "__main__":
	example1()
	print("Example 2")
	example2()


