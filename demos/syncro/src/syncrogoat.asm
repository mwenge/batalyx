;
; **** ZP ABSOLUTE ADRESSES **** 
;
a01 = $01
aCF = $CF
aF7 = $F7
aFC = $FC
aFD = $FD
aFF = $FF
;
; **** ZP POINTERS **** 
;
pFC = $FC
;
; **** FIELDS **** 
;
f0400 = $0400
f04A4 = $04A4
f04A5 = $04A5
f0500 = $0500
f0544 = $0544
f0545 = $0545
f05E4 = $05E4
f05E5 = $05E5
f0600 = $0600
f0684 = $0684
f0685 = $0685
f0700 = $0700
f0720 = $0720
f0741 = $0741
f0746 = $0746
f0747 = $0747
f0771 = $0771
f0799 = $0799
f07F8 = $07F8
fD100 = $D100
fD800 = $D800
fD900 = $D900
fDA00 = $DA00
fDB00 = $DB00
fDB46 = $DB46
fDB47 = $DB47
fDB71 = $DB71
fDB99 = $DB99
;
; **** ABSOLUTE ADRESSES **** 
;
a0314 = $0314
a0315 = $0315
a0727 = $0727
a072F = $072F
a0738 = $0738
a07FC = $07FC
a07FD = $07FD
aE13B = $E13B
;
; **** POINTERS **** 
;
pB0C7 = $B0C7
pC9C8 = $C9C8
;
; **** EXTERNAL JUMPS **** 
;
e0030 = $0030
eEA31 = $EA31

* = $0801

;--------------------------------------------------------------------------------------------------
; SYS 2061 ($080D)
; This launches the program from address $080D, i.e. s080D.
;--------------------------------------------------------------------------------------------------
; $9E = SYS
; $32,$30,$36,$31 = 2061 ($080D in hex)
        .BYTE $0B,$08,$01,$00,$9E,$32,$30,$36
        .BYTE $31,$00,$00,$00
;-------------------------------------------------------------------------
; s080D
;-------------------------------------------------------------------------
s080D
        JSR s0EDD
        JSR s10CD
        LDA #$00
        STA $D404    ;Voice 1: Control Register
        STA $D40B    ;Voice 2: Control Register
        STA $D412    ;Voice 3: Control Register
        LDA #$0F
        STA $D418    ;Select Filter Mode and Volume
        STA $D40C    ;Voice 2: Attack / Decay Cycle Control
        STA $D405    ;Voice 1: Attack / Decay Cycle Control
        LDA #$0D
        STA $D413    ;Voice 3: Attack / Decay Cycle Control
        LDA #$F0
        STA $D40D    ;Voice 2: Sustain / Release Cycle Control
        STA $D406    ;Voice 1: Sustain / Release Cycle Control
        LDA #$76
        STA $D414    ;Voice 3: Sustain / Release Cycle Control
        LDA #$21
        STA $D404    ;Voice 1: Control Register
        STA $D40B    ;Voice 2: Control Register
        JMP j084A

f0846   .BYTE $00,$FE,$FC,$02
;-------------------------------------------------------------------------
; j084A
;-------------------------------------------------------------------------
j084A
        SEI 
        LDA #<p08F9
        STA a0314    ;IRQ
        LDA #>p08F9
        STA a0315    ;IRQ
        LDA #$18
        STA $D018    ;VIC Memory Control Register
        JSR s097D
        JSR s0D8F
        LDA #$00
        STA a0D2D
        STA a0D2C
        STA a0E74
        JSR s0D37
        LDA #$FF
        STA $D015    ;Sprite display Enable
        LDA #$39
        STA a0727
        JSR s087E
        JMP j0E07

;-------------------------------------------------------------------------
; s087E
;-------------------------------------------------------------------------
s087E
        LDA #$81
        STA $D019    ;VIC Interrupt Request Register (IRR)
        STA $D01A    ;VIC Interrupt Mask Register (IMR)
        LDA #$F0
        STA $D012    ;Raster Position
        LDA $D011    ;VIC Control Register 1
        AND #$7F
        STA $D011    ;VIC Control Register 1
        CLI 
