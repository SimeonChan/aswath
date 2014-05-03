function retval = step (a, b, n)
	ar = 0:(n-1)
	retval = a + ((b-a)/(n-1)) * ar
#	retval = a:b
endfunction

step(3,5,7)
