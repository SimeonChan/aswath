.PHONY : all clean
BUILD = aswath.idx aswath.ilg aswath.ind aswath.toc

all : aswath.dvi aswath.pdf

aswath.ind : aswath.idx
	makeindex aswath.idx

aswath.dvi : aswath.ind aswath.ltx
	latex aswath.ltx

aswath.pdf : aswath.dvi
	dvipdfm aswath.dvi

clean : 
	rm -f $(BUILD) *.aux *.dvi *.log	