b0894   RTS 

;-------------------------------------------------------------------------
; s0895
;-------------------------------------------------------------------------
s0895
        LDY a08E5
        BEQ b0894
b089A   LDX #$00
b089C   LDA f08EE,X
        CLC 
        ASL 
        STA f08EE,X
        LDA f08E6,X
        ROL 
        STA f08E6,X
        LDA f08EE,X
        ADC #$00
        STA f08EE,X
        INX 
        CPX #$08
        BNE b089C
        DEY 
        BNE b089A
b08BB   RTS 

;-------------------------------------------------------------------------
; s08BC
;-------------------------------------------------------------------------
s08BC
        LDY a08E5
        BEQ b08BB
b08C1   LDX #$00
b08C3   LDA f08E6,X
        CLC 
        ROR 
        STA f08E6,X
        LDA f08EE,X
        ROR 
        STA f08EE,X
        BCC b08DC
        LDA f08E6,X
        ORA #$80
        STA f08E6,X
b08DC   INX 
        CPX #$08
        BNE b08C3
        DEY 
        BNE b08C1
        RTS 

a08E5   .BYTE $02
f08E6   LSR aCF
        ORA #$CF
        SBC #$F9
        BVS b090E
f08EE   JSR e0030
        BMI b096C
        .BYTE $FF,$E6,$46 ;ISC $46E6,X
b08F6   JMP eEA31

p08F9   LDA $D019    ;VIC Interrupt Request Register (IRR)
        AND #$01
        BEQ b08F6
        LDX #$00
b0902   JSR s0925
        JSR s0B05
        JSR s0BC6
        INX 
        CPX #$04
b090E   BNE b0902
        JSR s09D8
        JSR s0AE7
        JSR s0C10
        JSR s0F85
        JSR s1033
        JSR s087E
        JMP eEA31

;-------------------------------------------------------------------------
; s0925
;-------------------------------------------------------------------------
s0925
        TXA 
        PHA 
        CLC 
        ASL 
        ASL 
        ASL 
        ASL 
        TAY 
        LDX #$00
b092F   LDA f2400,Y
        STA f08E6,X
        INY 
        INX 
        CPX #$10
        BNE b092F
        PLA 
        PHA 
        TAX 
        LDA f0846,X
        AND #$80
        BNE b0951
        LDA f0846,X
        STA a08E5
        JSR s08BC
        JMP j095F

b0951   LDA f0846,X
        EOR #$FF
        CLC 
        ADC #$01
        STA a08E5
        JSR s0895
;-------------------------------------------------------------------------
; j095F
;-------------------------------------------------------------------------
j095F
        PLA 
        PHA 
        ASL 
        ASL 
        ASL 
        ASL 
        TAX 
        LDY #$01
b0968   LDA f08E6,Y
b096C   =*+$01
        STA f2400,X
        INX 
        INY 
        CPY #$10
        BNE b0968
        LDA f08E6
        STA f2400,X
        PLA 
        TAX 
        RTS 

;-------------------------------------------------------------------------
; s097D
;-------------------------------------------------------------------------
s097D
        LDX #$00
        STX $D020    ;Border Color
        STX $D021    ;Background Color 0
b0985   LDA #$20
        STA f0400,X
        STA f0500,X
        STA f0600,X
        STA f0700,X
        LDA #$01
        STA fD800,X
        STA fD900,X
        STA fDA00,X
        STA fDB00,X
        DEX 
        BNE b0985
        LDX #$00
b09A6   LDA #$80
        STA f04A4,X
        LDA #$81
        STA f04A5,X
        LDA #$82
        STA f0544,X
        LDA #$83
        STA f0545,X
        LDA #$84
        STA f05E4,X
        LDA #$85
        STA f05E5,X
        LDA #$86
        STA f0684,X
        LDA #$87
        STA f0685,X
        INX 
        INX 
        CPX #$20
        BNE b09A6
        JMP j0CDB

