all:
	happy -gca ParLE.y
	alex -g LexLE.x
	ghc --make TestLE.hs -o TestLE

clean:
	del -f *.log *.aux *.hi *.o *.dvi

distclean: clean
	del -f DocLE.* LexLE.* ParLE.* LayoutLE.* SkelLE.* PrintLE.* TestLE.* AbsLE.* TestLE ErrM.* SharedString.* ComposOp.* LE1.dtd XMLLE.* Makefile*
	

