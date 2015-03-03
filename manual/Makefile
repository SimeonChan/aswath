.PHONY : all clean install
BASE = aswath
BUILD = aswath.idx aswath.ilg aswath.ind aswath.toc
PDF = $(BASE).pdf

all : aswath.dvi $(PDF)

aswath.idx : aswath.ltx glossary.ltx opscale.ltx
	latex aswath.ltx

aswath.ind : aswath.idx
	makeindex aswath.idx

aswath.dvi : aswath.ind aswath.ltx
	latex aswath.ltx
	makeglossaries aswath
	latex aswath.ltx

$(PDF) : aswath.dvi
	dvipdfm aswath.dvi

clean : 
	rm -f $(BUILD) *.aux *.dvi *.log	

install : $(PDF)
	cp $(PDF) $(WWW_PDF_DIR)