a09D7   .BYTE $03
;-------------------------------------------------------------------------
; s09D8
;-------------------------------------------------------------------------
s09D8
        DEC a09D7
        BEQ b09DE
b09DD   RTS 

b09DE   LDA #$04
        STA a09D7
        LDA a0E74
        BNE b09DD
        JSR s0E75
        LDA $DC00    ;CIA1: Data Port Register A
        AND #$03
        CMP #$03
        BEQ b0A11
        AND #$01
        BEQ b09FE
b09F8   INC a0A47
        INC a0A47
b09FE   DEC a0A47
        LDA a0A47
        CMP #$FF
        BEQ b09F8
        CMP #$04
        BEQ b09FE
        AND #$03
        STA a0A47
b0A11   LDX a0A47
        LDA $DC00    ;CIA1: Data Port Register A
        AND #$0C
        CMP #$0C
        BEQ b0A46
        AND #$08
        BNE b0A27
        INC f0846,X
        INC f0846,X
b0A27   DEC f0846,X
        LDA a0BCC
        STA f0BDC,X
        LDA #$05
        STA f0BE0,X
        LDA f0846,X
        CMP #$08
        BNE b0A3F
        DEC f0846,X
b0A3F   CMP #$F8
        BNE b0A46
        INC f0846,X
b0A46   RTS 

a0A47   .BYTE $03
a0A48   .BYTE $03
a0A49   .BYTE $95
;-------------------------------------------------------------------------
; j0A4A
;-------------------------------------------------------------------------
j0A4A
        INC a0A49
        LDA a0A49
        AND #$0F
        TAX 
        JSR s0DB7
        LDA f0ACE,X
        STA a0ABC
        LDA f0ABE,X
        STA a0ABD
        LDA a0A47
        CMP a0A48
        BNE b0A6D
        JMP j0A7F

b0A6D   LDX a0A48
        LDA f0ADE,X
        STA aFC
        LDA f0AE2,X
        STA aFD
        LDA #$01
        JSR s0A8F
;-------------------------------------------------------------------------
; j0A7F
;-------------------------------------------------------------------------
j0A7F
        LDX a0A47
        LDA f0ADE,X
        STA aFC
        LDA f0AE2,X
        STA aFD
        LDA a0ABD
;-------------------------------------------------------------------------
; s0A8F
;-------------------------------------------------------------------------
s0A8F
        LDY #$00
b0A91   STA (pFC),Y
        INY 
        CPY #$20
        BNE b0A91
        LDA a0A47
        STA a0A48
        LDA a0CB1
        BEQ b0AB3
        LDY a0CB1
        LDA a0ABD,Y
        STA $D020    ;Border Color
        STA $D021    ;Background Color 0
        DEC a0CB1
        RTS 

b0AB3   LDA #$00
        STA $D020    ;Border Color
        STA $D021    ;Background Color 0
        RTS 

a0ABC   .BYTE $0C
a0ABD   .BYTE $03
f0ABE   .BYTE $00,$06,$02,$04,$05,$03,$07,$01
        .BYTE $01,$07,$03,$05,$04,$02,$06,$00
f0ACE   .BYTE $00,$00,$0B,$0B,$0C,$0C,$0F,$0F
        .BYTE $01,$01,$0F,$0F,$0C,$0C,$0B,$0B
f0ADE   .BYTE $A4,$44,$E4,$84
f0AE2   .BYTE $D8,$D9,$D9,$DA
a0AE6   .BYTE $01
;-------------------------------------------------------------------------
; s0AE7
;-------------------------------------------------------------------------
s0AE7
        DEC a0AE6
        BEQ b0AED
        RTS 

b0AED   LDA #$03
        STA a0AE6
        JMP j0A4A

