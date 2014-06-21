class Mmm:
	def __init__(self):
		pass

	def calc(self):
		self.p1 = self.a0 *(1-self.theta1) * self.r * (1-self.r**self.n) / (1-self.r)
		self.pt0 = self.a0* self.r**self.n * (1+self.gt)/self.ct
		self.p0 = self.p1 + self.pt0


class Param: pass

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
	print(m.__dict__)


if __name__ == "__main__":
	example1()
