.PHONY: all clean run

D64_IMAGE = "bin/syncrogoat.d64"
D64_ORIG_IMAGE = "orig/syncrogoat.d64"
X64 = x64
X64SC = x64sc
C1541 = c1541

all: clean d64 run
original: d64_orig run_orig

syncrogoat.prg: src/syncrogoat.asm
	64tass -Wall -Wno-implied-reg --cbm-prg -o bin/syncrogoat.prg -L bin/list-co1.txt -l bin/labels.txt src/syncrogoat.asm
	md5sum bin/syncrogoat.prg orig/syncrogoat.prg

d64: syncrogoat.prg
	$(C1541) -format "syncrogoat,rq" d64 $(D64_IMAGE)
	$(C1541) $(D64_IMAGE) -write bin/syncrogoat.prg "syncrogoat"
	$(C1541) $(D64_IMAGE) -list

d64_orig:
	$(C1541) -format "syncrogoat,rq" d64 $(D64_ORIG_IMAGE)
	$(C1541) $(D64_ORIG_IMAGE) -write orig/syncrogoat.prg "syncrogoat"
	$(C1541) $(D64_ORIG_IMAGE) -list

run: d64
	$(X64) -verbose $(D64_IMAGE)

run_orig: d64_orig
	$(X64) -verbose -moncommands bin/labels.txt $(D64_ORIG_IMAGE)

run: d64

clean:
	-rm $(D64_IMAGE) $(D64_ORIG_IMAGE) $(D64_HOKUTO_IMAGE)
	-rm bin/syncrogoat.prg
	-rm bin/*.txt