f0AF5   .BYTE $B5,$50,$AF,$50
f0AF9   .BYTE $3C,$5C,$5C,$7C
f0AFD   .BYTE $07,$04,$03,$02
f0B01   .BYTE $01
a0B02   .BYTE $02
a0B03   .BYTE $03
a0B04   .BYTE $04
;-------------------------------------------------------------------------
; s0B05
;-------------------------------------------------------------------------
s0B05
        TXA 
        ASL 
        TAY 
        LDA f0AF5,X
        STA $D000,Y  ;Sprite 0 X Pos
        LDA f0AF9,X
        STA $D001,Y  ;Sprite 0 Y Pos
        LDY f0C07,X
        LDA f0AFD,X
        STA $D027,X  ;Sprite 0 Color
        LDA f0AF5,X
        AND #$E0
        CMP f0C0B,Y
        BNE b0B2D
        LDA a0ABD
        STA $D027,X  ;Sprite 0 Color
b0B2D   LDA f0E03,X
        BEQ b0B38
        DEC f0E03,X
        JMP j0B64

b0B38   LDA f0AF5,X
        CLC 
        ADC f0B01,X
        ADC f0846,Y
        STA f0AF5,X
        LDA f0AF5,X
        AND #$F0
        CMP #$40
        BNE b0B58
        JSR s0BE4
        LDA #$F0
        STA f0AF5,X
        BNE j0B64
b0B58   CMP #$00
        BNE j0B64
        JSR s0BE4
        LDA #$50
        STA f0AF5,X
;-------------------------------------------------------------------------
; j0B64
;-------------------------------------------------------------------------
j0B64
        DEC f0BAB,X
        BEQ b0B6A
        RTS 

b0B6A   LDA f0B01,X
        PHA 
        AND #$80
        BEQ b0B79
        PLA 
        EOR #$FF
        CLC 
        ADC #$01
        PHA 
b0B79   PLA 
        AND #$07
        EOR #$07
        CLC 
        ADC #$01
        STA f0BAB,X
        INC f0BAF,X
        LDA f0BAF,X
        CMP #$C4
        BNE b0B93
        LDA #$C0
        STA f0BAF,X
b0B93   LDA f0BAF,X
        STA f07F8,X
        LDA f0B01,X
        AND #$80
        BEQ b0BA1
        RTS 

b0BA1   LDA f0BAF,X
        CLC 
        ADC #$04
        STA f07F8,X
        RTS 

f0BAB   .BYTE $06,$04,$01,$02
f0BAF   .BYTE $C1,$C1,$C2,$C1
b0BB3   LDA f0846,X
        BEQ b0BC5
        AND #$80
        BNE b0BC2
        DEC f0846,X
        DEC f0846,X
b0BC2   INC f0846,X
b0BC5   RTS 

;-------------------------------------------------------------------------
; s0BC6
;-------------------------------------------------------------------------
s0BC6
        DEC f0BDC,X
        BNE b0BC5
a0BCC   =*+$01
        LDA #$FF
        STA f0BDC,X
        DEC f0BE0,X
        BNE b0BC5
        LDA #$05
        STA f0BE0,X
        BNE b0BB3
f0BDC   .BYTE $BD,$D6,$BB,$34
f0BE0   .BYTE $05,$01,$02,$03
;-------------------------------------------------------------------------
; s0BE4
;-------------------------------------------------------------------------
s0BE4
        LDA f0AF9,X
        CLC 
        ADC #$20
        STA f0AF9,X
        CMP #$BC
        BNE b0BF6
        LDA #$3C
        STA f0AF9,X
b0BF6   INC f0C07,X
        LDA f0C07,X
        AND #$03
        STA f0C07,X
        LDA #$03
        STA f0E03,X
b0C06   RTS 

