.PHONY: all clean run

D64_IMAGE = "bin/syncro2.d64"
D64_ORIG_IMAGE = "orig/syncro2.d64"
X64 = x64
X64SC = x64sc
C1541 = c1541

all: clean d64 run
original: clean d64_orig run_orig

syncro2.prg: src/syncro2.asm
	64tass -Wall -Wno-implied-reg --cbm-prg -o bin/syncro2.prg -L bin/list-co1.txt -l bin/labels.txt src/syncro2.asm
	md5sum bin/syncro2.prg bin/syncro2-bench.prg

d64: syncro2.prg
	$(C1541) -format "syncro2,rq" d64 $(D64_IMAGE)
	$(C1541) $(D64_IMAGE) -write bin/syncro2.prg "syncro2"
	$(C1541) $(D64_IMAGE) -list

d64_orig:
	$(C1541) -format "syncro2,rq" d64 $(D64_ORIG_IMAGE)
	$(C1541) $(D64_ORIG_IMAGE) -write orig/syncro2.prg "syncro2"
	$(C1541) $(D64_ORIG_IMAGE) -list

run: d64
	$(X64) -verbose $(D64_IMAGE)

run_orig: d64_orig
	$(X64) -verbose -moncommands bin/labels.txt $(D64_ORIG_IMAGE)

run: d64

clean:
	-rm $(D64_IMAGE) $(D64_ORIG_IMAGE) $(D64_HOKUTO_IMAGE)
	-rm bin/syncro2.prg
	-rm bin/*.txt
