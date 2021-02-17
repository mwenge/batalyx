.PHONY: all clean run

D64_IMAGE = "bin/batalyx.d64"
X64 = x64
X64SC = x64sc
C1541 = c1541

all: clean d64 run
original: clean d64_orig run_orig

batalyx.prg: src/batalyx.asm
	64tass -Wall -Wno-implied-reg --cbm-prg -o bin/bx.prg -L bin/list-co1.txt -l bin/labels.txt src/batalyx.asm
	64tass -Wall -Wno-implied-reg --cbm-prg -o bin/titlescreen-bitmap.prg src/titlescreen-bitmap-2.asm
	exomizer sfx sys bin/bx.prg bin/titlescreen-bitmap.prg,0xe000 -n -o bin/batalyx.prg
	md5sum bin/bx-bench.prg bin/bx.prg
	md5sum bin/titlescreen-bitmap-bench.prg bin/titlescreen-bitmap.prg

batalyx-vsf.prg: src/batalyx.tas
	64tass -Wall -Wno-implied-reg --cbm-prg -o bin/batalyx-vsf.prg -L bin/list-co1.txt -l bin/labels.txt src/batalyx.tas

d64: batalyx.prg
	$(C1541) -format "batalyx,rq" d64 $(D64_IMAGE)
	$(C1541) $(D64_IMAGE) -write bin/batalyx.prg "batalyx"
	$(C1541) $(D64_IMAGE) -list

run: d64
	$(X64) -verbose $(D64_IMAGE)

run: d64

clean:
	-rm $(D64_IMAGE)
	-rm bin/batalyx.prg
	-rm bin/*.txt