f0C07   .BYTE $00,$01,$01,$02
f0C0B   .BYTE $A0
a0C0C   .BYTE $40
a0C0D   .BYTE $60
a0C0E   .BYTE $C0
a0C0F   .BYTE $01
;-------------------------------------------------------------------------
; s0C10
;-------------------------------------------------------------------------
s0C10
        LDA a0E74
        BNE b0C06
        LDA #$00
        STA a0C0F
        LDX #$00
b0C1C   LDY #$00
b0C1E   LDA f0AF5,X
        AND #$E0
        CMP f0C0B,Y
        BEQ b0C2F
b0C28   INY 
        CPY #$04
        BNE b0C1E
        BEQ b0C5D
b0C2F   LDA f0C07,X
        STA aF7
        CPY aF7
        BNE b0C28
        LDY f0C07,X
        LDA #$00
        CLC 
        ADC f0B01,X
        ADC f0846,Y
        BEQ b0C53
        CMP #$FF
        BNE b0C5D
        LDA f0B01,X
        AND #$80
        BEQ b0C5D
        BNE b0C5A
b0C53   LDA f0B01,X
        AND #$80
        BNE b0C5D
b0C5A   INC a0C0F
b0C5D   INX 
        CPX #$04
        BNE b0C1C
        LDA a0C0F
        CMP #$04
        BEQ b0C6A
        RTS 

b0C6A   NOP 
        LDA #$20
        STA a0CB1
        INC a0D2C
        LDA a0D2C
        CMP #$04
        BNE b0C8C
        LDA #$00
        STA a0D2C
        INC a0D2D
        LDA a0D2D
        CMP #$0A
        BNE b0C8C
        DEC a0D2D
b0C8C   JSR s0D37
        LDA #$01
        STA a0E59
        LDA #$39
        STA a0727
        LDA #$C9
        STA a101C
        LDA #$40
        STA a1019
        LDA #$21
        STA a101D
        LDA #$14
        STA a101B
        JSR s101E
        RTS 

a0CB1   .BYTE $00,$00
f0CB3   .BYTE $13,$19,$0E,$03,$12,$0F,$20,$39
        .BYTE $20,$12,$0F,$15,$0E,$04,$20,$30
        .BYTE $20,$20,$0C,$05,$16,$05,$0C,$20
        .BYTE $30,$20,$20,$20,$13,$03,$0F,$12
        .BYTE $05,$20,$30,$30,$30,$30,$30,$30
;-------------------------------------------------------------------------
; j0CDB
;-------------------------------------------------------------------------
j0CDB
        LDX #$00
b0CDD   LDA f0CB3,X
        STA f0720,X
        INX 
        CPX #$28
        BNE b0CDD
        LDX #$A0
b0CEA   LDA #$86
        STA f0746,X
        LDA #$87
        STA f0747,X
        LDA #$04
        STA fDB46,X
        STA fDB47,X
        DEX 
        DEX 
        BNE b0CEA
        LDX #$00
b0D02   LDA f1059,X
        STA f0771,X
        LDA f107F,X
        STA f0799,X
        LDA #$07
        STA fDB99,X
        STA fDB71,X
        INX 
        CPX #$26
        BNE b0D02
        RTS 

f0D1C   .BYTE $01,$02,$FD,$FA
f0D20   .BYTE $02,$FF,$05,$06
f0D24   .BYTE $03,$04,$FC,$FB
f0D28   .BYTE $04,$FD,$06,$07
a0D2C   .BYTE $00
a0D2D   .BYTE $00
f0D2E   .BYTE $FF,$C0,$A0,$80,$70,$60,$50,$40
        .BYTE $20
;-------------------------------------------------------------------------
; s0D37
;-------------------------------------------------------------------------
s0D37
        LDY #$00
        LDX a0D2C
        LDA f0D1C,X
        STA f0B01
        LDA f0D20,X
        STA a0B02
        LDA f0D24,X
        STA a0B03
        LDA f0D28,X
        STA a0B04
        JSR s10AD
        STA f0C0B
        JSR s10AD
        STA a0C0C
        JSR s10AD
        STA a0C0D
        JSR s10AD
        STA a0C0E
        LDX a0D2D
        LDA f0D2E,X
        STA a0BCC
        LDA f1050,X
        STA a0F83
        LDA a0D2D
        CLC 
        ADC #$30
        STA a0738
        LDA a0D2C
        CLC 
        ADC #$30
        STA a072F
        RTS 

a0D8E   .BYTE $26
;-------------------------------------------------------------------------
; s0D8F
;-------------------------------------------------------------------------
s0D8F
        LDA #$20
        STA $D008    ;Sprite 4 X Pos
        STA $D00A    ;Sprite 5 X Pos
        STA a0D8E
        STA $D009    ;Sprite 4 Y Pos
        LDA #$A5
        STA $D00B    ;Sprite 5 Y Pos
        LDA #<pC9C8
        STA a07FC
        LDA #>pC9C8
        STA a07FD
        LDA #$0C
        STA $D02B    ;Sprite 4 Color
        LDA #$07
        STA $D02C    ;Sprite 5 Color
b0DB6   RTS 

;-------------------------------------------------------------------------
; s0DB7
;-------------------------------------------------------------------------
s0DB7
        CPX #$0F
        BNE b0DB6
        LDA a0E74
        BEQ b0DC3
        JMP j10BA

b0DC3   LDA a0E59
        BNE b0DB6
        INC a0D8E
        LDA a0D8E
        CMP #$95
        BEQ b0DD6
        STA $D009    ;Sprite 4 Y Pos
        RTS 

b0DD6   LDA #$A5
        STA a0D8E
        STA $D009    ;Sprite 4 Y Pos
        STA a0E74
        LDA #$CA
        STA a07FD
        LDA #$20
        STA a0CB1
        LDA #$81
        STA a101D
        LDA #<pB0C7
        STA a101B
        LDA #>pB0C7
        STA a101C
        LDA #$10
        STA a1019
        JSR s101E
        RTS 

f0E03   .BYTE $00,$00,$00,$00
;-------------------------------------------------------------------------
; j0E07
;-------------------------------------------------------------------------
j0E07
        LDA a0CB1
        BNE b0E1B
        LDA a0E74
        BEQ b0E1B
        LDA $DC00    ;CIA1: Data Port Register A
        AND #$10
        BNE b0E1B
        JMP j084A

b0E1B   LDA a0E59
        BEQ j0E07
        LDY a0D2D
        INY 
        LDX #$06
;-------------------------------------------------------------------------
; j0E26
;-------------------------------------------------------------------------
j0E26
        INC a0D8E
        LDA a0D8E
        STA $D009    ;Sprite 4 Y Pos
        CMP #$95
        BEQ b0E49
        TYA 
        PHA 
        TXA 
        PHA 
        JSR s0E5A
        PLA 
        TAX 
        PLA 
        TAY 
        LDA #$00
        STA aFF
b0E42   DEC aFF
        BNE b0E42
        JMP j0E26

b0E49   LDA #$20
        STA a0D8E
        STA $D009    ;Sprite 4 Y Pos
        LDA #$00
        STA a0E59
        JMP j0E07

a0E59   .BYTE $00
;-------------------------------------------------------------------------
; s0E5A
;-------------------------------------------------------------------------
s0E5A
        TXA 
        PHA 
b0E5C   INC f0741,X
        LDA f0741,X
        CMP #$3A
        BNE b0E6E
        LDA #$30
        STA f0741,X
        DEX 
        BNE b0E5C
b0E6E   PLA 
        TAX 
        DEY 
        BNE s0E5A
        RTS 

a0E74   .BYTE $00
;-------------------------------------------------------------------------
; s0E75
;-------------------------------------------------------------------------
s0E75
        LDA a0CB1
        BEQ b0E7B
b0E7A   RTS 

b0E7B   LDA $DC00    ;CIA1: Data Port Register A
        AND #$10
        BNE b0E7A
        LDA a0727
        CMP #$30
        BEQ b0E7A
        DEC a0727
        LDA #$10
        STA a0CB1
        LDA #$21
        STA a101D
        LDA #$33
        STA a101B
        LDA #$80
        STA a1019
        LDA #$A0
        STA a101C
        JSR s101E
        LDX #$00
        LDY a0A47
        TYA 
b0EAE   CMP f0C07,X
        BEQ b0EBA
        INX 
        CPX #$04
        BNE b0EAE
        BEQ b0ED1
b0EBA   LDA f0B01,X
        EOR #$FF
        CLC 
        ADC #$01
        STA f0846,Y
        LDA f0B01,X
        AND #$80
        BEQ b0ED1
        TYA 
        TAX 
        DEC f0846,X
b0ED1   LDA a0BCC
        STA f0BDC,Y
        LDA #$05
        STA f0BE0,Y
        RTS 

;-------------------------------------------------------------------------
; s0EDD
;-------------------------------------------------------------------------
s0EDD
        LDA $DC0E    ;CIA1: CIA Control Register A
        AND #$FE
        STA $DC0E    ;CIA1: CIA Control Register A
        LDA a01
        AND #$FB
        STA a01
        LDX #$00
        LDY #$00
b0EEF   LDA $D000,X  ;Sprite 0 X Pos
        CPY #$07
        BNE b0EF8
        AND #$0F
b0EF8   STA f2000,X
        LDA fD100,X
        CPY #$07
        BNE b0F04
        AND #$0F
b0F04   STA f2100,X
        INY 
        TYA 
        AND #$07
        TAY 
        DEX 
        BNE b0EEF
        LDX #$00
b0F11   LDA f0F34,X
        STA f2400,X
        STA f2410,X
        STA f2420,X
        STA f2430,X
        INX 
        CPX #$10
        BNE b0F11
        LDA a01
        ORA #$04
        STA a01
        LDA $DC0E    ;CIA1: CIA Control Register A
        ORA #$01
        STA $DC0E    ;CIA1: CIA Control Register A
        RTS 

f0F34   .BYTE $40,$CC,$5E,$7F,$39,$11,$11,$33
        .BYTE $02,$33,$7A,$FE,$9C,$88,$88,$CC
f0F44   .BYTE $04,$04,$04,$04,$05,$05,$05,$06
        .BYTE $06,$07,$07,$07,$08,$08,$09,$09
        .BYTE $0A,$0B,$0B,$0C,$0D,$0E,$0E,$0F
        .BYTE $10,$11,$12,$13,$15,$16,$17
f0F63   .BYTE $30,$70,$B4,$FB,$47,$98,$ED,$47
        .BYTE $A7,$0C,$77,$E9,$61,$E1,$68,$F7
        .BYTE $8F,$30,$DA,$8F,$4E,$18,$EF,$D2
        .BYTE $C3,$C3,$D1,$EF,$1F,$60,$B5
a0F82   .BYTE $06
a0F83   .BYTE $0A
a0F84   .BYTE $53
;-------------------------------------------------------------------------
; s0F85
;-------------------------------------------------------------------------
s0F85
        DEC a0F82
        BEQ b0F8B
        RTS 

b0F8B   LDA a0F84
        CMP #$60
        BNE b0F94
        LDA #$00
b0F94   STA a0F84
        TAX 
        INC a0F84
        LDY f0FB9,X
        LDA f0F44,Y
        STA $D401    ;Voice 1: Frequency Control - High-Byte
        STA $D408    ;Voice 2: Frequency Control - High-Byte
        LDA f0F63,Y
        STA $D400    ;Voice 1: Frequency Control - Low-Byte
        ADC #$04
        STA $D407    ;Voice 2: Frequency Control - Low-Byte
        LDA a0F83
        STA a0F82
        RTS 

f0FB9   .BYTE $00,$0C,$04,$10,$07,$13,$04,$10
        .BYTE $00,$0C,$07,$13,$03,$0F,$04,$10
        .BYTE $00,$0C,$04,$10,$07,$13,$09,$15
        .BYTE $0A,$16,$09,$15,$07,$13,$04,$10
        .BYTE $05,$11,$09,$15,$0C,$18,$0E,$1A
        .BYTE $0F,$1B,$0E,$1A,$0C,$18,$09,$15
        .BYTE $00,$0C,$04,$10,$07,$13,$09,$15
        .BYTE $0C,$18,$0A,$16,$09,$15,$07,$13
        .BYTE $07,$13,$0B,$17,$0E,$1A,$10,$1C
        .BYTE $05,$11,$09,$15,$0C,$18,$0E,$1A
        .BYTE $00,$0C,$04,$10,$07,$13,$04,$10
        .BYTE $00,$0C,$07,$13,$07,$13,$07,$13
a1019   .BYTE $40
a101A   .BYTE $F4
a101B   .BYTE $14
a101C   .BYTE $00
a101D   .BYTE $21
;-------------------------------------------------------------------------
; s101E
;-------------------------------------------------------------------------
s101E
        LDA #$00
        STA $D412    ;Voice 3: Control Register
        LDA a1019
        STA $D40F    ;Voice 3: Frequency Control - High-Byte
        STA a101A
        LDA a101D
        STA $D412    ;Voice 3: Control Register
b1032   RTS 

;-------------------------------------------------------------------------
; s1033
;-------------------------------------------------------------------------
s1033
        LDA a101C
        BEQ b1032
        LDA a101A
        CLC 
        ADC a101B
        STA $D40F    ;Voice 3: Frequency Control - High-Byte
        STA a101A
        DEC a101C
        BNE b1032
        LDA #$10
        STA $D412    ;Voice 3: Control Register
        RTS 

f1050   .BYTE $0A,$09,$08,$07,$06,$05,$04,$03
        .BYTE $02
f1059   .BYTE $20,$07,$12,$05,$05,$14,$09,$0E
        .BYTE $07,$13,$20,$06,$12,$0F,$0D,$20
        .BYTE $19,$01,$0B,$20,$14,$08,$05,$20
        .BYTE $08,$01,$09,$12,$19,$20,$14,$0F
        .BYTE $20,$01,$0C,$0C,$20,$20
f107F   .BYTE $20,$20,$20,$20,$0C,$09,$0B,$05
        .BYTE $2D,$0D,$09,$0E,$04,$05,$04,$20
        .BYTE $08,$15,$0D,$01,$0E,$0F,$09,$04
        .BYTE $20,$05,$0E,$14,$09,$14,$09,$05
        .BYTE $13,$20,$20,$20,$20,$20
f10A5   .BYTE $40,$60,$80,$A0,$C0,$60,$80,$A0
;-------------------------------------------------------------------------
; s10AD
;-------------------------------------------------------------------------
s10AD
        INC a10B1
a10B1   =*+$01
        LDA aE13B
        AND #$07
        TAY 
        LDA f10A5,Y
        RTS 

;-------------------------------------------------------------------------
; j10BA
;-------------------------------------------------------------------------
j10BA
        LDA $D009    ;Sprite 4 Y Pos
        CMP #$A5
        BNE b10C7
        LDA #$95
        STA $D009    ;Sprite 4 Y Pos
        RTS 

b10C7   LDA #$A5
        STA $D009    ;Sprite 4 Y Pos
        RTS 

;-------------------------------------------------------------------------
; s10CD
;-------------------------------------------------------------------------
s10CD
        LDX #$00
b10CF   LDA f10E5,X
        STA f3000,X
        LDA f11E5,X
        STA f3100,X
        LDA f12E5,X
        STA f3200,X
        INX 
        BNE b10CF
        RTS 

.include "sprites.asm"
.include "padding.asm"

