;
; **** ZP FIELDS **** 
;
f0C = $0C
f39 = $39
f8D = $8D
fB5 = $B5
fC0 = $C0
fC1 = $C1
fC2 = $C2
fD4 = $D4
fE7 = $E7
;
; **** ZP ABSOLUTE ADRESSES **** 
;
a01 = $01
a02 = $02
a03 = $03
a04 = $04
a05 = $05
a06 = $06
a07 = $07
a08 = $08
a09 = $09
a0A = $0A
a0B = $0B
a0D = $0D
a0E = $0E
a0F = $0F
a10 = $10
a11 = $11
a12 = $12
a13 = $13
a14 = $14
a15 = $15
a16 = $16
a17 = $17
a18 = $18
a19 = $19
a1A = $1A
a1B = $1B
a1C = $1C
a1D = $1D
a1E = $1E
a1F = $1F
a20 = $20
a23 = $23
a24 = $24
a25 = $25
a26 = $26
a39 = $39
a3A = $3A
a3B = $3B
a3C = $3C
a3D = $3D
a3E = $3E
a3F = $3F
a40 = $40
a7D = $7D
a90 = $90
a99 = $99
a9A = $9A
a9D = $9D
aAD = $AD
aAE = $AE
aAF = $AF
aB7 = $B7
aB8 = $B8
aB9 = $B9
aBA = $BA
aBB = $BB
aBC = $BC
aC1 = $C1
aC2 = $C2
aC3 = $C3
aC4 = $C4
currentPressedKey = $C5
aC6 = $C6
aCC = $CC
aD0 = $D0
aD1 = $D1
aD3 = $D3
aD4 = $D4
aD6 = $D6
aD8 = $D8
aD9 = $D9
aFB = $FB
aFC = $FC
aFD = $FD
aFE = $FE
;
; **** ZP POINTERS **** 
;
p00 = $00
p01 = $01
p02 = $02
p04 = $04
p06 = $06
p11 = $11
p14 = $14
p17 = $17
p19 = $19
p1B = $1B
p1D = $1D
p1F = $1F
p23 = $23
p25 = $25
p3F = $3F
p60 = $60
p61 = $61
p8D = $8D
pAD = $AD
pBB = $BB
pC1 = $C1
pC3 = $C3
pD0 = $D0
pD1 = $D1
pF0 = $F0
pF3 = $F3
pFB = $FB
pFD = $FD
;
; **** FIELDS **** 
;
f00DB = $00DB
f00FE = $00FE
f00FF = $00FF
;
; **** ABSOLUTE ADRESSES **** 
;
a00A2 = $00A2
a00A9 = $00A9
a00D9 = $00D9
;
; **** POINTERS **** 
;
p0008 = $0008
p00C1 = $00C1

SCREEN_RAM = $0400

        * = $0801
        .BYTE $0C,$08,$0A,$00,$9E,$31,$36,$38,$31,$36,$00

* = $0810
;-------------------------------
; LaunchCippyOnTheRun
;-------------------------------
        JMP j0814

a0813   .BYTE $00
j0814   SEI 
        JSR s0D7C
        JSR s0857
        JSR s08A2
        LDA a0813
        BNE b083D
        JSR s0C56
        LDA #$00
        STA a13B6
        STA a16E6
        STA a19F1
        STA a0D91
        STA a1715
        STA a1714
        INC a0813
b083D   LDA #$00
        STA $D01C    ;Sprites Multi-Color Mode Select
        LDA $D016    ;VIC Control Register 2
        AND #$EF
        STA $D016    ;VIC Control Register 2
        JSR s102A
        CLI 
j084E   JSR s413B
        JSR s1994
        JMP j084E

;-------------------------------
; s0857
;-------------------------------
s0857   
        LDX #$00
        LDA $D01E    ;Sprite to Sprite Collision Detect
b085C   LDA #$20
        STA SCREEN_RAM + $0000,X
        STA SCREEN_RAM + $0100,X
        STA SCREEN_RAM + $01D0,X
        DEX 
        BNE b085C
        LDA $D011    ;VIC Control Register 1
        AND #$78
        ORA #$0B
        STA $D011    ;VIC Control Register 1
        LDX #$00
b0876   LDA #$7E
        STA SCREEN_RAM + $0000,X
        STA SCREEN_RAM + $02A8,X
        LDA #$0B
        STA $D800,X
        STA $DAA8,X
        INX 
        CPX #$28
        BNE b0876
        LDA $D016    ;VIC Control Register 2
        AND #$F0
        STA $D016    ;VIC Control Register 2
        LDA #$00
        STA $D015    ;Sprite display Enable
        STA a40D7
        STA a4142
        JSR s6004
        RTS 

;-------------------------------
; s08A2
;-------------------------------
s08A2   
        LDX #$00
b08A4   LDA f08BC,X
        STA f4122,X
        LDA f08BF,X
        STA f410A,X
        LDA f08C2,X
        STA f4116,X
        INX 
        CPX #$03
        BNE b08A4
b08BB   RTS 

f08BC   .BYTE $20,$C4,$FF
f08BF   .BYTE $F4,$20,$20
f08C2   .BYTE $08,$09,$09
a08C5   .BYTE $50
a08C6   .BYTE $60
a08C7   .BYTE $A8
a08C8   .BYTE $01
;-------------------------------
; s08C9
;-------------------------------
s08C9   
        LDA a0D91
        CMP #$02
        BEQ b08BB
        LDA a08C5
        STA a403E
        LDA a08C6
        STA a403F
        LDA #$06
        STA a4043
        LDA a08C8
        STA a4040
        LDA a08C7
        CLC 
        ADC a0A4B
        STA a4041
        JMP j094A

        LDA $D016    ;VIC Control Register 2
        AND #$F0
        ORA a09FD
        STA $D016    ;VIC Control Register 2
        JSR s4129
        JSR $FF9F ;$FF9F - scan keyboard                    
        JSR s0A58
p090A   =*+$02
        JSR s103F
        JSR s14D6
        JSR s12C3
        JSR s12E1
        JSR s4135
        JSR s16E9
        JSR s15EB
        JMP j4132

        LDA $D016    ;VIC Control Register 2
        AND #$F0
        STA $D016    ;VIC Control Register 2
        JSR s412C
        JSR s08C9
        JSR s09FE
        JSR s0A6F
        JSR s0B26
        JSR s0C85
        JSR s0E34
        JSR s120F
        JSR stroboscopeOnOff
        JSR s4129
        JMP j4132

a0949   .BYTE $00
j094A   DEC a0950
        BEQ b0951
        RTS 

a0950   .BYTE $01
b0951   LDA a0F61
        STA a0950
        LDA a08C7
        SEC 
        SBC #$A7
        BEQ b0964
        BMI b0964
        JMP j09B3

b0964   LDA a08C6
        CMP #$90
        BNE b0982
        LDA a0A6E
        AND #$01
        BNE b097E
        LDA a08C7
        CLC 
        ADC #$08
        STA a08C7
        JMP j1963

b097E   JMP j0CFA

        RTS 

b0982   LDA a08C6
        CLC 
        ADC a0949
        STA a08C6
        AND #$90
        CMP #$90
        BNE b09A2
        LDA #$90
        STA a08C6
        STA a403F
        LDA #$00
        STA a0949
        JMP j0CFA

b09A2   DEC a09B2
        BNE b09B0
        LDA a09B1
        STA a09B2
a09AE   =*+$01
        INC a0949
b09B0   RTS 

a09B1   .BYTE $03
a09B2   .BYTE $03
j09B3   LDA a08C6
        CMP #$3B
        BNE b09CD
        LDA a0A6E
        AND #$02
        BNE b097E
        LDA a08C7
        SEC 
        SBC #$08
        STA a08C7
        JMP j1963

b09CD   LDA a08C6
        SEC 
        SBC a0949
        STA a08C6
        AND #$F0
        CMP #$30
        BNE b09ED
        LDA #$3B
        STA a08C6
        STA a403F
        LDA #$00
        STA a0949
        JMP j0CFA

b09ED   DEC a09B2
        BNE b09FB
        LDA a09B1
        STA a09B2
        INC a0949
b09FB   RTS 

a09FC   .BYTE $01
a09FD   .BYTE $00
;-------------------------------
; s09FE
;-------------------------------
s09FE   
        LDA a09FD
        CLC 
        ADC a09FC
        STA a09FD
        AND #$88
        BNE b0A0D
        RTS 

b0A0D   PHA 
        LDA a09FD
        AND #$07
        STA a09FD
        PLA 
        AND #$80
        BNE b0A30
        DEC a0CF7
        LDA a0CF7
        CMP #$FF
        BNE b0A4A
        LDA #$0F
        STA a0CF7
        DEC a0CF8
        JMP j0A42

b0A30   INC a0CF7
        LDA a0CF7
        CMP #$10
        BNE b0A4A
        LDA #$00
        STA a0CF7
        INC a0CF8
j0A42   LDA a0CF8
        AND #$3F
        STA a0CF8
b0A4A   RTS 

a0A4B   .BYTE $00
j0A4C   INC a0A4B
        LDA a0A4B
        AND #$03
        STA a0A4B
        RTS 

;-------------------------------
; s0A58
;-------------------------------
s0A58   
        DEC a0A6D
        BEQ b0A5E
        RTS 

b0A5E   LDA a0A6C
        STA a0A6D
        LDA a09FC
        BEQ b0A86
        JMP j0A4C

a0A6C   .BYTE $07
a0A6D   .BYTE $01
a0A6E   .BYTE $FF
;-------------------------------
; s0A6F
;-------------------------------
s0A6F   
        LDA $DC00    ;CIA1: Data Port Register A
        STA a0A6E
        LDA a0D91
        CMP #$02
        BNE b0A81
        LDA #$FF
        STA a0A6E
b0A81   DEC a0B25
        BEQ b0A87
b0A86   RTS 

b0A87   LDA a18C4
        STA a0B25
        JSR s0ECC
        LDA a0A6E
        AND #$04
        BNE b0AC4
        LDA a08C7
        CMP #$A4
        BEQ b0AB0
        CMP #$AC
        BEQ b0AB0
        INC a09FC
        LDA a09FC
        CMP #$08
        BNE b0AAF
        DEC a09FC
b0AAF   RTS 

b0AB0   LDA a09FC
        BEQ b0ABA
        INC a09FC
        BNE b0AAF
b0ABA   LDA a08C7
        SEC 
        SBC #$04
        STA a08C7
b0AC3   RTS 

b0AC4   LDA a0A6E
        AND #$08
        BNE b0AF8
        LDA a08C7
        CMP #$A0
        BEQ b0AE4
        CMP #$A8
        BEQ b0AE4
        DEC a09FC
        LDA a09FC
        CMP #$F8
        BNE b0AC3
        INC a09FC
        RTS 

b0AE4   LDA a09FC
        BEQ b0AEF
        DEC a09FC
        BEQ b0AEF
        RTS 

b0AEF   LDA a08C7
        CLC 
        ADC #$04
        STA a08C7
b0AF8   LDA a0A6E
        AND #$10
        BNE b0B24
j0AFF   LDA a0949
        BNE b0B24
        LDA a08C6
        CMP #$3B
        BEQ b0B11
        CMP #$90
        BEQ b0B11
        BNE b0B24
b0B11   INC a08C6
        LDA #$FA
        STA a0949
        LDY #$12
b0B1B   LDA f193E,Y
        STA f4007,Y
        DEY 
        BNE b0B1B
b0B24   RTS 

a0B25   .BYTE $04
;-------------------------------
; s0B26
;-------------------------------
s0B26   
        LDA a09FC
        AND #$80
        BNE b0B39
        LDA a09FC
        EOR #$07
        CLC 
        ADC #$01
        STA a0A6C
        RTS 

b0B39   LDA a09FC
        AND #$07
        CLC 
        ADC #$01
        STA a0A6C
        RTS 

f0B45   .BYTE $01,$01,$0F,$0F,$0C,$0C,$0B,$0B
        .BYTE $0B,$0B,$0C,$0C,$0F
f0B52   .BYTE $0F
f0B53   .BYTE $01,$01
f0B55   .BYTE $02
f0B56   .BYTE $09,$08,$07
a0B59   .BYTE $05
a0B5A   .BYTE $0E,$04
a0B5C   .BYTE $06
a0B5D   .BYTE $06,$04,$0E,$05,$07
f0B62   .BYTE $08,$09,$02
f0B65   .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $05,$0D,$03,$0E,$05,$0D,$03,$0E
        .BYTE $05,$0D,$03,$0E,$05,$0D,$03,$0E
        .BYTE $06,$0E,$04,$0E,$06,$0E,$04,$0E
        .BYTE $06,$0E,$04,$0E,$06,$0E,$04,$0E
        .BYTE $02,$07,$06,$02,$07,$06,$02,$07
        .BYTE $06,$02,$07,$06,$02,$07,$06,$02
        .BYTE $02,$02,$02,$02,$02,$07,$07,$07
        .BYTE $07,$07,$07,$05,$05,$05,$05
f0BB4   .BYTE $05,$01,$01,$01,$01,$00,$00,$00
        .BYTE $00,$01,$01,$01,$01,$00,$00,$00
        .BYTE $00,$02,$02,$08,$08,$09,$09,$07
        .BYTE $07,$07,$07,$09,$09,$08,$08,$02
        .BYTE $02
f0BD5   .BYTE $FF
f0BD6   .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$00,$00,$00,$00
f0C15   .BYTE $00
f0C16   .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$3F,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$FF,$00,$00,$00,$00,$00
;-------------------------------
; s0C56
;-------------------------------
s0C56   
        LDX #$00
        TXA 
b0C59   STA f0BD6,X
        STA f0C16,X
        INX 
        CPX #$40
        BNE b0C59
        JSR s18A2
        JSR s0C7E
        AND #$3F
        TAX 
        LDA #$02
        STA f0BD6,X
        JSR s0C7E
        AND #$3F
        TAX 
        LDA #$02
        .BYTE $9D
;-------------------------------
; s0C7B
;-------------------------------
s0C7B   
        ASL f0C,X
        RTS 

a0C7F   =*+$01
;-------------------------------
; s0C7E
;-------------------------------
s0C7E   
        LDA $FFFF    ;IRQ
        INC a0C7F
        RTS 

;-------------------------------
; s0C85
;-------------------------------
s0C85   
        LDX #$00
        LDY a0CF8
        DEY 
        TYA 
        AND #$3F
        TAY 
        LDA a0CF7
        PHA 
        CLC 
        ADC #$0E
        STA a0CF7
        AND #$10
        BEQ b0CAA
        LDA a0CF7
        AND #$0F
        STA a0CF7
        INY 
        TYA 
        AND #$3F
        TAY 
b0CAA   LDA f0BD6,Y
        ASL 
        ASL 
        ASL 
        ASL 
        CLC 
        ADC a0CF7
        STX a0CF9
        TAX 
        LDA f0B45,X
        LDX a0CF9
        STA $D800,X
        LDA f0C16,Y
        ASL 
        ASL 
        ASL 
        ASL 
        ADC a0CF7
        STX a0CF9
        TAX 
        LDA f0B45,X
        LDX a0CF9
        STA $DAA8,X
        INC a0CF7
        LDA a0CF7
        AND #$10
        BEQ b0CED
        LDA #$00
        STA a0CF7
        INY 
        TYA 
        AND #$3F
        TAY 
b0CED   INX 
        CPX #$28
        BNE b0CAA
        PLA 
        STA a0CF7
        RTS 

a0CF7   .BYTE $00
a0CF8   .BYTE $01
a0CF9   .BYTE $00
j0CFA   LDA a13B7
        CMP a0CF8
        BNE b0D0B
        LDA a13B8
        CMP a403F
        BNE b0D0B
        RTS 

b0D0B   LDA a0CF8
        STA a13B7
        LDA a403F
        STA a13B8
        LDA a08C7
        CMP #$A8
        BEQ b0D4C
        CMP #$AC
        BEQ b0D4C
        LDY a0CF8
        INY 
        TYA 
        AND #$3F
        TAY 
        LDA f0C16,Y
        BEQ b0D40
        CMP #$01
        BNE b0D49
        LDA a13B6
        AND #$02
        BNE b0D3B
        RTS 

b0D3B   LDA #$00
        JMP j0D43

b0D40   LDA a0D73
j0D43   STA f0C16,Y
        JMP j1921

b0D49   JMP j137E

b0D4C   LDY a0CF8
        INY 
        TYA 
        AND #$3F
        TAY 
        LDA f0BD6,Y
        BEQ b0D6A
        CMP #$01
        BNE b0D49
        LDA a13B6
        AND #$02
        BNE b0D65
        RTS 

b0D65   LDA #$00
        JMP j0D6D

b0D6A   LDA a0D73
j0D6D   STA f0BD6,Y
        JMP j1921

a0D73   .BYTE $01
f0D74   .BYTE $00
f0D75   .BYTE $10,$20,$30
f0D78   .BYTE $40,$50,$60,$70
;-------------------------------
; s0D7C
;-------------------------------
s0D7C   
        LDX #$00
b0D7E   LDY f0D74,X
        LDA #$00
        STA a403E,Y
        LDA #$70
        STA a4043,Y
        INX 
        CPX #$08
        BNE b0D7E
        RTS 

a0D91   .BYTE $00
f0D92   .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF
a0DA4   .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF
f0DD2   .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF
p0E0F   .BYTE $FF,$FF,$00
j0E12   LDX #$00
b0E14   LDA a403F
        STA f0D92,X
        LDA a4041
        STA f0DD2,X
        INX 
        CPX #$40
        BNE b0E14
        LDA #$01
        STA a0D91
        LDA #$FF
        STA $D017    ;Sprites Expand 2x Vertical (Y)
        STA $D01D    ;Sprites Expand 2x Horizontal (X)
b0E32   RTS 

a0E33   .BYTE $00
;-------------------------------
; s0E34
;-------------------------------
s0E34   
        LDA a0D91
        BEQ b0E32
        CMP #$02
        BNE b0E40
        JMP j13F0

b0E40   INC a0E33
        LDA a0E33
        AND #$3F
        STA a0E33
        TAX 
        LDA a403F
        STA f0D92,X
        LDA a4041
        STA f0DD2,X
        LDA #<p01
        STA a0EAF
        LDA #>p01
        STA a0EB0
b0E62   TXA 
        SEC 
        SBC #$04
        AND #$3F
        TAX 
        LDA a0EB0
        CLC 
        ADC a09FC
        STA a0EB0
        LDY a0EAF
        LDA f0D74,Y
        TAY 
        LDA a403E
        CLC 
        ADC a0EB0
        STA a403E,Y
        LDA f0D92,X
        STA a403F,Y
        LDA f0DD2,X
        STA a4041,Y
        LDA #$06
        STA a4043,Y
        STY a0CF9
        LDY a0EAF
        LDA selectedSubGame,Y
        LDY a0CF9
        STA a4040,Y
        INC a0EAF
        LDA a0EAF
        CMP #$08
        BNE b0E62
        RTS 

a0EAF   .BYTE $00
a0EB0   .BYTE $00
f0EB1   .BYTE $00,$00,$00
f0EB4   .BYTE $00,$00,$00
f0EB7   .BYTE $00,$00,$00
f0EBA   .BYTE $00,$00,$00
f0EBD   .BYTE $00,$00,$00
f0EC0   .BYTE $00,$00,$00
f0EC3   .BYTE $00,$00,$00
f0EC6   .BYTE $00,$00,$00
f0EC9   .BYTE $00,$00,$00
;-------------------------------
; s0ECC
;-------------------------------
s0ECC   
        LDA a0D91
        BNE b0ED3
        BEQ b0ED4
b0ED3   RTS 

b0ED4   LDX #$00
b0ED6   LDA f0EB1,X
        BEQ b0EE1
        INX 
        CPX #$03
        BNE b0ED6
        RTS 

b0EE1   LDA a08C7
        SEC 
        SBC #$A8
        BEQ b0EF2
        BPL b0EF2
        LDA #$01
        STA f0EC0,X
        BNE b0EF7
b0EF2   LDA #$02
        STA f0EC0,X
b0EF7   LDA a08C7
        CMP #$A0
        BEQ b0F09
        CMP #$A8
        BEQ b0F09
        LDA f0EC0,X
        ORA #$08
        BNE b0F0E
b0F09   LDA f0EC0,X
        ORA #$04
b0F0E   STA f0EC0,X
        LDA #$00
        STA f0EC3,X
        JSR s0C7E
        AND #$07
        TAY 
        LDA f0F62,Y
        STA f0EB7,X
        LDA a403E
        STA f0EB1,X
        LDA a403F
        STA f0EB4,X
        LDA f0EC0,X
        AND #$02
        BEQ b0F3E
        LDA f0EB4,X
        CLC 
        ADC #$05
        STA f0EB4,X
b0F3E   JSR s0C7E
        AND #$07
        ORA #$01
        TAY 
        LDA selectedSubGame,Y
        LDY f0D75,X
        STA a4040,Y
        LDA a0F61
        STA f0EBA,X
        STA f0EBD,X
        LDA #$02
        STA f0EC6,X
        STA f0EC9,X
        RTS 

a0F61   .BYTE $01
f0F62   .BYTE $B0,$B1,$B2,$B3,$B4,$B5,$B6,$B4
;-------------------------------
; s0F6A
;-------------------------------
s0F6A   
        LDX #$00
b0F6C   LDA f0EB1,X
        BEQ b0F7A
        JSR s0F84
b0F74   INX 
        CPX #$03
        BNE b0F6C
        RTS 

b0F7A   LDY f0D75,X
        LDA #$00
        STA a403E,Y
        BEQ b0F74
;-------------------------------
; s0F84
;-------------------------------
s0F84   
        LDA f0EB1,X
        SEC 
        SBC a09FC
        STA f0EB1,X
        AND #$F0
        BEQ b0F9C
        CMP #$C0
        BEQ b0F9C
        JSR s0FBD
        JMP j0FA2

b0F9C   LDA #$00
        STA f0EB1,X
        RTS 

j0FA2   LDY f0D75,X
        LDA f0EB1,X
        STA a403E,Y
        LDA f0EB4,X
        STA a403F,Y
        LDA f0EB7,X
        STA a4041,Y
        LDA #$60
        STA a4043,Y
        RTS 

;-------------------------------
; s0FBD
;-------------------------------
s0FBD   
        DEC f0EBD,X
        BEQ b0FC3
        RTS 

b0FC3   LDA f0EBA,X
        STA f0EBD,X
        DEC f0EC9,X
        BNE b0FD7
        LDA f0EC6,X
        STA f0EC9,X
        INC f0EC3,X
b0FD7   LDA f0EC0,X
        AND #$01
        BNE b0FEB
        LDA f0EB4,X
        CLC 
        ADC f0EC3,X
        ADC f0EC3,X
        STA f0EB4,X
b0FEB   LDA f0EB4,X
        SEC 
        SBC f0EC3,X
        STA f0EB4,X
        AND #$F0
        CMP #$30
        BEQ b1000
        CMP #$A0
        BEQ b1000
b0FFF   RTS 

b1000   LDA f0EC3,X
        BEQ b1024
        BMI b0FFF
        EOR #$FF
        CLC 
        ADC #$02
        STA f0EC3,X
        LDA f0EB4,X
        AND #$F0
        CMP #$A0
        BEQ b101E
        LDA #$3B
        STA f0EB4,X
        RTS 

b101E   LDA #$A0
        STA f0EB4,X
        RTS 

b1024   LDA #$00
        STA f0EB1,X
a1029   RTS 

;-------------------------------
; s102A
;-------------------------------
s102A   
        LDX #$00
        LDA #$3E
b102E   STA SCREEN_RAM + $02D4,X
        STA SCREEN_RAM + $0324,X
        INX 
        CPX #$20
        BNE b102E
        LDA #$2A
        STA SCREEN_RAM + $030C
        RTS 

;-------------------------------
; s103F
;-------------------------------
s103F   
        LDA a0CF8
        SEC 
        SBC #$0F
        AND #$3F
        TAY 
        LDX #$00
b104A   LDA f0BD6,Y
        STY a1072
        TAY 
        LDA f1073,Y
        STA $DAD4,X
        LDY a1072
        LDA f0C16,Y
        TAY 
        LDA f1073,Y
        STA $DB24,X
        LDY a1072
        INY 
        TYA 
        AND #$3F
        TAY 
        INX 
        CPX #$20
        BNE b104A
a1071   RTS 

a1072   .BYTE $00
f1073   .BYTE $0B
a1074   .BYTE $08,$00,$05,$06,$02,$07
a107A   .BYTE $01
f107B   .BYTE $00,$00,$00,$00
f107F   .BYTE $00,$00,$00,$00
f1083   .BYTE $01,$01,$01,$01
f1087   .BYTE $00,$00,$00,$00
f108B   .BYTE $00,$00,$00,$00
f108F   .BYTE $00,$00,$00,$00
f1093   .BYTE $00,$00,$00,$00
;-------------------------------
; s1097
;-------------------------------
s1097   
        DEC a109D
        BEQ b109E
        RTS 

a109D   .BYTE $10
b109E   LDA a41AF
        AND #$0F
        BNE b10A8
        CLC 
        ADC #$01
b10A8   ASL 
        ASL 
        ASL 
        STA a109D
        LDX #$00
b10B0   LDA f107B,X
        BEQ b10BB
        INX 
        CPX #$04
        BNE b10B0
        RTS 

b10BB   JSR s0C7E
        AND #$0F
        ADC #$60
        STA f107F,X
        JSR s0C7E
        AND #$3F
        ADC #$40
        STA f107B,X
        LDA #$C5
        STA f1087,X
        LDA #$0B
        STA f1083,X
        JSR s0C7E
        AND #$07
        ORA #$01
        SEC 
        SBC #$04
        STA f108B,X
        JSR s0C7E
        AND #$07
        ORA #$01
        SEC 
        SBC #$03
        STA f108F,X
        LDA #$00
        STA f1093,X
        RTS 

;-------------------------------
; s10F9
;-------------------------------
s10F9   
        LDX #$00
b10FB   LDA f107B,X
        BEQ b1109
        JSR s1113
b1103   INX 
        CPX #$04
        BNE b10FB
        RTS 

b1109   LDY f0D78,X
        LDA #$00
        STA a403E,Y
        BEQ b1103
;-------------------------------
; s1113
;-------------------------------
s1113   
        LDA f1093,X
        BEQ b111B
        JMP j1293

b111B   LDA f1087,X
        CMP #$D0
        BNE b1125
        JMP j117D

b1125   DEC f112B,X
        BEQ b112F
        RTS 

f112B   .BYTE $04,$04,$04,$04
b112F   INC f1087,X
        LDA #$08
        STA f112B,X
j1137   LDY f0D78,X
        LDA f107B,X
        CLC 
        ADC a09FC
        STA a403E,Y
        LDA f107F,X
        STA a403F,Y
        LDA f1087,X
        STA a4041,Y
        LDA f1083,X
        AND #$80
        BEQ b1171
        LDA f1083,X
        AND #$0F
        ASL 
        ASL 
        ASL 
        ASL 
        STY a1072
        CLC 
        ADC a12DB
        TAY 
        LDA f40DA,Y
        LDY a1072
        JMP j1174

b1171   LDA f1083,X
j1174   STA a4040,Y
        LDA #$60
        STA a4043,Y
        RTS 

j117D   LDA f1083,X
        AND #$80
        BNE b1192
        LDA a41AF
        ROR 
        ROR 
        AND #$0F
        TAY 
        LDA f1588,Y
        STA f1083,X
b1192   LDA f107B,X
        CLC 
        ADC f108B,X
        STA f107B,X
        AND #$F0
        BEQ b11A6
        CMP #$A0
        BEQ b11A6
        BNE b11B2
b11A6   LDA #$00
        STA f107B,X
        LDY f0D78,X
        STA a403E,Y
        RTS 

b11B2   LDA f107F,X
        CLC 
        ADC f108F,X
        STA f107F,X
        AND #$F0
        CMP #$20
        BEQ b11C9
        CMP #$B0
        BEQ b11C9
        JMP j1137

b11C9   LDA f108F,X
        EOR #$FF
        CLC 
        ADC #$01
        STA f108F,X
        JSR s0C7E
        AND #$07
        SEC 
        SBC #$04
        STA f108B,X
        LDA f107B,X
        CLC 
        ROR 
        CLC 
        ROR 
        CLC 
        ROR 
        CLC 
        ROR 
        CLC 
        ROR 
        CLC 
        ROR 
        CLC 
        ADC a0CF8
        AND #$3F
        TAY 
        STY a1072
        LDA f107F,X
        AND #$F0
        CMP #$20
        BNE b1208
        JSR s1336
        STA f0BD6,Y
        RTS 

b1208   JSR s136C
        STA f0C16,Y
        RTS 

;-------------------------------
; s120F
;-------------------------------
s120F   
        LDA $D01E    ;Sprite to Sprite Collision Detect
        STA a121A
        AND #$F0
        BNE b121B
        RTS 

a121A   .BYTE $00
b121B   LDA a121A
        AND #$0E
        BNE b1223
        RTS 

b1223   LDX #$00
b1225   LDY #$00
b1227   LDA f0EB1,X
        SEC 
        SBC f107B,Y
        JSR s128A
        CMP #$0C
        BMI b1240
b1235   INY 
        CPY #$04
        BNE b1227
        INX 
        CPX #$03
        BNE b1225
        RTS 

b1240   LDA f1093,Y
        CMP #$01
        BEQ b1235
        LDA f0EB4,X
        SEC 
        SBC f107F,Y
        JSR s128A
        CMP #$0C
        BMI b1258
        JMP b1235

b1258   LDA #$01
        STA f1093,Y
        LDA #$00
        STA f0EB1,X
        LDA #$07
        STA f108B,Y
        LDA #<p12DC
        STA a1B
        LDA #>p12DC
        STA a1C
        LDA #$01
        STA a4141
        STY a1072
        LDY #$12
b1279   LDA f18FC,Y
        STA f4019,Y
        DEY 
        BNE b1279
        LDA #$57
        STA a40D8
        JMP b1235

;-------------------------------
; s128A
;-------------------------------
s128A   
        BMI b128D
        RTS 

b128D   EOR #$FF
        CLC 
        ADC #$01
        RTS 

j1293   CMP #$01
        BEQ b1298
        RTS 

b1298   LDA f108B,X
        BNE b12A9
        LDA #$00
        STA f107B,X
        LDY f0D78,X
        STA a403E,Y
        RTS 

b12A9   TAY 
        LDA f40F9,Y
        STA f1083,X
        LDA f12BB,Y
        STA f1087,X
        DEC f108B,X
f12BB   =*+$02
        JMP j1137

        .BYTE $F7,$F8,$F9,$FA,$F9,$F8,$F7
;-------------------------------
; s12C3
;-------------------------------
s12C3   
        DEC a12C9
a12C6   BEQ b12CA
        RTS 

a12C9   .BYTE $03
b12CA   LDA #$03
        STA a12C9
        INC a12DB
        LDA a12DB
        AND #$0F
a12D8   =*+$01
        STA a12DB
        RTS 

a12DB   .BYTE $00
p12DC   .BYTE $00,$01,$01,$00,$FF
;-------------------------------
; s12E1
;-------------------------------
s12E1   
        LDY #$00
        LDX #$0F
        LDA f0B55,Y
        PHA 
b12E9   LDA f0B56,Y
        STA f0B55,Y
        STA f0B55,X
        DEX 
        INY 
        CPY #$08
        BNE b12E9
        PLA 
        STA a0B5C
        STA a0B5D
        STA a1074
        INC a1335
        LDA a1335
        AND #$0F
        TAX 
        LDA #$02
        STA f0B65,X
        DEX 
        TXA 
        AND #$0F
        TAX 
        LDA #$0A
        STA f0B65,X
        DEX 
        TXA 
        AND #$0F
        TAX 
        LDA #$00
        STA f0B65,X
        LDX #$10
b1326   LDA f0BB4,X
        EOR #$01
        STA f0BB4,X
        DEX 
        BNE b1326
a1332   =*+$01
        STA a107A
        RTS 

a1335   .BYTE $00
;-------------------------------
; s1336
;-------------------------------
s1336   
        LDA f0BD6,Y
        BEQ b135C
        CMP #$01
        BEQ b1340
        RTS 

b1340   STA a14EA
        LDA f1083,X
        AND #$07
        TAY 
        LDA f1376,Y
        BEQ b135C
        LDA a13B6
        AND #$01
        BNE b135C
        LDA a14EA
        LDY a1072
        RTS 

b135C   LDA f1083,X
        AND #$07
        TAY 
        JSR s1981
        LDA f1376,Y
        LDY a1072
        RTS 

;-------------------------------
; s136C
;-------------------------------
s136C   
        LDA f0C16,Y
        BEQ b135C
        CMP #$01
        BEQ b1340
        RTS 

f1376   .BYTE $03,$04,$00,$05,$06,$07,$08,$02
j137E   CMP #$01
        BNE b1383
        RTS 

b1383   PHA 
        LDY #$12
b1386   LDA f192C,Y
        STA f4007,Y
        DEY 
        BNE b1386
        PLA 
        CMP #$03
        BEQ b1397
        JMP j13B9

b1397   LDA a08C6
        CMP #$3B
        BNE b13A8
        LDA a08C7
        SEC 
        SBC #$08
        STA a08C7
b13A7   RTS 

a13A9   =*+$01
b13A8   CMP #$90
        BNE b13A7
        LDA a08C7
        CLC 
        ADC #$08
        STA a08C7
        RTS 

a13B6   .BYTE $00
a13B7   .BYTE $FF
a13B8   .BYTE $00
j13B9   CMP #$02
        BEQ b13C0
        JMP j1592

b13C0   LDA #$02
        STA a0D91
        LDX #$12
b13C7   LDA f18D8,X
        STA f4007,X
        DEX 
        BNE b13C7
        LDX #$00
b13D2   LDA #$00
        STA f107B,X
        STA f0EB1,X
        INX 
        CPX #$03
        BNE b13D2
        STA f107B,X
        LDA #$30
        STA a1433
        LDA #$00
        STA a09FC
        STA a14EB
        RTS 

j13F0   LDA a185F
        BEQ b13F8
        JMP j1860

b13F8   LDA a14EB
        BEQ b1400
        JMP j14EC

b1400   LDA a1433
        BEQ b1435
        LDA a1433
        AND #$0F
        TAX 
        LDA f40FA,X
        STA a4040
        DEC a1433
        BEQ b1417
        RTS 

b1417   LDA #<p12DC
        STA a1B
        LDA #>p12DC
        STA a1C
        LDA #$01
        STA a4141
        STA a1434
        LDX #$12
b1429   LDA f18EA,X
        STA f4007,X
        DEX 
        BNE b1429
        RTS 

a1433   .BYTE $00
a1434   .BYTE $00
b1435   LDA a1434
        CLC 
        ROR 
        TAY 
        LDA f40EA,Y
        STA a14EA
        CLC 
        ADC #$50
        LDX #$00
        JSR s1490
        LDA a1434
        ASL 
        CLC 
        ADC #$50
        LDX #$02
        JSR s1490
        LDA a1434
        ASL 
        ASL 
        CLC 
        ADC #$50
        LDX #$04
        JSR s1490
        LDA a1434
        ASL 
        ASL 
        ASL 
        CLC 
        ADC #$50
        LDX #$06
        JSR s1490
        INC a1434
        LDA a1434
        CMP #$10
        BEQ b147B
        RTS 

b147B   LDA #$40
        STA a14EB
        LDX #$00
b1482   LDY f0D74,X
        LDA #$00
        STA a4040,Y
        INX 
        CPX #$08
        BNE b1482
        RTS 

;-------------------------------
; s1490
;-------------------------------
s1490   
        PHA 
        LDY f0D74,X
        STA a403E,Y
        LDA #$06
        STA a4043,Y
        LDA a4041
        STA a4041,Y
        LDA a403F
        STA a403F,Y
        LDA a14EA
        STA a4040,Y
        PLA 
        SEC 
        SBC #$50
        STA a1072
        LDA #$50
        SEC 
        SBC a1072
        STA f404E,Y
        LDA #$06
        STA f4053,Y
        LDA a4041
        STA f4051,Y
        LDA a403F
        STA f404F,Y
        LDA a14EA
        STA f4050,Y
b14D5   RTS 

;-------------------------------
; s14D6
;-------------------------------
s14D6   
        LDA a0D91
        BNE b14D5
        LDA a16E8
        BNE b14D5
        JSR s0F6A
        JSR s1097
        JSR s10F9
        RTS 

a14EA   .BYTE $00
a14EB   .BYTE $00
j14EC   LDA a14EB
        CMP #$40
        BNE b150C
        JSR s0C7E
        AND #$07
        ASL 
        ASL 
        ASL 
        TAY 
        LDX #$00
b14FE   LDA f1548,Y
        AND #$3F
        STA SCREEN_RAM + $0178,X
        INY 
        INX 
        CPX #$08
        BNE b14FE
b150C   LDA a14EB
        ROR 
        ROR 
        AND #$0F
        TAY 
        LDA f40EA,Y
        LDX #$08
b1519   STA $D977,X
        DEX 
        BNE b1519
        DEC a14EB
        BEQ b1525
        RTS 

b1525   LDA a1714
        BEQ b1535
        LDA #$00
        STA a1714
        LDA #$30
        STA a185F
        RTS 

b1535   LDX #$08
b1537   LDA #$20
        STA SCREEN_RAM + $0177,X
        DEX 
        BNE b1537
j153F   JSR s0C56
        LDA #$00
        STA a0D91
        RTS 

f1548   .BYTE $A0,$A0,$D9,$CF,$D7,$A1,$A0,$A0
        .BYTE $A0,$AA,$C2,$CF,$C7,$C7,$AA,$A0
        .BYTE $A0,$CF,$CF,$D0,$D3,$A1,$A1,$A0
        .BYTE $D9,$C1,$CB,$A1,$D9,$C1,$CB,$A1
        .BYTE $C4,$C5,$C5,$D2,$A0,$CD,$C5,$A1
        .BYTE $AD,$C7,$CC,$D5,$D2,$CB,$CB,$AD
        .BYTE $AD,$C6,$D2,$C9,$C5,$C4,$A1,$AD
        .BYTE $CF,$C8,$A0,$C7,$C1,$D2,$C7,$A1
f1588   .BYTE $87,$86,$85,$84,$83,$82,$81,$81
        .BYTE $80,$80
j1592   CMP #$04
        BNE b15B8
        LDA a09FC
        EOR #$FF
        CLC 
        ADC #$01
        STA a09FC
        LDA a08C7
        CMP #$A0
        BEQ b15B3
        CMP #$A8
        BEQ b15B3
        SEC 
        SBC #$04
b15AF   STA a08C7
        RTS 

b15B3   CLC 
        ADC #$04
        BNE b15AF
b15B8   CMP #$05
        BNE b15C5
        JSR s0C7E
        AND #$3F
        STA a0CF8
        RTS 

b15C5   CMP #$07
        BNE b15CC
        JMP j0AFF

b15CC   CMP #$08
        BNE b15D6
        LDA #$00
        STA a09FC
b15D5   RTS 

b15D6   CMP #$06
        BNE b15D5
        LDA #<p18C5
        STA a1B
        LDA #>p18C5
        STA a1C
        LDA #$01
        STA a4141
        JMP s18A2

b15EA   RTS 

;-------------------------------
; s15EB
;-------------------------------
s15EB   
        LDX #$40
b15ED   LDA f0C15,X
        BEQ b15EA
        LDA f0BD5,X
        BEQ b15EA
        DEX 
        BNE b15ED
        LDX #$12
b15FC   LDA f19C4,X
        STA f4007,X
        DEX 
        BNE b15FC
        LDA #<p1851
        STA a1B
        LDA #>p1851
        STA a1C
        LDA #$01
        STA a4141
        LDA #$00
        STA a1993
        LDX #$40
b1619   LDA f0BD5,X
        CMP #$01
        BNE b1623
        INC a1993
b1623   LDA f0C15,X
        CMP #$01
        BNE b162D
        INC a1993
b162D   DEX 
        BNE b1619
        LDA #$07
        SEC 
        SBC a13B6
        ORA #$30
        STA a40D8
        LDA a1993
        CMP #$7E
        BNE b1659
        LDA #$FF
        STA a1993
        LDX #$0B
b1649   LDA f19B9,X
        AND #$3F
        STA SCREEN_RAM + $0175,X
        DEX 
        BNE b1649
        LDA #$40
        STA a16E8
b1659   LDA a1714
        BEQ b167B
        LDA #$56
        STA a40D8
        LDA #$45
        STA a1B
        LDA #$0B
        STA a1B
        LDA #$01
        STA a4141
        LDA #$00
        STA a0D91
        STA a1714
        JMP j169D

b167B   JSR s19D7
        INC a16E6
        LDA a16E6
        CMP #$02
        BNE j169D
        INC a13B6
        LDA a13B6
        CMP #$07
        BNE b1695
        DEC a13B6
b1695   LDA #$00
        STA a16E6
        JMP j1716

j169D   JSR s0C56
        LDA #$00
        STA a1714
        LDA a16E8
        BEQ b16AB
        RTS 

b16AB   LDX #$0B
b16AD   LDA f16CF,X
        AND #$3F
        STA SCREEN_RAM + $0175,X
        DEX 
        BNE b16AD
        LDA #$40
        STA a16E8
        LDA a16E6
        CLC 
        ADC #$30
        STA SCREEN_RAM + $0180
        LDA a13B6
        CLC 
        ADC #$30
        STA SCREEN_RAM + $017A
f16CF   RTS 

        .BYTE $CC,$C5,$D6,$BA,$B0,$A0,$D0,$C8
        .BYTE $C1,$BA
f16DA   .BYTE $B0,$C2,$CF,$CE,$D5,$D3,$A0,$D2
        .BYTE $D5,$CE,$BA,$B0
a16E6   BRK #$00
a16E8   .BYTE $00
;-------------------------------
; s16E9
;-------------------------------
s16E9   
        LDA a16E8
        BNE b16EF
b16EE   RTS 

b16EF   ROR 
        ROR 
        AND #$0F
        TAY 
        LDA #$00
        STA a09FC
        LDA f40EA,Y
        LDX #$0B
b16FE   STA $D975,X
        DEX 
        BNE b16FE
        DEC a16E8
        BNE b16EE
        LDX #$0B
        LDA #$20
b170D   STA SCREEN_RAM + $0175,X
        DEX 
        BNE b170D
        RTS 

a1714   .BYTE $00
a1715   .BYTE $00
j1716   LDA #$01
        STA a1714
        LDA a16E8
        BNE b1738
        LDA #$01
        LDX #$0B
b1724   LDA f16DA,X
        AND #$3F
        STA SCREEN_RAM + $0175,X
        DEX 
        BNE b1724
        LDA #$31
        CLC 
        ADC a1715
        STA SCREEN_RAM + $0180
b1738   LDA #$01
        STA a0D91
        LDA #$40
        STA a16E8
        JSR s1803
        INC a1715
        LDA a1715
        AND #$03
        STA a1715
        JMP j0E12

f1753   .BYTE $00,$00,$00,$00,$00,$00,$00,$00
f175B   .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$01,$06,$02,$00,$01,$00,$02
        .BYTE $01,$00,$02,$00,$01,$06,$02,$00
        .BYTE $06,$02,$00,$01,$04,$05,$05,$05
        .BYTE $03,$04,$03,$04,$00,$00,$00,$06
        .BYTE $05,$00,$02,$00,$05,$06,$04,$01
        .BYTE $02,$00,$01,$00,$06,$01,$00,$02
        .BYTE $02,$01,$06,$01,$02,$00,$01,$02
        .BYTE $01,$00,$01,$02,$00,$01,$02,$06
        .BYTE $07,$00,$07,$06,$02,$00,$07,$00
        .BYTE $03,$00,$03,$00,$03,$06,$02,$00
        .BYTE $01,$02,$01,$06,$00,$02,$01,$02
        .BYTE $03,$00,$03,$00,$00,$03,$06,$03
        .BYTE $02,$06,$03,$01,$00,$03,$02,$00
        .BYTE $00,$00,$03,$03,$03,$03,$00,$06
        .BYTE $03,$02,$03,$01,$00,$02,$03,$02
        .BYTE $02,$03,$02,$00,$02,$03,$02,$03
f17E3   .BYTE $00,$00,$00,$01,$00,$00,$00,$00
        .BYTE $00,$01,$00,$01,$01,$00,$01,$00
        .BYTE $00,$01,$01,$01,$00,$01,$01,$01
        .BYTE $01,$01,$01,$01,$01,$01,$01,$01
;-------------------------------
; s1803
;-------------------------------
s1803   
        JSR s18A2
        LDX #$00
        LDA a1715
        ASL 
        ASL 
        ASL 
        TAY 
        LDA #$08
        STA a184F
b1814   LDA f17E3,Y
        JSR s1821
        INY 
        DEC a184F
        BNE b1814
        RTS 

;-------------------------------
; s1821
;-------------------------------
s1821   
        BEQ b182B
        JSR s0C7E
        AND #$07
        CLC 
        ADC #$01
b182B   STY a1072
        ASL 
        ASL 
        ASL 
        ASL 
        TAY 
        LDA #$08
        STA a1850
b1838   LDA f1753,Y
        STA f0BD6,X
        LDA f175B,Y
        STA f0C16,X
a1844   INX 
        INY 
        DEC a1850
        BNE b1838
        LDY a1072
        RTS 

a184F   .BYTE $00
a1850   .BYTE $00
p1851   .BYTE $00,$01,$01,$00,$0F,$0F,$00,$0C
        .BYTE $0C,$00,$0B,$0B,$00
        .BYTE $FF
a185F   .BYTE $00
j1860   LDA a185F
        BNE b1866
b1865   RTS 

b1866   LDX #$12
        LDY a185F
b186B   LDA f1890,X
        AND #$3F
        STA SCREEN_RAM + $0170,X
        LDA selectedSubGame,Y
        STA $D970,X
        DEX 
        BNE b186B
        DEC a185F
        BNE b1865
        LDX #$12
        LDA #$20
b1885   STA SCREEN_RAM + $0170,X
        DEX 
        BNE b1885
        JSR b16AB
f1890   =*+$02
        JMP j153F

        .BYTE $D3,$CF,$D2,$D2,$D9,$A0,$AD,$A0
        .BYTE $CE,$CF,$A0,$C2,$CF,$CE,$D5,$D3
        .BYTE $A1
;-------------------------------
; s18A2
;-------------------------------
s18A2   
        JSR s0C7E
        AND #$01
        CLC 
        ADC #$01
        STA a0F61
        JSR s0C7E
        AND #$03
        CLC 
        ADC #$01
        STA a09B1
        JSR s0C7E
        AND #$03
        CLC 
        ADC #$01
        STA a18C4
        RTS 

a18C4   .BYTE $00
p18C5   .BYTE $00,$02,$00,$02,$00,$02,$00,$07
        .BYTE $00,$07,$00,$07,$00,$05,$00,$05
        .BYTE $00,$05,$00
f18D8   .BYTE $FF,$81
a18DA   .BYTE $0F,$AA,$01,$A0,$21,$04,$05,$00
        .BYTE $FF,$00,$00,$00,$00,$00,$00,$00
f18EA   .BYTE $00,$81,$0F,$99,$01,$10,$11,$FF
        .BYTE $0C,$00,$01,$80,$10,$40,$04,$FF
        .BYTE $0C,$00
f18FC   .BYTE $01,$88,$0F,$0A,$01,$E0,$81,$80
        .BYTE $04,$00,$02,$10,$10,$FF,$0C,$FA
        .BYTE $02,$00
f190E   .BYTE $01,$81,$7F,$06,$01,$60,$81,$06
        .BYTE $0C,$00,$01,$20,$80,$40,$03,$00
        .BYTE $03,$00,$01
j1921   LDX #$12
b1923   LDA f190E,X
        STA f4007,X
        DEX 
        BNE b1923
f192C   RTS 

        .BYTE $81,$7F,$0C,$01,$10,$21,$80,$02
        .BYTE $04,$0C,$10,$30,$80,$02,$FC,$0C
        .BYTE $00
f193E   .BYTE $01,$81,$0F,$0A,$01,$C0,$81,$01
        .BYTE $04,$00,$02,$10,$10,$20,$03,$03
        .BYTE $10,$00,$01,$81,$2F,$09,$01,$A0
        .BYTE $21,$03,$03,$08,$03,$10,$C0,$08
        .BYTE $04,$F0,$0C,$00,$01
j1963   LDX #$12
        .BYTE $BD
f1966   .BYTE $50,$19,$9D,$07,$40,$CA,$D0,$F7
f196E   .BYTE $60
        .BYTE $8F,$0F,$0A,$01,$20,$11,$FF,$0C
        .BYTE $00,$01,$10,$50,$22,$06,$E0,$20
        .BYTE $00,$01
;-------------------------------
; s1981
;-------------------------------
s1981   
        STY a0CF9
        LDY #$12
b1986   LDA f196E,Y
        STA f402B,Y
        DEY 
        BNE b1986
        LDY a0CF9
        RTS 

a1993   .BYTE $00
;-------------------------------
; s1994
;-------------------------------
s1994   
        LDA a1993
        BNE b19A2
        LDA a40D8
        BNE b199F
        RTS 

b199F   JMP j413E

b19A2   LDA a40D8
        PHA 
        BEQ b19AB
        JSR j413E
b19AB   PLA 
        STA a40D8
        DEC a1993
        BNE b19A2
        LDA #$00
        STA a40D8
f19B9   RTS 

        .BYTE $AA,$A0,$D0,$C5,$D2,$C6,$C5,$C3
        .BYTE $D4,$A0
f19C4   .BYTE $AA,$81,$0F,$0A,$01,$40,$81,$FF
        .BYTE $10,$00,$01,$20,$C0,$FC,$06,$10
        .BYTE $F0,$00,$01
;-------------------------------
; s19D7
;-------------------------------
s19D7   
        LDX a19F1
        CPX #$04
        BNE b19DF
        RTS 

b19DF   LDY f19F2,X
        LDA f19F6,X
        STA SCREEN_RAM + $0381,Y
        LDA #$07
        STA $DB81,Y
        INC a19F1
        RTS 

a19F1   .BYTE $00
f19F2   .BYTE $00,$28,$01,$29
f19F6   .BYTE $A1,$A2,$A3,$A4,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$BB,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$FF,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$FB,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$FF,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$E7,$80,$03,$E7,$C0,$07
        .BYTE $FF,$E0,$0F,$C7,$F0,$1F,$E7,$F8
        .BYTE $3F,$E7,$FC,$7F,$C7,$FE,$FF,$FF
        .BYTE $FF,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$40,$00,$00,$00,$03,$80,$60
        .BYTE $07,$C0,$70,$07,$C0,$5C,$07,$C0
        .BYTE $7C,$0F,$E0,$E0,$0E,$E8,$E0,$1D
        .BYTE $F7,$E0,$1B,$77,$C0,$3B,$7B,$80
        .BYTE $3B,$38,$00,$36,$18,$00,$36,$38
        .BYTE $00,$16,$30,$00,$38,$38,$00,$38
        .BYTE $38,$00,$18,$30,$00,$18,$30,$00
        .BYTE $38,$30,$00,$70,$38,$00,$00,$1C
        .BYTE $00,$40,$00,$00,$00,$03,$80,$00
        .BYTE $07,$C0,$60,$07,$C0,$70,$07,$C0
        .BYTE $5C,$0F,$E0,$78,$0F,$E0,$70,$1D
        .BYTE $F6,$F0,$1D,$B7,$E0,$3D,$BB,$E0
        .BYTE $39,$BB,$C0,$30,$D8,$00,$38,$D8
        .BYTE $00,$18,$D0,$00,$38,$18,$00,$38
        .BYTE $38,$00,$18,$30,$00,$18,$30,$00
        .BYTE $18,$38,$00,$38,$1C,$00,$70,$00
        .BYTE $00,$40,$18,$00,$30,$18,$00,$60
        .BYTE $38,$30,$E0,$28,$60,$E0,$6C,$6C
        .BYTE $A0,$64,$F9,$A0,$67,$FD,$60,$3F
        .BYTE $FF,$C0,$19,$FB,$80,$1C,$55,$80
        .BYTE $1B,$8D,$80,$1B,$FD,$80,$0B,$1B
        .BYTE $00,$0C,$E7,$00,$0F,$FF,$00,$0F
        .BYTE $77,$00,$0C,$73,$00,$0C,$8B,$00
        .BYTE $01,$FA,$00,$03,$6C,$00,$01,$F8
        .BYTE $00,$40,$C0,$00,$18,$60,$C0,$30
        .BYTE $70,$60,$70,$58,$60,$E0,$6C,$6C
        .BYTE $A0,$66,$FD,$A0,$27,$FD,$60,$3F
        .BYTE $FF,$E0,$19,$9B,$C0,$1C,$05,$80
        .BYTE $1B,$6D,$80,$1B,$FD,$80,$1B,$1B
        .BYTE $00,$0C,$E7,$00,$0F,$FF,$00,$0F
        .BYTE $77,$00,$0C,$93,$00,$05,$FA,$00
        .BYTE $03,$6C,$00,$03,$6C,$00,$01,$F8
        .BYTE $00,$40,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$3C,$00,$00
        .BYTE $7E,$00,$00,$7E,$00,$00,$7E,$00
        .BYTE $00,$3C,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$3F,$80,$00,$60,$E0,$00
        .BYTE $1B,$70,$00,$1B,$70,$00,$3B,$70
        .BYTE $00,$1B,$70,$00,$3F,$E0,$00,$E0
        .BYTE $03,$00,$C0,$FE,$00,$61,$B0,$00
        .BYTE $00,$30,$00,$00,$70,$00,$00,$30
        .BYTE $00,$00,$36,$06,$00,$FC,$7C,$03
        .BYTE $86,$CC,$03,$01,$8C,$01,$81,$CE
        .BYTE $00,$01,$CE,$00,$00,$CC,$00,$00
        .BYTE $78,$00,$00,$7C,$00,$03,$FF,$80
        .BYTE $0F,$EF,$E0,$1F,$9F,$F0,$1F,$FF
        .BYTE $F0,$3F,$FF,$00,$3F,$F0,$00,$3F
        .BYTE $F0,$00,$7F,$FF,$00,$7F,$FF,$F0
        .BYTE $DF,$FF,$F0,$CF,$FF,$E0,$CF,$FF
        .BYTE $E0,$D8,$7C,$60,$6C,$C6,$30,$D8
        .BYTE $63,$60,$CE,$33,$30,$63,$66,$30
        .BYTE $C6,$63,$30,$06,$31,$98,$00,$18
        .BYTE $00,$00,$00,$7C,$00,$03,$FF,$80
        .BYTE $0F,$DF,$C0,$1F,$3F,$00,$1F,$FC
        .BYTE $00,$3F,$F0,$00,$3F,$C0,$00,$3F
        .BYTE $C0,$00,$7F,$F0,$00,$7F,$FC,$00
        .BYTE $DF,$FF,$00,$CF,$FF,$C0,$CF,$FF
        .BYTE $E0,$6C,$7C,$60,$6C,$C6,$60,$C6
        .BYTE $C6,$30,$CC,$66,$60,$C6,$63,$60
        .BYTE $CC,$63,$30,$6C,$C3,$60,$00,$61
        .BYTE $80,$00,$00,$00,$00,$00,$00,$00
        .BYTE $38,$00,$1C,$6F,$00,$36,$DD,$80
        .BYTE $FB,$DD,$81,$BB,$DD,$81,$BB,$61
        .BYTE $E3,$86,$3C,$36,$1C,$07,$DD,$F0
        .BYTE $00,$C1,$80,$01,$B6,$C0,$01,$80
        .BYTE $C0,$00,$C1,$80,$00,$C1,$80,$00
        .BYTE $D5,$80,$00,$77,$00,$00,$3E,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$1F,$FF,$FE
        .BYTE $19,$7F,$FE,$1D,$FF,$FE,$1D,$FF
        .BYTE $FE,$1F,$FF,$FE,$3F,$FF,$FC,$3F
        .BYTE $FF,$FC,$63,$3F,$38,$7F,$FF,$F8
        .BYTE $CD,$3E,$70,$FF,$FF,$F0,$C2,$7E
        .BYTE $70,$FF,$FF
a1DA9   .BYTE $F0,$C6,$FE,$70,$FF,$FF,$F0,$66
        .BYTE $BF,$38,$7F,$FF,$F8,$39,$00,$0C
        .BYTE $1F,$FF,$FE,$00,$00,$00,$00,$00
        .BYTE $00,$00,$3F,$FF,$FC,$32,$FF,$FC
        .BYTE $3B,$FF,$FC,$1D,$FF,$FE,$1F,$FF
        .BYTE $FE,$1F,$FF,$FE,$3F,$FF,$FC,$31
        .BYTE $9F,$9C,$3F,$FF,$FC,$66,$9F,$38
        .BYTE $7F,$FF,$F8,$61,$3F,$38,$FF,$FF
        .BYTE $F0,$C6,$FE,$70,$FF,$FF,$F0,$CD
        .BYTE $7E,$70,$FF,$FF,$F0,$72,$00,$18
        .BYTE $7F,$FF,$F8,$00,$00,$00,$00,$18
        .BYTE $00,$7D,$30,$00,$79,$03,$00,$0F
        .BYTE $01,$80,$EF,$19,$81,$E8,$31,$87
        .BYTE $DF,$63,$1F,$9F,$66,$3F,$07,$30
        .BYTE $FE,$00,$01,$FC,$00,$07,$F8,$00
        .BYTE $09,$F8,$00,$1E,$F0,$00,$35,$60
        .BYTE $00,$26,$C0,$00,$35,$80,$00,$0E
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$30
        .BYTE $00,$FB,$60,$60,$F7,$C0,$C0,$FF
        .BYTE $70,$60,$FF,$18,$30,$C0,$0C,$60
        .BYTE $1C,$39,$C0,$F9,$63,$07,$F7,$30
        .BYTE $3F,$CF,$00,$FF,$80,$05,$7F,$00
        .BYTE $01,$3C,$00,$0A,$98,$00,$15,$30
        .BYTE $00,$02,$80,$00,$04,$80,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$7F
        .BYTE $FF,$F0,$60,$F3,$18,$60,$F3,$0C
        .BYTE $60,$F3,$06,$60,$F3,$06,$60,$FF
        .BYTE $06,$60,$00,$06,$60,$00,$06,$60
        .BYTE $00,$06,$60,$00,$06,$63,$FF,$C6
        .BYTE $63,$6B,$C6,$63,$FF,$C6,$63,$37
        .BYTE $C6,$63,$FF,$C6,$63,$45,$C6,$63
        .BYTE $FF,$C6,$7F,$FF,$FE,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$7F
        .BYTE $FF,$F0,$67,$D8,$18,$67,$B8,$0C
        .BYTE $67,$D8,$06,$67,$B8,$06,$67,$F8
        .BYTE $06,$60,$00,$06,$60,$00,$06,$60
        .BYTE $00,$06,$60,$00,$06,$63,$FF,$C6
        .BYTE $63,$6B,$C6,$63,$FF,$C6,$63,$37
        .BYTE $C6,$63,$FF,$C6,$63,$45,$C6,$63
        .BYTE $FF,$C6,$7F,$FF,$FE,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$1C
        .BYTE $00,$70,$36,$00,$D8,$06,$00,$C0
        .BYTE $03,$01,$80,$03,$01,$80,$01,$83
        .BYTE $00,$01,$83,$00,$01,$83,$00,$00
        .BYTE $C6,$00,$00,$C6,$00,$00,$C6,$00
        .BYTE $00,$FE,$00,$01,$FF,$00,$01,$7D
        .BYTE $00,$00,$BA,$00,$00,$FE,$00,$00
        .BYTE $FE,$00,$00,$FE,$00,$00,$6C,$00
        .BYTE $00,$82,$00,$00,$FE,$00,$BD,$03
        .BYTE $FF,$E0,$03,$FF,$E0,$03,$FF,$E0
        .BYTE $06,$DB,$70,$07,$6D,$B0,$03,$DB
        .BYTE $60,$03,$6D,$E0,$03,$DB,$60,$03
        .BYTE $6D,$E0,$03,$DB,$60,$01,$ED,$C0
        .BYTE $01,$DB,$C0,$01,$ED,$C0,$01,$DB
        .BYTE $C0,$01,$ED,$C0,$01,$DB,$C0,$01
        .BYTE $ED,$C0,$01,$FF,$C0,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$BD,$03
        .BYTE $FF,$E0,$03,$00,$60,$03,$60,$60
        .BYTE $06,$03,$30,$06,$30,$30,$03,$00
        .BYTE $60,$03,$FF,$E0,$03,$FF,$E0,$03
        .BYTE $FF,$E0,$03,$DB,$60,$01,$ED,$C0
        .BYTE $01,$DB,$C0,$01,$ED,$C0,$01,$DB
        .BYTE $C0,$01,$ED,$C0,$01,$DB,$C0,$01
        .BYTE $ED,$C0,$01,$FF,$C0,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$BD,$03
        .BYTE $FF,$E0,$03,$00,$60,$03,$60,$60
        .BYTE $06,$03,$30,$06,$30,$30,$03,$00
        .BYTE $60,$03,$0C,$60,$03,$00,$60,$03
        .BYTE $30,$60,$03,$06,$60,$01,$80,$C0
        .BYTE $01,$80,$C0,$01,$80,$C0,$01,$FF
        .BYTE $C0,$01,$FF,$C0,$01,$FF,$C0,$01
        .BYTE $ED,$C0,$01,$FF,$C0,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$FF,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$7C
        .BYTE $36,$66,$C6,$FE,$C6,$CC,$60,$F8
        .BYTE $6C,$6C,$7C,$66,$66,$FC,$C0,$3C
        .BYTE $66,$CC,$C0,$C0,$C0,$C6,$7C,$38
        .BYTE $0C,$06,$76,$DE,$C6,$C6,$7C,$1C
        .BYTE $76,$C0,$C0,$F8,$C0,$76,$1C,$3E
        .BYTE $66,$0C,$7E,$D8,$18,$30,$60,$3C
        .BYTE $66,$CC,$C0,$CC,$7C,$18,$F0,$C0
        .BYTE $60,$60,$7C,$76,$63,$66,$CC,$0C
        .BYTE $00,$0C,$3C,$0C,$0C,$18,$18,$3E
        .BYTE $E6,$06,$06,$0C,$0C,$CC,$78,$C6
        .BYTE $6C,$6C,$78,$6C,$66,$63,$C6,$38
        .BYTE $78,$30,$30,$60,$60,$CE,$F8,$63
        .BYTE $F7,$DF,$C3,$C3,$C3,$C6,$60,$CC
        .BYTE $E6,$F6,$DE,$CE,$C6,$C6,$60,$3C
        .BYTE $66,$C3,$DB,$DB,$C3,$66,$3C,$FC
        .BYTE $66
a2082   .BYTE $66,$7C,$60,$60,$60,$C0,$38,$6C
        .BYTE $C6,$C6,$DE,$CE,$7F,$01,$FC,$66
        .BYTE $66,$7C,$6C,$66,$66,$C0,$7C,$C6
        .BYTE $60,$38,$0C,$06,$C6,$7C,$7F,$CC
        .BYTE $18,$30,$60,$60,$66,$3C,$66,$E6
        .BYTE $66,$66,$C6,$C6,$C6,$7C,$CE,$C6
        .BYTE $C6,$C6,$C6,$66,$3C,$18,$60,$C6
        .BYTE $C3,$C3,$C3,$DB,$FF,$66,$C6,$6C
        .BYTE $6C,$38,$38,$6C,$6C,$C6,$66,$C3
        .BYTE $66,$3C,$18,$18,$18,$30,$7E,$C6
        .BYTE $0C,$18,$30,$60,$C6,$FC,$00,$00
        .BYTE $00,$03,$00,$00,$00,$00,$00,$00
        .BYTE $00,$0C,$00,$00,$00,$00,$00,$00
        .BYTE $00,$30,$00,$00,$00,$00,$00,$00
        .BYTE $00,$C0,$00,$00,$00,$00,$00,$FF
        .BYTE $00,$FF,$00,$00,$00,$FF,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$06,$0E
        .BYTE $0E,$1C,$18,$00,$30,$30,$66,$CC
        .BYTE $CC,$00,$00,$00,$00,$00,$FF,$00
        .BYTE $FF,$40,$F8,$03,$FF,$00,$3C,$18
        .BYTE $DB,$DB,$7E,$18,$18,$3C,$E3,$C6
        .BYTE $0C,$18,$30,$63,$C7,$00,$60,$F0
        .BYTE $D8,$78,$CC,$CC,$7F,$06,$0C,$0C
        .BYTE $18,$00,$00,$00,$00,$00,$3C,$60
        .BYTE $C0,$C0,$C0,$C0,$60,$3C,$F0,$18
        .BYTE $0C,$0C,$0C,$0C,$18,$F0,$10,$00
        .BYTE $10,$BA,$10,$00,$10,$00,$00,$0C
        .BYTE $0C,$18,$FF,$18,$30,$30,$00,$00
        .BYTE $00,$00,$00,$30,$30,$60,$00,$00
        .BYTE $00,$7E,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$30,$30,$06,$0C
        .BYTE $0C,$0C,$18,$30,$60,$C0,$38,$6C
        .BYTE $C6,$C6,$C6,$C6,$6C,$38,$18,$38
        .BYTE $18,$18,$18,$18,$18,$3C,$7C,$C6
        .BYTE $06,$0C,$18,$30,$66,$FE,$7C,$C6
        .BYTE $06,$1C,$06,$06,$C6,$7C,$C0,$C0
        .BYTE $D8,$FC,$18,$18,$18,$18,$FE,$C6
        .BYTE $C0,$FC,$06,$06,$C6,$7C,$7C,$C6
        .BYTE $C0,$FC,$C6,$C6,$C6,$7C,$7E,$C6
        .BYTE $0C,$18,$FE,$30,$30,$30,$7C,$C6
        .BYTE $C6,$7C,$C6,$C6,$C6,$7C,$7C,$C6
        .BYTE $C6,$7E,$06,$06,$C6,$7C,$00,$00
        .BYTE $30,$00,$00,$30,$00,$00,$00,$00
        .BYTE $30,$00,$00,$30,$60,$00,$00,$00
        .BYTE $C0,$C0,$C0,$C0,$00,$00,$00,$00
        .BYTE $F0,$F0,$F0,$F0,$00,$00,$00,$00
        .BYTE $FC,$FC,$FC,$FC,$00,$00,$00,$00
        .BYTE $FF,$FF,$FF,$FF,$00,$00,$01,$03
        .BYTE $07,$0F,$1F,$3F,$7F,$FF,$80,$C0
        .BYTE $E0,$F0,$F8,$FC,$FE,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$C0,$03
        .BYTE $18,$00,$66,$00,$DC,$FF,$06,$60
        .BYTE $00,$06,$30,$00,$66,$FF,$C1,$03
        .BYTE $67,$0F,$DF,$3F,$7F,$FF,$98,$C3
        .BYTE $EC,$F0,$FB,$FC,$FE,$FF,$A5,$D3
        .BYTE $ED,$F4,$FA,$FD,$FE,$FF
f2240   .BYTE $1A,$63,$0A,$67,$62,$6F,$1A,$58
        .BYTE $00,$00
a224A   .BYTE $A9,$FF,$FF
a224D   .BYTE $40,$00,$00,$00,$00
a2252   .BYTE $20,$FF,$FF
a2255   .BYTE $1C,$00,$00,$01,$03,$06,$FF,$F6
        .BYTE $3F,$7B,$FF,$00,$00,$0F,$01,$00
        .BYTE $00,$00,$00,$00,$00,$01,$0F,$00
        .BYTE $00,$00,$00,$00,$00,$80,$F0,$78
        .BYTE $3C,$3C,$3C,$3C,$78,$F0,$80,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$2B,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$80,$00
        .BYTE $80,$80,$EA,$80,$80,$00,$80,$00
        .BYTE $00,$00,$00,$00,$08,$00,$08,$5D
        .BYTE $08,$00,$08,$00,$00,$00,$18,$18
        .BYTE $00,$00,$00,$FF,$FF,$FF,$E0,$1F
        .BYTE $FC,$83,$CE,$F3,$FC,$FE,$CC,$99
        .BYTE $C3,$FF,$FF,$FF,$FF,$FF,$0F,$F1
        .BYTE $3E,$07,$19,$3C,$00,$4F,$C7,$CF
        .BYTE $CF,$CF,$FF,$FF,$FF,$FF,$F8,$F0
        .BYTE $F0,$F0,$F0,$FF,$FF,$FF,$1F,$0F
        .BYTE $0F,$0F,$0F,$0F,$0F,$0F,$0F,$1F
        .BYTE $FF,$FF,$FF,$F0,$F0,$F0,$F0,$F8
        .BYTE $FF,$FF,$FF,$00,$7E,$7E,$7E,$7E
        .BYTE $7E,$7E,$00,$FF,$FF,$FF,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $FF,$FF,$FF,$F0,$F0,$F0,$F0,$F0
        .BYTE $F0,$F0,$F0,$0F,$0F,$0F,$0F,$0F
        .BYTE $0F,$0F,$0F
f2318   .BYTE $FF,$FF,$00,$00,$FF,$FF,$00,$00
        .BYTE $FF,$FF,$00,$00,$00,$FF,$FF,$FF
        .BYTE $FF,$FF,$00,$00,$00,$00,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
        .BYTE $00,$00,$00,$00,$00,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$0F,$8F,$CF,$A7,$B7,$91,$FF
        .BYTE $7F,$1C,$4E,$4E,$4E,$4E,$4E,$46
        .BYTE $60,$78,$7E,$7E,$7E,$7E,$7C,$7F
        .BYTE $FF,$1C,$39,$39,$39,$39,$39,$31
        .BYTE $03,$0F,$3F,$3F,$3F,$3F,$1F,$FF
        .BYTE $7F,$7F,$7F,$7F,$7E,$55,$7B,$77
        .BYTE $00,$7F,$00,$7F,$7F,$00,$7F,$7F
        .BYTE $F7,$FB,$B7,$5B,$EB,$F7,$FB,$FD
        .BYTE $00,$FF,$00,$FF,$FF,$00,$FF,$FF
        .BYTE $7F,$66,$66,$7F,$66,$66,$7F,$66
        .BYTE $66,$7F,$66,$66,$7F,$66,$66,$7F
        .BYTE $FF,$67,$67,$FF,$67,$67,$FF,$67
        .BYTE $67,$FF,$67,$67,$FF,$67,$67,$FF
        .BYTE $7F,$7F,$7F,$7D,$78,$78,$70,$70
        .BYTE $00,$64,$67,$4B,$4B,$4B,$45,$7F
        .BYTE $FF,$E7,$F1,$F1,$F3,$F3,$63,$63
        .BYTE $00,$0F,$8F,$CF,$A7,$B7,$91,$FF
        .BYTE $01,$01,$05,$05,$15,$15,$55,$55
        .BYTE $55,$55,$55,$55,$55,$55,$55,$55
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $01,$01,$05,$05,$17,$17,$57,$57
        .BYTE $5F,$5F,$5F,$5F,$7F,$7F,$7F,$7F
        .BYTE $55,$55,$55,$55,$57,$57,$57,$57
        .BYTE $0A,$00,$2A,$2A,$A2,$85,$01,$05
        .BYTE $05,$05,$01,$05,$01,$05,$05,$15
        .BYTE $0A,$A8,$A0,$AA,$AA,$42,$40,$40
        .BYTE $00,$40,$40,$40,$40,$00,$40,$50
        .BYTE $00,$0F,$3F,$C3,$00,$00,$00,$00
        .BYTE $00,$00,$C3,$3F,$0F,$00,$00,$00
        .BYTE $00,$00,$C0,$F0,$F0,$FC,$FC,$FC
        .BYTE $FC,$F0,$F0,$C0,$00,$00,$00,$00
        .BYTE $03,$00,$00,$03,$30,$03,$03,$CF
        .BYTE $03,$03,$30,$03,$00,$00,$03,$00
        .BYTE $00,$00,$00,$00,$30,$00,$00,$CC
        .BYTE $00,$00,$30,$00,$00,$00,$00,$00
        .BYTE $C0,$C0,$F0,$F0,$FC,$FC,$FF,$FF
        .BYTE $00,$00,$00,$00,$07,$3C,$E3,$73
        .BYTE $1C,$07,$07,$0D,$D9,$71,$00,$00
        .BYTE $00,$00,$00,$00,$C0,$73,$1E,$38
        .BYTE $E0,$80,$80,$80,$80,$80,$00,$00
        .BYTE $03,$07,$03,$00,$43,$E0,$77,$1F
        .BYTE $13,$1F,$0F,$0B,$0D,$07,$00,$07
        .BYTE $00,$80,$00,$00,$04,$0E,$DC,$F0
        .BYTE $90,$F0,$E0,$A0,$60,$C0,$00,$C0
        .BYTE $0F,$1B,$33,$6B,$7B,$1B,$1B,$38
        .BYTE $71,$60,$C0,$66,$6E,$3C,$0C,$0F
        .BYTE $1E,$33,$6D,$DF,$B0,$B0,$60,$60
        .BYTE $B0,$30,$30,$18,$18,$0C,$06,$FE
        .BYTE $FF,$FF,$C0,$C0,$FC,$FC,$CC,$CC
        .BYTE $FF,$FF,$87,$87,$87,$87,$FF,$FF
        .BYTE $3C,$7C,$9C,$9D,$9B,$93,$E3,$C3
f2540   .BYTE $87,$87,$87,$FF,$FF,$FF,$FF,$87
        .BYTE $FF,$FF,$30,$30,$78,$78,$FC,$FC
        .BYTE $9F,$0F,$06,$00,$00,$06,$0F,$9F
        .BYTE $8F,$8F,$81,$FF,$FF,$81,$F1,$F1
        .BYTE $D4,$CF,$D6,$54,$7D,$7D,$7C,$57
        .BYTE $1C,$1C,$3E,$3E,$7F,$7F,$7F,$77
        .BYTE $63,$63,$E3,$E3,$63,$63,$63,$E3
        .BYTE $0C,$0B,$0E,$0C,$0C,$1C,$78,$70
        .BYTE $00,$00,$80,$80,$00,$00,$00,$80
        .BYTE $00,$FF,$00,$66,$CC,$98,$32,$65
        .BYTE $CB,$97,$37,$67,$CB,$99,$32,$66
        .BYTE $00,$E0,$60,$60,$60,$00,$70,$FC
        .BYTE $BE,$7F,$FF,$FF,$FE,$FC,$70,$00
        .BYTE $7F,$00,$79,$7C,$7E,$7E,$7E,$7E
        .BYTE $6F,$73,$7C,$7F,$7F,$7F,$00,$7F
        .BYTE $FF,$00,$E7,$CF,$9F,$3F,$2F,$1F
        .BYTE $3F,$8F,$1F,$FF,$FF,$FF,$00,$FF
        .BYTE $7F,$7F,$7F,$7F,$7F,$7F,$7F,$7B
        .BYTE $4F,$4F,$7F,$7F,$7F,$7C,$7C,$7F
        .BYTE $FF,$FF,$FF,$E7,$CB,$C3,$67,$FF
        .BYTE $DF,$FF,$BF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$29,$28,$27
        .BYTE $26,$00,$00,$FF,$FF,$FF,$FF,$FF
        .BYTE $00,$00,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $00,$00,$00,$00,$00,$00,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$00,$00,$00
        .BYTE $FF,$FF,$FF,$FF,$00,$00,$00,$FF
        .BYTE $FF,$00,$00,$FF,$00,$00,$FF,$FF
        .BYTE $FF,$00,$FF,$80,$FF,$00,$BF,$00
        .BYTE $FF,$00,$FF,$00,$FF,$00,$BF,$00
        .BYTE $FF,$00,$FF,$00,$FF,$00,$FF,$00
        .BYTE $FF,$00,$FF,$00,$BF,$00,$FF,$10
        .BYTE $BF,$00,$FF,$00,$FF,$00,$FF,$00
        .BYTE $EF,$00,$FF,$00,$FF,$80,$FF,$15
        .BYTE $FF,$00,$FF,$00,$FF,$00,$06,$00
        .BYTE $FF,$00,$FF,$00,$BF,$F9,$BD,$F8
        .BYTE $00,$9D,$00,$B3,$BF,$FF,$1D,$80
        .BYTE $4A,$0C,$00,$8E,$08,$FD,$82,$80
        .BYTE $00,$FF,$00,$BF,$00,$BD,$00,$0A
        .BYTE $02,$99,$00,$FF,$8E,$08,$00,$88
        .BYTE $00,$FF,$00,$FF,$00,$1F,$00,$FF
        .BYTE $00,$FF,$00,$0A,$80,$BD,$00,$FE
        .BYTE $AA,$7F,$00,$FD,$00,$1D,$00,$FF
        .BYTE $14,$BD,$00,$D5,$BD,$00,$BF,$80
        .BYTE $00,$3D,$00,$3C,$00,$FF,$00,$DF
        .BYTE $00,$FF,$00,$FF,$00,$FF,$40,$FF
        .BYTE $00,$FF,$00,$FF,$00,$FF,$00,$FF
        .BYTE $00,$FF,$00,$FF,$42,$BD,$00,$EF
        .BYTE $40,$FF,$00,$FF,$00,$FF,$00,$FF
        .BYTE $10,$FF,$00,$FF,$00,$FF,$00,$AA
        .BYTE $00,$FF,$00,$FF,$00,$FF,$F9,$FF
        .BYTE $00,$BF,$00,$BF,$00,$80,$42,$A7
        .BYTE $FE,$00,$FF,$0C,$D5,$00,$E2,$8A
        .BYTE $B1,$81,$FF,$B1,$F7,$00,$80,$BD
        .BYTE $FF,$00,$FF,$00,$FF,$00,$FF,$00
        .BYTE $FF,$80,$BF,$00,$91,$81,$BF,$A5
        .BYTE $FF,$00,$FF,$00,$FF,$00,$FF,$00
        .BYTE $FF,$00,$FB,$80,$F9,$00,$FF,$01
        .BYTE $9D,$00,$FF,$00,$FF,$00,$FF,$00
        .BYTE $EB,$00,$FF,$80,$01,$BF,$00,$BD
        .BYTE $FF,$00,$FF,$00,$FF,$00,$FF,$00
        .BYTE $FF,$00,$FF,$00,$FF,$00,$BF,$00
        .BYTE $FF,$00,$FF,$00,$FF,$00,$FF,$00
        .BYTE $FF,$00,$FF,$00,$FF,$00,$FF,$10
        .BYTE $BF,$00,$FF,$00,$FF,$00,$FF,$00
        .BYTE $EF,$00,$FF,$00,$FF,$00,$FF,$15
        .BYTE $FF,$00,$FF,$00,$FF,$00,$5F,$00
        .BYTE $FF,$00,$FF,$00,$FF,$B1,$BF,$F8
        .BYTE $00,$BD,$00,$F3,$AA,$FF,$1D,$C0
        .BYTE $4A,$0E,$00,$CE,$08,$FD,$82,$00
        .BYTE $00,$FF,$00,$FF,$00,$BF,$00,$9A
        .BYTE $00,$99,$00,$FF,$8C,$08,$00,$88
        .BYTE $00,$FF,$00,$FF,$00,$BF,$00,$FF
        .BYTE $00,$FD,$00,$1F,$80,$BD,$00,$FE
        .BYTE $02,$FF,$00,$FD,$00,$9D,$00,$FF
        .BYTE $14,$BD,$00,$D5,$BD,$00,$BF,$80
        .BYTE $00,$FF,$00,$BD,$00,$FF,$00,$FF
        .BYTE $00,$FF,$00,$FF,$00,$FF,$40,$FF
        .BYTE $00,$FF,$00,$FF,$00,$FF,$00,$FF
        .BYTE $00,$FF,$00,$FF,$00,$BF,$00,$EF
        .BYTE $40,$FF,$00,$FF,$00,$FF,$00,$FF
        .BYTE $10,$FF,$00,$FF,$00,$FF,$00,$EA
        .BYTE $00,$FF,$00,$FF,$00,$FF,$A0,$FF
        .BYTE $00,$BF,$00,$BF,$00,$80,$40,$A7
        .BYTE $00,$FF,$80,$07,$E1,$F8,$0E,$00
        .BYTE $0E,$1E,$00,$00,$33,$80,$00,$7F
        .BYTE $F0,$00,$F9,$FC,$00,$63,$FE,$00
        .BYTE $07,$7E,$00,$0E,$7F,$00,$0E,$7F
        .BYTE $00,$0C,$7F,$00,$00,$7F,$00,$00
        .BYTE $E3,$80,$00,$E3,$80,$01,$C1,$C0
        .BYTE $01,$C1,$C0,$03,$C0,$E0,$03,$80
        .BYTE $E0,$0F,$81,$E0,$1F,$03,$C0,$9E
        .BYTE $00,$FF,$80,$07,$E1,$F8,$0E,$00
        .BYTE $0E,$1E,$00,$00,$33,$80,$00,$7F
        .BYTE $F0,$00,$F9,$FC,$00,$63,$FE,$00
        .BYTE $07,$7E,$00,$07,$7F,$00,$07,$7F
        .BYTE $00,$03,$7F,$00,$00,$7F,$00,$00
        .BYTE $77,$80,$00,$E7,$80,$00,$E7,$C0
        .BYTE $00,$E1,$F0,$00,$E0,$70,$00,$E0
        .BYTE $F0,$03,$E0,$60,$03,$E0,$00,$9E
        .BYTE $00,$FF,$80,$07,$E1,$F8,$0E,$00
        .BYTE $0E,$1E,$00,$00,$33,$80,$00,$7F
        .BYTE $F0,$00,$F9,$FC,$00,$63,$FE,$00
        .BYTE $03,$7E,$00,$07,$7F,$00,$07,$7F
        .BYTE $00,$06,$7F,$00,$00,$7F,$00,$00
        .BYTE $7F,$00,$00,$FE,$00,$01,$F8,$00
        .BYTE $00,$FF,$00,$00,$3F,$80,$00,$3B
        .BYTE $80,$00,$78,$00,$00,$F8,$00,$9E
        .BYTE $00,$0F,$F8,$00,$FC,$1E,$07,$C0
        .BYTE $00,$0E,$00,$00,$3F,$80,$00,$33
        .BYTE $F0,$00,$7F,$FC,$00,$FB,$FE,$00
        .BYTE $63,$7E,$00,$07,$7F,$00,$0E,$7F
        .BYTE $00,$0C,$7F,$00,$00,$7F,$00,$00
        .BYTE $7F,$00,$00,$FE,$00,$01,$FE,$00
        .BYTE $03,$EE,$00,$1F,$8F,$00,$0F,$07
        .BYTE $00,$06,$07,$00,$00,$0F,$00,$9E
        .BYTE $01,$FF
a2902   .BYTE $00,$1F,$87,$E0,$70,$00,$70,$00
        .BYTE $00,$78,$00,$01,$CC,$00,$0F,$FE
        .BYTE $00,$3F,$9F,$00,$7F,$C6,$00,$7E
        .BYTE $E0,$00,$FE,$70,$00,$FE,$70,$00
        .BYTE $FE,$30,$00,$FE,$00,$01,$C7,$00
        .BYTE $01,$C7,$00,$03,$83,$80,$03,$83
        .BYTE $80,$07,$03,$C0,$07,$01,$C0,$07
        .BYTE $81,$F0,$03,$C0,$F8,$9E,$01,$FF
        .BYTE $00,$1F,$87,$E0,$70,$00,$70,$00
        .BYTE $00,$78,$00,$01,$CC,$00,$0F,$FE
        .BYTE $00,$3F,$9F,$00,$7F,$C6,$00,$7E
        .BYTE $E0,$00,$FE,$E0,$00,$FE,$E0,$00
        .BYTE $FE,$C0,$00,$FE,$00,$01,$EE,$00
        .BYTE $01,$E7,$00,$03,$E7,$00,$0F,$87
        .BYTE $00,$0E,$07,$00,$0F,$07,$00,$06
        .BYTE $07,$C0,$00,$07,$C0,$9E,$01,$FF
        .BYTE $00,$1F,$87,$E0,$70,$00,$70,$00
        .BYTE $00,$78,$00,$01,$CC,$00,$0F,$FE
        .BYTE $00,$3F,$9F,$00,$7F,$C6,$00,$7E
        .BYTE $C0,$00,$FE,$E0,$00,$FE,$E0,$00
        .BYTE $FE,$60,$00,$FE,$00,$00,$FE,$00
        .BYTE $00,$7F,$00,$00,$1F,$80,$00,$FF
        .BYTE $00,$01,$FC,$00,$01,$DC,$00,$00
        .BYTE $1E,$00,$00,$1F,$00,$9E,$1F,$F0
        .BYTE $00,$78,$3F,$00,$00,$03,$E0,$00
        .BYTE $00,$70,$00,$01,$FC,$00,$0F,$CC
        .BYTE $00,$3F,$FE,$00,$7F,$DF,$00,$7E
        .BYTE $C6,$00,$FE,$E0,$00,$FE,$70,$00
        .BYTE $FE,$30,$00,$FE,$00,$00,$FE,$00
        .BYTE $00,$7F,$00,$00,$7F,$80,$00,$77
        .BYTE $C0,$00,$F1,$F8,$00,$E0,$F0,$00
        .BYTE $E0,$60,$00,$F0,$00,$9E,$1F
p2A01   .BYTE $03,$C0,$0F,$81,$E0,$03,$80,$E0
        .BYTE $03,$C0,$E0,$01,$C1,$C0,$01,$C1
        .BYTE $C0,$00,$E3,$80,$00,$E3,$80,$00
        .BYTE $7F,$00,$0C,$7F,$00,$0E,$7F,$00
        .BYTE $0E,$7F,$00,$07,$7E,$00,$63,$FE
        .BYTE $00,$F9,$FC,$00,$7F,$F0,$00,$33
        .BYTE $80,$00,$1E,$00,$00,$0E,$00,$0E
        .BYTE $07,$E1,$F8,$00,$FF,$80,$9E,$03
        .BYTE $E0,$00,$03,$E0,$60,$00,$E0,$F0
        .BYTE $00,$E0,$70,$00,$E1,$F0,$00,$E7
        .BYTE $C0,$00,$E7,$80,$00,$77,$80,$00
        .BYTE $7F,$00,$03,$7F,$00,$07,$7F,$00
        .BYTE $07,$7F,$00,$07,$7E,$00,$63,$FE
        .BYTE $00,$F9,$FC,$00,$7F,$F0,$00,$33
        .BYTE $80,$00,$1E,$00,$00,$0E,$00,$0E
        .BYTE $07,$E1,$F8,$00,$FF,$80,$9E,$00
        .BYTE $F8,$00,$00,$78,$00,$00,$3B,$80
        .BYTE $00,$3F,$80,$00,$FF,$00,$01,$F8
        .BYTE $00,$00,$FE,$00,$00,$7F,$00,$00
        .BYTE $7F,$00,$06,$7F,$00,$07,$7F,$00
        .BYTE $07,$7F,$00,$03,$7E,$00,$63,$FE
        .BYTE $00,$F9,$FC,$00,$7F,$F0,$00,$33
        .BYTE $80,$00,$1E,$00,$00,$0E,$00,$0E
        .BYTE $07,$E1,$F8,$00,$FF,$80,$9E,$00
        .BYTE $0F,$00,$06,$07,$00,$0F,$07,$00
        .BYTE $1F,$8F,$00,$03,$EE,$00,$01,$FE
        .BYTE $00,$00,$FE,$00,$00,$7F,$00,$00
        .BYTE $7F,$00,$0C,$7F,$00,$0E,$7F,$00
        .BYTE $07,$7F,$00,$63,$7E,$00,$FB,$FE
        .BYTE $00,$7F,$FC,$00,$33,$F0,$00,$3F
        .BYTE $80,$00,$0E,$00,$00,$07,$C0,$00
        .BYTE $00,$FC,$1E,$00,$0F,$F8,$9E,$03
        .BYTE $C0,$F8,$07,$81,$F0,$07,$01,$C0
        .BYTE $07,$03,$C0,$03,$83,$80,$03,$83
        .BYTE $80,$01,$C7,$00,$01,$C7,$00,$00
        .BYTE $FE,$00,$00,$FE,$30,$00,$FE,$70
        .BYTE $00,$FE,$70,$00,$7E,$E0,$00,$7F
        .BYTE $C6,$00,$3F,$9F,$00,$0F,$FE,$00
        .BYTE $01,$CC,$00,$00,$78,$70,$00,$70
        .BYTE $1F,$87,$E0,$01,$FF,$00,$9E,$00
        .BYTE $07,$C0,$06,$07,$C0,$0F,$07,$00
        .BYTE $0E,$07,$00,$0F,$87,$00,$03,$E7
        .BYTE $00,$01,$E7,$00,$01,$EE,$00,$00
        .BYTE $FE,$00,$00,$FE,$C0,$00,$FE,$E0
        .BYTE $00,$FE,$E0,$00,$7E,$E0,$00,$7F
        .BYTE $C6,$00,$3F,$9F,$00,$0F,$FE,$00
        .BYTE $01,$CC,$00,$00,$78,$70,$00,$70
        .BYTE $1F,$87,$E0,$01,$FF,$00,$9E,$00
        .BYTE $1F,$00,$00,$1E,$00,$01,$DC,$00
        .BYTE $01,$FC,$00,$00,$FF,$00,$00,$1F
        .BYTE $80,$00,$7F,$00,$00,$FE,$00,$00
        .BYTE $FE,$00,$00,$FE,$60,$00,$FE,$E0
        .BYTE $00,$FE,$E0,$00,$7E,$C0,$00,$7F
        .BYTE $C6,$00,$3F,$9F,$00,$0F,$FE,$00
        .BYTE $01,$0C,$00,$00,$78,$70,$00,$70
        .BYTE $1F,$87,$E0,$01,$FF,$00,$9E,$00
        .BYTE $F0,$00,$00,$E0,$60,$00,$E0,$F0
        .BYTE $00,$F1,$F8,$00,$77,$C0,$00,$7F
        .BYTE $80,$00,$7F,$00,$00,$FE,$00,$00
        .BYTE $FE,$00,$00,$FE,$30,$00,$FE,$70
        .BYTE $00,$FE,$E0,$00,$7E,$C6,$00,$7F
        .BYTE $DF,$00,$3F,$FE,$00,$0F,$CC,$00
        .BYTE $01,$FC,$00,$00,$70,$00,$03,$E0
        .BYTE $78,$3F,$00,$1F,$F0,$00,$9E,$00
        .BYTE $1C,$00,$00,$FF,$80,$03,$DD,$E0
        .BYTE $07,$36,$70,$0C,$36,$18,$0C,$63
        .BYTE $1C,$11,$C1,$C4,$2E,$33,$3A,$DB
        .BYTE $77,$6D,$57,$77,$5C,$6C,$33,$30
        .BYTE $1B,$77,$6C,$3F,$FF,$FC,$20,$80
        .BYTE $86,$18,$C1,$8C,$0C,$C9,$98,$0D
        .BYTE $9C,$D8,$07,$B6,$60,$03,$E3,$E0
        .BYTE $03,$7E,$E0,$02,$1C,$20,$00,$00
        .BYTE $08,$00,$00,$1C,$00,$00,$3A,$00
        .BYTE $00,$7D,$00,$00,$FA,$80,$01,$FD
        .BYTE $40,$03,$FA,$A0,$07,$FD,$50,$0F
        .BYTE $FA,$A8,$1F,$FD,$54,$3F,$FA,$AA
        .BYTE $7F,$FD,$55,$3F,$FA,$AE,$07,$FD
        .BYTE $70,$00,$FB,$80,$00,$1C,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$40
        .BYTE $10,$00,$60,$18,$00,$30,$0C,$00
        .BYTE $18,$0C,$00,$18,$0C,$00,$0C,$0C
        .BYTE $00,$0E,$18,$00,$07,$18,$00,$23
        .BYTE $32,$00,$3B,$37,$00,$2E,$ED,$00
        .BYTE $1F,$FE,$00,$03,$68,$00,$03,$FC
        .BYTE $00,$03,$FE,$00,$01,$FF,$00,$02
        .BYTE $5A,$80,$03,$2F,$80,$07,$91,$00
        .BYTE $0F,$CF,$00,$1F,$E0,$00,$00,$00
        .BYTE $00,$00,$00,$A5,$00,$02,$A5,$40
        .BYTE $02,$A5,$40,$0A,$A5,$50,$0A,$A5
        .BYTE $50,$0A,$BD,$50,$2A,$FF,$54,$2A
        .BYTE $FF,$54,$2A,$C3,$54,$2A,$C3,$54
        .BYTE $2A,$FF,$54,$2A,$FF,$54,$0A,$BD
        .BYTE $50,$0A,$A5,$50,$0A,$A5,$50,$02
        .BYTE $A5,$40,$02,$A5,$40,$00,$A5,$00
        .BYTE $00,$00,$00,$00,$00,$00,$08,$10
        .BYTE $00,$08,$38,$00,$1C,$7C,$00,$3E
        .BYTE $FF,$FF,$FF,$7F,$FF,$FE,$3F,$FF
        .BYTE $FC,$1E,$1F,$F8,$0F,$FC,$30,$0F
        .BYTE $FF,$F0,$0F,$FF,$F0,$0F,$E7,$F0
        .BYTE $0F,$E7,$F0,$0F,$E7,$F0,$0F,$FF
        .BYTE $F0,$07,$FF,$E0,$03,$3C,$C0,$01
        .BYTE $81,$80,$01,$FF,$80,$01,$FF,$80
        .BYTE $00,$FF,$00,$00,$7E,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$07,$81,$F0,$1D,$FF
        .BYTE $FE,$7E,$FF,$FF,$EF,$FF,$FF,$FF
        .BYTE $FF,$FF,$7D,$FF,$FF,$01,$FF,$FC
        .BYTE $01,$80,$E0,$0F,$03,$80,$05,$3B
        .BYTE $E6,$78,$10,$82,$40,$10,$80,$78
        .BYTE $10,$80,$08,$38,$80,$78,$00,$00
        .BYTE $00,$00,$00,$00,$89,$E4,$9C,$89
        .BYTE $24,$92,$51,$24,$92,$21,$24,$9C
        .BYTE $21,$24,$92,$21,$E7,$92,$00,$00
        .BYTE $00,$00,$00,$00,$E7,$A5,$2E,$94
        .BYTE $A5,$A9,$94,$A5,$A9,$E4,$A5,$69
        .BYTE $94,$A5,$69,$97,$BD,$2E,$40,$00
        .BYTE $70,$00,$0A,$AA,$00,$2A,$AA,$80
        .BYTE $28,$AA,$80,$A2,$AA,$A0,$6A,$AA
        .BYTE $A0,$6A,$AA,$A0,$6A,$AA,$A0,$6A
        .BYTE $AA,$A0,$AA,$AA,$A0,$2A,$AA,$80
        .BYTE $2A,$AA,$80,$0A,$AA,$00,$00,$A0
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$82,$00
        .BYTE $A0,$00,$0A,$9F,$00,$2A,$AA,$80
        .BYTE $28,$AA,$80,$A2,$AA,$A0,$5A,$AA
        .BYTE $A0,$DA,$AA,$A0,$DA,$AA,$A0,$5A
        .BYTE $AA,$A0,$AA,$AA,$A0,$2A,$AA,$80
        .BYTE $2A,$AA,$80,$0A,$AA,$00,$00,$A0
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$82,$00
        .BYTE $A0,$00,$0A,$AA,$00,$2A,$AA,$80
        .BYTE $28,$A7,$C0,$A2,$AA,$A0,$56,$AA
        .BYTE $A0,$76,$AA,$A0,$76,$AA,$A0,$56
        .BYTE $AA,$A0,$AA,$AA,$A0,$2A,$AA,$80
        .BYTE $2A,$AA,$80,$0A,$AA,$00,$00,$A0
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$82,$00
        .BYTE $A0,$00,$0A,$AA,$00,$2A,$AA,$80
        .BYTE $28,$AA,$80,$A2,$9F,$F0,$55,$6A
        .BYTE $A0,$7D,$6A,$A0,$7D,$6A,$A0,$55
        .BYTE $6A,$A0,$AA,$AA,$A0,$2A,$AA,$80
        .BYTE $2A,$AA,$80,$0A,$AA,$00,$00,$A0
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$82,$00
        .BYTE $A0,$00,$0A,$AA,$00,$2A,$AA,$80
        .BYTE $28,$AA,$80,$A2,$7F,$F0,$95,$56
        .BYTE $A0,$97,$D6,$A0,$97,$D6,$A0,$95
        .BYTE $56,$A0,$AA,$AA,$A0,$2A,$AA,$80
        .BYTE $2A,$AA,$80,$0A,$AA,$00,$00,$A0
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$82,$00
        .BYTE $A0,$00,$0A,$AA,$00,$2A,$AA,$80
        .BYTE $28,$AA,$80,$A2,$AA,$A0,$A5,$55
        .BYTE $60,$A5,$7D,$60,$A5,$7D,$60,$A5
        .BYTE $55,$60,$FF,$DA,$A0,$2A,$AA,$80
        .BYTE $2A,$AA,$80,$0A,$AA,$00,$00,$A0
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$82,$00
        .BYTE $A0,$00,$0A,$AA,$00,$2A,$AA,$80
        .BYTE $28,$AA,$80,$A2,$AA,$A0,$AA,$95
        .BYTE $50,$AA,$97,$D0,$AA,$97,$D0,$AA
        .BYTE $95,$50,$FF,$6A,$A0,$2A,$AA,$80
        .BYTE $2A,$AA,$80,$0A,$AA,$00,$00,$A0
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$82,$00
        .BYTE $A0,$00,$0A,$AA,$00,$2A,$AA,$80
        .BYTE $28,$AA,$80,$A2,$AA,$A0,$AA,$A5
        .BYTE $50,$AA,$A5,$D0,$AA,$A5,$D0,$AA
        .BYTE $A5,$50,$AA,$AA,$A0,$3D,$AA,$80
        .BYTE $2A,$AA,$80,$0A,$AA,$00,$00,$A0
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$82,$00
        .BYTE $A0,$00,$0A,$AA,$00,$2A,$AA,$80
        .BYTE $28,$AA,$80,$A2,$AA,$A0,$AA,$AA
        .BYTE $50,$AA,$AA,$70,$AA,$AA,$70,$AA
        .BYTE $AA,$50,$AA,$AA,$A0,$2A,$AA,$80
        .BYTE $2A,$AA,$80,$0F,$6A,$00,$00,$A0
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$A7
p3000   .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$60,$00,$00,$F0,$00,$7C,$3C
        .BYTE $F9,$F8,$0F,$FF,$E0,$07,$FF,$80
        .BYTE $07,$FF,$80,$07,$FF,$80,$07,$FF
        .BYTE $80,$03,$FF,$80,$01,$FF,$00,$01
        .BYTE $FF,$00,$01,$FF,$00,$01,$FF,$00
        .BYTE $01,$FF,$00,$01,$FF,$00,$01,$FF
        .BYTE $00,$01,$FF,$80,$00,$FF,$80,$40
        .BYTE $00,$00,$00,$00,$00,$00,$60,$00
        .BYTE $07,$3C,$7C,$7E,$1F,$FF,$F0,$07
        .BYTE $FF,$C0,$03,$FF,$C0,$03,$FF,$C0
        .BYTE $03,$FF,$C0,$01,$FF,$C0,$00,$FF
        .BYTE $80,$00,$FF,$80,$00,$FF,$80,$00
        .BYTE $FF,$80,$00,$FF,$80,$00,$FF,$80
        .BYTE $00,$FF,$80,$00,$FF,$80,$00,$FF
        .BYTE $80,$00,$FF,$80,$00,$FF,$80,$40
        .BYTE $00,$00,$00,$00,$00,$0C,$38,$00
        .BYTE $1C,$1E,$7C,$7C,$0F,$FF,$F0,$07
        .BYTE $FF,$C0,$03,$FF,$C0,$03,$FF,$C0
        .BYTE $03,$FF,$C0,$01,$FF,$C0,$00,$FF
        .BYTE $80,$00,$FF,$80,$00,$FF,$80,$00
        .BYTE $FF,$80,$00,$FF,$80,$00,$FF,$80
        .BYTE $00,$FF,$80,$00,$FF,$80,$00,$FF
        .BYTE $80,$00,$FF,$80,$00,$FF,$80,$40
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $0C,$0C,$00,$0C,$0E,$00,$1C,$07
        .BYTE $3E,$38,$07,$FF,$F0,$03,$FF,$E0
        .BYTE $01,$FF,$E0,$01,$FF,$E0,$01,$FF
        .BYTE $E0,$00,$FF,$E0,$00,$7F,$C0,$00
        .BYTE $7F,$C0,$00,$7F,$C0,$00,$7F,$C0
        .BYTE $00,$7F,$C0,$00,$7F,$C0,$00,$7F
        .BYTE $C0,$00,$FF,$80,$00,$FF,$80,$40
        .BYTE $00,$FF,$80,$00,$FF,$80,$00,$FF
        .BYTE $80,$00,$FF,$80,$00,$FF,$80,$00
        .BYTE $FF,$80,$00,$FF,$80,$00,$FF,$80
        .BYTE $00,$FF,$80,$00,$FF,$80,$01,$FF
        .BYTE $C0,$01,$FF,$C0,$03,$FF,$E0,$03
        .BYTE $FF,$E0,$07,$FF,$F0,$0F,$FF,$F8
        .BYTE $1F,$FF,$FC,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$40
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$18,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$18,$00
        .BYTE $00,$3C,$00,$00,$18,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$18,$00,$00,$3C,$00
        .BYTE $00,$7E,$00,$00,$3C,$00,$00,$18
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$3C,$00,$00,$7E,$00
        .BYTE $00,$7E,$00,$00,$7E,$00,$00,$3C
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $3C,$00,$00,$7E,$00,$00,$FF,$00
        .BYTE $00,$FF,$00,$00,$FF,$00,$00,$7E
        .BYTE $00,$00,$3C,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$18,$00,$00
        .BYTE $7E,$00,$00,$FF,$00,$01,$FF,$80
        .BYTE $01,$FF,$80,$01,$FF,$80,$00,$FF
        .BYTE $00,$00,$7E,$00,$00,$18,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$3C,$00,$00
        .BYTE $FF,$00,$01,$FF,$80,$03,$FF,$C0
        .BYTE $03,$FF,$C0,$03,$FF,$C0,$01,$FF
        .BYTE $80,$00,$FF,$00,$00,$3C,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$7E,$00,$01
        .BYTE $FF,$80,$03,$FF,$C0,$07,$FF,$E0
        .BYTE $07,$FF,$E0,$07,$FF,$E0,$03,$FF
        .BYTE $C0,$01,$FF,$80,$00,$7E,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$3C,$00,$00,$FF,$00,$03
        .BYTE $FF,$C0,$07,$FF,$E0,$0F,$FF,$F0
        .BYTE $0F,$FF,$F0,$0F,$FF,$F0,$07,$FF
        .BYTE $E0,$03,$FF,$C0,$00,$FF,$00,$00
        .BYTE $3C,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$7E,$00,$01,$FF,$80,$07
        .BYTE $FF,$E0,$0F,$FF,$F0,$1F,$FF,$F8
        .BYTE $1F,$FF,$F8,$1F,$FF,$F8,$0F,$FF
        .BYTE $F0,$07,$FF,$E0,$01,$FF,$80,$00
        .BYTE $7E,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$3C
        .BYTE $00,$01,$FF,$80,$07,$FF,$E0,$0F
        .BYTE $FF,$F0,$1F,$FF,$F8,$3F,$FF,$FC
        .BYTE $3F,$FF,$FC,$3F,$FF,$FC,$1F,$FF
        .BYTE $F8,$0F,$FF,$F0,$07,$FF,$E0,$01
        .BYTE $FF,$80,$00,$3C,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$7E
        .BYTE $00,$03,$FF,$C0,$0F,$FF,$F0,$1F
        .BYTE $FF,$F8,$3F,$FF,$FC,$7F,$FF,$FE
        .BYTE $7F,$FF,$FE,$7F,$FF,$FE,$3F,$FF
        .BYTE $FC,$1F,$FF,$F8,$0F,$FF,$F0,$03
        .BYTE $FF,$C0,$00,$7E,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$18,$00,$00,$FF
        .BYTE $00,$07,$FF,$E0,$1F,$FF,$F8,$3F
        .BYTE $FF,$FC,$7F,$FF,$FE,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$7F,$FF
        .BYTE $FE,$3F,$FF,$FC,$1F,$FF,$F8,$07
        .BYTE $FF,$E0,$00,$FF,$00,$00,$18,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $03,$7E,$C0,$0F,$7E,$F8,$3F,$7E
        .BYTE $FC,$7F,$00,$FE,$7F,$00,$FE,$FF
        .BYTE $00,$FF,$FF,$00,$FF,$00,$06,$00
        .BYTE $07,$30,$E0,$07,$00,$E0,$07,$0C
        .BYTE $E0,$07,$60,$E0,$07,$00,$E0,$00
        .BYTE $18,$00,$FF,$00,$FF,$FF,$00,$FF
        .BYTE $7F,$00,$FE,$7F,$00,$FC,$3F,$7E
        .BYTE $F8,$0F,$7E,$F0,$03,$7E,$C0,$BD
        .BYTE $00,$00,$00,$01,$BD,$80,$07,$BD
        .BYTE $F0,$1F,$BD,$F8,$3F,$81,$F8,$3F
        .BYTE $81,$FC,$7F,$81,$FE,$7F,$B1,$FE
        .BYTE $00,$00,$00,$03,$99,$C0,$03,$81
        .BYTE $C0,$03,$B1,$C0,$00,$00,$00,$7F
        .BYTE $8D,$FE,$7F,$81,$FE,$3F,$81,$FC
        .BYTE $3F,$81,$FC,$1F,$BD,$F8,$07,$BD
        .BYTE $E0,$01,$BD,$80,$00,$00,$00,$BD
        .BYTE $00,$00,$00,$00,$00,$00,$01,$BD
        .BYTE $80,$07,$BD,$E0,$1F,$81,$F8,$1F
        .BYTE $81,$F8,$3F,$81,$FC,$3F,$81,$FC
        .BYTE $00,$0C,$00,$01,$81,$80,$01,$B1
        .BYTE $80,$01,$81,$80,$00,$0C,$00,$3F
        .BYTE $81,$FC,$3F,$B1,$FC,$1F,$81,$F8
        .BYTE $1F,$81,$F0,$0F,$BD,$E0,$01,$BD
        .BYTE $80,$00,$00,$00,$00,$00,$00,$BD
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$01,$BD,$80,$07,$BD,$E0,$0F
        .BYTE $81,$F0,$1F,$87,$F8,$1F,$81,$F8
        .BYTE $00,$18,$00,$01,$81,$80,$01,$81
        .BYTE $80,$01,$81,$80,$00,$0C,$00,$1F
        .BYTE $81,$F8,$1F,$99,$F8,$0F,$81,$F0
        .BYTE $07,$BD,$E0,$01,$BD,$80,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$BD
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$DB,$00,$03
        .BYTE $C3,$C0,$07,$C3,$E0,$0F,$CB,$F0
        .BYTE $0F,$C3,$F0,$00,$10,$00,$00,$C3
        .BYTE $00,$00,$00,$00,$0F,$CB,$F0,$0F
        .BYTE $C3,$F0,$07,$D3,$E0,$03,$C3,$C0
        .BYTE $00,$DB,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$BD
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $DB,$00,$03,$C3,$C0,$07,$C3,$E0
        .BYTE $07,$D3,$E0,$00,$00,$00,$00,$CB
        .BYTE $00,$00,$00,$00,$07,$D3,$E0,$07
        .BYTE $C3,$E0,$03,$C3,$C0,$00,$DB,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$BD
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$66,$00,$01,$E7,$80
        .BYTE $03,$E7,$C0,$03,$E7,$C0,$00,$00
        .BYTE $00,$03,$E7,$C0,$03,$E7,$C0,$01
        .BYTE $E7,$80,$00,$66,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$BD
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$66,$00
        .BYTE $00,$E7,$00,$01,$E7,$80,$00,$00
        .BYTE $00,$01,$E7,$80,$00,$E7,$00,$00
        .BYTE $66,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$BD
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$36,$00,$00,$77,$00,$00,$00
        .BYTE $00,$00,$77,$00,$00,$36,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$BD
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$36,$00,$00,$00
        .BYTE $00,$00,$36,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$BD
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$14,$00,$00,$14
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$BD
        .BYTE $01,$80,$30,$03,$C0,$1E,$07,$E0
        .BYTE $17,$07,$E0,$3E,$0F,$F0,$38,$1F
        .BYTE $F0,$38,$1F,$F8,$38,$3F,$F8,$78
        .BYTE $7F,$FC,$F0,$FB,$FF,$F0,$BD,$FF
        .BYTE $E0,$BC,$3F,$80,$3A,$0E,$00,$76
        .BYTE $07,$00,$73,$0B,$00,$61,$99,$80
        .BYTE $61,$98,$C0,$63,$30,$C0,$63,$19
        .BYTE $80,$63,$0D,$80,$73,$8D,$C0,$00
        .BYTE $03,$00,$60,$07,$80,$3C,$0F,$C0
        .BYTE $2E,$0F,$C0,$7C,$1F,$E0,$70,$1F
        .BYTE $F0,$70,$3F,$F8,$38,$3F,$F8,$78
        .BYTE $7F,$FC,$F0,$FB,$FF,$F0,$B9,$FF
        .BYTE $E0,$BC,$3F,$80,$78,$0E,$00,$E6
        .BYTE $06,$00,$E6,$1B,$00,$C3,$33,$00
        .BYTE $C3,$31,$80,$C6,$31,$80,$C6,$33
        .BYTE $00,$66,$1B,$00,$27,$03,$80,$00
        .BYTE $06,$00,$C0,$0F,$00,$78,$0F,$80
        .BYTE $5C,$0F,$C0,$78,$1F,$E0,$70,$1F
        .BYTE $F0,$70,$3F,$F8,$70,$3F,$F8,$78
        .BYTE $7F,$FC,$F8,$FB,$FF,$F0,$B9,$FF
        .BYTE $E0,$3C,$3F,$80,$F8,$0E,$00,$E6
        .BYTE $06,$00,$C6,$16,$00,$C6,$1B,$00
        .BYTE $66,$1B,$00,$66,$13,$00,$76,$16
        .BYTE $00,$34,$06,$00,$0C,$07,$00,$00
        .BYTE $0C,$03,$00,$0F,$01,$F0,$1F,$81
        .BYTE $B8,$1F,$C1,$F0,$1F,$E0,$E0,$1F
        .BYTE $F0,$70,$3F,$F0,$70,$3F,$F8,$78
        .BYTE $7F,$FE,$F8,$FB,$FF,$F0,$B9,$FF
        .BYTE $E0,$3C,$3F,$80,$78,$0E,$00,$76
        .BYTE $06,$80,$E6,$06,$80,$E6,$06,$00
        .BYTE $66,$16,$00,$66,$16,$00,$36,$16
        .BYTE $00,$34,$06,$00,$04,$07,$00,$00
        .BYTE $06,$00,$C0,$0F,$00,$78,$0F,$80
        .BYTE $5C,$0F,$C0,$78,$1F,$E0,$70,$1F
        .BYTE $F0,$70,$3F,$F8,$70,$3F,$F8,$78
        .BYTE $7F,$FC,$F8,$FB,$FF,$F0,$BC,$7F
        .BYTE $E0,$BE,$3F,$80,$7C,$0E,$00,$30
        .BYTE $06,$80,$1C,$06,$C0,$0C,$06,$C0
        .BYTE $2C,$16,$80,$36,$16,$00,$33,$06
        .BYTE $00,$30,$06,$00,$38,$07,$00,$00
        .BYTE $03,$00,$60,$07,$80,$3C,$0F,$C0
        .BYTE $2E,$0F,$C0,$7C,$1F,$E0,$70,$1F
        .BYTE $F0,$70,$3F,$F8,$38,$3F,$F8,$78
        .BYTE $7F,$FC,$F0,$FB,$FF,$F0,$BD,$FF
        .BYTE $E0,$BE,$3F,$80,$3C,$0E,$00,$38
        .BYTE $06,$80,$1C,$06,$80,$0E,$0C,$C0
        .BYTE $23,$0E,$C0,$61,$8D,$80,$61,$CD
        .BYTE $00,$60,$06,$00,$70,$07,$00,$00
        .BYTE $01,$80,$30,$03,$C0,$1E,$07,$E0
        .BYTE $17,$07,$E0,$3E,$0F,$F0,$38,$1F
        .BYTE $F0,$38,$1F,$F8,$38,$3F,$F8,$78
        .BYTE $7F,$FC,$F0,$FB,$FF,$F0,$BD,$FF
        .BYTE $E0,$BE,$3F,$80,$3E,$0E,$00,$1E
        .BYTE $06,$80,$1C,$06,$80,$26,$0C,$C0
        .BYTE $73,$0E,$C0,$63,$0C,$C0,$61,$8C
        .BYTE $60,$61,$8C,$60,$70,$EE,$30,$00
        .BYTE $01,$80,$60,$07,$C0,$3C,$07,$C0
        .BYTE $2E,$0F,$E0,$7C,$0F,$E0,$70,$1F
        .BYTE $F0,$70,$3F,$F0,$38,$3F,$F8,$78
        .BYTE $7F,$FC,$F0,$FB,$FF,$F0,$BD,$FF
        .BYTE $E0,$BE,$3F,$80,$3E,$0E,$00,$1E
        .BYTE $06,$80,$5C,$06,$80,$66,$0C,$80
        .BYTE $66,$1C,$C0,$C3,$18,$C0,$C3,$18
        .BYTE $C0,$C3,$0D,$80,$E1,$8E,$C0,$00
        .BYTE $00,$C0,$C0,$03,$C0,$78,$07,$E0
        .BYTE $5C,$07,$E0,$F8,$0F,$E0,$E0,$0F
        .BYTE $F0,$70,$1F,$F0,$38,$3F,$F8,$78
        .BYTE $7F,$FC,$F0,$FB,$FF,$F0,$BD,$FF
        .BYTE $E0,$BE,$3F,$80,$3E,$0E,$00,$1E
        .BYTE $06,$80,$5C,$0E,$80,$DC,$1C,$80
        .BYTE $CC,$1C,$C0,$CC,$18,$C0,$E6,$31
        .BYTE $80,$66,$1B,$00,$07,$03,$C0,$00
        .BYTE $00,$61,$80,$01,$E0,$F8,$03,$F0
        .BYTE $5C,$07,$F0,$F8,$0F,$F0,$E0,$0F
        .BYTE $F8,$E0,$1F,$F8,$70,$3F,$FC,$78
        .BYTE $7F,$FE,$F0,$FB,$FF,$F0,$BD,$FF
        .BYTE $E0,$BE,$3F,$80,$3E,$0F,$00,$1E
        .BYTE $07,$00,$5C,$07,$00,$DC,$07,$00
        .BYTE $58,$06,$00,$58,$06,$00,$0C,$0B
        .BYTE $00,$0C,$0C,$00,$0E,$0E,$00,$00
        .BYTE $00,$C0,$C0,$03,$C0,$78,$07,$E0
        .BYTE $5C,$07,$E0,$F8,$0F,$E0,$E0,$0F
        .BYTE $F0,$70,$1F,$F0,$38,$3F,$F8,$78
        .BYTE $7F,$FC,$F0,$FB,$FF,$F0,$BD,$FF
        .BYTE $E0,$BE,$3F,$80,$3E,$07,$00,$1E
        .BYTE $03,$00,$1C,$01,$80,$3D,$03,$80
        .BYTE $31,$0B,$00,$30,$0B,$00,$18,$0B
        .BYTE $C0,$18,$0C,$00,$1C,$0E,$00,$00
        .BYTE $01,$80,$60,$07,$C0,$3C,$07,$C0
        .BYTE $2E,$0F,$E0,$7C,$0F,$E0,$70,$1F
        .BYTE $F0,$70,$3F,$F0,$38,$3F,$F8,$78
        .BYTE $7F,$FC,$F0,$FB,$FF,$F0,$BD,$FF
        .BYTE $E0,$BE,$3F,$80,$3E,$03,$00,$1E
        .BYTE $03,$80,$1C,$05,$80,$3D,$0D,$C0
        .BYTE $33,$0C,$C0,$33,$0C,$C0,$33,$8C
        .BYTE $C0,$30,$0C,$60,$38,$0E,$F0,$00
        .BYTE $01,$80,$30,$03,$C0,$1E,$07,$E0
        .BYTE $17,$07,$E0,$3E,$0F,$F0,$38,$1F
        .BYTE $F0,$38,$1F,$F8,$38,$3F,$F8,$78
        .BYTE $7F,$FC,$F0,$FB,$FF,$F0,$BD,$FF
        .BYTE $E0,$BE,$3F,$80,$3E,$03,$00,$1E
        .BYTE $0B,$80,$1C,$0D,$80,$39,$0D,$C0
        .BYTE $33,$18,$C0,$31,$98,$C0,$31,$98
        .BYTE $C0,$31,$8C,$60,$39,$CE,$F0,$00
        .BYTE $01,$80,$30,$03,$C0,$1E,$07,$E0
        .BYTE $17,$07,$E0,$3E,$0F,$F0,$38,$1F
        .BYTE $F0,$38,$1F,$F8,$38,$3F,$F8,$78
        .BYTE $7F,$FC,$F0,$FB,$FF,$F0,$BD,$FF
        .BYTE $C0,$3C,$3F,$00,$3A,$0E,$00,$76
        .BYTE $07,$00,$76,$03,$40,$6C,$01,$B0
        .BYTE $CC,$00,$D8,$CC,$00,$6C,$CC,$00
        .BYTE $36,$CC,$00,$37,$66,$00,$10,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$61
        .BYTE $80,$01,$E0,$F8,$03,$F0,$5C,$07
        .BYTE $F0,$F8,$0F,$F0,$E0,$0F,$F8,$E0
        .BYTE $1F,$F8,$70,$3F,$FC,$78,$7F,$FE
        .BYTE $F0,$FB,$FF,$F0,$BD,$FF
a3AE6   .BYTE $E0,$BE,$07,$80,$1F,$0B,$00,$07
        .BYTE $1D,$80,$06,$18,$C0,$0D,$30,$C0
        .BYTE $1B,$30,$60,$33,$30,$30,$3B,$B8
        .BYTE $38,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$01,$C3
        .BYTE $00,$03,$E1,$F0,$03,$E0,$BC,$07
        .BYTE $F0,$F8,$0F,$F0,$E8,$0F,$F8,$E0
        .BYTE $1F,$F8,$70,$3F,$FC,$78,$7F,$FE
        .BYTE $F0,$FB,$FF,$F0,$FE,$FF,$C0,$BF
        .BYTE $1F,$00,$9F,$0E,$00,$9E,$33,$80
        .BYTE $78,$61,$C0,$F4,$C0,$70,$CE,$C0
        .BYTE $1C,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$01
        .BYTE $C3,$00,$03,$E1,$FC,$03,$E0,$DE
        .BYTE $07,$F0,$FC,$0F,$F0,$E6,$0F,$F8
        .BYTE $E0,$1F,$F8,$70,$3F,$FC,$78,$7F
        .BYTE $FE,$F0,$FB,$FF,$F0,$BE,$FF,$C0
        .BYTE $BF,$7F,$C0,$46,$F8,$F1,$7E,$C0
        .BYTE $3F,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$18,$01
        .BYTE $C0,$30,$03,$E6,$FE,$03,$E3,$BC
        .BYTE $07,$F0,$F0,$0F,$F0,$E0,$0F,$F8
        .BYTE $E0,$1F,$F8,$70,$3F,$FC,$78,$7F
        .BYTE $FE,$F0,$FB,$FF,$F0,$BE,$FF,$C0
        .BYTE $BF,$7F,$C0,$46,$F8,$F1,$7E,$C0
        .BYTE $3F,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$60,$00,$00,$C8,$01
        .BYTE $C0,$DC,$03,$E1,$F8,$03,$E7,$60
        .BYTE $07,$E1,$E0,$0F,$F0,$E0,$0F,$F8
        .BYTE $F0,$1F,$F8,$70,$3F,$FC,$78,$7F
        .BYTE $FE,$F0,$FB,$FF,$F0,$BE,$FF,$C0
        .BYTE $BF,$7F,$C0,$46,$F8,$F1,$7E,$C0
        .BYTE $3F,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$03,$00,$00,$0F,$00,$00
        .BYTE $3B,$00,$F0,$EB,$03,$FF,$EB,$0E
        .BYTE $FA,$AB,$FE,$AA,$AF,$0F,$EF,$BC
        .BYTE $00,$FF,$C0,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $C0,$00,$00,$F0,$00,$00,$EC,$00
        .BYTE $00,$EB,$0F,$00,$EB,$FF,$C0,$EA
        .BYTE $AF,$B0,$FA,$AA,$BF,$3E,$AB,$F0
        .BYTE $03,$FF,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$9E,$79,$E7,$79,$E7,$9E
        .BYTE $E7,$9E,$79,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$BD,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$E7,$9E,$79,$9E,$79,$E7
        .BYTE $79,$E7,$9E,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$BD,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$79,$E7,$9E,$E7,$9E,$79
        .BYTE $9E,$79,$E7,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$BD,$31,$C7,$1C,$73,$2C,$B2
        .BYTE $F3,$2C,$B2,$33,$2C,$B2,$33,$2C
        .BYTE $B2,$33,$2C,$B2,$33,$2C,$B2,$F9
        .BYTE $C7,$1C,$00,$00,$00,$00,$10,$00
        .BYTE $00,$10,$00,$00,$00,$00,$01,$93
        .BYTE $00,$03,$01,$80,$01,$BB,$00,$00
        .BYTE $FE,$00,$00,$54,$00,$00,$7C,$00
        .BYTE $00,$7C,$00,$00,$38,$00,$00,$00
        .BYTE $00,$00,$03,$C3,$C0,$00,$00,$00
        .BYTE $06,$00,$60,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $C3,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$C3
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $06,$00,$60,$00,$00,$00,$03,$C3
        .BYTE $C0,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$40,$00,$04,$01
        .BYTE $00,$00,$00,$00,$00,$C0,$10,$10
        .BYTE $0C,$C0,$03,$3E,$00,$00,$2A,$C0
        .BYTE $10,$AA,$F4,$03,$AA,$C0,$00,$EE
        .BYTE $00,$00,$F6,$D0,$00,$00,$00,$04
        .BYTE $0C,$40,$00,$40,$00,$00,$04,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$FF,$00,$00,$00,$00,$00,$00
        .BYTE $01,$00,$00,$10,$41,$00,$04,$01
        .BYTE $00,$00,$00,$04,$40,$FF,$10,$13
        .BYTE $AF,$C0,$02,$AA,$C0,$0E,$AA,$80
        .BYTE $5E,$AA,$F5,$0E,$AA,$C0,$0E,$AA
        .BYTE $C0,$03,$AA,$D0,$00,$FB,$C4,$04
        .BYTE $0F,$00,$10,$40,$00,$00,$04,$10
        .BYTE $01,$00,$00,$00,$04,$00,$00,$00
        .BYTE $00,$FF,$01,$00,$00,$40,$01,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $01,$00,$FF,$C0,$0F,$FF,$F0,$0F
        .BYTE $AA,$F0,$3E,$AA,$B0,$3A,$A2,$BC
        .BYTE $3A,$2A,$AC,$3A,$AA,$BC,$0E,$8A
        .BYTE $B0,$0F,$AA,$F0,$03,$FB,$C0,$00
        .BYTE $FF,$01,$00,$00,$00,$40,$00,$00
        .BYTE $00,$00,$00,$04,$00,$04,$00,$04
        .BYTE $00,$FF,$0F,$0C,$C0,$30,$03,$00
        .BYTE $3C,$03,$00,$0F,$0F,$03,$0F,$3C
        .BYTE $0C,$03,$FF,$CC,$0F,$BB,$F0,$CE
        .BYTE $28,$F0,$FA,$AA,$B0,$FA,$82,$BC
        .BYTE $3A,$00,$AF,$3A,$82,$BC,$CC,$8A
        .BYTE $30,$0F,$AA,$FF,$3F,$EA,$C3,$C0
        .BYTE $EF,$30,$00,$3F,$3C,$00,$FC,$0C
        .BYTE $C3,$C0,$30,$3F,$00,$C0,$00,$00
        .BYTE $30,$FF,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$0E
        .BYTE $00,$E0,$1F,$FF,$F0,$1F,$FF,$F0
        .BYTE $0E,$00,$E0,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$FF,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$07,$00
        .BYTE $00,$0F,$80,$00,$0F,$80,$00,$07
        .BYTE $C0,$00,$00,$F0,$00,$00,$3C,$00
        .BYTE $00,$0F,$C0,$00,$03,$E0,$00,$03
        .BYTE $E0,$00,$01,$C0,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$FF,$00,$00,$00,$00,$00,$00
        .BYTE $00,$70,$00,$00,$F8,$00,$00,$F8
        .BYTE $00,$00,$70,$00,$00,$70,$00,$00
        .BYTE $70,$00,$00,$70,$00,$00,$70,$00
        .BYTE $00,$70,$00,$00,$70,$00,$00,$70
        .BYTE $00,$00,$F8,$00,$00,$F8,$00,$00
        .BYTE $70,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$FF,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$01
        .BYTE $C0,$00,$03,$E0,$00,$03,$E0,$00
        .BYTE $0F,$C0,$00,$3C,$00,$00,$F0,$00
        .BYTE $07,$C0,$00,$0F,$80,$00,$0F,$80
        .BYTE $00,$07,$00
a3FA9   .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$FF,$31
        .BYTE $83,$6C,$52,$44,$92,$12,$44,$92
        .BYTE $12,$44,$92,$12,$44,$92,$7B,$C7
        .BYTE $FE,$79,$93,$6C,$00,$20,$00,$00
        .BYTE $00,$00,$00,$00,$00,$0F,$01,$E0
        .BYTE $11,$83,$10,$00,$C6,$00,$06,$EE
        .BYTE $C0,$03,$FF,$C0,$01,$BB,$00,$00
        .BYTE $FE,$00,$00,$FE,$00,$00,$7C,$00
        .BYTE $00,$6C,$00,$00,$38,$00,$A5,$A9
        .BYTE $0F,$8D,$18,$D4,$4C,$B0
f4007   .BYTE $41
f4008   .BYTE $00
f4009   .BYTE $0F
f400A   .BYTE $DD
f400B   .BYTE $01
f400C   .BYTE $80
f400D   .BYTE $81
f400E   .BYTE $06
f400F   .BYTE $02
f4010   .BYTE $00
f4011   .BYTE $01
f4012   .BYTE $80
f4013   .BYTE $03
f4014   .BYTE $05
f4015   .BYTE $10
f4016   .BYTE $00
f4017   .BYTE $01
f4018   .BYTE $00
f4019   .BYTE $00
f401A   .BYTE $00,$0F,$FF,$02,$60,$21,$03,$05
        .BYTE $00,$08,$80,$80,$FC,$10,$00,$08
        .BYTE $20
f402B   .BYTE $06
f402C   .BYTE $00,$0F,$FF,$03,$60,$21,$03,$05
        .BYTE $00,$08,$80,$80,$FC,$10,$00,$08
        .BYTE $20,$06
a403E   .BYTE $FF
a403F   .BYTE $00
a4040   .BYTE $00
a4041   .BYTE $00
f4042   .BYTE $00
a4043   .BYTE $70
f4044   .BYTE $00
f4045   .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00
f404E   .BYTE $FF
f404F   .BYTE $00
f4050   .BYTE $00
f4051   .BYTE $00,$01
f4053   .BYTE $70,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00
a405E   .BYTE $30,$60
a4060   .BYTE $01,$C0,$02,$70
a4064   .BYTE $30
a4065   .BYTE $0C,$04,$04,$00,$01,$01,$00,$00
        .BYTE $00,$32,$60,$08,$C1,$03,$70,$28
        .BYTE $03,$FD,$02,$02,$00,$00,$00,$00
        .BYTE $00,$34,$60,$07,$C2,$04,$70,$20
        .BYTE $06,$FD,$02,$02,$00,$00,$00,$00
        .BYTE $00,$36,$60,$05,$C3,$05,$70,$18
        .BYTE $09,$FD,$02,$02,$00,$00,$00,$00
        .BYTE $00,$38,$60,$0E,$C0,$06,$70,$10
        .BYTE $0C,$FD,$02,$02,$00,$00,$00,$00
        .BYTE $00,$3A,$60,$04,$C2,$07,$70,$08
        .BYTE $13,$FD,$02,$02,$00,$00,$00,$00
        .BYTE $00
f40BE   .BYTE $3E,$4E,$5E,$6E,$7E,$8E,$9E,$AE
f40C6   .BYTE $40,$40,$40,$40,$40,$40,$40,$40
f40CE   .BYTE $01,$02,$04,$08,$10,$20,$40,$80
a40D6   .BYTE $08
a40D7   .BYTE $03
a40D8   .BYTE $00
selectedSubGame   .BYTE $02
f40DA   .BYTE $02,$08,$07
f40DD   .BYTE $05,$0E,$04,$06,$00,$00,$06
f40E4   .BYTE $04,$0E,$05,$07,$08,$02
f40EA   .BYTE $01,$01,$0F,$0F,$0C,$0C,$0B,$0B
        .BYTE $0B,$0B,$0C,$0C,$0F,$0F,$01
f40F9   .BYTE $01
f40FA   .BYTE $00
f40FB   .BYTE $06,$02,$04,$05,$03,$07,$01,$01
        .BYTE $07,$03,$05,$04,$02,$06,$00
f410A   .BYTE $55
a410B   .BYTE $55
a410C   .BYTE $22,$22,$22,$22,$46,$46,$46,$46
        .BYTE $46,$46
f4116   .BYTE $C0
a4117   .BYTE $C0
a4118   .BYTE $C3,$C3,$C3,$C3,$42,$42,$42,$42
        .BYTE $42,$42
f4122   .BYTE $E0,$FF,$C0,$FF,$A0,$C0,$FF
;-------------------------------
; s4129
;-------------------------------
s4129   
        JMP j47BB

;-------------------------------
; s412C
;-------------------------------
s412C   
        JMP j4677

;-------------------------------
; stroboscopeOnOff
;-------------------------------
stroboscopeOnOff   
        JMP j542B

j4132   JMP j4246

;-------------------------------
; s4135
;-------------------------------
s4135   
        JMP j4C40

;-------------------------------
; s4138
;-------------------------------
s4138   
        JMP j59ED

;-------------------------------
; s413B
;-------------------------------
s413B   
        JMP CheckSubGameSelection

j413E   JMP j578A

a4142   =*+$01
a4141   BRK #$01
;-------------------------------
; s4143
;-------------------------------
s4143   
        LDA #>SCREEN_RAM + $0000
        STA a03
        LDA #<SCREEN_RAM + $0000
        STA a02
        LDX #$00
b414D   LDA a02
        STA $0340,X
        LDA a03
        STA $0360,X
        LDA a02
        CLC 
        ADC #$28
        STA a02
        LDA a03
        ADC #$00
        STA a03
        INX 
        CPX #$1A
        BNE b414D
        RTS 

;-------------------------------
; s416A
;-------------------------------
s416A   
        LDX #$00
b416C   LDA #$20
        STA SCREEN_RAM + $0000,X
        STA SCREEN_RAM + $0100,X
        STA SCREEN_RAM + $0200,X
        STA SCREEN_RAM + $0300,X
        LDA #$01
        STA $DAF0,X
        DEX 
        BNE b416C
        RTS 

;-------------------------------
; s4183
;-------------------------------
s4183   
        LDX a05
        LDY a04
        LDA $0340,X
        STA a02
        LDA $0360,X
        STA a03
        RTS 

;-------------------------------
; s4192
;-------------------------------
s4192   
        JSR s4183
        LDA (p02),Y
        RTS 

;-------------------------------
; s4198
;-------------------------------
s4198   
        JSR s4183
        LDA a07
        STA (p02),Y
        LDA a03
        PHA 
        CLC 
        ADC #$D4
        STA a03
        LDA a06
        STA (p02),Y
        PLA 
        STA a03
        RTS 

a41AF   .BYTE $27
;41B0
        JSR s4143
        JSR s416A
        JSR s574D
        LDA $D016    ;VIC Control Register 2
        AND #$F0
        STA $D016    ;VIC Control Register 2
        JSR s4B1B
        JSR s41EC
        LDA #$18
        STA $D018    ;VIC Memory Control Register
        LDA #$00
        STA $D020    ;Border Color
        STA $D021    ;Background Color 0
        STA $D400    ;Voice 1: Frequency Control - Low-Byte
        LDA #$04
        STA $D407    ;Voice 2: Frequency Control - Low-Byte
        LDA #$08
        STA $D40E    ;Voice 3: Frequency Control - Low-Byte
        LDA #$02
        STA selectedSubGame
        JSR s4BC9
        JMP TitleScreenLoop

;-------------------------------
; s41EC
;-------------------------------
s41EC   
        SEI 
        LDA #$7F
        STA $DC0D    ;CIA1: CIA Interrupt Control Register
        LDA #<p422D
        STA $0314    ;IRQ
        LDA #>p422D
        STA $0315    ;IRQ
        LDA #$00
        STA a0A
        JSR s420C
        JSR s4572
        LDA #$01
        STA $D01A    ;VIC Interrupt Mask Register (IMR)
        RTS 

;-------------------------------
; s420C
;-------------------------------
s420C   
        LDA $D011    ;VIC Control Register 1
        AND #$7F
        STA $D011    ;VIC Control Register 1
        LDX a0A
        LDA f4122,X
        CMP #$FF
        BNE b4224
        LDA #$00
        STA a0A
        LDA f4122
b4224   STA $D012    ;Raster Position
        LDA #$01
        STA $D019    ;VIC Interrupt Request Register (IRR)
        RTS 

p422D   LDA $D019    ;VIC Interrupt Request Register (IRR)
        AND #$01
        BNE b4237
        JMP $EA31

b4237   LDX a0A
        LDA f410A,X
        STA a08
        LDA f4116,X
        STA a09
        JMP ($0008)

j4246   INC a0A
        JSR s420C
        PLA 
        TAY 
        PLA 
        TAX 
        PLA 
        RTI 

        LDX a0A
        LDA f40DA,X
        STA $D020    ;Border Color
        STA $D021    ;Background Color 0
        JMP j4246

;-------------------------------
; LaunchSubGame
;-------------------------------
LaunchSubGame
        SEI 
        LDA #$00
        STA a0A
        JSR s420C
        LDX selectedSubGame
        LDA subGameJumpMapLoPtr,X
        STA a449E
        LDA subGameJumpMapHiPtr,X
        STA a449F
        JSR s4BC9
        JMP (a449E)

subGameJumpMapLoPtr   .BYTE $00,$00,$88,$10,$00,$00
subGameJumpMapHiPtr   .BYTE $AB,$60,$42,$08,$A0,$78


;-------------------------------
; LaunchIridisBase ($4288)
;-------------------------------
        LDA $D011    ;VIC Control Register 1
        AND #$6F
        STA $D011    ;VIC Control Register 1
        JSR s6004
        LDA #$00
        STA $D020    ;Border Color
        STA $D021    ;Background Color 0
        LDX #$00
b429D   LDA f4CD4,X
        LDY f48F0,X
        STA a403E,Y
        LDA selectedSubGame,X
        STA a4040,Y
        INX 
        CPX #$08
        BNE b429D
        LDA #$03
        STA a40D7
        STA a4142
        LDA #$03
        STA $D015    ;Sprite display Enable
        STA $D01D    ;Sprites Expand 2x Horizontal (X)
        STA $D017    ;Sprites Expand 2x Vertical (Y)
        LDA #$00
        STA $D01C    ;Sprites Multi-Color Mode Select
        STA $D010    ;Sprites 0-7 MSB of X coordinate
        JSR s451E
        LDX #$00
b42D1   LDA f4CD0,X
        STA f4122,X
        INX 
        CPX #$04
        BNE b42D1
        LDA #$08
        STA $D027    ;Sprite 0 Color
        STA $D028    ;Sprite 1 Color
        LDA #<pC4C0
        STA SCREEN_RAM + $03F8
        LDA #>pC4C0
        STA SCREEN_RAM + $03F9
        LDA #$00
        STA a4489
        STA a0E
        LDA #$06
        STA a5252
        LDA #$13
        STA f410A
        LDA #$44
        STA f4116
        LDA #$4A
        STA a410C
        LDA #$45
        STA a4118
        LDA #$7E
        STA a410B
        LDA #$4F
        STA a4117
        LDA #$00
        STA a4141
        STA $D020    ;Border Color
        STA $D021    ;Background Color 0
        JSR s50FF
        JSR s5042
        LDA #$00
        STA a5028
        STA a40D8
        LDA a5AE9
        BEQ b4380
        JSR s4CA1
        JSR s5460
        JSR s4CBA
        LDA a54B4
        BEQ b436C
        STA a4B68
        LDA #$00
        STA a54B4
b434C   JSR s54B5
        INC a54B4
        LDA a54B4
        CMP a4B68
        BNE b434C
        CMP #$06
        BNE b436C
        LDA $D011    ;VIC Control Register 1
        ORA #$10
        AND #$7F
        STA $D011    ;VIC Control Register 1
        CLI 
        JMP j5627

b436C   LDY a5A7A
        BEQ b437C
        DEY 
b4372   LDA #$24
        STA SCREEN_RAM + $02F9,Y
        DEY 
        CPY #$FF
        BNE b4372
b437C   CLI 
        JMP j43B6

b4380   JSR s55E4
j4383   LDA #$0F
        STA a50FE
        STA a5AE9
        LDA #$60
        STA a405E
        JSR s5460
        LDA #<p507C
        STA a19
        LDA #>p507C
        STA a1A
        LDA #$C0
        JSR s5055
        JSR s520C
        LDA #$07
        STA a545F
        LDA a52BD
        STA a52BC
        LDA #$00
        STA a5253
        STA a52BB
j43B6   LDA $D011    ;VIC Control Register 1
        ORA #$10
        AND #$7F
        STA $D011    ;VIC Control Register 1
        LDA a41AF
        ROR 
        ROR 
        ROR 
        AND #$07
        TAX 
        INX 
        LDA f466D,X
        STA a448B
        STA a448A
        LDA f4C7B,X
        STA a52BD
        CLI 
b43DA   LDA a5028
        BNE b43DA
        LDA #$00
        STA a5252
        STA a52BE
b43E7   CLI 
        JSR CheckSubGameSelection
        LDA a40D8
        BEQ b43F3
        JSR j578A
b43F3   LDA a5252
        BEQ b43E7
        JSR s550D
        LDA #$01
        STA a58BF
        LDA a5028
        BNE b4408
        JSR s5362
b4408   LDA a5028
        BNE b4408
j440D   JMP j4383

        JMP j440D

        LDX a4489
        JSR s44ED
        JSR s4DF9
        JSR s4ED0
        JSR s4659
        JSR s5029
        JSR s4FB1
        JSR s4AFC
        JSR s4653
        JSR s5254
        JSR j59ED
        DEC a448B
        BEQ b443C
        JMP j4246

b443C   LDA a448A
        STA a448B
        INC a4489
        LDA a4489
        CMP #$06
        BNE b4451
        LDA #$00
        STA a4489
b4451   LDX a4489
        LDA f4498,X
        STA SCREEN_RAM + $03F8
        LDA f448C,X
        CLC 
        ADC #$A0
        STA $D000    ;Sprite 0 X Pos
        JSR s4C88
        LDA f4492,X
        CLC 
        ADC #$A0
        STA $D002    ;Sprite 1 X Pos
        CPX #$00
        BEQ b4479
        CPX #$03
        BEQ b4479
        BNE b4486
b4479   LDX #$00
b447B   LDA f48D2,X
        STA f4008,X
        INX 
        CPX #$12
        BNE b447B
b4486   JMP j4246

a4489   .BYTE $0D
a448A   .BYTE $AD
a448B   .BYTE $F4
f448C   .BYTE $FD,$FE,$00,$02,$00,$FE
f4492   .BYTE $FE,$FF,$00,$01,$00,$FF
f4498   .BYTE $C0,$C1,$C2,$C3,$C2,$C1
a449E   .BYTE $18
a449F   .BYTE $6D
;-------------------------------
; s44A0
;-------------------------------
s44A0   
        LDY a0D
        LDX #$00
j44A4   LDA f9000,Y
        STA SCREEN_RAM + $0000,X
        LDA f9040,Y
        STA SCREEN_RAM + $0028,X
        LDA f9080,Y
        STA SCREEN_RAM + $0050,X
        LDA f90C0,Y
        STA SCREEN_RAM + $0078,X
        LDA f9100,Y
        STA SCREEN_RAM + $00A0,X
        LDA f9140,Y
        STA SCREEN_RAM + $00C8,X
        LDA f9180,Y
        STA SCREEN_RAM + $00F0,X
        LDA f91C0,Y
        STA SCREEN_RAM + $0118,X
        LDA f9200,Y
        STA SCREEN_RAM + $0140,X
        INY 
        INX 
        CPX #$28
        BEQ b44E3
        JMP j44A4

b44E3   RTS 

f44E4   .BYTE $01,$01,$03,$03,$03,$03,$03,$03
        .BYTE $06
;-------------------------------
; s44ED
;-------------------------------
s44ED   
        LDA $D011    ;VIC Control Register 1
        AND #$F8
        ORA f4518,X
        STA $D011    ;VIC Control Register 1
        STA a13
        LDA #$75
        CLC 
        ADC f4518,X
        STA $D001    ;Sprite 0 Y Pos
        LDA #$9D
        CLC 
        ADC f4518,X
        STA $D003    ;Sprite 1 Y Pos
        LDA $D016    ;VIC Control Register 2
        AND #$F0
        ORA a0E
        STA $D016    ;VIC Control Register 2
        RTS 

        .BYTE $06
f4518   .BYTE $04,$03,$02,$04,$02,$03
;-------------------------------
; s451E
;-------------------------------
s451E   
        JSR s4584
        LDA #<SCREEN_RAM + $0209
        STA a05
        LDA #>SCREEN_RAM + $0209
        STA a06
b4529   LDY a05
        LDA f5A54,Y
        STA a07
        LDA #$00
        STA a04
b4534   JSR s4198
        INC a04
        LDA a04
        CMP #$28
        BNE b4534
        INC a05
        LDA a05
        CMP #$12
        BNE b4529
        JMP j5A6A

        LDA $D011    ;VIC Control Register 1
        AND #$F8
        ORA #$04
        STA $D011    ;VIC Control Register 1
        JSR s45AC
        JSR s45FD
        JSR s45C7
        JSR s44A0
        JSR j4677
        JSR s48F8
        JSR j542B
        JSR s5586
        JSR j4C40
        JMP j4246

;-------------------------------
; s4572
;-------------------------------
s4572   
        LDX #$00
b4574   LDA #$46
        STA f410A,X
        LDA #$42
        STA f4116,X
        INX 
        CPX #$0C
        BNE b4574
        RTS 

;-------------------------------
; s4584
;-------------------------------
s4584   
        LDA #>p00
        STA a05
b4588   LDA #<p00
        STA a04
        LDY a05
        LDA f44E4,Y
        STA a06
b4593   JSR s4192
        STA a07
        JSR s4198
        INC a04
        LDA a04
        CMP #$28
        BNE b4593
        INC a05
        LDA a05
        CMP #$09
        BNE b4588
        RTS 

;-------------------------------
; s45AC
;-------------------------------
s45AC   
        LDA #$1E
        SEC 
        SBC a0D
        TAY 
        LDA #$01
        STA $D800,Y
        STA $D801,Y
        STA $D828,Y
        STA $D829,Y
        STA $D827,Y
        STA $D82A,Y
        RTS 

;-------------------------------
; s45C7
;-------------------------------
s45C7   
        LDA #$1E
        SEC 
        SBC a0D
        TAY 
        INC a45F1
        LDA a45F1
        AND #$0F
        STA a45F1
        CLC 
        ROR 
        TAX 
        LDA f45F2,X
        STA $D800,Y
        STA $D801,Y
        STA $D828,Y
        STA $D829,Y
        STA $D827,Y
        STA $D82A,Y
        RTS 

a45F1   .BYTE $01
f45F2   .BYTE $01,$0F,$0C,$0B
        .BYTE $0B,$0C ;ANC #$0C
        .BYTE $0F,$01
b45FA   PLA 
        PLA 
        RTS 

;-------------------------------
; s45FD
;-------------------------------
s45FD   
        DEC a4FAF
        BEQ b4603
b4602   RTS 

b4603   LDA a574C
        BNE b4602
        LDA #$02
        STA a4FAF
        LDA a0E
        PHA 
        LDA a0D
        PHA 
        LDA a0F
        BEQ b45FA
        AND #$01
        BNE b463B
        INC a0E
        LDA a0E
        AND #$08
        BNE b4646
        JMP b45FA

b4626   LDA a0E
        AND #$07
        STA a0E
        INC a0D
        LDA a0D
        CMP #$17
        BNE b45FA
j4634   PLA 
        STA a0D
        PLA 
        STA a0E
        RTS 

b463B   DEC a0E
        LDA a0E
        AND #$08
        BNE b4626
        JMP b45FA

b4646   LDA a0E
        AND #$07
        STA a0E
        DEC a0D
        BNE b45FA
        JMP j4634

;-------------------------------
; s4653
;-------------------------------
s4653   
        LDA $DC00    ;CIA1: Data Port Register A
        STA a10
        RTS 

;-------------------------------
; s4659
;-------------------------------
s4659   
        LDA a10
        AND #$0C
        CMP #$0C
        BEQ b4666
        ROR 
        ROR 
        STA a0F
        RTS 

b4666   LDA #$00
        STA a0F
        RTS 

        .BYTE $06,$03
f466D   .BYTE $00,$02,$03,$05,$06,$07,$0C,$0D
        .BYTE $10,$13
j4677   LDX #$00
        LDA a40D7
        STA $D015    ;Sprite display Enable
b467F   LDA f40BE,X
        STA a11
        LDA f40C6,X
        STA a12
        LDY #$00
        LDA (p11),Y
        BEQ b469D
        CMP #$FF
        BEQ b4696
        JSR s46BA
b4696   INX 
        CPX a40D6
        BNE b467F
        RTS 

b469D   LDY #$04
        TXA 
        PHA 
        LDA (p11),Y
        TAX 
        LDA f40CE,X
        EOR #$FF
        AND $D015    ;Sprite display Enable
        STA $D015    ;Sprite display Enable
        LDA #$FF
        LDY #$00
        STA (p11),Y
        PLA 
        TAX 
        JMP b4696

;-------------------------------
; s46BA
;-------------------------------
s46BA   
        PHA 
        INY 
        LDA (p11),Y
        PHA 
        INY 
        LDA (p11),Y
        PHA 
        INY 
        LDA (p11),Y
        PHA 
        INY 
        INY 
        LDA (p11),Y
        PHA 
        DEY 
        LDA (p11),Y
        TAY 
        PLA 
        BEQ b46D6
        JSR s4733
b46D6   PLA 
        STA SCREEN_RAM + $03F8,Y
        PLA 
        PHA 
        STX a0B
        AND #$80
        BEQ b46EC
        PLA 
        AND #$07
        TAX 
        LDA f4CEA,X
        JMP j46ED

b46EC   PLA 
j46ED   STA $D027,Y  ;Sprite 0 Color
        LDX a0B
        LDA f40CE,Y
        ORA $D015    ;Sprite display Enable
        STA $D015    ;Sprite display Enable
        TYA 
        CLC 
        ASL 
        TAY 
        LDA a4142
        BEQ b470B
        PLA 
        CLC 
        ADC a13
        JMP j470C

b470B   PLA 
j470C   STA $D001,Y  ;Sprite 0 Y Pos
        PLA 
        CLC 
        ASL 
        STA $D000,Y  ;Sprite 0 X Pos
        BCS b4725
        TYA 
        CLC 
        ROR 
        TAY 
        LDA f479E,Y
        AND $D010    ;Sprites 0-7 MSB of X coordinate
        STA $D010    ;Sprites 0-7 MSB of X coordinate
        RTS 

b4725   TYA 
        CLC 
        ROR 
        TAY 
        LDA f40CE,Y
        ORA $D010    ;Sprites 0-7 MSB of X coordinate
        STA $D010    ;Sprites 0-7 MSB of X coordinate
        RTS 

;-------------------------------
; s4733
;-------------------------------
s4733   
        PHA 
        AND #$F0
        BNE b476F
        PLA 
        PHA 
        AND #$01
        BEQ b4747
        LDA f40CE,Y
        ORA $D01C    ;Sprites Multi-Color Mode Select
        STA $D01C    ;Sprites Multi-Color Mode Select
b4747   PLA 
        PHA 
        AND #$02
        BEQ b4756
        LDA f40CE,Y
        ORA $D01D    ;Sprites Expand 2x Horizontal (X)
        STA $D01D    ;Sprites Expand 2x Horizontal (X)
b4756   PLA 
        AND #$04
        BEQ b4764
        LDA f40CE,Y
        ORA $D017    ;Sprites Expand 2x Vertical (Y)
        STA $D017    ;Sprites Expand 2x Vertical (Y)
b4764   TYA 
        PHA 
        LDY #$05
        LDA #$00
        STA (p11),Y
        PLA 
        TAY 
        RTS 

b476F   PLA 
        PHA 
        AND #$10
        BEQ b477E
        LDA f479E,Y
        AND $D01C    ;Sprites Multi-Color Mode Select
        STA $D01C    ;Sprites Multi-Color Mode Select
b477E   PLA 
        PHA 
        AND #$20
        BEQ b478D
        LDA f479E,Y
        AND $D01D    ;Sprites Expand 2x Horizontal (X)
        STA $D01D    ;Sprites Expand 2x Horizontal (X)
b478D   PLA 
        AND #$40
        BEQ b4764
        LDA f479E,Y
        AND $D017    ;Sprites Expand 2x Vertical (Y)
        STA $D017    ;Sprites Expand 2x Vertical (Y)
        JMP b4764

f479E   .BYTE $FE,$FD,$FB,$F7,$EF,$DF,$BF,$7F
f47A6   .BYTE $00
f47A7   .BYTE $00
f47A8   .BYTE $00
f47A9   .BYTE $00
f47AA   .BYTE $00
f47AB   .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
j47BB   LDY #$00
b47BD   LDA f4008,Y
        BNE b47CC
b47C2   TYA 
        CLC 
        ADC #$12
        TAY 
        CPY #$36
        BNE b47BD
        RTS 

b47CC   LDA f4008,Y
        AND #$7F
        TAX 
        DEX 
        LDA f4008,Y
        AND #$80
        BEQ b4815
        INX 
        TXA 
        DEX 
        STA f4008,Y
        LDA f4009,Y
        STA $D405,X  ;Voice 1: Attack / Decay Cycle Control
        LDA f400A,Y
        STA $D406,X  ;Voice 1: Sustain / Release Cycle Control
        LDA f400B,Y
        STA f47A9,X
        LDA f400C,Y
        STA f47A6,X
        STA $D401,X  ;Voice 1: Frequency Control - High-Byte
        STA f47A8,X
        LDA f400D,Y
        STA $D404,X  ;Voice 1: Control Register
        LDA #$01
        STA f47AA,X
        LDA f400F,Y
        STA f47A7,X
        LDA f4011,Y
        STA f47AB,X
b4815   DEC f47A9,X
        BNE b47C2
        LDA f400B,Y
        STA f47A9,X
        LDA f47AA,X
        CMP #$02
        BEQ b487D
        LDA f47A6,X
        CLC 
        ADC f400E,Y
        STA f47A6,X
        STA $D401,X  ;Voice 1: Frequency Control - High-Byte
        DEC f47A7,X
        BNE b47C2
        LDA f47A8,X
        CLC 
        ADC f4010,Y
        STA f47A8,X
        STA f47A6,X
        STA $D401,X  ;Voice 1: Frequency Control - High-Byte
        LDA f400F,Y
        STA f47A7,X
        DEC f47AB,X
        BEQ b4857
        JMP b47C2

b4857   INC f47AA,X
        LDA f4012,Y
        STA $D404,X  ;Voice 1: Control Register
        LDA f4013,Y
        BEQ b486E
        STA $D401,X  ;Voice 1: Frequency Control - High-Byte
        STA f47A6,X
        STA f47A8,X
b486E   LDA f4015,Y
        STA f47A7,X
        LDA f4017,Y
        STA f47AB,X
b487A   JMP b47C2

b487D   LDA f47A6,X
        CLC 
        ADC f4014,Y
        STA f47A6,X
        STA $D401,X  ;Voice 1: Frequency Control - High-Byte
        DEC f47A7,X
        BNE b487A
        LDA f4015,Y
        STA f47A7,X
        LDA f47A8,X
        CLC 
        ADC f4016,Y
        STA f47A8,X
        STA f47A6,X
        STA $D401,X  ;Voice 1: Frequency Control - High-Byte
        DEC f47AB,X
        BNE b487A
        LDA f4018,Y
        CLC 
        ADC f400C,Y
        STA f400C,Y
        LDA f4019,Y
        SEC 
        SBC #$01
        STA f4019,Y
        BEQ b48CA
        LDA f4008,Y
        ORA #$80
        STA f4008,Y
        JMP b47C2

b48CA   LDA #$00
        STA f4008,Y
        JMP b47C2

f48D2   .BYTE $81,$0F,$AA,$01,$80,$81,$06,$02
        .BYTE $00,$02,$80,$10,$15,$03,$08,$04
f48E2   .BYTE $00,$01,$20,$30,$40,$50
f48E8   .BYTE $60,$70,$00,$00,$00,$00,$00,$00
f48F0   .BYTE $00,$10,$20,$30,$40,$50,$60,$70
;-------------------------------
; s48F8
;-------------------------------
s48F8   
        LDX #$02
b48FA   LDY f48F0,X
        TYA 
        STA f48E2,X
        LDA f4044,Y
        STA f48E8,X
        CLC 
        ROR 
        ROR 
        AND #$0F
        TAY 
        CPX #$02
        BNE b4917
        LDA f49ED,Y
        JMP j491A

b4917   LDA f496D,Y
j491A   LDY f48F0,X
        STA a4041,Y
        JSR s497D
        INX 
        CPX #$08
        BNE b48FA
        LDX #$02
b492A   TXA 
        TAY 
        INY 
b492D   LDA f48E8,X
        CMP f48E8,Y
        BMI b494E
j4935   INY 
        CPY #$08
        BNE b492D
        INX 
        CPX #$07
        BNE b492A
        LDX #$02
b4941   LDY f48E2,X
        TXA 
        STA f4042,Y
        INX 
        CPX #$08
        BNE b4941
        RTS 

b494E   LDA f48E8,X
        PHA 
        LDA f48E8,Y
        STA f48E8,X
        PLA 
        STA f48E8,Y
        LDA f48E2,X
        PHA 
        LDA f48E2,Y
        STA f48E2,X
        PLA 
        STA f48E2,Y
        JMP j4935

f496D   .BYTE $C5,$C5,$C5,$C5,$C6,$C7,$C8,$C9
        .BYTE $CA,$CB,$CC,$CD,$CE,$CF,$D0,$D1
;-------------------------------
; s497D
;-------------------------------
s497D   
        LDA f4044,Y
        CLC 
        ROR 
        ROR 
        AND #$0F
        PHA 
        TAY 
        LDA f49AB,Y
        STA a14
        LDA f49BC,Y
        STA a15
        LDY f48F0,X
        LDA f4045,Y
        TAY 
        LDA (p14),Y
        STA a0B
        PLA 
        TAY 
        LDA f49CD,Y
        SEC 
        SBC a0B
        LDY f48F0,X
        STA a403F,Y
        RTS 

f49AB   .BYTE $60,$A0,$E0,$20,$60,$A0,$E0,$20
        .BYTE $60,$A0,$E0,$20,$60,$A0,$E0,$20
        .BYTE $60
f49BC   .BYTE $92,$92,$92,$93,$93,$93,$93,$94
        .BYTE $94,$94,$94,$95,$95,$95,$95,$96
        .BYTE $96
f49CD   .BYTE $60,$60,$60,$62,$63,$65,$68,$6A
        .BYTE $6E,$71,$75,$79,$7D,$82,$86,$8B
f49DD   .BYTE $01,$01,$01,$01,$01,$01,$02,$02
        .BYTE $02,$03,$03,$04,$04,$05,$05,$06
f49ED   .BYTE $DC,$DC,$DC,$DC,$DB,$DB,$DA,$DA
        .BYTE $D9,$D8,$D7,$D6,$D5,$D4,$D3,$D2
;-------------------------------
; s49FD
;-------------------------------
s49FD   
        LDA a405E
        BEQ b4A1E
        CMP #$FF
        BEQ b4A1E
        LDA a4AB8
        BNE b4A1F
        JSR s4D78
        LDA a10
        AND #$10
        BNE b4A1E
        LDA #$01
        STA a4AB8
        LDA #$81
        STA a4060
b4A1E   RTS 

b4A1F   LDA a4AB8
        CMP #$01
        BNE b4A31
        LDA a10
        STA a4D77
        JSR s4CEE
        JMP j4A9B

b4A31   LDA a5826
        BEQ b4A3A
        LDA #$0A
        STA a10
b4A3A   LDA a10
        AND #$02
        BNE b4A48
        DEC a4065
        BNE b4A48
        INC a4065
b4A48   LDA a10
        AND #$01
        BNE b4A5B
        INC a4065
        LDA a4065
        CMP #$40
        BNE b4A5B
        DEC a4065
b4A5B   LDA a4064
        ROR 
        ROR 
        AND #$0F
        TAY 
        LDA a10
        AND #$04
        BNE b4A7E
        LDA a405E
        SEC 
        SBC f49DD,Y
        STA a405E
        AND #$F0
        BEQ b4A79
        BNE b4A7E
b4A79   LDA #$10
        STA a405E
b4A7E   LDA a10
        AND #$08
        BNE j4A9B
        LDA a405E
        CLC 
        ADC f49DD,Y
        STA a405E
        AND #$F0
        BEQ b4A96
        CMP #$A0
        BNE j4A9B
b4A96   LDA #$9F
        STA a405E
j4A9B   LDA a4AB8
        CMP #$02
        BEQ b4ABA
        LDA a10
        AND #$10
        BNE b4AB7
        LDA #$00
        STA a4AB9
        LDA #$80
        STA a4060
        LDA #$02
        STA a4AB8
b4AB7   RTS 

a4AB8   .BYTE $02
a4AB9   .BYTE $00
b4ABA   DEC a5143
        BEQ b4AC0
        RTS 

b4AC0   LDA a5142
        STA a5143
        LDA a4AB9
        BNE b4AD7
        DEC a4064
        DEC a4064
        BNE b4AD6
        INC a4AB9
b4AD6   RTS 

b4AD7   INC a4064
        INC a4064
        LDA a4064
        CMP #$3E
        BNE b4AD6
        LDA a5826
        BEQ b4AF0
        LDA #$00
        STA a4AB9
        BEQ b4AF5
b4AF0   LDA #$00
        STA a4AB8
b4AF5   LDA #$01
        STA a4060
        RTS 

a4AFB   .BYTE $62
;-------------------------------
; s4AFC
;-------------------------------
s4AFC   
        INC a4AFB
        LDA a4AFB
        AND #$0F
        TAY 
        LDA f40DA,Y
        STA f4CEA
        LDA f40EA,Y
        STA a4CEB
        LDA f40FA,Y
        STA a4CEC
        RTS 

        STA a6003
;-------------------------------
; s4B1B
;-------------------------------
s4B1B   
        LDA #$36
        STA a01
        LDA #$00
        STA a54B4
        STA a5AE9
        STA a58BF
        STA a574C
        STA a5A7A
        STA a5AEA
        STA a0813
        STA a6003
        STA aA003
        STA aAB03
        STA a4CE8
        LDX #$0A
        LDA #$20
b4B46   STA SCREEN_RAM + $037C,X
        STA SCREEN_RAM + $03A4,X
        DEX 
        BNE b4B46
        LDA #$02
        STA a0D
        SEI 
        LDA #<p4CE9
        STA $0318    ;NMI
        LDA #>p4CE9
        STA $0319    ;NMI
        LDA #$80
        STA $0291
        CLI 
        JSR s4BF9
        RTS 

a4B68   .BYTE $00
;-------------------------------
; CheckSubGameSelection
;-------------------------------
CheckSubGameSelection
        LDA a4CE8
        BEQ b4B74
        LDX #$F8
        TXS 
        JMP jBA02

b4B74   LDA currentPressedKey
        CMP #$40
        BNE b4B7B
        RTS 

b4B7B   CMP #$03 ; F7
        BNE b4B85
        ;F7 reloads the title screen.
        LDX #$F8
        TXS 
        JMP TitleScreenLoop

b4B85   LDX #$00
b4B87   CMP keyPressToSubGameMap,X
        BEQ b4B92
        INX 
        CPX #$06
        BNE b4B87
b4B91   RTS 

b4B92   CPX selectedSubGame
        BEQ b4B91
        STX selectedSubGame
        LDX #$F8
        TXS 
        JSR AnimateScreenDissolve
        JMP LaunchSubGame

;-------------------------------
; s4BA3
;-------------------------------
s4BA3   
        JSR s4198
        INC a05
        INC a07
        JSR s4198
        INC a07
        DEC a05
        INC a04
        JSR s4198
        INC a07
        INC a05
        JMP s4198

f4BBD   .BYTE $01,$03,$05,$07,$09,$0B
f4BC3   .BYTE $B9,$82,$7A,$B5,$7E,$76
;-------------------------------
; s4BC9
;-------------------------------
s4BC9   
        LDX #$00
b4BCB   LDA #$0B
        STA a06
        CPX selectedSubGame
        BNE b4BD8
        LDA #$01
        STA a06
b4BD8   LDA f4BBD,X
        STA a04
        LDA f4BC3,X
        STA a07
        LDA #$16
        STA a05
        TXA 
        PHA 
        JSR s4BA3
        PLA 
        TAX 
        INX 
        CPX #$06
        BNE b4BCB
        RTS 

keyPressToSubGameMap   .BYTE $38,$3B,$08,$0B,$10,$13
;-------------------------------
; s4BF9
;-------------------------------
s4BF9   
        LDA #$27
        STA a41AF
        TAX 
b4BFF   LDA #$3F
        STA SCREEN_RAM + $0348,X
        LDA f4C17,X
        STA $DB48,X
        DEX 
        BNE b4BFF
        LDX #$08
b4C0F   LDA #$30
        STA SCREEN_RAM + $03B6,X
        DEX 
        BNE b4C0F
f4C17   RTS 

        .BYTE $02,$02,$02,$02,$02,$02,$08,$08
        .BYTE $08,$08,$08,$07,$07,$07,$07,$07
        .BYTE $05,$05,$05,$05,$05,$05,$0E,$0E
        .BYTE $0E,$0E,$0E,$04,$04,$04,$04,$04
        .BYTE $06,$06,$06,$06,$06,$06
a4C3E   .BYTE $40
a4C3F   .BYTE $04
j4C40   DEC a4C3E
        BEQ b4C46
b4C45   RTS 

b4C46   LDX selectedLevel
        LDA f4CE2,X
        STA a4C3E
        DEC a4C3F
        BEQ b4C55
        RTS 

b4C55   LDA #$04
        STA a4C3F
        LDA a41AF
        BEQ b4C45
        TAX 
        DEC SCREEN_RAM + $0348,X
        LDA SCREEN_RAM + $0348,X
        CMP #$3B
        BNE b4C45
        LDA #$20
        STA SCREEN_RAM + $0348,X
        DEC a41AF
        BEQ b4C75
        RTS 

b4C75   LDA #$01
        STA a4CE8
        RTS 

f4C7B   .BYTE $01,$04,$05,$06,$07,$08,$09,$0A
        .BYTE $0B
a4C84   .BYTE $00
a4C85   .BYTE $00
a4C86   .BYTE $00
a4C87   .BYTE $00
;-------------------------------
; s4C88
;-------------------------------
s4C88   
        LDA a405E
        STA a4C84
        LDA a4060
        STA a4C87
        LDA a4064
        STA a4C86
        LDA a4065
        STA a4C85
        RTS 

;-------------------------------
; s4CA1
;-------------------------------
s4CA1   
        LDA a4C84
        STA a405E
        LDA a4C85
        STA a4065
        LDA a4C86
        STA a4064
        LDA a4C87
        STA a4060
        RTS 

;-------------------------------
; s4CBA
;-------------------------------
s4CBA   
        LDX #$07
        CPX a545F
        BEQ b4CCF
b4CC1   LDY f48F0,X
        LDA #$FF
        STA a403E,Y
        DEX 
        CPX a545F
        BNE b4CC1
b4CCF   RTS 

f4CD0   .BYTE $20,$80,$C0,$FF
f4CD4   .BYTE $FF,$FF,$C0,$C0,$C0,$C0,$C0,$C0
        .BYTE $EA,$EA,$EA,$4C,$02,$BA
f4CE2   .BYTE $C0,$80,$40,$20,$10,$00
a4CE8   .BYTE $00
p4CE9   .BYTE $40
f4CEA   .BYTE $A9
a4CEB   .BYTE $0F
a4CEC   .BYTE $8D
a4CED   .BYTE $00
;-------------------------------
; s4CEE
;-------------------------------
s4CEE   
        LDA a405E
        PHA 
        LDA a4065
        PHA 
        LDA a4D77
        AND #$0C
        CMP #$0C
        BNE b4D05
        JSR s4DAF
        JMP j4D30

b4D05   AND #$08
        BNE b4D12
        LDA a4CED
        INC a4CED
        INC a4CED
b4D12   DEC a4CED
        LDA a4CED
        CMP #$06
        BNE b4D1F
        DEC a4CED
b4D1F   CMP #$FA
        BNE b4D26
        INC a4CED
b4D26   LDA a405E
        CLC 
        ADC a4CED
        STA a405E
j4D30   LDA a4D77
        AND #$03
        CMP #$03
        BNE b4D3C
        JMP j4D52

b4D3C   AND #$01
        BNE b4D4C
        INC a4065
        INC a4065
        INC a4065
        INC a4065
b4D4C   DEC a4065
        DEC a4065
j4D52   LDA a4065
        AND #$FE
        BEQ b4D61
        CMP #$40
        BPL b4D61
        PLA 
        JMP j4D65

b4D61   PLA 
        STA a4065
j4D65   LDA a405E
        AND #$F0
        BEQ b4D72
        CMP #$A0
        BEQ b4D72
        PLA 
        RTS 

b4D72   PLA 
        STA a405E
        RTS 

a4D77   .BYTE $FF
;-------------------------------
; s4D78
;-------------------------------
s4D78   
        LDA a405E
        CLC 
        ADC #$20
        AND #$80
        BEQ b4D8A
        LDA #$08
        STA a4D77
        JMP j4D8F

b4D8A   LDA #$04
        STA a4D77
j4D8F   LDA a4065
        AND #$FE
        CMP #$20
        BEQ b4DD0
        BMI b4DA5
        LDA a4D77
        ORA #$01
j4D9F   STA a4D77
        JMP s4CEE

b4DA5   LDA a4D77
        ORA #$02
        JMP j4D9F

        .BYTE $00
a4DAE   .BYTE $04
;-------------------------------
; s4DAF
;-------------------------------
s4DAF   
        DEC a4DAE
        BEQ b4DB5
        RTS 

b4DB5   LDA #$04
        STA a4DAE
        LDA a4CED
        BEQ b4DCF
        LDA a4CED
        AND #$80
        BEQ b4DCC
        INC a4CED
        INC a4CED
b4DCC   DEC a4CED
b4DCF   RTS 

b4DD0   LDA a4D77
        ORA #$03
        JMP j4D9F

        .BYTE $07,$07,$07,$07,$06,$06,$06,$05
        .BYTE $05,$05,$04,$04,$03,$03,$02,$01
        .BYTE $B9,$3E,$40,$29,$F0,$C9,$E0,$F0
        .BYTE $01,$60,$A9,$00,$99,$3E,$40,$60
        .BYTE $05
;-------------------------------
; s4DF9
;-------------------------------
s4DF9   
        LDX #$03
b4DFB   LDY f48F0,X
        STX a4EEF
        TYA 
        TAX 
        JSR s4EF0
        LDX a4EEF
        INX 
        CPX #$08
        BNE b4DFB
        RTS 

f4E0F   .BYTE $FF,$A0,$C0,$FF,$4C,$BB,$47,$4C
        .BYTE $77,$46,$4C,$2B,$54,$4C,$46,$42
        .BYTE $4C,$40,$4C,$4C,$ED,$59,$4C,$69
        .BYTE $4B,$4C,$8A,$57,$00,$01,$A9,$04
        .BYTE $85,$03,$A9,$00,$85,$02,$A2,$00
b4E37   LDA a02
        STA $0340,X
        LDA a03
        STA $0360,X
        LDA a02
        CLC 
        ADC #$28
        STA a02
        LDA a03
        ADC #$00
        STA a03
        INX 
f4E4F   CPX #$1A
        BNE b4E37
        RTS 

        LDX #$00
b4E56   LDA #$20
        STA SCREEN_RAM + $0000,X
        STA SCREEN_RAM + $0100,X
        STA SCREEN_RAM + $0200,X
        STA SCREEN_RAM + $0300,X
        LDA #$01
        STA $DAF0,X
        DEX 
        BNE b4E56
        RTS 

        LDX a05
        LDY a04
        LDA $0340,X
        STA a02
        LDA $0360,X
        STA a03
        RTS 

        JSR s4183
        LDA (p02),Y
        RTS 

        JSR s4183
        LDA a07
        STA (p02),Y
        LDA a03
        PHA 
        CLC 
        ADC #$D4
f4E8F   STA a03
        LDA a06
        STA (p02),Y
        PLA 
        STA a03
        RTS 

        .BYTE $00
        JSR s4143
        JSR s416A
        JSR s574D
        LDA $D016    ;VIC Control Register 2
        AND #$F0
        STA $D016    ;VIC Control Register 2
        JSR s4B1B
        JSR s41EC
        LDA #$18
        STA $D018    ;VIC Memory Control Register
        LDA #$00
        STA $D020    ;Border Color
        STA $D021    ;Background Color 0
        STA $D400    ;Voice 1: Frequency Control - Low-Byte
        LDA #$04
        STA $D407    ;Voice 2: Frequency Control - Low-Byte
        LDA #$08
        STA $D40E    ;Voice 3: Frequency Control - Low-Byte
        LDA #$02
a4ECF   =*+$02
        STA @w$00D9
;-------------------------------
; s4ED0
;-------------------------------
s4ED0   
        INC a4ECF
        LDA a4ECF
        AND #$3F
        STA a4ECF
        TAX 
        LDA a405E
        STA f4E0F,X
        LDA a4065
        STA f4E4F,X
        LDA a4064
        STA f4E8F,X
b4EEE   RTS 

a4EEF   .BYTE $00
;-------------------------------
; s4EF0
;-------------------------------
s4EF0   
        LDX a4EEF
        LDA a403E,Y
        CMP #$FF
        BEQ b4EEE
        LDA f4F1E,X
        CLC 
        ASL 
        ASL 
        ASL 
        STA a4F26
        LDA a4ECF
        SEC 
        SBC a4F26
        AND #$3F
        TAX 
        LDA f4E0F,X
        STA a403E,Y
        LDA f4E4F,X
        STA f4045,Y
        LDA f4E8F,X
f4F1E   =*+$01
        STA f4044,Y
        RTS 

        .BYTE $01,$02,$03,$04,$05
a4F26   .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00
a4F78   =*+$01
;-------------------------------
; s4F77
;-------------------------------
s4F77   
        LDA $EEEE
        INC a4F78
        RTS 

        LDY #$00
        LDA $D016    ;VIC Control Register 2
        AND #$F8
        STA $D016    ;VIC Control Register 2
        LDA $D020    ;Border Color
        PHA 
b4F8C   LDA f40DA,Y
        STA $D020    ;Border Color
        LDX #$10
b4F94   DEX 
        BNE b4F94
        INY 
        CPY #$07
        BNE b4F8C
        PLA 
        STA $D020    ;Border Color
        JSR s5721
        JSR j47BB
        JSR $FF9F ;$FF9F - scan keyboard                    
        JSR s49FD
        JMP j4246

a4FAF   .BYTE $01
a4FB0   .BYTE $00
;-------------------------------
; s4FB1
;-------------------------------
s4FB1   
        DEC a5026
        BNE b4FD4
        JSR s4F77
        AND #$3F
        ORA #$01
        STA a5026
        JSR s4F77
        AND #$10
        STA a5027
        JSR s4F77
        AND #$10
        CLC 
        ADC a5027
        STA a5027
b4FD4   LDX #$00
        LDY #$00
b4FD8   LDA a4FB0
        CLC 
        ADC a5027
        TAX 
        LDA f40DA,X
        STA $D9F7,Y
        STA $DA97,Y
        INC a4FB0
        LDA a4FB0
        AND #$0F
        STA a4FB0
        INY 
        CPY #$0F
        BNE b4FD8
        DEC a5025
        BEQ b4FFF
        RTS 

b4FFF   LDA #$0C
        STA a5025
        INC a5024
        LDA a5024
        AND #$0F
        STA a5024
        TAX 
        LDA f40EA,X
        LDX #$00
b5015   STA $DA47,X
        STA $DA6F,X
        STA $DA1F,X
        INX 
        CPX #$0F
        BNE b5015
        RTS 

a5024   .TEXT $00
a5025   .TEXT $02
a5026   .TEXT $10
a5027   .TEXT $00
a5028   .BYTE $01
;-------------------------------
; s5029
;-------------------------------
s5029   
        LDA a5028
        BNE b502F
b502E   RTS 

b502F   LDA currentPressedKey
        CMP #$40
        BEQ b503D
        LDA #$00
        STA a5028
        JMP s5042

b503D   DEC a5028
        BNE b502E
;-------------------------------
; s5042
;-------------------------------
s5042   
        LDA #$20
        LDX #$00
b5046   STA SCREEN_RAM + $0247,X
        STA SCREEN_RAM + $021F,X
        STA SCREEN_RAM + $026F,X
        INX 
        CPX #$0F
        BNE b5046
        RTS 

;-------------------------------
; s5055
;-------------------------------
s5055   
        STA a5028
        LDY #$00
        STY a5024
        LDX #$00
b505F   LDA (p19),Y
        AND #$3F
        STA SCREEN_RAM + $021F,X
        TYA 
        PHA 
        CLC 
        ADC #$0F
        TAY 
        LDA (p19),Y
        AND #$3F
        STA SCREEN_RAM + $026F,X
        PLA 
        TAY 
        INY 
        INX 
        CPX #$0F
        BNE b505F
        RTS 

p507C   .TEXT "STAND BY FOR   SEQUENCE TRACE "
j509A   LDY #$00
        LDX a4FB0
        LDA #<$DA13
        STA a17
        LDA #>$DA13
        STA a18
        LDA f40EA,X
        PHA 
        LDX #$00
b50AD   LDY f50E5,X
        PLA 
        PHA 
        STA (p17),Y
        INX 
        CPX #$09
        BNE b50AD
        PLA 
        LDA a50FE
        AND #$0F
        EOR #$0F
        BEQ b50D3
        TAX 
        LDA f50EE,X
        TAX 
        LDY f50E5,X
        LDX a4FB0
        LDA f40DA,X
        STA (p17),Y
b50D3   LDA a50FE
        AND #$10
        BNE b50E4
        LDY #$29
        LDX a4FB0
        LDA f40DA,X
        STA (p17),Y
b50E4   RTS 

f50E5   .BYTE $00,$01,$02,$28,$29,$2A,$50,$51
        .BYTE $52
f50EE   .BYTE $FF,$01,$07,$FF,$03,$00,$06,$FF
        .BYTE $05,$02,$08,$FF,$FF,$FF,$FF,$FF
a50FE   .BYTE $00
;-------------------------------
; s50FF
;-------------------------------
s50FF   
        LDX #$00
b5101   LDY f5110,X
        LDA f5129,X
        STA SCREEN_RAM + $01EA,Y
        INX 
        CPX #$19
        BNE b5101
        RTS 

f5110   .BYTE $00,$01,$02,$03,$04,$28,$29,$2A
        .BYTE $2B,$2C,$50,$51,$52,$53,$54,$78
        .BYTE $79,$7A,$7B,$7C,$A0,$A1,$A2,$A3
        .BYTE $A4
f5129   .BYTE $5A,$5F,$5F,$5F,$5B,$61,$5E,$5E
        .BYTE $5E,$62,$61,$5E,$5E,$5E,$62,$61
        .BYTE $5E,$5E,$5E,$62,$5D,$60,$60,$60
        .BYTE $5C
a5142   .BYTE $04
a5143   .BYTE $04
f5144   .BYTE $BD
        STY a1844
        ADC #$A0
        STA $D000    ;Sprite 0 X Pos
        JSR s4C88
        LDA f4492,X
        CLC 
        ADC #$A0
        STA $D002    ;Sprite 1 X Pos
        CPX #$00
        BEQ b5163
        CPX #$03
        BEQ b5163
        BNE b5170
b5163   LDX #$00
b5165   LDA f48D2,X
        STA f4008,X
        INX 
        CPX #$12
        BNE b5165
b5170   JMP j4246

        ORA $F4AD
        SBC @w$00FE,X
        .BYTE $02    ;JAM 
        BRK #$FE
        INC @w$00FF,X
        ORA (p00,X)
        .BYTE $FF,$C0,$C1 ;ISC $C1C0,X
        .BYTE $C2,$C3 ;NOP #$C3
        .BYTE $C2,$C1 ;NOP #$C1
        CLC 
        ADC a0DA4
        LDX #$00
        LDA f9000,Y
        STA SCREEN_RAM + $0000,X
        LDA f9040,Y
        STA SCREEN_RAM + $0028,X
        LDA f9080,Y
        STA SCREEN_RAM + $0050,X
        LDA f90C0,Y
        STA SCREEN_RAM + $0078,X
f51A8   =*+$02
        LDA f9100,Y
        STA SCREEN_RAM + $00A0,X
        LDA f9140,Y
        STA SCREEN_RAM + $00C8,X
        LDA f9180,Y
        STA SCREEN_RAM + $00F0,X
        LDA f91C0,Y
        STA SCREEN_RAM + $0118,X
        LDA f9200,Y
        STA SCREEN_RAM + $0140,X
        INY 
        INX 
        CPX #$28
        BEQ b51CD
        JMP j44A4

b51CD   RTS 

        .BYTE $01,$01,$03,$03,$03,$03,$03,$03
        ASL aAD
        ORA (pD0),Y
        AND #$F8
        ORA f4518,X
        STA $D011    ;VIC Control Register 1
        STA a13
        LDA #$75
        CLC 
        ADC f4518,X
        STA $D001    ;Sprite 0 Y Pos
        LDA #$9D
        CLC 
        ADC f4518,X
        STA $D003    ;Sprite 1 Y Pos
        LDA $D016    ;VIC Control Register 2
        AND #$F0
        ORA a0E
        STA $D016    ;VIC Control Register 2
        RTS 

        .BYTE $06,$04,$03,$02,$04,$02,$03,$20
        .BYTE $84,$45,$A9
;-------------------------------
; s520C
;-------------------------------
s520C   
        LDX #$00
b520E   LDA #$00
        STA f5144,X
        STA f51A8,X
        INX 
        CPX #$64
        BNE b520E
        LDX #$00
b521D   JSR s4F77
        AND #$07
        BEQ b522A
        JSR s53C2
        JMP j5245

b522A   LDY #$0A
b522C   TYA 
        PHA 
        JSR s4F77
        AND #$07
        TAY 
        LDA f524A,Y
        STA f5144,X
        LDA #$01
        STA f51A8,X
        PLA 
        TAY 
        INX 
        DEY 
        BNE b522C
j5245   CPX #$64
        BNE b521D
        RTS 

f524A   .BYTE $0E,$06,$07,$05,$0D,$09,$0B,$0A
a5252   .BYTE $00
a5253   .BYTE $00
;-------------------------------
; s5254
;-------------------------------
s5254   
        LDA a5252
        BEQ b5264
        LDA a5826
        BEQ b5261
        JSR s5827
b5261   JMP j509A

b5264   DEC a52BC
        BNE b5261
        LDA a52BD
        STA a52BC
        LDX a52BB
        LDA f5144,X
        ORA #$10
        LDY a4AB8
        BNE b527E
        AND #$EF
b527E   STA a50FE
        INC a5253
        LDA a10
        AND #$1F
        CMP a50FE
        BEQ b5294
        LDA a5253
        CMP #$20
        BNE b52B8
b5294   JSR s52BF
        LDA a50FE
        LDA #$00
        STA a5253
        INC a52BB
        LDA a52BB
        CMP #$64
        BNE b52B8
j52A9   LDA #$00
        STA a52BB
        LDA #$01
        STA a5252
        LDA #$FF
        STA a50FE
b52B8   JMP b5261

a52BB   .BYTE $00
a52BC   .BYTE $20
a52BD   .BYTE $08
a52BE   .BYTE $00
;-------------------------------
; s52BF
;-------------------------------
s52BF   
        LDA a5253
        CMP #$0A
        BMI b5316
        LDA #<p544F
        STA a1B
        LDA #>p544F
        STA a1C
        LDA #$01
        STA a4141
        LDX #$00
b52D5   LDA f595B,X
        STA f401A,X
        INX 
        CPX #$12
        BNE b52D5
        LDY a545F
        LDA f48F0,Y
        TAX 
        LDA #$00
        STA a403E,X
        DEC a545F
        DEY 
        CPY #$01
        BNE b5313
        LDA #<p5496
        STA a19
        LDA #>p5496
        STA a1A
        LDA #$C0
        JSR s5055
        LDX #$00
b5303   LDA f597F,X
        STA f401A,X
        INX 
        CPX #$12
        BNE b5303
        PLA 
        PLA 
        JMP j52A9

b5313   JMP j5812

b5316   PHA 
        CMP #$02
        BPL b5333
        LDA f5144,X
        CMP a5143,X
        BEQ b5333
        LDA f51A8,X
        BEQ b5333
        LDA #$24
        LDX a5A7A
        STA SCREEN_RAM + $02F9,X
        INC a5A7A
b5333   PLA 
        EOR #$0F
        JSR s57DE
        ASL 
        ASL 
        ASL 
        ASL 
        AND #$F0
        ORA #$07
        STA a40D8
        INC a52BE
        LDA #<p5536
        STA a1B
        LDA #>p5536
        STA a1C
        LDA #$01
        STA a4141
        LDX #$00
b5356   LDA f5895,X
        STA f401A,X
        INX 
        CPX #$12
        BNE b5356
        RTS 

;-------------------------------
; s5362
;-------------------------------
s5362   
        LDA #<p53A4
        STA a19
        LDA #>p53A4
        STA a1A
        LDA #$30
        STA a53AF
        STA a53B0
        STA a53B1
        LDY a52BE
        BEQ b539E
b537A   INC a53B1
        LDA a53B1
        CMP #$3A
        BNE b539B
        LDA #$30
        STA a53B1
        INC a53B0
        LDA a53B0
        CMP #$3A
        BNE b539B
        LDA #$30
        STA a53B0
        INC a53AF
b539B   DEY 
        BNE b537A
b539E   LDA #$C0
        JSR s5055
        RTS 

p53A4   .TEXT "EFFICIENCY "
a53AF   .TEXT "0"
a53B0   .TEXT "0"
a53B1   .TEXT "0%SEQUENCE OVER.."
;-------------------------------
; s53C2
;-------------------------------
s53C2   
        TAY 
        LDA #$00
b53C5   CLC 
        ADC #$0A
        DEY 
        BNE b53C5
        TAY 
        LDA #$0A
        STA a53E4
b53D1   LDA f53DB,Y
        STA f5144,X
        LDA #$00
f53DB   =*+$02
        STA f51A8,X
        INX 
        INY 
        DEC a53E4
        BNE b53D1
        RTS 

a53E4   .BYTE $D0,$0E,$0D,$0E,$0D,$0B,$07,$0B
        .BYTE $07,$0A,$06,$0E,$06,$07,$05,$0D
        .BYTE $09,$0B,$0A,$0E,$0F,$0D,$05,$07
        .BYTE $06,$0E,$0A,$0B,$09,$0D,$0F,$0F
        .BYTE $0E,$0F,$0D,$09,$0B,$0F,$07,$06
        .BYTE $0E,$0A,$0E,$06,$07,$05,$07,$06
        .BYTE $0E,$0A,$0F,$09,$05,$06,$0A,$0B
        .BYTE $0E,$0B,$0E,$07,$0D,$0B,$0F,$07
        .BYTE $0F,$0B,$0F,$0E,$0F,$0D,$0F
j542B   LDY a4141
        BNE b5431
b5430   RTS 

b5431   LDA (p1B),Y
        STA $D020    ;Border Color
        STA $D021    ;Background Color 0
        INC a4141
        INY 
        LDA (p1B),Y
        CMP #$FF
        BNE b5430
        LDA #$00
        STA a4141
        STA $D020    ;Border Color
        STA $D021    ;Background Color 0
        RTS 

p544F   .BYTE $00,$02,$00,$08,$00,$07,$00,$05
        .BYTE $00,$0E,$00,$04,$00,$06,$00,$FF
a545F   .BYTE $00
;-------------------------------
; s5460
;-------------------------------
s5460   
        LDX #$00
b5462   LDA a405E
        STA f4E0F,X
        LDA a4065
        STA f4E4F,X
        LDA a4064
        STA f4E8F,X
        INX 
        CPX #$40
        BNE b5462
        LDX #$03
b547B   LDY f48F0,X
        LDA a405E
        STA a403E,Y
        LDA a4064
        STA f4044,Y
        LDA a4065
        STA f4045,Y
        INX 
        CPX #$08
        BNE b547B
        RTS 

p5496   .TEXT "PHOSPHENES LOSTSEQUENCE FAILED"
a54B4   .TEXT $00
;-------------------------------
; s54B5
;-------------------------------
s54B5   
        LDX a54B4
        LDA f5501,X
        STA a1D
        LDA f5507,X
        STA a1E
        LDY #$00
        LDA f40E4,X
b54C7   STA (p1D),Y
        INY 
        CPY #$28
        BNE b54C7
        LDA #<p54E9
        STA a1B
        LDA #>p54E9
        STA a1C
        LDA #$01
        STA a4141
        LDX #$00
b54DD   LDA f596D,X
        STA f401A,X
        INX 
        CPX #$12
        BNE b54DD
        RTS 

p54E9   .BYTE $00,$01,$00,$01,$00,$00,$01,$00
        .BYTE $00,$00,$00,$01,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$01,$01,$FF
f5501   .BYTE $18,$F0,$C8,$A0,$78,$50
f5507   .BYTE $D9,$D8,$D8,$D8,$D8,$D8
;-------------------------------
; s550D
;-------------------------------
s550D   
        LDA a545F
        STA a5876
        CMP #$01
        BNE b5518
        RTS 

b5518   DEC a545F
b551B   JSR s54B5
        INC a54B4
        LDX a54B4
        CPX #$06
        BNE b5530
        LDA #$01
        STA a5826
        JMP j5627

b5530   DEC a545F
        BNE b551B
        RTS 

p5536   .BYTE $00,$01,$00,$00,$00,$01,$00,$FF
f553E   .BYTE $04,$23,$30,$21,$06,$34,$11,$23
        .BYTE $26,$0E,$1F,$3D
f554A   .BYTE $1B,$1B,$1B,$1B,$1B,$1B,$1B,$1B
        .BYTE $1B,$1B,$1B,$1B
f5556   .BYTE $01,$01,$02,$02,$03,$03,$04,$04
        .BYTE $05,$05,$06,$06
f5562   .BYTE $01,$01,$02,$02,$03,$03,$04,$04
        .BYTE $05,$05,$06,$06
f556E   .BYTE $80,$80,$C0,$C0,$00,$00,$40,$40
        .BYTE $80,$80,$C0,$C0
f557A   .BYTE $90,$90,$90,$90,$91,$91,$91,$91
        .BYTE $91,$91,$91,$91
;-------------------------------
; s5586
;-------------------------------
s5586   
        LDX #$00
b5588   LDA f556E,X
        STA a17
        LDA f557A,X
        STA a18
        DEC f5556,X
        BNE b559A
        JSR s55A0
b559A   INX 
        CPX #$0C
        BNE b5588
        RTS 

;-------------------------------
; s55A0
;-------------------------------
s55A0   
        LDA f5562,X
        STA f5556,X
        INC f554A,X
        LDA f554A,X
        CMP #$1F
        BEQ b55C0
j55B0   PHA 
        LDY f553E,X
        LDA (p17),Y
        AND #$40
        BNE b55BE
        PLA 
        STA (p17),Y
        RTS 

b55BE   PLA 
        RTS 

b55C0   LDY f553E,X
        LDA (p17),Y
        AND #$40
        BNE b55CD
        LDA #$20
        STA (p17),Y
b55CD   DEC f553E,X
        DEY 
        CPY #$FF
        BNE b55DB
        LDA #$3F
        STA f553E,X
        TAY 
b55DB   LDA #$1B
        STA f554A,X
        JMP j55B0

a55E3   .BYTE $02
;-------------------------------
; s55E4
;-------------------------------
s55E4   
        LDX #$00
b55E6   LDA f9000,X
        JSR s55FC
        STA f9000,X
        LDA f9100,X
        JSR s55FC
        STA f9100,X
        DEX 
        BNE b55E6
        RTS 

;-------------------------------
; s55FC
;-------------------------------
s55FC   
        PHA 
        AND #$40
        BEQ b5619
        PLA 
        PHA 
        CMP #$48
        BEQ b5619
        CMP #$49
        BEQ b5619
        CMP #$4A
        BEQ b5619
        CMP #$4B
        BEQ b561D
        CMP #$47
        BEQ b5621
        PLA 
        RTS 

b5619   PLA 
        LDA #$20
        RTS 

b561D   PLA 
        LDA #$40
        RTS 

b5621   PLA 
        LDA #$41
        RTS 

a5625   .BYTE $E0
a5626   .BYTE $07
j5627   LDA #$19
        STA a574C
        SEC 
        SBC a0D
        STA a55E3
        LDX #$00
b5634   LDA f58A7,X
        STA f401A,X
        STA f402C,X
        INX 
        CPX #$12
        BNE b5634
        LDA #$88
        STA f401A
        LDX #$00
b5649   LDA #$01
        STA $D8C8,X
        INX 
        CPX a55E3
        BNE b5649
        LDX #$00
b5656   LDA #$49
        STA f9140,X
        LDA #$4A
        STA f9141,X
        INX 
        INX 
        CPX #$18
        BNE b5656
        LDA #$49
        STA f9140,X
        LDA #$4B
        STA f9141,X
        LDY #$21
        LDA #$02
        STA a5625
        STA a5626
j567A   LDA #<f9000
        STA a1F
        LDA #>f9000
        STA a20
b5682   LDA #$48
        STA (p1F),Y
        LDA a1F
        CLC 
        ADC #$40
        STA a1F
        LDA a20
        ADC #$00
        STA a20
        DEC a5625
        BNE b5682
        LDA a5626
        CMP #$08
        BEQ b56A3
        LDA #$47
        STA (p1F),Y
b56A3   INC a5626
        INY 
        LDA a5626
        CMP #$09
        BEQ b56B4
        STA a5625
        JMP j567A

b56B4   LDA a55E3
        CLC 
        ADC #$08
        TAY 
        LDA #$03
        STA a5625
        STA a5626
j56C3   LDA #<$D800
        STA a1F
        LDA #>$D800
        STA a20
b56CB   LDX a5626
        LDA a40D7,X
        STA (p1F),Y
        LDA a1F
        CLC 
        ADC #$28
        STA a1F
        LDA a20
        ADC #$00
        STA a20
        DEC a5625
        BNE b56CB
        INC a5626
        INY 
        LDA a5626
        CMP #$0A
        BEQ b56F6
        STA a5625
        JMP j56C3

b56F6   JSR s5AEB
        LDA a5AEA
        BEQ b5701
        JMP j571B

b5701   LDA #$01
        STA a5AEA
        LDA a5826
        BEQ b5718
        LDA a40D8
        BEQ b5701
        JSR j578A
        LDA a5826
        BNE b5701
b5718   JSR s58C0
j571B   JSR CheckSubGameSelection
        JMP j571B

;-------------------------------
; s5721
;-------------------------------
s5721   
        JSR s4F77
        STA a224A
        JSR s4F77
        STA a224D
        JSR s4F77
        STA a2252
        JSR s4F77
        STA a2255
        LDX #$00
b573B   JSR s4F77
        EOR f2240,X
        AND #$7F
        STA f2240,X
        INX 
        CPX #$08
        BNE b573B
        RTS 

a574C   .BYTE $00
;-------------------------------
; s574D
;-------------------------------
s574D   
        LDX #$00
b574F   LDA f5762,X
        AND #$3F
        STA SCREEN_RAM + $0398,X
        LDA #$01
        STA $DB98,X
        INX 
        CPX #$28
        BNE b574F
        RTS 

f5762   .BYTE $A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0
        .BYTE $A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0
        .BYTE $A0,$A0,$A0,$A0,$A0,$A0,$A0,$A7
        .BYTE $D3,$C3,$CF,$D2,$C5,$A7,$A0,$B0
        .BYTE $B0,$B0,$B0,$B0,$B0,$B0,$B0,$A0
j578A   TXA 
        PHA 
        TYA 
        PHA 
        LDA a40D8
        PHA 
        LDA #$00
        STA a40D8
        PLA 
        PHA 
        ROR 
        ROR 
        ROR 
        ROR 
        AND #$0F
        TAY 
b57A0   PLA 
        PHA 
        AND #$0F
        TAX 
b57A5   INC SCREEN_RAM + $03B6,X
        LDA SCREEN_RAM + $03B6,X
        CMP #$3A
        BNE b57B7
        LDA #$30
        STA SCREEN_RAM + $03B6,X
        DEX 
        BNE b57A5
b57B7   DEY 
        BNE b57A0
        PLA 
        PLA 
        TAY 
        PLA 
        TAX 
        RTS 

p57C0   .TEXT "RESPONSE MODE "
a57CE   .TEXT "                "
;-------------------------------
; s57DE
;-------------------------------
s57DE   
        PHA 
        CLC 
        ADC #$FA
        STA a57CE
        LDA #<p57C0
        STA a19
        LDA #>p57C0
        STA a1A
        LDA #$20
        JSR s5055
        PLA 
        RTS 

p57F4   .TEXT "PHOSPHENE LOST "
a5803   .TEXT "0 REMAINING."
        .TEXT "..."
j5812   TYA 
        CLC 
        ADC #$2F
        STA a5803
        LDA #<p57F4
        STA a19
        LDA #>p57F4
        STA a1A
        LDA #$40
        JMP s5055

a5826   .BYTE $00
;-------------------------------
; s5827
;-------------------------------
s5827   
        DEC a582D
        BEQ b582E
        RTS 

a582D   .BYTE $30
b582E   LDA #$30
        STA a582D
        LDA a5876
        CMP #$01
        BEQ b5866
        TAX 
        LDY f48F0,X
        LDA #$00
        STA a403E,Y
        LDA #<p586C
        STA a1B
        LDA #>p586C
        STA a1C
        LDA #$01
        STA a4141
        LDA #$14
        STA a40D8
        LDA #<p5877
        STA a19
        LDA #>p5877
        STA a1A
        LDA #$30
        JSR s5055
        DEC a5876
        RTS 

b5866   LDA #$00
        STA a5826
        RTS 

p586C   .BYTE $00,$01,$07,$03,$05,$04,$02,$06
        .BYTE $00,$FF
a5876   .BYTE $00
p5877   .BYTE $42    ;JAM 
        .TEXT "ONUS FOR ANY  PHOSPHENES LEFT"
f5895   .BYTE $88,$0F,$99,$01,$40,$21,$F8,$08
        .BYTE $00,$01,$10,$30,$FE,$0C,$00,$01
        .BYTE $00,$01
f58A7   .BYTE $8F,$0F,$BB,$03,$03,$21,$00,$40
        .BYTE $00,$01,$20,$80,$0C,$05,$04,$04
        .BYTE $00,$01,$A2,$00,$CA,$D0,$FD,$60
a58BF   .BYTE $00
;-------------------------------
; s58C0
;-------------------------------
s58C0   
        JSR s5A7B
        LDA a58BF
        BEQ b58C9
        RTS 

b58C9   LDA #<p5927
        STA a1B
        LDA #>p5927
        STA a1C
        LDA #$01
        STA a4141
        LDX #$00
b58D8   LDA f5915,X
        STA f401A,X
        INX 
        CPX #$12
        BNE b58D8
        LDA #<p593D
        STA a19
        LDA #>p593D
        STA a1A
        LDA #$C0
        JSR s5055
        LDA #<p6464
        STA a593B
b58F5   LDA #>p6464
        STA a593C
b58FA   LDA #$A8
        STA a40D8
        JSR j578A
        DEC a593C
        BNE b58FA
        DEC a593B
        BNE b58F5
        LDA #$65
        STA a40D8
        JSR j578A
        RTS 

f5915   .BYTE $88,$0F,$AA,$01,$20,$11,$FE,$10
        .BYTE $00,$10,$20,$20,$01,$08,$06,$05
        .BYTE $00,$01
p5927   .BYTE $02,$07,$02,$07,$02,$07,$02,$07
        .BYTE $02,$07,$02,$07,$02,$01,$00,$01
        .BYTE $00,$01,$00,$FF
a593B   .BYTE $00
a593C   .BYTE $00
p593D   .TEXT "!!! PE"
        .TEXT "RFECT !!!BONUS OF 106000"
f595B   .BYTE $88,$2F,$99,$01,$40,$21,$FC,$06
        .BYTE $FE,$04,$20,$10,$FE,$06,$FE,$03
        .BYTE $00,$01
f596D   .BYTE $88,$1F,$99,$01,$60,$21,$FA,$08
        .BYTE $00,$03,$10,$10,$FF,$0C,$00,$01
        .BYTE $00,$01
f597F   .BYTE $88,$7F,$AA,$02,$04,$21,$02,$06
        .BYTE $03,$03,$20,$10,$FF,$0F,$00,$01
        .BYTE $00,$01
f5991   .BYTE $08,$08,$08,$08,$04,$04,$04,$04
        .BYTE $02,$02,$02,$02,$01,$01,$01,$01
        .BYTE $01,$01,$01,$01,$01,$01,$01,$01
        .BYTE $01,$01,$01,$01
f59AD   .BYTE $01,$01,$01,$01,$02,$02,$02,$02
        .BYTE $03,$03,$03,$03,$04,$04,$04,$04
        .BYTE $05,$05,$05,$05,$06,$06,$06,$06
        .BYTE $07,$07,$07,$07,$08,$08,$08,$08
f59CD   .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
f59DD   .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
j59ED   DEC a5A5C
        BNE b5A10
        LDA #$1C
        STA a5A5C
        LDX #$00
b59F9   LDA f59DD,X
        BEQ b5A06
        INX 
        CPX #$10
        BNE b59F9
        JMP b5A10

b5A06   LDA #$01
        STA f59DD,X
        LDA #$00
        STA f59CD,X
b5A10   LDX #$00
b5A12   LDA f59DD,X
        BEQ b5A23
        DEC f59DD,X
        BNE b5A23
        TXA 
        PHA 
        JSR s5A29
        PLA 
        TAX 
b5A23   INX 
        CPX #$10
        BNE b5A12
        RTS 

;-------------------------------
; s5A29
;-------------------------------
s5A29   
        LDA f59CD,X
        STA aD0
        CLC 
        ROR 
        STA aD1
        INC f59CD,X
        LDA #$FF
        LDY aD0
        STA f2318,Y
        INY 
        TYA 
        STA aD0
        CMP #$48
        BNE b5A45
        RTS 

b5A45   LDY aD1
        LDA f5991,Y
        STA f59DD,X
        LDX f59AD,Y
        LDY aD0
        LDA #$00
f5A54   INY 
        STA f2318,Y
        DEX 
        BNE f5A54
        RTS 

a5A5C   .BYTE $01,$63,$64,$65,$66,$67,$68,$69
        .BYTE $6A,$6B,$6C,$6D,$6E,$6F
j5A6A   LDX #$00
b5A6C   LDA #$42
        STA SCREEN_RAM + $01F7,X
        STA SCREEN_RAM + $0297,X
        INX 
        CPX #$0F
        BNE b5A6C
        RTS 

a5A7A   .BYTE $00
;-------------------------------
; s5A7B
;-------------------------------
s5A7B   
        LDA a5A7A
        BNE b5A81
        RTS 

b5A81   DEC a5A7A
        LDA #$14
        STA a40D8
        JSR j578A
        LDA #<p5AB9
        STA a19
        LDA #>p5AB9
        STA a1A
        LDA #$20
        JSR s5055
        LDX a5A7A
        LDA #$20
        STA SCREEN_RAM + $02F9,X
        LDX #$00
b5AA3   LDA f5AD7,X
        STA f401A,X
        INX 
        CPX #$12
        BNE b5AA3
b5AAE   LDA a5028
        BNE b5AAE
        LDA a5A7A
        BNE b5A81
        RTS 

p5AB9   .TEXT "-- PSIONIXX -- 10,000 PER TIME"
f5AD7   .BYTE $88,$8F,$99,$01,$70,$11,$3C,$10
        .BYTE $80,$02,$20,$10,$80,$02,$06,$10
        .BYTE $00,$01
a5AE9   .BYTE $00
a5AEA   .BYTE $00
;-------------------------------
; s5AEB
;-------------------------------
s5AEB   
        LDX #$00
b5AED   LDY f5B01,X
        LDA f5B05,X
        STA SCREEN_RAM + $037D,Y
        LDA #$03
        STA $DB7D,Y
        INX 
        CPX #$04
        BNE b5AED
        RTS 

f5B01   .BYTE $00,$28,$01,$29
f5B05   .BYTE $99,$9A,$9B,$9C
p5B09   .BYTE $30,$30,$30,$30,$30,$30,$30,$30
        .BYTE $20,$20,$20,$20,$20,$20,$20,$20
        .BYTE $20,$20,$20,$20,$20,$20,$20,$20
        .BYTE $20,$20,$20,$20,$20,$20,$20,$20
        .BYTE $20,$20,$20,$20,$20,$20,$20,$20
        .BYTE $20,$20,$20,$20,$20,$20,$20,$20
        .BYTE $30,$30,$30,$30,$30,$30,$30,$30
        .BYTE $20,$20,$20,$20,$20,$20,$20,$20
        .BYTE $20,$20,$20,$20,$20,$20,$20,$20
        .BYTE $20,$20,$20,$20,$20,$20,$20,$20
        .BYTE $20,$20,$20,$20,$20,$20,$20,$20
        .BYTE $20,$20,$20,$20,$20,$20,$20,$20
        .BYTE $30,$30,$30,$30,$30,$30,$30,$30
        .BYTE $20,$20,$20,$20,$20,$20,$20,$20
        .BYTE $20,$20,$20,$20,$20,$20,$20,$20
        .BYTE $20,$20,$20,$20,$20,$20,$20,$20
        .BYTE $20,$20,$20,$20,$20,$20,$20,$20
        .BYTE $20,$20,$20,$20,$20,$20,$20,$20
        .BYTE $30,$30,$30,$30,$30,$30,$30,$30
        .BYTE $20,$20,$20,$20,$20,$20,$20,$20
        .BYTE $20,$20,$20,$20,$20,$20,$20,$20
        .BYTE $20,$20,$20,$20,$20,$20,$20,$20
        .BYTE $20,$20,$20,$20,$20,$20,$20,$20
        .BYTE $20,$20,$20,$20,$20,$20,$20,$20
        .BYTE $30,$30,$30,$30,$30,$30,$30,$30
        .BYTE $20,$20,$20,$20,$20,$20,$20,$20
        .BYTE $20,$20,$20,$20,$20,$20,$20,$20
        .BYTE $20,$20,$20,$20,$20,$20,$20,$20
        .BYTE $20,$20,$20,$20,$20,$20,$20,$20
        .BYTE $20,$20,$20,$20,$20,$20,$20,$20
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF
p5C00   .BYTE $06,$07,$08,$09,$0A,$0B,$0C,$0D
        .BYTE $0E,$0F,$10,$11,$12,$13,$14,$15
        .BYTE $16,$17,$18,$19,$1A,$1B,$1C,$1D
        .BYTE $1E,$1F,$20,$06,$06,$06,$0E,$0B
        .BYTE $12,$12,$15,$06,$1A,$0E,$0B,$18
        .BYTE $0B,$06,$06,$06,$1A,$0E,$0B,$06
        .BYTE $1F,$07,$11,$06,$19,$16,$0B,$0B
        .BYTE $11,$19,$06,$1A,$15,$06,$07,$14
        .BYTE $1F,$15,$14,$0B,$06,$1D,$0E,$15
        .BYTE $06,$0F,$19,$06,$08,$15,$1A,$0E
        .BYTE $0B,$18,$0F,$14,$0D,$06,$1A,$15
        .BYTE $06,$0A,$0B,$09,$15,$0A,$0B,$06
        .BYTE $1A,$0E,$0F,$19,$06,$06,$06,$06
        .BYTE $06,$1A,$0E,$0F,$19,$06,$0D,$07
        .BYTE $13,$0B,$06,$1D,$07,$19,$06,$1D
        .BYTE $18,$0F,$1A,$1A,$0B,$14,$06,$15
        .BYTE $1C,$0B,$18,$06,$07,$06,$0C,$15
        .BYTE $1B,$18,$06,$13,$15,$14,$1A,$0E
        .BYTE $06,$16,$0B,$18,$0F,$15,$0A,$06
        .BYTE $06,$06,$12,$15,$14,$0D,$0B,$18
        .BYTE $06,$1A,$0E,$0F,$19,$06,$0F,$1A
        .BYTE $13,$0B,$06,$16,$0B,$18,$0E,$07
        .BYTE $16,$19,$06,$08,$0B,$09,$07,$1B
        .BYTE $19,$0B,$06,$0F,$06,$0E,$07,$1C
        .BYTE $0B,$06,$0E,$07,$0A,$06,$0D,$12
        .BYTE $07,$14,$0A,$1B,$12,$07,$18,$06
        .BYTE $0C,$0B,$1C,$0B,$18,$06,$07,$12
        .BYTE $12,$06,$1A,$0E,$0B,$06,$1D,$07
        .BYTE $1F,$06,$1A,$0E,$18,$15,$1B,$0D
        .BYTE $0E,$06,$0F,$1A,$06,$06,$06,$06
        .BYTE $15,$0E,$06,$1D,$0B,$12,$12,$06
        .BYTE $19,$15,$06,$0F,$1A,$06,$0D,$15
        .BYTE $0B,$19,$06,$0F,$06,$0D,$1B,$0B
        .BYTE $19,$19,$06,$06,$06,$06,$06,$06
        .BYTE $1F,$07,$11,$06,$0E,$15,$16,$0B
        .BYTE $19,$06,$1F,$15,$1B,$06,$12,$0F
        .BYTE $11,$0B,$06,$13,$15,$06,$1D,$07
        .BYTE $18,$0A,$0B,$14,$19,$06,$20,$07
        .BYTE $18,$10,$07,$20,$06,$1A,$0F,$1A
        .BYTE $12,$0B,$06,$19,$09,$18,$0B,$0B
        .BYTE $14,$06,$06,$06,$06,$0B,$1E,$16
        .BYTE $0B,$09,$1A,$06,$1A,$15,$06,$19
        .BYTE $0B,$0B,$06,$13,$15,$18,$0B,$06
        .BYTE $15,$0C,$06,$1A,$0E,$07,$1A,$06
        .BYTE $19,$1A,$1B,$0C,$0C,$06,$0F,$14
        .BYTE $06,$1A,$0E,$0B,$06,$0C,$1B,$1A
        .BYTE $1B,$18,$0B,$06,$06,$06,$06,$07
        .BYTE $19,$06,$0F,$06,$1D,$18,$0F,$1A
        .BYTE $0B,$06,$1A,$0E,$0F,$19,$06,$0F
        .BYTE $06,$07,$13,$06,$12,$0F,$19,$1A
        .BYTE $0B,$14,$0F,$14,$0D,$06,$1A,$15
        .BYTE $06,$13,$0B,$06,$19,$1A,$0B,$18
        .BYTE $0B,$15,$06,$07,$14,$0A,$06,$08
        .BYTE $0B,$0F,$14,$0D,$06,$13,$0B,$0D
        .BYTE $07,$06,$11,$14,$07,$09,$11,$0B
        .BYTE $18,$0B,$0A,$06,$09,$15,$20,$06
        .BYTE $0F,$06,$19,$1A,$07,$1F,$0B,$0A
        .BYTE $06,$1B,$16,$06,$07,$12,$12,$06
        .BYTE $14,$0F,$1A,$0B,$06,$16,$18,$15
        .BYTE $0D,$18,$07,$13,$13,$0F,$14,$0D
        .BYTE $06,$06,$06,$06,$06,$06,$0F,$06
        .BYTE $19,$0E,$15,$1B,$12,$0A,$06,$08
        .BYTE $0B,$06,$0D,$0B,$1A,$1A,$0F,$14
        .BYTE $0D,$06,$13,$0B,$06,$07,$13,$0F
        .BYTE $0D,$07,$06,$1A,$0E,$0F,$19,$06
        .BYTE $1D,$0B,$0B,$11,$06,$0F,$06,$0E
        .BYTE $15,$16,$0B,$06,$19,$15,$06,$06
        .BYTE $06,$06,$0F,$0C,$06,$1F,$15,$1B
        .BYTE $06,$07,$18,$0B,$14,$1A,$06,$07
        .BYTE $12,$18,$0B,$07,$0A,$1F,$06,$15
        .BYTE $14,$06,$09,$15,$13,$16,$1B,$14
        .BYTE $0B,$1A,$06,$1A,$0E,$0B,$14,$06
        .BYTE $0D,$0B,$1A,$06,$07,$06,$13,$15
        .BYTE $0A,$0B,$13,$06,$07,$14,$0A,$06
        .BYTE $0D,$15,$06,$15,$14,$06,$12,$0F
        .BYTE $14,$0B,$06,$07,$1A,$06,$15,$14
        .BYTE $09,$0B,$06,$0F,$1A,$19,$06,$0D
        .BYTE $18,$0B,$07,$1A,$06,$0C,$1B,$14
        .BYTE $06,$06,$06,$06,$06,$06,$06,$0F
        .BYTE $14,$1A,$0B,$18,$0B,$19,$1A,$0F
        .BYTE $14,$0D,$06,$1A,$15,$06,$19,$0B
        .BYTE $0B,$06,$0E,$15,$1D,$06,$13,$07
        .BYTE $14,$1F,$06,$18,$0B,$1C,$0F,$0B
        .BYTE $1D,$0B,$18,$19,$06,$09,$15,$13
        .BYTE $16,$18,$0B,$0E,$0B,$14,$0A,$06
        .BYTE $1A,$0E,$0F,$19,$06,$15,$14,$0B
        .BYTE $06,$07,$14,$0A,$06,$1D,$0E,$0B
        .BYTE $1A,$0E,$0B,$18,$06,$20,$20,$07
        .BYTE $16,$06,$19,$12,$07,$0D,$06,$0F
        .BYTE $1A,$06,$15,$18,$06,$14,$15,$1A
        .BYTE $06,$06,$06,$06,$0F,$06,$0A,$15
        .BYTE $14,$1A,$06,$1A,$0E,$0F,$14,$11
        .BYTE $06,$20,$20,$07,$16,$06,$12,$0F
        .BYTE $11,$0B,$19,$06,$0E,$07,$0F,$18
        .BYTE $1F,$06,$16,$18,$15,$0D,$18,$07
        .BYTE $13,$13,$0B,$18,$19,$06,$06,$06
        .BYTE $06,$19,$1A,$0F,$12,$12,$06,$0F
        .BYTE $06,$0A,$15,$14,$1A,$06,$13,$0F
        .BYTE $14,$0A,$06,$06,$06,$06,$1A,$0E
        .BYTE $0B,$0F,$18,$06,$13,$0F,$14,$0A
        .BYTE $06,$0F,$19,$06,$13,$1F,$06,$07
        .BYTE $19,$0E,$1A,$18,$07,$1F,$06,$06
        .BYTE $06,$06,$06,$06,$06,$1D,$0B,$12
        .BYTE $12,$06,$19,$0B,$0B,$1F,$07,$06
        .BYTE $06,$1A,$0E,$0F,$19,$06,$0F,$19
        .BYTE $06,$1A,$0E,$0B,$06,$08,$0B,$07
        .BYTE $19,$1A,$06,$19,$0F,$0D,$14,$0F
        .BYTE $14,$0D,$06,$15,$0C,$0C,$06,$07
        .BYTE $14,$0A,$06,$12,$15,$15,$11,$0F
        .BYTE $14,$0D,$06,$0C,$1B,$18,$06,$1A
        .BYTE $0E,$0B,$06,$14,$0B,$07,$18,$0B
        .BYTE $19,$1A,$06,$0D,$15,$07,$1A,$06
        .BYTE $06,$06,$06,$06,$06,$06,$06,$06
        .BYTE $06,$06,$FF,$FF,$00,$FF,$00,$FF
        .BYTE $00,$FF,$00,$FF,$00,$FF,$00,$FF
        .BYTE $00,$FF,$00,$FF,$00,$FD,$C2,$BD
        .BYTE $00,$FF,$00,$FF,$1D,$FF,$00,$BF
        .BYTE $00,$FF,$00,$FF,$40,$FF,$00,$FF
        .BYTE $00,$FF,$00,$FF,$00,$FF,$00,$FF
        .BYTE $00,$FF,$00,$FF,$40,$FF,$90,$BD
        .BYTE $00,$FD,$00,$FF,$00,$FF,$42,$FD
        .BYTE $00,$FD,$00,$FD,$10,$FD,$40,$FD
        .BYTE $00,$FF,$00,$FF,$00,$FF,$00,$FF
        .BYTE $00,$FF,$00,$FF,$11,$FF,$02,$FD
        .BYTE $00,$FF,$00,$FF,$10,$FD,$00,$FF
        .BYTE $10,$FD,$40,$FF,$00,$FF,$00,$FD
        .BYTE $00,$FF,$00,$FF,$BD,$FF,$00,$FF
        .BYTE $B9,$FF,$00,$FF,$BD,$FD,$C2,$FF
        .BYTE $4C,$2B
        .BYTE $60
a6003   .BYTE $00
;-------------------------------
; s6004
;-------------------------------
s6004   
        LDX #$00
b6006   LDY f634A,X
        LDA #$70
        STA a4043,Y
        INX 
        CPX #$08
        BNE b6006
        LDX #$00
b6015   LDA #$20
        STA SCREEN_RAM + $02D0,X
        INX 
        CPX #$78
        BNE b6015
        LDA #$00
        STA $D017    ;Sprites Expand 2x Vertical (Y)
        STA $D01C    ;Sprites Multi-Color Mode Select
        STA $D01D    ;Sprites Expand 2x Horizontal (X)
        RTS 

;-------------------------------
; Orphan
;-------------------------------
        SEI 
        LDA a6003
        BNE b605C
        LDA #$01
        STA a6003
        LDA #$00
        STA a6F29
        STA a754E
        JSR s7470
        JSR s6F34
        LDX #$00
b6046   LDA #$00
        STA f754F,X
        INX 
        CPX #$0A
        BNE b6046
        LDX #$00
b6052   LDA #$FF
        STA f6455,X
        INX 
        CPX #$03
        BNE b6052
b605C   LDA a71C3
        BEQ b6066
        LDA #$01
        STA a71C2
b6066   JSR s7479
        LDA a41AF
        ASL 
        ASL 
        STA a6ADB
        JSR s6004
        JSR s60E0
        JSR s616C
        JSR s6F4E
        JSR s70E4
        CLI 
j6081   JSR s6F20
        JSR s413B
        JSR s6E5E
        JSR s71C4
        JMP j6081

;-------------------------------
; s6090
;-------------------------------
s6090   
        LDX a60DD
        LDA a71C3
        BNE b60DC
        LDY #$00
b609A   LDA f9660,Y
        STA SCREEN_RAM + $0028,X
        LDA f9688,Y
        STA SCREEN_RAM + $0050,X
        LDA f96B0,Y
        STA SCREEN_RAM + $0078,X
        LDA f96D8,Y
        STA SCREEN_RAM + $00A0,X
        LDA f9700,Y
        STA SCREEN_RAM + $00C8,X
        LDA f9728,Y
        STA SCREEN_RAM + $00F0,X
        LDA f9750,Y
        STA SCREEN_RAM + $0118,X
        LDA f9778,Y
        STA SCREEN_RAM + $0140,X
        LDA f97A0,Y
        STA SCREEN_RAM + $0168,X
        INX 
        CPX #$28
        BNE b60D7
        LDX #$00
b60D7   INY 
        CPY #$28
        BNE b609A
b60DC   RTS 

a60DD   .BYTE $00
a60DE   .BYTE $0C
a60DF   .BYTE $01
;-------------------------------
; s60E0
;-------------------------------
s60E0   
        JSR s6090
        LDA #$0A
        STA a05
        LDA #$63
        STA a07
        LDA a74D2
        STA a06
b60F0   LDA #$00
        STA a04
b60F4   JSR s4198
        INC a04
        LDA a04
        CMP #$28
        BNE b60F4
        INC a07
        INC a05
        LDA a05
        CMP #$12
        BNE b60F0
        LDX #$00
b610B   LDA a74D1
        STA $D828,X
        STA $D890,X
        DEX 
        BNE b610B
        LDX #$00
b6119   LDA #$20
        STA SCREEN_RAM + $0000,X
        STA SCREEN_RAM + $02D0,X
        INX 
        CPX #$28
        BNE b6119
        LDA #$09
        STA $D022    ;Background Color 1, Multi-Color Register 0
        LDA #$05
        STA $D023    ;Background Color 2, Multi-Color Register 1
        LDA $D011    ;VIC Control Register 1
        AND #$F8
        ORA #$03
        STA $D011    ;VIC Control Register 1
        LDA #$00
        STA $D015    ;Sprite display Enable
        STA a40D7
        STA a4142
        JSR s6328
        LDA #$02
        STA $D025    ;Sprite Multi-Color Register 0
        LDA #$03
        STA $D026    ;Sprite Multi-Color Register 1
        LDA #<p8090
        STA a403E
        LDA #>p8090
        STA a403F
        LDA #<$F006
        STA a4040
        LDA #>$F006
        STA a4041
        LDA #$01
        STA a4043
        RTS 

;-------------------------------
; s616C
;-------------------------------
s616C   
        LDX #$00
b616E   LDA f6186,X
        STA f4122,X
        LDA f618C,X
        STA f410A,X
        LDA f6191,X
        STA f4116,X
        INX 
        CPX #$06
        BNE b616E
        RTS 

f6186   .BYTE $24,$44,$64,$84,$BC,$FF
f618C   .BYTE $96,$B8,$C7,$D6,$ED
f6191   ADC (p61,X)
        ADC (p61,X)
        ADC (pAD,X)
        AND (pD0,X)
        STA a689E
        LDA a7230
        STA $D021    ;Background Color 0
        LDA $D016    ;VIC Control Register 2
        ORA #$10
        AND #$F0
        ORA a6217
        STA $D016    ;VIC Control Register 2
        JSR s67BB
        JSR s721A
        JMP j4132

        LDA a7231
        STA $D021    ;Background Color 0
        JSR s4129
        JSR s4135
        JMP j4132

        LDA a7232
        STA $D021    ;Background Color 0
        JSR s62B2
        JSR s6B87
        JMP j4132

        LDA a689E
        STA $D021    ;Background Color 0
        LDA $D016    ;VIC Control Register 2
        AND #$E0
        STA $D016    ;VIC Control Register 2
        JSR s64FB
        JSR $FF9F ;$FF9F - scan keyboard                    
        JMP j4132

        LDA $D01E    ;Sprite to Sprite Collision Detect
        STA a67BA
        JSR s63EA
        JSR s647F
        JSR s4138
        JSR s62A4
        JSR s6090
        JSR s412C
        JSR s692F
        JSR stroboscopeOnOff
        JSR s6732
        JSR s7006
        LDA $D01E    ;Sprite to Sprite Collision Detect
        JMP j4132

a6217   .BYTE $00
j6218   LDA a6251
        JSR s63B7
        AND #$07
        CLC 
        ADC a6217
        STA a6217
        AND #$F8
        BEQ b6236
        LDA a6217
        AND #$07
        STA a6217
        INC a60DD
b6236   LDA a6251
        ROR 
        ROR 
        ROR 
        AND #$07
        CLC 
        ADC a60DD
        CMP #$28
        BPL b624A
        STA a60DD
        RTS 

b624A   SEC 
        SBC #$28
        STA a60DD
        RTS 

a6251   .BYTE $00
j6252   LDA a6251
        EOR #$FF
        CLC 
        ADC #$01
        STA a62A2
        AND #$07
        STA a62A3
        JSR s63D1
        LDA a6217
        SEC 
        SBC a62A3
        STA a6217
        AND #$F8
        BEQ b627E
        LDA a6217
        AND #$07
        STA a6217
        DEC a60DD
b627E   LDA a62A2
        ROR 
        ROR 
        ROR 
        AND #$07
        STA a62A2
        LDA a60DD
        SEC 
        SBC a62A2
        STA a60DD
        AND #$80
        BNE b6298
        RTS 

b6298   LDA a60DD
        CLC 
        ADC #$28
        STA a60DD
        RTS 

a62A3   =*+$01
a62A2   BRK #$00
;-------------------------------
; s62A4
;-------------------------------
s62A4   
        LDA a6251
        AND #$80
        BNE b62AE
        JMP j6218

b62AE   JMP j6252

a62B1   .BYTE $06
;-------------------------------
; s62B2
;-------------------------------
s62B2   
        LDA $DC00    ;CIA1: Data Port Register A
        ORA a6F93
        STA a6327
        JSR s7170
        LDA #$01
        ORA a7233
        STA a4043
        DEC a62B1
        BEQ b62D1
        JSR s638B
        JMP j6309

b62D1   LDA #$03
        STA a62B1
        LDA a6327
        AND #$04
        BEQ b631E
        LDA a6327
        AND #$08
        BNE b62ED
        JSR s6A49
        DEC a6251
        JMP j636E

b62ED   DEC a638A
        BNE j6309
        LDA #$02
        STA a638A
        LDA a6251
        BEQ j6309
        AND #$80
        BNE b6306
        DEC a6251
        DEC a6251
b6306   INC a6251
j6309   LDA a6F93
        CMP #$FF
        BNE b6311
        RTS 

b6311   LDA a6389
        CMP #$F0
        BNE b631B
        JMP j6352

b631B   JMP j636E

b631E   INC a6251
        JSR s6A49
        JMP j6352

a6327   .BYTE $FF
;-------------------------------
; s6328
;-------------------------------
s6328   
        LDA #$00
        STA $D01C    ;Sprites Multi-Color Mode Select
        STA $D017    ;Sprites Expand 2x Vertical (Y)
        STA $D01D    ;Sprites Expand 2x Horizontal (X)
        LDX #$00
b6335   LDY f634A,X
        LDA #$00
        STA a403E,Y
        STA a4043,Y
        TXA 
        STA f4042,Y
        INX 
        CPX #$08
        BNE b6335
b6349   RTS 

f634A   .BYTE $00
f634B   .BYTE $10,$20,$30
f634E   .BYTE $40,$50
f6350   .BYTE $60,$70
j6352   LDA a7233
        BNE b6349
        LDA #$F0
        STA a4041
        STA a6389
        LDA a403E
        CMP #$90
        BNE b6367
        RTS 

b6367   INC a403E
        INC a403E
b636D   RTS 

j636E   LDA a7233
        BNE b636D
        LDA #$F1
        STA a6389
        STA a4041
        LDA a403E
        CMP #$20
        BEQ b636D
        DEC a403E
        DEC a403E
        RTS 

a6389   .BYTE $00
a638A   .BYTE $02
;-------------------------------
; s638B
;-------------------------------
s638B   
        JSR s66D1
        LDA a6327
        AND #$01
        BNE b63A2
        LDA a403F
        CMP #$38
        BEQ b63A2
        SEC 
        SBC #$04
        STA a403F
b63A2   LDA a6327
        AND #$02
        BNE b63B6
        LDA a403F
        CMP #$A4
        BEQ b63B6
        CLC 
        ADC #$04
        STA a403F
b63B6   RTS 

;-------------------------------
; s63B7
;-------------------------------
s63B7   
        PHA 
        CLC 
        ADC a60DF
        STA a60DF
        LDA a60DE
        ADC #$00
        CMP #$0F
        BNE b63CA
        LDA #$01
b63CA   AND #$0F
        STA a60DE
        PLA 
        RTS 

;-------------------------------
; s63D1
;-------------------------------
s63D1   
        LDA a60DF
        SEC 
        SBC a62A2
        STA a60DF
        LDA a60DE
        SBC #$00
        AND #$0F
        BNE b63E6
        LDA #$0E
b63E6   STA a60DE
        RTS 

;-------------------------------
; s63EA
;-------------------------------
s63EA   
        LDA a60DF
        ROR 
        ROR 
        ROR 
        ROR 
        AND #$0F
        STA a6454
        LDA a60DE
        ASL 
        ASL 
        ASL 
        ASL 
        AND #$F0
        ORA a6454
        EOR #$FF
        STA $D008    ;Sprite 4 X Pos
        LDA #$C4
        STA $D009    ;Sprite 4 Y Pos
        LDA #$F6
        STA SCREEN_RAM + $03FC
        LDA #$01
        STA $D02B    ;Sprite 4 Color
        LDA #$00
        STA $D01C    ;Sprites Multi-Color Mode Select
        STA $D010    ;Sprites 0-7 MSB of X coordinate
        STA $D017    ;Sprites Expand 2x Vertical (Y)
        STA $D01D    ;Sprites Expand 2x Horizontal (X)
        LDA #$F0
        STA $D015    ;Sprite display Enable
        LDX #$00
b642B   LDY f652F,X
        LDA f64F8,X
        STA $D00A,Y  ;Sprite 5 X Pos
        LDA #$C4
        STA $D00B,Y  ;Sprite 5 Y Pos
        LDA f6461,X
        STA SCREEN_RAM + $03FD,X
        LDA f645E,X
        ROR 
        ROR 
        ROR 
        AND #$07
        TAY 
        LDA f40DA,Y
        STA $D02C,X  ;Sprite 5 Color
        INX 
        CPX #$03
        BNE b642B
        RTS 

a6454   .BYTE $00
f6455   .BYTE $FF,$FF,$FF
f6458   .BYTE $30,$50,$70
f645B   .BYTE $90,$90,$90
f645E   .BYTE $37,$37,$37
f6461   .BYTE $DD,$DD,$DD
p6464   .BYTE $00,$00,$00
f6467   .BYTE $00,$00,$00
f646A   .BYTE $03,$06,$08
f646D   .BYTE $01,$01,$01
f6470   .BYTE $20,$30,$40
f6473   .BYTE $04,$06,$0C
f6476   .BYTE $01,$01,$01
f6479   .BYTE $00,$00,$00
f647C   .BYTE $00,$00,$00
;-------------------------------
; s647F
;-------------------------------
s647F   
        INC a689D
        LDX #$00
b6484   JSR s6490
        JSR s6540
        INX 
        CPX #$03
        BNE b6484
b648F   RTS 

;-------------------------------
; s6490
;-------------------------------
s6490   
        LDA f6455,X
        CMP #$FF
        BEQ b648F
        LDA a60DF
        SEC 
        SBC f6458,X
        STA a64F7
        LDA a60DE
        SBC f6455,X
        STA a64F6
        LDA a64F6
        BEQ b64BB
b64AF   LDA #$00
        LDY f634B,X
        STA a403E,Y
        STA f6467,X
        RTS 

b64BB   LDA a64F7
        AND #$F0
        CMP #$F0
        BEQ b64AF
        LDA #$01
        STA f6467,X
        LDY f634B,X
        LDA f645B,X
        STA a403F,Y
        LDA a64F7
        STA a403E,Y
        STA f647C,X
        LDA f6461,X
        STA a4041,Y
        LDA #$06
        STA a4043,Y
        LDA a689D
        AND #$0F
        TAY 
        LDA f40FA,Y
        LDY f634B,X
        STA a4040,Y
        RTS 

a64F6   .BYTE $00
a64F7   .BYTE $00
f64F8   .BYTE $00,$00,$00
;-------------------------------
; s64FB
;-------------------------------
s64FB   
        LDX #$00
b64FD   JSR s6506
        INX 
        CPX #$03
        BNE b64FD
        RTS 

;-------------------------------
; s6506
;-------------------------------
s6506   
        LDA f6455,X
        CMP #$FF
        BNE b6513
        LDA #$00
        STA f64F8,X
        RTS 

b6513   ASL 
        ASL 
        ASL 
        ASL 
        AND #$F0
        STA f64F8,X
        LDA f6458,X
        ROR 
        ROR 
        ROR 
        ROR 
        AND #$0F
        ORA f64F8,X
        EOR #$FF
        STA f64F8,X
        RTS 

        .BYTE $00
f652F   .BYTE $00,$02,$04
f6532   .BYTE $EB,$EC,$ED,$EE,$ED,$EC,$EB
a653A   =*+$01
;-------------------------------
; s6539
;-------------------------------
s6539   
        LDA $EEEC
        INC a653A
b653F   RTS 

;-------------------------------
; s6540
;-------------------------------
s6540   
        LDA f6455,X
        CMP #$FF
        BEQ b653F
        LDA a71C3
        BEQ b6552
        LDA #$FF
        STA f6455,X
        RTS 

b6552   JSR s6AB0
        LDA p6464,X
        BEQ b655D
        JMP j6605

b655D   DEC f646D,X
        BEQ b6563
        RTS 

b6563   LDA f646A,X
        STA f646D,X
        LDA f645E,X
        BNE b657B
        LDA #$00
        STA f6479,X
        LDA #$03
        STA p6464,X
        JMP s6540

b657B   INC f6461,X
        LDA f6461,X
        CMP #$EA
        BNE b658A
        LDA #$DD
        STA f6461,X
b658A   JSR s6590
        JMP j65B5

;-------------------------------
; s6590
;-------------------------------
s6590   
        DEC f6458,X
        LDA f6458,X
        CMP #$FF
        BNE b65A5
        DEC f6455,X
        LDA f6455,X
        AND #$0F
        STA f6455,X
b65A5   LDA f6455,X
        BNE b65B4
        LDA p6464,X
        BNE b65B4
        LDA #$04
        STA p6464,X
b65B4   RTS 

j65B5   DEC f6470,X
        BNE b6604
        JSR s6539
        AND #$07
        BEQ b65E3
        JSR s6539
        AND #$1F
        ADC #$06
        STA f6470,X
        LDA #$FA
        STA f6479,X
        JSR s6539
        AND #$03
        ADC #$02
        STA f6473,X
        STA f6476,X
        LDA #$01
        STA p6464,X
        RTS 

b65E3   JSR s6539
        AND #$1F
        ADC #$06
        STA f6470,X
        LDA #$02
        STA p6464,X
        JSR s6539
        AND #$07
        ADC #$04
        STA f6473,X
        STA f6476,X
        LDA #$00
        STA f6479,X
b6604   RTS 

j6605   CMP #$02
        BNE b6633
        DEC f6476,X
        BEQ b660F
b660E   RTS 

b660F   LDA f6473,X
        STA f6476,X
        LDY f6479,X
        LDA f6532,Y
        STA f6461,X
        INC f6479,X
        LDA f6479,X
        CMP #$07
        BNE b660E
        LDA #$00
        STA p6464,X
        LDA #$DD
        STA f6461,X
        RTS 

b6633   CMP #$01
        BEQ b663A
        JMP j66CE

b663A   DEC f66CA,X
        BEQ b6642
        JMP j66CD

b6642   LDA #$02
        STA f66CA,X
        LDA #$EA
        STA f6461,X
        LDA f645E,X
        BNE b6677
        LDA #$01
        STA f74FE,X
        LDA a40D8
        BNE b6660
        LDA #$15
        STA a40D8
b6660   LDA #$05
        STA p6464,X
        LDA #$00
        STA f6476,X
        LDA #$04
        STA f6473,X
        LDA #$03
        STA f6479,X
        JMP s6540

b6677   JSR s6590
        LDA f645B,X
        CLC 
        ADC f6479,X
        STA f645B,X
        DEC f6473,X
        BNE j66CD
        LDA f6476,X
        STA f6473,X
        INC f6479,X
        LDA f6479,X
        CMP #$07
        BNE j66CD
        LDA #$90
        STA f645B,X
        LDA #$DD
        STA f6461,X
        LDA #$02
        STA p6464,X
        LDA #$03
        STA f6473,X
        STA f6476,X
        LDA #$00
        LDA f4018
        AND #$80
        BNE b66C9
        STA f6479,X
        LDY #$00
b66BE   LDA f6A8C,Y
        STA f402C,Y
        INY 
        CPY #$12
        BNE b66BE
b66C9   RTS 

f66CA   .BYTE $01,$01,$01
j66CD   RTS 

j66CE   JMP j696C

;-------------------------------
; s66D1
;-------------------------------
s66D1   
        LDA a6327
        AND #$10
        BEQ b66DE
        LDA #$00
        STA a6A12
        RTS 

b66DE   LDA a6F93
        BNE b66EB
        LDA a6A12
        BEQ b66EC
        DEC a6A12
b66EB   RTS 

b66EC   LDA #$06
        STA a6A12
        LDX #$00
b66F3   LDA f672E,X
        BEQ b66FE
        INX 
        CPX #$02
        BNE b66F3
        RTS 

b66FE   LDY f634E,X
        LDA a403E
        STA a403E,Y
        STA f672E,X
        LDA a4041
        STA f6730,X
        LDA a403F
        STA a403F,Y
        STA f672C,X
        LDA #$F2
        STA a4041,Y
        LDX #$00
b6720   LDA f6A13,X
        STA f401A,X
        INX 
        CPX #$12
        BNE b6720
        RTS 

f672C   BRK #$00
f672E   BRK #$00
f6730   BRK #$00
;-------------------------------
; s6732
;-------------------------------
s6732   
        LDA a6F93
        BEQ b6738
        RTS 

b6738   LDX #$00
b673A   JSR s6743
        INX 
        CPX #$02
        BNE b673A
        RTS 

;-------------------------------
; s6743
;-------------------------------
s6743   
        LDA f672E,X
        BNE b6751
        LDY f634E,X
        LDA #$00
        STA a403E,Y
        RTS 

b6751   LDA f6730,X
        AND #$80
        BNE b6776
        LDA f6730,X
        TAY 
        LDA f688A,Y
        LDY f634E,X
        STA a4041,Y
        LDA #$01
        STA a4043,Y
        DEC f6730,X
        BEQ b6770
        RTS 

b6770   LDA #$00
        STA f672E,X
        RTS 

b6776   LDA f6730,X
        LDY f634E,X
        AND #$01
        BNE b6789
        LDA f672E,X
        SEC 
        SBC #$0A
        STA f672E,X
b6789   LDA f672E,X
        CLC 
        ADC #$05
        STA f672E,X
        STA a403E,Y
        LDA #$F2
        STA a4041,Y
        LDA #$01
        STA a4043,Y
        LDA a4040,Y
        CLC 
        ADC #$01
        STA a4040,Y
        LDA f672E,X
        AND #$F0
        BEQ b67B4
        CMP #$C0
        BEQ b67B4
        RTS 

b67B4   LDA #$00
        STA f672E,X
        RTS 

a67BA   .BYTE $00
;-------------------------------
; s67BB
;-------------------------------
s67BB   
        LDA a691A
        BEQ b67C3
        DEC a691A
b67C3   LDA a67BA
        AND #$0E
        BNE b67D5
        LDA a67BA
        AND #$C1
        BEQ b67D4
        JMP j6D5A

b67D4   RTS 

b67D5   PHA 
        JSR s689F
        LDA a67BA
        AND #$0E
        BNE b67E2
        PLA 
        RTS 

b67E2   PLA 
        PHA 
        AND #$02
        BEQ b67ED
        LDX #$00
        JMP j67FA

b67ED   PLA 
        PHA 
        AND #$04
        BEQ b67F8
        LDX #$01
        JMP j67FA

b67F8   LDX #$02
j67FA   PLA 
b67FB   LDY #$00
b67FD   LDA f6730,Y
        AND #$80
        BEQ b6819
        LDA f647C,X
        SEC 
        SBC f672E,Y
        PHA 
        AND #$80
        BEQ b6814
        PLA 
        EOR #$FF
        PHA 
b6814   PLA 
        CMP #$10
        BMI b6824
b6819   INY 
        CPY #$02
        BNE b67FD
        INX 
        CPX #$03
        BNE b67FB
        RTS 

b6824   LDA f645B,X
        SEC 
        SBC f672C,Y
        PHA 
        AND #$80
        BEQ b6834
        PLA 
        EOR #$FF
        PHA 
b6834   PLA 
        CMP #$18
        BMI b683C
        JMP b6819

b683C   LDA #$08
        STA f6730,Y
        LDA a6EF8
        BNE b6853
        LDA #<p6893
        STA a1B
        LDA #>p6893
        STA a1C
        LDA #$01
        STA a4141
b6853   STY a75B2
        LDY #$00
b6858   LDA f6A25,Y
        STA f4008,Y
        INY 
        CPY #$12
        BNE b6858
        LDA f645E,X
        SEC 
        SBC #$04
        STA f645E,X
        AND #$F0
        CMP #$F0
        BNE b6884
        LDA #$00
        STA f645E,X
        LDY #$00
b6879   LDA f6A9E,Y
        STA f402C,Y
        INY 
        CPY #$12
        BNE b6879
b6884   LDY a75B2
        JMP b6819

f688A   .BYTE $00
f688B   .BYTE $F7,$F8,$F9,$FA,$F9,$F8,$F7,$F4
p6893   .BYTE $07,$02,$07,$02,$02,$00,$00,$02
        .BYTE $00,$FF
a689D   .BYTE $00
a689E   .BYTE $00
;-------------------------------
; s689F
;-------------------------------
s689F   
        LDA a67BA
        AND #$01
        BNE b68A7
        RTS 

b68A7   LDX #$00
b68A9   LDA f647C,X
        ROR 
        AND #$7F
        STA a6C28
        LDA a403E
        ROR 
        AND #$7F
        SEC 
        SBC a6C28
        JSR s690F
        PHA 
        AND #$80
        BEQ b68C8
        PLA 
        JMP j68CD

b68C8   PLA 
        CMP #$08
        BMI b68D3
j68CD   INX 
        CPX #$03
        BNE b68A9
        RTS 

b68D3   LDA a403F
        SEC 
        SBC f645B,X
        JSR s690F
        CMP #$10
        BMI b68E2
b68E1   RTS 

b68E2   LDA a691A
        BNE b68E1
        LDA #$10
        STA a691A
        LDA #<p691B
        STA a1B
        LDA #>p691B
        STA a1C
        LDA #$01
        STA a4141
        JSR s6F0B
        LDA a6251
        AND #$80
        BNE b6909
        LDA #$F8
        STA a6251
        RTS 

b6909   LDA #$08
        STA a6251
        RTS 

;-------------------------------
; s690F
;-------------------------------
s690F   
        PHA 
        AND #$80
        BNE b6916
        PLA 
        RTS 

b6916   PLA 
        EOR #$FF
        RTS 

a691A   .BYTE $00
p691B   .BYTE $00,$01,$00,$01,$00,$01,$00,$01
        .BYTE $00,$01,$00,$01,$00,$01,$00,$01
        .BYTE $00,$01,$00,$FF
;-------------------------------
; s692F
;-------------------------------
s692F   
        LDA a71C3
        BEQ b6937
        JMP j7325

b6937   LDA a6251
        AND #$80
        BEQ b6946
        LDA a6251
        EOR #$FF
        JMP j6949

b6946   LDA a6251
j6949   AND #$C0
        BEQ b695F
        INC a696B
        LDA a696B
        STA $D020    ;Border Color
        STA $D021    ;Background Color 0
        LDA #$FF
        STA a6A8B
        RTS 

b695F   LDA #$00
        STA $D020    ;Border Color
        STA $D021    ;Background Color 0
        STA a6A8B
        RTS 

a696B   .BYTE $00
j696C   CMP #$03
        BEQ b6973
        JMP j6DDA

b6973   DEC a6979
        BEQ b697A
        RTS 

a6979   .BYTE $05
b697A   LDA #$03
        STA a6979
        LDY f6479,X
        LDA f69C1,Y
        LDY f634B,X
        STA a4041,Y
        STA f6461,X
        LDY f6479,X
        LDA f69EA,Y
        LDY f634B,X
        STA a403F,Y
        INC f6479,X
        LDA a4041,Y
        CMP #$FF
        BEQ b69A5
        RTS 

b69A5   LDA #$00
        STA a403E,Y
        LDA #$FF
        STA f6455,X
        LDY a6F29
        LDA a40D8
        BNE b69BD
        LDA f6F2A,Y
        STA a40D8
b69BD   JSR s711F
        RTS 

f69C1   .BYTE $EB,$EB,$EB,$EB,$EB,$EB,$EB,$EB
        .BYTE $EC,$EC,$EC,$EC,$ED,$ED,$EE,$EE
        .BYTE $EF,$EF,$EF,$EF,$EE,$EE,$ED,$ED
        .BYTE $EC,$EC,$EC,$EC,$ED,$ED,$EE,$EE
        .BYTE $EE,$EE,$EF,$EF,$EF,$EF,$EF,$EF
        .BYTE $FF
f69EA   .BYTE $90,$91,$90,$91,$90,$91,$90,$91
        .BYTE $90,$90,$90,$90,$90,$90,$91,$90
        .BYTE $91,$90,$90,$90,$90,$8F,$8F,$8E
        .BYTE $8E,$8E,$8E,$8E,$8F,$8F,$8F,$90
        .BYTE $91,$90,$91,$90,$00,$90,$90,$00
a6A12   .BYTE $00
f6A13   .BYTE $88,$0F,$AA,$01,$20,$21,$FC,$06
        .BYTE $00,$02,$20,$50,$04,$03,$02,$20
        .BYTE $00,$01
f6A25   .BYTE $81,$0F,$AA,$03,$20,$81,$00,$01
        .BYTE $00,$01,$80,$10,$FF,$0F,$00,$01
        .BYTE $00,$01
f6A37   .BYTE $81,$3F,$77,$01,$40,$81,$00,$0C
        .BYTE $00,$01,$80,$00,$FF,$03,$00,$01
        .BYTE $00,$01
;-------------------------------
; s6A49
;-------------------------------
s6A49   
        LDA a6EF8
        BEQ b6A52
        DEC a6EF8
        RTS 

b6A52   LDX #$00
b6A54   LDA f6A37,X
        STA f4008,X
        INX 
        CPX #$12
        BNE b6A54
        LDA a6251
        AND #$80
        BEQ b6A6E
        LDA a6251
        EOR #$FF
        JMP j6A71

b6A6E   LDA a6251
j6A71   CLC 
        ROR 
        AND #$7F
        ADC #$08
        STA f400C
        LDY a6A8B
        BEQ b6A8A
        LDA #$21
        STA f400D
        JSR s6539
        STA f400C
b6A8A   RTS 

a6A8B   .BYTE $00
f6A8C   .BYTE $8F,$0F,$AA,$01,$40,$81,$00,$01
        .BYTE $20,$02,$80,$10,$81,$0C,$00,$01
        .BYTE $00,$01
f6A9E   .BYTE $8F,$2F,$AA,$01,$10,$11,$03,$10
        .BYTE $00,$01,$20,$80,$FC,$04,$E0,$08
        .BYTE $40,$03
;-------------------------------
; s6AB0
;-------------------------------
s6AB0   
        LDA f6467,X
        BNE b6AB6
        RTS 

b6AB6   DEC f6AD7,X
        BNE b6AC5
        LDA a6ADB
        STA f6AD7,X
        JSR s6C45
b6AC4   RTS 

b6AC5   DEC f6AD4,X
        BNE b6AC4
        LDA a6ADA
        STA f6AD4,X
        JSR s6AFD
        RTS 

f6AD4   .BYTE $10,$12,$15
f6AD7   .BYTE $20,$30,$40
a6ADA   .BYTE $10
a6ADB   .BYTE $C0
f6ADC   .BYTE $00
a6ADD   .BYTE $00
f6ADE   .BYTE $00,$00
f6AE0   .BYTE $00,$00
f6AE2   .BYTE $00,$00
f6AE4   .BYTE $00,$00
f6AE6   .BYTE $00,$00
;-------------------------------
; s6AE8
;-------------------------------
s6AE8   
        LDA a6F93
        BEQ b6AF0
        LDY #$02
        RTS 

b6AF0   LDY #$00
b6AF2   LDA f6ADC,Y
        BEQ b6AFC
        INY 
        CPY #$02
        BNE b6AF2
b6AFC   RTS 

;-------------------------------
; s6AFD
;-------------------------------
s6AFD   
        JSR s6AE8
        CPY #$02
        BEQ b6AFC
        TXA 
        PHA 
        LDA a6C40
        STA f6AE0,Y
        STA f6AE2,Y
        LDA f647C,X
        CLC 
        ADC #$0C
        STA f6ADC,Y
        ROR 
        AND #$7F
        STA a6C28
        LDA a403E
        ROR 
        AND #$7F
        SEC 
        SBC a6C28
        STA a6C28
        PHA 
        AND #$80
        BNE b6B36
        LDA a6C28
        JMP j6B41

b6B36   LDA a6C28
        EOR #$FF
        CLC 
        ADC #$01
        STA a6C28
j6B41   ROR 
        ROR 
        ROR 
        ROR 
        AND #$07
        TAX 
        PLA 
        AND #$80
        BEQ b6B56
        LDA f6C29,X
        STA f6C3A,Y
        JMP j6B5C

b6B56   LDA f6C31,X
        STA f6C3A,Y
j6B5C   PLA 
        TAX 
        LDA a6C39
        STA f6AE4,Y
        STA f6AE6,Y
        LDA f645B,X
        SEC 
        SBC #$0C
        STA f6ADE,Y
        LDA a403F
        SEC 
        SBC f645B,X
        BPL b6B80
        LDA a6C3E
        STA f6C3C,Y
        RTS 

b6B80   LDA a6C3F
        STA f6C3C,Y
        RTS 

;-------------------------------
; s6B87
;-------------------------------
s6B87   
        LDA a6F93
        BEQ b6B8D
        RTS 

b6B8D   LDX #$00
b6B8F   LDA f6ADC,X
        BEQ b6B9A
        JSR s6BAB
        JMP j6BA5

b6B9A   LDY f6350,X
        LDA #$00
        STA a403E,Y
        STA f6ADC,X
j6BA5   INX 
        CPX #$02
        BNE b6B8F
        RTS 

;-------------------------------
; s6BAB
;-------------------------------
s6BAB   
        LDA f6C43,X
        BEQ b6BBA
        CMP #$02
        BNE b6BB7
        JMP j6D42

b6BB7   JMP j6C73

b6BBA   LDA f6AE0,X
        BEQ b6BD4
        DEC f6AE2,X
        BNE b6BD4
        LDA f6AE0,X
        STA f6AE2,X
        LDA f6ADC,X
        CLC 
        ADC f6C3A,X
        STA f6ADC,X
b6BD4   DEC f6AE4,X
        BNE b6BE9
        LDA f6AE6,X
        STA f6AE4,X
        LDA f6ADE,X
        CLC 
        ADC f6C3C,X
        STA f6ADE,X
b6BE9   LDA f6ADC,X
        LDY f6350,X
        STA a403E,Y
        AND #$F0
        BEQ b6BFA
        CMP #$B0
        BNE b6C03
b6BFA   LDA #$00
        STA a403E,Y
        STA f6ADC,X
        RTS 

b6C03   LDA f6ADE,X
        AND #$F0
        BEQ b6BFA
        CMP #$B0
        BEQ b6BFA
        LDA f6ADE,X
        STA a403F,Y
        LDA #$01
        STA a4040,Y
        INC f6C41,X
        LDA f6C41,X
        AND #$03
        CLC 
        ADC #$FB
        STA a4041,Y
        RTS 

a6C28   .BYTE $00
f6C29   .BYTE $FF,$FE,$FD,$FA,$F8,$F4,$F0,$F0
f6C31   .BYTE $01,$02,$03,$04,$06,$08,$10,$10
a6C39   .BYTE $03
f6C3A   .BYTE $00,$00
f6C3C   .BYTE $00,$00
a6C3E   .BYTE $FD
a6C3F   .BYTE $03
a6C40   .BYTE $02
f6C41   .BYTE $00,$00
f6C43   .BYTE $00,$00
;-------------------------------
; s6C45
;-------------------------------
s6C45   
        JSR s6AE8
        CPY #$02
        BNE b6C4D
        RTS 

b6C4D   LDA f647C,X
        STA f6ADC,Y
        LDA f645B,X
        STA f6ADE,Y
        LDA #$00
        STA f6AE0,Y
        STA f6AE4,Y
        LDA #$01
        STA f6C43,Y
        STA f6AE2,Y
        STA f6AE6,Y
        LDA a6D41
        STA f6C3C,Y
        RTS 

j6C73   DEC a6C79
        BEQ b6C7B
        RTS 

a6C79   .BYTE $01
a6C7A   .BYTE $03
b6C7B   LDA a6C7A
        STA a6C79
        DEC f6AE2,X
        BNE b6CA9
        LDA a6D2E
        STA f6AE2,X
        LDA a403E
        ROR 
        AND #$7F
        STA a6C28
        LDA f6ADC,X
        ROR 
        AND #$7F
        CMP a6C28
        BMI b6CA6
        DEC f6AE0,X
        DEC f6AE0,X
b6CA6   INC f6AE0,X
b6CA9   DEC f6AE6,X
        BEQ b6CD1
        LDA a6D2F
        STA f6AE6,X
        LDA a403F
        ROR 
        AND #$7F
        STA a6C28
        LDA f6ADE,X
        ROR 
        AND #$7F
        CMP a6C28
        BMI b6CCE
        DEC f6AE4,X
        DEC f6AE4,X
b6CCE   INC f6AE4,X
b6CD1   LDA f6AE0,X
        JSR s6D30
        STA f6AE0,X
        LDA f6AE4,X
        JSR s6D30
        STA f6AE4,X
        LDA f6AE4,X
        CLC 
        ADC f6ADE,X
        STA f6ADE,X
        LDY f6350,X
        STA a403F,Y
        LDA f6AE0,X
        CLC 
        ADC f6ADC,X
        STA f6ADC,X
        STA a403E,Y
        INC f6C41,X
        LDA f6C41,X
        AND #$07
        TAY 
        LDA f40EA,Y
        LDY f6350,X
        STA a4040,Y
        LDA f6C41,X
        AND #$03
        CLC 
        ADC #$FB
        STA a4041,Y
        DEC f6C3C,X
        BNE b6D2D
        LDA #$00
        STA f6C43,X
        STA f6ADC,X
        STA a403E,Y
b6D2D   RTS 

a6D2E   .BYTE $07
a6D2F   .BYTE $04
;-------------------------------
; s6D30
;-------------------------------
s6D30   
        PHA 
        AND #$80
        BNE b6D39
        PLA 
        AND #$03
        RTS 

b6D39   PLA 
        EOR #$FF
        AND #$03
        EOR #$FF
        RTS 

a6D41   .BYTE $50
j6D42   LDY f6AE0,X
        LDA f688A,Y
        LDY f6350,X
        STA a4041,Y
        DEC f6AE0,X
        BEQ b6D54
        RTS 

b6D54   LDA #$00
        STA f6ADC,X
        RTS 

j6D5A   AND #$01
        BNE b6D5F
        RTS 

b6D5F   LDX #$00
b6D61   LDA f6C43,X
        CMP #$02
        BEQ b6D81
        LDA a403E
        ROR 
        AND #$7F
        STA a6C28
        LDA f6ADC,X
        ROR 
        AND #$7F
        SBC a6C28
        JSR s690F
        CMP #$0C
        BMI b6D87
b6D81   INX 
        CPX #$02
        BNE b6D61
        RTS 

b6D87   LDA f6ADE,X
        ROR 
        AND #$7F
        STA a6C28
        LDA a403F
        ROR 
        AND #$7F
        SBC a6C28
        JSR s690F
        CMP #$0C
        BPL b6D81
        LDA #$02
        STA f6C43,X
        LDA #$08
        STA f6AE0,X
        LDA a6251
        AND #$80
        BEQ b6DBE
        LDA a6251
        EOR #$FF
        ROR 
        AND #$7F
        EOR #$FF
        JMP j6DC4

b6DBE   LDA a6251
        ROR 
        AND #$7F
j6DC4   STA a6251
        LDA #<p691B
        STA a1B
        LDA #>p691B
        STA a1C
        LDA #$01
        STA a4141
        JSR s6F0B
        JMP b6D81

j6DDA   CMP #$04
        BEQ b6DE0
        BNE b6E15
b6DE0   LDA f645E,X
        BNE b6DF7
        LDA a40D8
        BNE b6DF4
        LDA #$14
        STA a40D8
        LDA #$02
        STA f74FE,X
b6DF4   JMP b6660

b6DF7   DEC f645B,X
        BNE b6E14
        LDA #$FF
        STA f6455,X
        LDA #$00
        STA p6464,X
        LDA a71C3
        BNE b6E14
        INC a7153
        INC a7153
        JSR s711F
b6E14   RTS 

b6E15   LDA f645B,X
        CLC 
        ADC f6476,X
        STA f645B,X
        PHA 
        LDA f74FE,X
        BEQ b6E2C
        TAY 
        LDA f7500,Y
        STA f6461,X
b6E2C   PLA 
        AND #$F0
        CMP #$90
        BEQ b6E41
        DEC f6473,X
        BNE b6E40
        LDA #$04
        STA f6473,X
        INC f6476,X
b6E40   RTS 

b6E41   STA f645B,X
        LDA #$00
        STA f74FE,X
        LDA f6479,X
        CMP #$02
        BNE b6E53
        JMP b65E3

b6E53   LDA #$03
        STA p6464,X
        LDA #$00
        STA f6479,X
        RTS 

;-------------------------------
; s6E5E
;-------------------------------
s6E5E   
        LDA a71C3
        BNE b6E6D
        LDA a6A8B
        BNE b6E6D
        LDA a7153
        BNE b6E6E
b6E6D   RTS 

b6E6E   LDX #$00
b6E70   LDA f6455,X
        CMP #$FF
        BNE b6E7F
        JSR s6E85
        LDA a7153
        BEQ b6E6D
b6E7F   INX 
        CPX #$03
        BNE b6E70
        RTS 

;-------------------------------
; s6E85
;-------------------------------
s6E85   
        JSR s6539
        AND #$3F
        BEQ b6EBD
        LDA a60DE
        BEQ b6EBD
        CMP #$01
        BEQ b6EBD
        LDA a60DF
        STA f6458,X
        LDA a60DE
        STA f6455,X
        DEC f6455,X
        JSR s6539
        AND #$7F
        CLC 
        ADC #$80
        ADC f6458,X
        STA f6458,X
        LDA f6455,X
        ADC #$00
        STA f6455,X
        JMP j6EC8

b6EBD   LDA #$04
        STA f6455,X
        JSR s6539
        STA f6458,X
j6EC8   LDA #$05
        STA p6464,X
        LDA #$00
        STA f6476,X
        STA f645B,X
        LDA #$02
        STA f6479,X
        LDA #$04
        STA f6473,X
        LDA #$EA
        STA f6461,X
        LDA #$37
        STA f645E,X
        JSR s6539
        AND #$07
        ADC a74D3
        DEC a7153
        JSR s711F
        RTS 

a6EF8   .BYTE $00
f6EF9   .BYTE $81,$0F,$AA,$03,$20,$81,$00,$01
        .BYTE $00,$01,$80,$10,$FF,$0E,$00,$01
        .BYTE $00,$01
;-------------------------------
; s6F0B
;-------------------------------
s6F0B   
        LDY #$00
b6F0D   LDA f6EF9,Y
        STA f4008,Y
        INY 
        CPY #$12
        BNE b6F0D
        LDA #$10
        STA a6EF8
        JMP j6F67

;-------------------------------
; s6F20
;-------------------------------
s6F20   
        LDA a40D8
        BNE b6F26
        RTS 

b6F26   JMP j413E

a6F29   .BYTE $00
f6F2A   .BYTE $16,$26,$46,$86,$25,$45,$85,$24
        .BYTE $44,$84
;-------------------------------
; s6F34
;-------------------------------
s6F34   
        LDX #$00
b6F36   LDA #$07
        STA f6F46,X
        INX 
        CPX #$07
        BNE b6F36
        LDA #$07
        STA a6F4D
f6F45   RTS 

f6F46   .BYTE $07,$07,$07,$07,$07,$07,$07
a6F4D   .BYTE $07
;-------------------------------
; s6F4E
;-------------------------------
s6F4E   
        LDX #$00
b6F50   LDA f6F46,X
        BEQ b6F66
        TAY 
        LDA selectedSubGame,Y
        STA $DAF0,X
        LDA #$3D
        STA SCREEN_RAM + $02F0,X
        INX 
        CPX #$07
        BNE b6F50
b6F66   RTS 

j6F67   LDY a6F4D
        BEQ b6F66
        LDA f6F45,Y
        SEC 
        SBC #$01
        STA f6F45,Y
        BNE b6F85
        LDA #$00
        STA $DAEF,Y
        DEC a6F4D
        BNE b6F66
        JSR s6FB7
        RTS 

b6F85   STY a6C28
        TAY 
        LDA selectedSubGame,Y
        LDY a6C28
        STA $DAEF,Y
        RTS 

a6F93   .BYTE $00
f6F94   .BYTE $00,$00,$00,$00,$00
f6F99   .BYTE $00,$00,$00,$00,$00
f6F9E   .BYTE $00,$00,$00,$00,$00
f6FA3   .BYTE $00,$00,$00,$00,$00
f6FA8   .BYTE $04,$04,$04,$04,$04
f6FAD   .BYTE $00,$00,$00,$00,$00
f6FB2   .BYTE $00,$40,$50,$60,$70
;-------------------------------
; s6FB7
;-------------------------------
s6FB7   
        LDY #$00
b6FB9   LDA a403E
        STA f6F94,Y
        LDA a403F
        STA f6F99,Y
        JSR s6539
        AND #$07
        SBC #$04
        STA f6F9E,Y
        JSR s6539
        AND #$07
        SBC #$06
        STA f6FA3,Y
        LDA #$04
        STA f6FA8,Y
        STA f6FAD,Y
        INY 
        CPY #$05
        BNE b6FB9
        LDA #$FF
        STA a6F93
        LDA #<p7097
        STA a1B
        LDA #>p7097
        STA a1C
        LDA #$01
        STA a4141
        LDY #$00
b6FFA   LDA f70D2,Y
        STA f4008,Y
        INY 
        CPY #$12
        BNE b6FFA
        RTS 

;-------------------------------
; s7006
;-------------------------------
s7006   
        LDA a6F93
        CMP #$FF
        BEQ b700E
        RTS 

b700E   LDX #$00
        LDA #$00
        STA a7096
b7015   JSR s702C
        JSR s7051
        INX 
        CPX #$05
        BNE b7015
        INC a7050
        LDA a7096
        BNE b702B
        JMP j7503

b702B   RTS 

;-------------------------------
; s702C
;-------------------------------
s702C   
        LDY f6FB2,X
        LDA f6F94,X
        STA a403E,Y
        LDA f6F99,X
        STA a403F,Y
        LDA a7050
        AND #$07
        TAY 
        LDA f688B,Y
        LDY f6FB2,X
        STA a4041,Y
        LDA #$01
        STA a4043,Y
        RTS 

a7050   .BYTE $00
;-------------------------------
; s7051
;-------------------------------
s7051   
        LDA f6F94,X
        CLC 
        ADC f6F9E,X
        STA f6F94,X
        AND #$F0
        CMP #$F0
        BNE b7064
        STA f6F94,X
b7064   LDA f6F99,X
        CLC 
        ADC f6FA3,X
        STA f6F99,X
        AND #$F0
        BEQ b708A
        CMP #$F0
        BEQ b708A
        DEC f6FA8,X
        BNE b7084
        LDA f6FAD,X
        STA f6FA8,X
        INC f6FA3,X
b7084   LDA #$01
        STA a7096
        RTS 

b708A   STA f6F99,X
        LDA #$00
        LDY f6FB2,X
        STA a403E,Y
        RTS 

a7096   .BYTE $00
p7097   .BYTE $00,$01,$00,$01,$00,$01,$00,$01
        .BYTE $04,$05,$04,$05,$04,$05,$07,$02
        .BYTE $07,$02,$07,$02,$07,$00,$02,$00
        .BYTE $07,$00,$02,$00,$06,$01,$06,$01
        .BYTE $06,$01,$06,$01,$00,$00,$01,$00
        .BYTE $01,$00,$00,$00,$01,$00,$00,$00
        .BYTE $01,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$01,$FF
f70D2   .BYTE $81,$0F,$AA,$01,$03,$81,$01,$03
        .BYTE $00,$01,$80,$06,$FF,$05,$00,$0C
        .BYTE $00,$01
;-------------------------------
; s70E4
;-------------------------------
s70E4   
        LDX #$00
b70E6   LDA f7154,X
        AND #$3F
        STA SCREEN_RAM + $0311,X
        LDA #$01
        STA $DB11,X
        LDA f7162,X
        AND #$3F
        STA SCREEN_RAM + $0339,X
        LDA #$01
        STA $DB39,X
        INX 
        CPX #$0E
        BNE b70E6
        LDX a6F29
        BEQ s711F
b710A   INC SCREEN_RAM + $031E
        LDA SCREEN_RAM + $031E
        CMP #$3A
        BNE b711C
        LDA #$30
        STA SCREEN_RAM + $031E
        INC SCREEN_RAM + $031D
b711C   DEX 
        BNE b710A
;-------------------------------
; s711F
;-------------------------------
s711F   
        LDX a7153
        LDY #$00
b7124   LDA f6455,Y
        CMP #$FF
        BEQ b712C
        INX 
b712C   INY 
        CPY #$03
        BNE b7124
        LDA #$30
        STA SCREEN_RAM + $0346
        STA SCREEN_RAM + $0345
        CPX #$00
        BEQ b7152
b713D   INC SCREEN_RAM + $0346
        LDA SCREEN_RAM + $0346
        CMP #$3A
        BNE b714F
        LDA #$30
        STA SCREEN_RAM + $0346
        INC SCREEN_RAM + $0345
b714F   DEX 
        BNE b713D
b7152   RTS 

a7153   .TEXT $10
f7154   .TEXT "BONUS LEVEL 00"
f7162   .TEXT "CAMELS LEFT 00"
;-------------------------------
; s7170
;-------------------------------
s7170   
        LDA a6251
        CMP #$80
        BEQ b7178
b7177   RTS 

b7178   LDA a71C3
        BNE b7177
        LDA #$01
        STA a71C2
        STA a71C3
        LDA #$0C
        STA a6F93
        LDY #$00
b718C   LDA #$FF
        STA f6455,Y
        LDA #$00
        STA a7230,Y
        INY 
        CPY #$03
        BNE b718C
        LDA #$00
        STA $D020    ;Border Color
        STA $D021    ;Background Color 0
        STA a689E
        LDA a4041
        CMP #$F1
        BNE b71B4
        LDA #$20
        STA a403E
        BNE b71B9
b71B4   LDA #$90
        STA a403E
b71B9   LDA #$02
        STA a7233
        JSR s7253
        RTS 

a71C2   .BYTE $00
a71C3   .BYTE $00
;-------------------------------
; s71C4
;-------------------------------
s71C4   
        LDA a71C2
        BNE b71CA
        RTS 

b71CA   CMP #$02
        BNE b71D1
        JMP j7371

b71D1   LDA #$00
        STA a71C2
        LDA #>SCREEN_RAM + $0028
        STA aFC
        LDA #<SCREEN_RAM + $0028
        STA aFB
        LDX #$00
b71E0   LDA f7211,X
        LDY #$00
b71E5   STA (pFB),Y
        PHA 
        LDA aFC
        PHA 
        CLC 
        ADC #$D4
        STA aFC
        LDA $DAB0
        STA (pFB),Y
        PLA 
        STA aFC
        PLA 
        INY 
        CPY #$28
        BNE b71E5
        LDA aFB
        CLC 
        ADC #$28
        STA aFB
        LDA aFC
        ADC #$00
        STA aFC
        INX 
        CPX #$09
        BNE b71E0
b7210   RTS 

f7211   .BYTE $C0,$C1,$C2,$C3,$C4,$C5,$C6,$C7
        .BYTE $20
;-------------------------------
; s721A
;-------------------------------
s721A   
        LDA a71C3
        BEQ b7210
;-------------------------------
; s721F
;-------------------------------
s721F   
        LDX #$FF
        LDY #$00
b7223   LDA f2318,Y
        STA f2540,X
        DEX 
        INY 
        CPY #$40
        BNE b7223
        RTS 

a7230   .BYTE $0B
a7231   .BYTE $0C
a7232   .BYTE $0F
a7233   .BYTE $00
f7234   .BYTE $00,$00,$00,$00,$00,$00,$00
f723B   .BYTE $00,$00,$00,$00,$00,$00,$00
f7242   .BYTE $00,$00,$00,$00,$00,$00,$00
f7249   .BYTE $00,$00,$00,$00,$00,$00,$00,$01
        .BYTE $03
a7252   .BYTE $03
;-------------------------------
; s7253
;-------------------------------
s7253   
        LDX #$00
b7255   LDA #$F0
        LDY f634B,X
        STA a403E,Y
        JSR s6539
        AND #$3F
        CLC 
        ADC #$28
        STA f7234,X
        JSR s6539
        AND a7252
        CLC 
        ADC #$01
        STA f723B,X
        LDA a7328
        STA f7242,X
        STA f7249,X
        LDA #$00
        STA a4043,Y
        INX 
        CPX #$07
        BNE b7255
        LDX #$00
b7289   LDA f758E,X
        STA f4008,X
        LDA f75A0,X
        STA f401A,X
        INX 
        CPX #$12
        BNE b7289
        RTS 

j729B   LDX #$00
b729D   JSR s72B4
        INX 
        CPX #$07
        BNE b729D
        INC f6C41
        LDA #$80
        STA a6251
        JSR s7329
        JSR s74D4
        RTS 

;-------------------------------
; s72B4
;-------------------------------
s72B4   
        LDA a4041
        LDY f634B,X
        CMP #$F1
        BEQ b72C9
        LDA f723B,X
        CLC 
        ASL 
        ADC a403E,Y
        STA a403E,Y
b72C9   LDA a403E,Y
        SEC 
        SBC f723B,X
        STA a403E,Y
        LDA f7234,X
        STA a403F,Y
        DEC f7249,X
        BNE b72F6
        LDA f7242,X
        STA f7249,X
        LDA a403F
        SEC 
        SBC f7234,X
        BPL b72F3
        DEC f7234,X
        DEC f7234,X
b72F3   INC f7234,X
b72F6   LDA f6C41
        AND #$03
        CLC 
        ADC #$FB
        STA a4041,Y
        LDA f6C41
        AND #$0F
        TAY 
        LDA f40EA,Y
        LDY f634B,X
        STA a4040,Y
        LDA a403E,Y
        AND #$F0
        CMP #$F0
        BNE b7324
        JSR s6539
        AND a7252
        ADC #$01
        STA f723B,X
b7324   RTS 

j7325   JMP j729B

a7328   .BYTE $05
;-------------------------------
; s7329
;-------------------------------
s7329   
        DEC a7359
        BEQ b732F
        RTS 

b732F   LDA a7358
        STA a7359
        LDA a6F93
        CMP #$FF
        BEQ b7324
        LDA a4041
        CMP #$F0
        BEQ b7349
        INC a403E
        INC a403E
b7349   DEC a403E
        LDA a403E
        AND #$F0
        BEQ b735A
        CMP #$90
        BEQ b735A
        RTS 

a7358   .BYTE $03
a7359   .BYTE $01
b735A   LDA #$00
        STA a71C3
        STA a6F93
        STA a7233
        LDA #$02
        STA a71C2
        STA a6251
        STA a754C
        RTS 

j7371   LDX #$F8
        TXS 
        JSR s750B
        LDA #$00
        STA a71C2
        STA f6ADC
        STA a6ADD
        JSR s6F34
        LDA a754D
        BNE b7390
        INC a6F29
        INC a6F29
b7390   DEC a6F29
        LDA a6F29
        CMP #$FF
        BEQ b73A3
        CMP #$0A
        BNE b73A8
        DEC a6F29
        BNE b73A8
b73A3   LDA #$00
        STA a6F29
b73A8   LDA #$00
        STA a754D
        JSR s7470
        JSR s60E0
        JSR s6F4E
        LDA a4041
        CMP #$F0
        JSR s70E4
        BNE b73CD
        LDA #$20
        STA a403E
        LDA #$3F
        STA a6251
        JMP j7588

b73CD   LDA #$90
        STA a403E
        LDA #$D0
        STA a6251
        JMP j7588

f73DA   .BYTE $0E,$0F,$00,$00,$0B,$06,$06,$02
        .BYTE $07,$00
f73E4   .BYTE $04,$0C,$00,$00,$00,$06,$0E,$0A
        .BYTE $07,$00
f73EE   .BYTE $06,$0B,$00,$00,$00,$06,$0E,$0A
        .BYTE $07,$00
f73F8   .BYTE $02,$04,$04,$06,$05,$02,$04,$07
        .BYTE $04,$00
f7402   .BYTE $0F,$0F,$0F,$01,$0F,$0E,$0F,$0F
        .BYTE $0F,$08
f740C   .BYTE $08,$0A,$0E,$10,$12,$14,$18,$1A
        .BYTE $1C,$50
f7416   .BYTE $10,$0C,$08,$04,$01,$01,$08,$04
        .BYTE $02,$01
f7420   .BYTE $07,$05,$03,$07,$02,$05,$03,$01
        .BYTE $03,$01
f742A   .BYTE $04,$04,$03,$02,$02,$02,$01,$01
        .BYTE $02,$01
f7434   .BYTE $03,$02,$03,$02,$02,$01,$02,$01
        .BYTE $02,$01
f743E   .BYTE $50,$60,$70,$70,$80,$80,$80,$80
        .BYTE $90,$90
f7448   .BYTE $02,$01,$02,$02,$02,$02,$01,$01
        .BYTE $02,$01
f7452   .BYTE $03,$02,$01,$03,$02,$02,$01,$03
        .BYTE $02,$01
f745C   .BYTE $05,$02,$04,$02,$01,$01,$04,$03
        .BYTE $02,$01
f7466   .BYTE $03,$03,$07,$07,$07,$03,$07,$07
        .BYTE $0F,$0F
;-------------------------------
; s7470
;-------------------------------
s7470   
        LDX a6F29
        LDA f740C,X
        STA a7153
;-------------------------------
; s7479
;-------------------------------
s7479   
        LDX a6F29
        LDA f73DA,X
        STA a7230
        LDA f73E4,X
        STA a7231
        LDA f73EE,X
        STA a7232
        LDA f73F8,X
        STA a74D2
        LDA f7402,X
        STA a74D1
        LDA f7416,X
        STA a74D3
        LDA f7420,X
        STA a6D2E
        LDA f742A,X
        STA a6D2F
        LDA f7434,X
        STA a6C7A
        LDA f743E,X
        STA a6D41
        LDA f7448,X
        STA a6C40
        LDA f7452,X
        STA a6C39
        LDA f7466,X
        STA a7252
        LDA f745C,X
        STA a7328
        RTS 

a74D1   .BYTE $00
a74D2   .BYTE $00
a74D3   .BYTE $00
;-------------------------------
; s74D4
;-------------------------------
s74D4   
        LDA a67BA
        AND #$01
        BNE b74DC
b74DB   RTS 

b74DC   LDA a4141
        BNE b74DB
        LDA #<p691B
        STA a1B
        LDA #>p691B
        STA a1C
        LDA #$01
        STA a4141
        LDX #$00
b74F0   LDA f6EF9,X
        STA f4008,X
        INX 
        CPX #$12
        BNE b74F0
        JMP j6F67

f74FE   .BYTE $00,$00
f7500   .BYTE $00,$F5,$FF
j7503   LDA #$01
        STA a754D
        JMP b735A

;-------------------------------
; s750B
;-------------------------------
s750B   
        LDA a7153
        BEQ b7516
        LDA #$00
        STA a754C
        RTS 

b7516   LDA a6F4D
        BEQ b752D
        JSR s7561
j751E   LDA a6F4D
        CMP #$01
        BNE b7533
        TAY 
        LDA f6F45,Y
        CMP #$01
        BNE b7533
b752D   LDA #$00
        STA a754C
        RTS 

b7533   JSR j6F67
        LDY a6F29
        INY 
b753A   TYA 
        PHA 
        LDA #$16
        STA a40D8
        JSR j413E
        PLA 
        TAY 
        DEY 
        BNE b753A
        JMP j751E

a754C   .BYTE $00
a754D   .BYTE $00
a754E   .BYTE $00
f754F   .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00
f7559   .BYTE $00,$01,$28,$29
f755D   .BYTE $9D,$9F,$9E,$A0
;-------------------------------
; s7561
;-------------------------------
s7561   
        LDX a6F29
        LDA f754F,X
        BEQ b756A
b7569   RTS 

b756A   LDA #$FF
        STA f754F,X
        LDX a754E
        CPX #$04
        BEQ b7569
        LDY f7559,X
        LDA f755D,X
        STA SCREEN_RAM + $037F,Y
        LDA #$04
        STA $DB7F,Y
        INC a754E
        RTS 

j7588   JSR s7470
        JMP j6081

f758E   .BYTE $81,$0F,$CC,$01,$0C,$81,$FF,$0C
        .BYTE $00,$01,$80,$20,$03,$06,$03,$03
        .BYTE $10,$10
f75A0   .BYTE $88,$0F,$CC,$01,$50,$21,$03,$04
        .BYTE $04,$02,$20,$70,$FC,$02,$F0,$05
        .BYTE $08,$18
a75B2   .BYTE $00,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
        .BYTE $FF,$00,$FF,$00,$FF,$20,$F0,$00
        .BYTE $FF,$00,$FF,$00,$FF,$00,$FF,$00
        .BYTE $FF,$00,$FF,$00,$FF,$00,$FF,$00
        .BYTE $FF,$40,$61,$00,$FF,$00,$BD,$00
        .BYTE $FF,$00,$FF,$C2,$FF,$00,$BF,$00
        .BYTE $F7,$00,$FF,$A0,$FF,$00,$FF,$00
        .BYTE $FF,$00,$FF,$00,$FF,$00,$FF,$00
        .BYTE $FF,$00,$5D,$40,$9D,$40,$FF,$40
        .BYTE $FF,$00,$FF,$00,$BD,$00,$4F,$00
        .BYTE $FF,$00,$FD,$02,$FF,$40,$FF,$00
        .BYTE $FF,$00,$FF,$00,$FF,$00,$FF,$00
        .BYTE $FF,$00,$FF,$19,$FF,$00,$FF,$00
        .BYTE $FF,$00,$FF,$00,$BF,$00,$FF,$00
        .BYTE $FF,$00,$FF,$00,$FF,$C0,$FF,$00
        .BYTE $FF,$00,$FF,$00,$FF,$00,$BD,$00
        .BYTE $FF,$00,$BD,$40,$3D,$40,$20,$3C
        .BYTE $00,$FF,$00,$FF,$00,$DF,$0D,$FF
        .BYTE $00,$FF,$00,$FF,$00,$FF,$00,$BF
        .BYTE $00,$FF,$00,$FF,$00,$FF,$00,$FF
        .BYTE $00,$3D,$99,$DD,$00,$BD,$02,$FF
        .BYTE $00,$FF,$00,$1D,$00,$FF,$00,$BF
        .BYTE $08,$FF,$00,$4E,$00,$FF,$00,$FF
        .BYTE $00,$FF,$00,$FF,$00,$BF,$00,$BF
        .BYTE $00,$BD,$80,$BD,$A2,$BD,$00,$BD
        .BYTE $00,$FF,$00,$FF,$02,$FF,$B0,$FF
        .BYTE $00,$FF,$00,$FC,$00,$08,$00,$FF
        .BYTE $00,$FF,$00,$FF,$00,$FF,$00,$FF
        .BYTE $00,$FF,$00,$C0,$00,$BD,$00,$FF
        .BYTE $00,$FF,$00,$FF,$40,$FF,$00,$FF
        .BYTE $00,$FF,$00,$FF,$00,$1D,$00,$FF
        .BYTE $00,$FF,$00,$FF,$00,$FF,$02,$FF
        .BYTE $00,$FF,$00,$BF,$42,$8C,$FF,$40
        .BYTE $FF,$00,$FF,$00,$FF,$20,$FD,$00
        .BYTE $FF,$00,$FF,$00,$FF,$00,$FF,$00
        .BYTE $FF,$00,$FF,$00,$FF,$00,$FF,$00
        .BYTE $FF,$40,$ED,$00,$FF,$00,$BF,$00
        .BYTE $FF,$00,$FF,$42,$FF,$00,$FF,$00
        .BYTE $F7,$00,$FF,$00,$FF,$00,$FF,$00
        .BYTE $FF,$00,$FF,$00,$FF,$00,$FF,$00
        .BYTE $FF,$00,$DF,$40,$BF,$40,$FF,$40
        .BYTE $FF,$00,$FF,$00,$BF,$00,$4F,$00
        .BYTE $FF,$00,$FD,$02,$FF,$40,$FF,$00
        .BYTE $FF,$00,$FF,$00,$FF,$00,$FF,$00
        .BYTE $FF,$00,$FF,$98,$FF,$00,$FF,$00
        .BYTE $FF,$00,$FF,$00,$BF,$00,$FF,$00
        .BYTE $FF,$00,$FF,$00,$FF,$40,$FF,$00
        .BYTE $FF,$00,$FF,$00,$FF,$00,$BF,$00
        .BYTE $FF,$00,$BF,$40,$BD,$40,$20,$BD
        .BYTE $00,$FF,$00,$FF,$00,$DF,$08,$FF
        .BYTE $00,$FF,$00,$FF,$00,$FF,$00,$FF
        .BYTE $00,$FF,$00,$FF,$00,$FF,$00,$FF
        .BYTE $00,$BD,$98,$FD,$00,$BD,$00,$FF
        .BYTE $00,$FF,$00,$BD,$00,$FF,$00,$FF
        .BYTE $08,$FF,$00,$DF,$00,$FF,$00,$FF
        .BYTE $00,$FF,$00,$FF,$00,$BF,$00,$BF
        .BYTE $00,$FF,$80,$BD,$02,$BD,$00,$BD
        .BYTE $00,$FF,$00,$FF,$02,$FF,$B0,$FF
        .BYTE $00,$FF,$00,$FD,$00,$9D,$00,$FF
        .BYTE $00,$FF,$00,$FF,$00,$FF,$00,$FF
        .BYTE $00,$FF,$00,$C0,$00,$BF,$00,$FF
        .BYTE $00,$FF,$00,$FF,$40,$FF,$00,$FF
        .BYTE $00,$FF,$00,$FF,$00,$BD,$00,$FF
        .BYTE $00,$FF,$00,$FF,$00,$FF,$00,$FF
        .BYTE $00,$FF,$40
        .BYTE $BF,$42,$9D ;LAX $9D42,Y
        SEI 
        JSR s781A
        JSR s78A2
        JSR s7C45
        JSR s7D7F
        JSR s7DE4
        CLI 
j7811   JSR s7C8F
        JSR s7CD6
        JMP j7811

;-------------------------------
; s781A
;-------------------------------
s781A   
        LDX #$00
b781C   LDA #$20
        STA SCREEN_RAM + $0000,X
        DEX 
        BNE b781C
        LDA $D016    ;VIC Control Register 2
        AND #$F0
        ORA #$08
        STA $D016    ;VIC Control Register 2
        LDA #$0A
        STA a05
        LDA #$63
        STA a07
        LDA a78DF
        STA a06
b783B   LDA #$00
        STA a04
b783F   JSR s4198
        LDA a05
        PHA 
        SEC 
        SBC #$0A
        STA a05
        LDA a07
        PHA 
        CLC 
        CLC 
        ADC #$5D
        STA a07
        JSR s4198
        PLA 
        STA a07
        PLA 
        STA a05
        INC a04
        LDA a04
        CMP #$28
        BNE b783F
        INC a07
        INC a05
        LDA a05
        CMP #$12
        BNE b783B
        LDA $D011    ;VIC Control Register 1
        AND #$F8
        ORA #$03
        STA $D011    ;VIC Control Register 1
        LDA #$00
        STA $D015    ;Sprite display Enable
        STA a40D7
        STA a4142
        STA $D404    ;Voice 1: Control Register
        STA $D40B    ;Voice 2: Control Register
        STA $D412    ;Voice 3: Control Register
        JSR s6004
        LDX #$00
b7891   LDA #$42
        STA SCREEN_RAM + $0140,X
        LDA a78DF
        STA $D940,X
        INX 
        CPX #$50
        BNE b7891
        RTS 

;-------------------------------
; s78A2
;-------------------------------
s78A2   
        LDX #$00
b78A4   LDA f78BC,X
        STA f4122,X
        LDA f78BF,X
        STA f410A,X
        LDA f78C2,X
        STA f4116,X
        INX 
        CPX #$03
        BNE b78A4
        RTS 

f78BC   .BYTE $C0,$FF,$FF
f78BF   .BYTE $C5,$C5,$C5
f78C2   .BYTE $78,$78,$78
        LDA a7E2C
        AND #$0F
        STA $D020    ;Border Color
        STA $D021    ;Background Color 0
        JSR s4138
        JSR s721F
        JSR s78FC
        JSR $FF9F ;$FF9F - scan keyboard                    
        JMP j4132

a78DF   .BYTE $0B
a78E0   .BYTE $15
a78E1   .BYTE $0B
a78E2   .BYTE $01
;-------------------------------
; s78E3
;-------------------------------
s78E3   
        LDY a78E0
        LDX a78E1
        LDA $0340,X
        STA a23
        LDA $0360,X
        CLC 
        ADC #$D4
        STA a24
        LDA a78E2
        STA (p23),Y
        RTS 

;-------------------------------
; s78FC
;-------------------------------
s78FC   
        LDA a78DF
        STA a78E2
        JSR s78E3
        JSR s7911
        LDA #$01
        STA a78E2
        JSR s78E3
        RTS 

;-------------------------------
; s7911
;-------------------------------
s7911   
        DEC a7917
        BEQ b7918
        RTS 

a7917   .BYTE $02
b7918   LDA a7D25
        STA a7917
        LDA $DC00    ;CIA1: Data Port Register A
        STA a797D
        AND #$02
        BEQ b7937
        DEC a78E1
        LDA a78E1
        CMP #$FF
        BNE b7937
        LDA #$11
        STA a78E1
b7937   LDA a797D
        AND #$01
        BEQ b794D
        INC a78E1
        LDA a78E1
        CMP #$12
        BNE b794D
        LDA #$00
        STA a78E1
b794D   LDA a797D
        AND #$08
        BEQ b7963
        DEC a78E0
        LDA a78E0
        CMP #$FF
        BNE b7963
        LDA #$27
        STA a78E0
b7963   LDA a797D
        AND #$04
        BEQ b7979
        INC a78E0
        LDA a78E0
        CMP #$28
        BNE b7979
        LDA #$00
        STA a78E0
b7979   JSR s7C52
        RTS 

a797D   .BYTE $7F
;-------------------------------
; s797E
;-------------------------------
s797E   
        LDX a79BF
        LDY a79C0
        LDA $0340,X
        STA a25
        LDA $0360,X
        CLC 
        ADC #$D4
        STA a26
        LDA (p25),Y
        AND #$0F
        CMP a78DF
        BEQ b79A6
        TAX 
        LDA f79AC,X
        CMP a79BD
        BEQ b79A6
        BPL b79A6
        RTS 

b79A6   LDA a79BE
        STA (p25),Y
        RTS 

f79AC   .BYTE $08,$08,$01,$08,$06,$04,$07,$03
        .BYTE $02,$08,$08,$08,$08,$08,$05,$08
        .BYTE $08
a79BD   .BYTE $07
a79BE   .BYTE $0B
a79BF   .BYTE $0C
a79C0   .BYTE $0C
;-------------------------------
; s79C1
;-------------------------------
s79C1   
        LDA a79BF
        AND #$80
        BEQ b79C9
b79C8   RTS 

b79C9   LDA a79BF
        CMP #$12
        BPL b79C8
        LDA a79C0
        AND #$80
        BNE b79C8
        LDA a79C0
        CMP #$28
        BPL b79C8
        LDA a79BE
        TAX 
        LDA f79AC,X
        STA a79BD
        DEC a79BD
        JSR s797E
        LDA a7A3F
        BNE b79F4
b79F3   RTS 

b79F4   CMP #$02
        BEQ b7A27
        CMP #$03
        BEQ b7A33
        LDA #$27
        SEC 
        SBC a79C0
        STA a79C0
        JSR s797E
        LDA a7A3F
        CMP #$01
        BEQ b79F3
        LDA #$11
        SEC 
        SBC a79BF
        STA a79BF
        JSR s797E
        LDA #$27
        SEC 
        SBC a79C0
        STA a79C0
        JMP s797E

b7A27   LDA #$11
        SEC 
        SBC a79BF
        STA a79BF
        JMP s797E

b7A33   LDA #$27
        SEC 
        SBC a79C0
        STA a79C0
        JMP b7A27

a7A3F   .BYTE $01
f7A40   .BYTE $02,$08,$07,$05,$0E,$04,$06
a7A47   .BYTE $0B
a7A48   .BYTE $07
a7A49   .BYTE $13
;-------------------------------
; s7A4A
;-------------------------------
s7A4A   
        LDA #$00
        STA a7A49
        STA a7A48
        LDA a7AC3
        STA a79C0
        LDA a7AC4
        STA a79BF
        JSR s79C1
        LDA a7AC2
        BNE b7A67
        RTS 

b7A67   LDX a7A49
        LDA f7A9A,X
        CMP #$55
        BEQ b7A8B
        CLC 
        ADC a7AC3
        STA a79C0
        LDA f7AAE,X
        CLC 
        ADC a7AC4
        STA a79BF
        JSR s79C1
        INC a7A49
        JMP b7A67

b7A8B   INC a7A49
        INC a7A48
        LDA a7A48
        CMP a7AC2
        BNE b7A67
        RTS 

f7A9A   .BYTE $FF,$01,$55,$FE,$02,$55,$FD,$03
        .BYTE $55,$FC,$04,$55,$FB,$05,$55,$FA
        .BYTE $06,$55,$55,$55
f7AAE   .BYTE $01,$FF,$55,$FE,$02,$55,$03,$FD
        .BYTE $55,$FC,$04,$55,$05,$FB,$55,$FA
        .BYTE $06,$55,$55,$55
a7AC2   .BYTE $07
a7AC3   .BYTE $15
a7AC4   .BYTE $06
f7AC5   .BYTE $01,$01,$01,$01,$01,$01,$01,$01
        .BYTE $01,$01,$01,$01,$01,$01,$01,$01
        .BYTE $01,$01,$01,$01,$01,$01,$01,$01
        .BYTE $01,$01,$01,$01,$01,$01,$01,$01
        .BYTE $01,$01,$01,$01,$01,$01,$01,$01
        .BYTE $01,$01,$01,$01,$01,$01,$01,$01
        .BYTE $01,$01,$01,$01,$01,$01,$01,$01
        .BYTE $01,$01,$01,$01,$01,$01,$01,$01
f7B05   .BYTE $15,$15,$15,$15,$15,$15,$15,$15
        .BYTE $15,$15,$15,$15,$15,$15,$15,$15
        .BYTE $15,$15,$15,$15,$15,$15,$15,$15
        .BYTE $15,$15,$15,$15,$15,$15,$15,$15
        .BYTE $15,$15,$15,$15,$15,$15,$15,$15
        .BYTE $15,$15,$15,$15,$15,$14,$15,$16
        .BYTE $17,$18,$19,$1A,$1B,$1C,$1D,$1D
        .BYTE $1D,$1C,$1B,$1A,$19,$18,$17,$16
f7B45   .BYTE $02,$03,$04,$05,$06,$07,$08,$09
        .BYTE $0A,$0B,$0C,$0D,$0E,$0F,$10,$11
        .BYTE $00,$01,$02,$03,$04,$05,$06,$07
        .BYTE $08,$09,$0A,$0B,$0C,$0D,$0E,$0F
        .BYTE $10,$11,$00,$01,$02,$03,$04,$05
        .BYTE $06,$07,$08,$09,$0A,$0C,$0B,$0A
        .BYTE $09,$08,$07,$06,$05,$04,$03,$02
        .BYTE $01,$00,$11,$11,$11,$11,$00,$01
f7B85   .BYTE $0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C
        .BYTE $0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C
        .BYTE $0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C
        .BYTE $0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C
        .BYTE $0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C
        .BYTE $0C,$04,$07,$0A,$02,$0C,$0C,$0C
        .BYTE $0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C
        .BYTE $0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C
f7BC5   .BYTE $0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C
        .BYTE $0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C
        .BYTE $0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C
        .BYTE $0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C
        .BYTE $0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C
        .BYTE $0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C
        .BYTE $0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C
        .BYTE $0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C
f7C05   .BYTE $08,$08,$08,$08,$08,$08,$08,$08
        .BYTE $08,$08,$08,$08,$08,$08,$08,$08
        .BYTE $08,$08,$08,$08,$08,$08,$08,$08
        .BYTE $08,$08,$08,$08,$08,$08,$08,$08
        .BYTE $08,$08,$08,$08,$08,$08,$08,$08
        .BYTE $08,$08,$08,$08,$08,$08,$08,$08
        .BYTE $08,$08,$08,$08,$08,$08,$08,$08
        .BYTE $08,$08,$08,$08,$08,$08,$08,$08
;-------------------------------
; s7C45
;-------------------------------
s7C45   
        LDX #$00
b7C47   LDA #$08
        STA f7C05,X
        INX 
        CPX #$40
        BNE b7C47
b7C51   RTS 

;-------------------------------
; s7C52
;-------------------------------
s7C52   
        LDA a797D
        AND #$10
        BNE b7C51
        LDX a7C8E
        LDA f7C05,X
        AND #$08
        BEQ b7C82
        LDA #$00
        STA f7C05,X
        LDA a78E0
        STA f7B05,X
        LDA a78E1
        STA f7B45,X
        LDA a7E2D
        STA f7AC5,X
        LDA #$0C
        STA f7B85,X
        STA f7BC5,X
b7C82   INC a7C8E
        LDA a7C8E
        AND #$3F
        STA a7C8E
        RTS 

a7C8E   .BYTE $2D
;-------------------------------
; s7C8F
;-------------------------------
s7C8F   
        LDX a7CD5
        LDA f7C05,X
        AND #$08
        BNE b7CC9
        DEC f7B85,X
        BNE b7CC9
        LDA f7BC5,X
        STA f7B85,X
        LDA f7B05,X
        STA a7AC3
        LDA f7B45,X
        STA a7AC4
        LDA f7C05,X
        STA a7AC2
        TAY 
        LDA f7AC5,X
        STA a7A3F
        LDA f7A40,Y
        STA a79BE
        INC f7C05,X
        JSR s7A4A
b7CC9   INC a7CD5
        LDA a7CD5
        AND #$3F
        STA a7CD5
        RTS 

a7CD5   .BYTE $01
;-------------------------------
; s7CD6
;-------------------------------
s7CD6   
        LDA currentPressedKey
        CMP #$40
        BNE b7CE2
        LDA #$00
        STA a7D26
b7CE1   RTS 

b7CE2   LDY a7D26
        BNE b7CE1
        CMP #$0D
        BNE b7D03
        LDA #$01
        STA a7D26
        INC a7E2D
        LDA a7E2D
        CMP #$05
        BNE b7CFF
        LDA #$00
        STA a7E2D
b7CFF   JSR s7DE4
        RTS 

b7D03   CMP #$14
        BNE b7D1E
        LDA #$01
        STA a7D26
        INC a7D25
        LDA a7D25
        CMP #$05
        BNE b7CFF
        LDA #$01
        STA a7D25
        JMP b7CFF

b7D1E   CMP #$04
        BEQ b7D27
        JMP s413B

a7D25   .BYTE $02    ;JAM 
b7D27   =*+$01
a7D26   BRK #$AD
        STA a2902
        ORA (pF0,X)
        ORA #$EE
        BIT aA97E
        ORA (p8D,X)
        ROL a7D
        RTS 

        LDA a78DF
        STA a7D7E
        SEI 
        INC a78DF
        LDA a78DF
        AND #$0F
        STA a78DF
        STA a7A47
        LDX #$00
b7D4E   LDA $D800,X
        JSR s7D73
        STA $D800,X
        LDA $D900,X
        JSR s7D73
        STA $D900,X
        LDA $D9D0,X
        JSR s7D73
        STA $D9D0,X
        DEX 
        BNE b7D4E
        LDA #$01
        STA a7D26
        CLI 
b7D72   RTS 

;-------------------------------
; s7D73
;-------------------------------
s7D73   
        AND #$0F
        CMP a7D7E
        BNE b7D72
        LDA a78DF
        RTS 

a7D7E   .BYTE $00
;-------------------------------
; s7D7F
;-------------------------------
s7D7F   
        LDX #$00
b7D81   LDA f7D94,X
        AND #$3F
        STA SCREEN_RAM + $0320,X
        LDA #$0B
        STA $DB20,X
        INX 
        CPX #$28
        BNE b7D81
        RTS 

f7D94   .TEXT "*** KLINGE MODE *** HAVE FUN- USE S,C,F1"
f7DBC   .TEXT "      SYMMETRY .... CURSOR SPEED 0      "
;-------------------------------
; s7DE4
;-------------------------------
s7DE4   
        LDX #$00
b7DE6   LDA f7DBC,X
        AND #$3F
        STA SCREEN_RAM + $02D0,X
        LDA #$0B
        STA $DAD0,X
        INX 
        CPX #$28
        BNE b7DE6
        LDA a7D25
        CLC 
        ADC #$30
        STA SCREEN_RAM + $02F1
        LDA a7E2D
        ASL 
        ASL 
        TAY 
        LDX #$00
b7E09   LDA f7E18,Y
        AND #$3F
        STA SCREEN_RAM + $02DF,X
        INY 
        INX 
        CPX #$04
        BNE b7E09
        RTS 

f7E18   .TEXT "NONE Y   X  X-Y QUAD"
a7E2C   .BYTE $00
a7E2D   .BYTE $01,$DD
        STA f6461,X
        RTS 

        CMP #$01
        BEQ b7E3A
        JMP j66CE

b7E3A   DEC f66CA,X
        BEQ b7E42
        JMP j66CD

b7E42   LDA #$02
        STA f66CA,X
        LDA #$EA
        STA f6461,X
        LDA f645E,X
        BNE b7E77
        LDA #$01
        STA f74FE,X
        LDA a40D8
        BNE b7E60
        LDA #$15
        STA a40D8
b7E60   LDA #$05
        STA p6464,X
        LDA #$00
        STA f6476,X
        LDA #$04
        STA f6473,X
        LDA #$03
        STA f6479,X
        JMP s6540

b7E77   JSR s6590
        LDA f645B,X
        CLC 
        ADC f6479,X
        STA f645B,X
        DEC f6473,X
        BNE b7ECD
        LDA f6476,X
        STA f6473,X
        INC f6479,X
        LDA f6479,X
        CMP #$07
        BNE b7ECD
        LDA #$90
        STA f645B,X
        LDA #$DD
        STA f6461,X
        LDA #$02
        STA p6464,X
        LDA #$03
        STA f6473,X
        STA f6476,X
        LDA #$00
        LDA f4018
        AND #$80
        BNE b7EC9
        STA f6479,X
        LDY #$00
b7EBE   LDA f6A8C,Y
        STA f402C,Y
        INY 
        CPY #$12
        BNE b7EBE
b7EC9   RTS 

        ORA (p01,X)
b7ECD   =*+$01
        ORA (p60,X)
        JMP j696C

        LDA a6327
        AND #$10
        BEQ b7EDE
        LDA #$00
        STA a6A12
        RTS 

b7EDE   LDA a6F93
        BNE b7EEB
        LDA a6A12
        BEQ b7EEC
        DEC a6A12
b7EEB   RTS 

b7EEC   LDA #$06
        STA a6A12
        LDX #$00
b7EF3   LDA f672E,X
        BEQ b7EFE
        INX 
        CPX #$02
        BNE b7EF3
        RTS 

b7EFE   LDY $FF4E,X
        RTI 

        .BYTE $FF,$00,$FF ;ISC $FF00,X
        .BYTE $00,$FF,$20,$FD,$00,$FF,$00,$FF
        .BYTE $00,$FF,$00,$FF,$00,$FF,$00,$FF
        .BYTE $00,$FF,$00,$FF,$00,$FF,$40,$ED
        .BYTE $00,$FF,$00,$FF,$00,$FF,$00,$FF
        .BYTE $42,$FF,$00,$FF,$00,$F7,$00,$FF
        .BYTE $00,$FF,$00,$FF,$00,$FF,$00,$FF
        .BYTE $00,$FF,$00,$FF,$00,$FF,$00,$FF
        .BYTE $40,$BF,$40,$FF,$40,$FF,$00,$FF
        .BYTE $00,$BF,$00,$5F,$00,$FF,$00,$FD
        .BYTE $02,$FF,$40,$FF,$00,$FF,$00,$FF
        .BYTE $00,$FF,$00,$FF,$00,$FF,$00,$FF
        .BYTE $90,$FF,$00,$FF,$00,$FF,$00,$FF
        .BYTE $00,$BF,$00,$FF,$00,$FF,$00,$FF
        .BYTE $00,$FF,$40,$FF,$00,$FF,$00,$FF
        .BYTE $00,$FF,$00,$BF,$00,$FF,$00,$BF
        .BYTE $40,$BD,$40,$00,$BD,$00,$FF,$00
        .BYTE $FF,$00,$DF,$00,$FF,$00,$FF,$00
        .BYTE $FF,$00,$FF,$00,$FF,$00,$FF,$00
        .BYTE $FF,$00,$FF,$00,$FF,$00,$BD,$90
        .BYTE $FD,$00,$FD,$00,$FF,$00,$FF,$00
        .BYTE $FD,$00,$FF,$00,$FF,$08,$FF,$00
        .BYTE $FF,$00,$FF,$00,$FF,$00,$FF,$00
        .BYTE $FF,$00,$FF,$00,$BF,$00,$FF,$80
        .BYTE $BD,$00,$BD,$00,$BD,$00,$FF,$00
        .BYTE $FF,$00,$FF,$A0,$FF,$00,$FF,$00
        .BYTE $FD,$00,$BD,$00,$FF,$00,$FF,$00
        .BYTE $FF,$00,$FF,$00,$FF,$00,$FF,$00
        .BYTE $C0,$00,$BF,$00,$FF,$00,$FF,$00
        .BYTE $FF,$40,$FF,$00,$FF,$00,$FF,$00
        .BYTE $FF,$00,$FD,$00,$FF,$00,$FF,$00
        .BYTE $FF,$00,$FF,$00,$FF,$00,$FF,$40
        .BYTE $BF,$42,$BD,$00,$8D,$72,$8E,$00
        .BYTE $C2,$CD,$38,$30,$20,$F7,$82,$B0
        .BYTE $03,$4C,$C0,$85
b8011   LDX #$00
        STX $0211
b8016   JSR s85A9
        CMP #$20
        BEQ b8011
        JSR s8144
        BCC b802A
        CMP #$3A
        BCC b8011
        CMP #$46
        BEQ b8011
b802A   STA $012F,X
        INX 
        CPX #$03
        BNE b8016
b8032   DEX 
        BMI b8049
        LDA $012F,X
        SEC 
        SBC #$3F
        LDY #$05
b803D   LSR 
        ROR $0211
        ROR $0210
        DEY 
        BNE b803D
        BEQ b8032
b8049   LDX #$02
b804B   JSR $FFCF ;$FFCF - input character                  
        CMP #$3A
        BEQ b8074
        CMP #$0D
        BEQ b8074
        CMP #$20
        BEQ b804B
        JSR s8144
        BCC b806E
        JSR s8581
        LDY aC1
        STY aC2
        STA aC1
        LDA #$30
        STA $0210,X
        INX 
b806E   STA $0210,X
        INX 
        BNE b804B
b8074   STX $0129
        JSR s86E0
        LDX #>p00
        STX a3B
j807E   LDX #<p00
        STX a3A
        LDA a3B
        JSR s8643
        LDX a3D
        STX $012A
        TAX 
        LDA f87C8,X
p8090   JSR s8116
        LDA f8788,X
        JSR s8116
        LDX #$06
b809B   CPX #$03
        BNE b80B1
        LDY a3E
        BEQ b80B1
b80A3   LDA a3D
        CMP #$E8
        LDA #$30
a80A9   BCS b80C8
        JSR s8113
        DEY 
        BNE b80A3
b80B1   ASL a3D
        BCC b80C3
        LDA f877B,X
        JSR s8127
        LDA f8781,X
        BEQ b80C3
        JSR s8127
b80C3   DEX 
        BNE b809B
        BEQ b80CE
b80C8   JSR s8113
        JSR s8113
b80CE   LDA $0129
        CMP a3A
        BEQ b80D8
        JMP j811D

b80D8   JSR s8157
        LDY a3E
        BEQ b810C
        LDA $012A
        CMP #$9D
        BNE b8104
        JSR s82BF
        BCC b80F5
        TYA 
        BNE b8124
        LDX $012D
        BMI b8124
        BPL b80FD
b80F5   INY 
        BNE b8124
        LDX $012D
        BPL b8124
b80FD   DEX 
        DEX 
        TXA 
        LDY a3E
        BNE b8107
b8104   LDA $00DB,Y
b8107   STA (pC1),Y
        DEY 
        BNE b8104
b810C   LDA a3B
        STA (pC1),Y
        JMP j8433

;-------------------------------
; s8113
;-------------------------------
s8113   
        JSR s8116
;-------------------------------
; s8116
;-------------------------------
s8116   
        JSR s813C
        BEQ b8137
b811B   PLA 
        PLA 
j811D   INC a3B
        BEQ b8124
        JMP j807E

b8124   JMP j85C0

;-------------------------------
; s8127
;-------------------------------
s8127   
        JSR s813C
        BEQ b8137
        CMP #$29
        BEQ b8139
        ORA #$08
        CMP #$2C
        BNE b811B
b8137   =*+$01
        BIT a3AE6
b8139   LDX a3C
        RTS 

;-------------------------------
; s813C
;-------------------------------
s813C   
        STX a3C
        LDX a3A
        CMP $0210,X
        RTS 

;-------------------------------
; s8144
;-------------------------------
s8144   
        CMP #$30
        BCC b8156
        CMP #$3A
        BCC b8155
        CMP #$47
        BCS b8153
        CMP #$41
        RTS 

b8153   CLC 
        RTS 

b8155   SEC 
b8156   RTS 

;-------------------------------
; s8157
;-------------------------------
s8157   
        LDX #$02
b8159   LDA fC0,X
        PHA 
        LDA fC2,X
        STA fC0,X
        PLA 
        STA fC2,X
        DEX 
        BNE b8159
        RTS 

;-------------------------------
; s8167
;-------------------------------
s8167   
        LDA #$18
        STA $012A
        LDX #$00
        BIT a39
        BMI b8173
        TAX 
b8173   STX $02A5
        CPX aD6
        BEQ b817B
        RTS 

b817B   BIT a39
        BPL b8182
        JSR s8DAB
b8182   JSR s8D96
        CMP #$2C
        BEQ b81AA
        CMP #$3A
        BEQ b81AA
        CMP #$27
        BEQ b81AA
b8191   LDA a39
        EOR #$80
        JSR $FFD2 ;$FFD2 - output character                 
        DEC $012A
        BNE b8182
        LDA #$00
        STA a39
;-------------------------------
; s81A1
;-------------------------------
s81A1   
        LDX $02A5
        DEX 
        STX aD6
        JMP j8DA8

b81AA   TAY 
        JSR s8301
        BCC b8191
        STA aC3
        STX aC4
        JSR s81A1
        BIT a39
        BMI b81DF
        JSR s8DAE
        CPY #$2C
        BEQ b81CE
        CPY #$27
        BEQ b81D7
        LDA #$07
        JSR s8626
        JMP j83B2

b81CE   JSR s863F
        JSR s8620
        JMP j85CC

b81D7   LDA #$1F
        JSR s8626
        JMP j83BD

b81DF   STY a39
        LDA #$80
        STA aD8
        JSR $E981
        LDA aD9
        ORA #$80
        STA aD9
        LDA #$00
        STA aD8
        JSR s8DAB
        LDY a39
        LDA #$F7
        CPY #$3A
        BEQ b822A
        LDA #$DF
        CPY #$27
        BEQ b822A
        STA a3A
b8205   JSR s8626
b8208   JSR s863F
        JSR s8620
        CMP aC3
        BEQ b8224
        BMI b8208
        LDA aC3
        STA aC1
        LDA aC4
        STA aC2
        INC a3A
        LDA a3A
        BNE b8205
        STA a3E
b8224   INC a3E
        LDA a3E
        EOR #$FF
b822A   JSR s8626
        JSR s832D
        JSR s8DAB
        BNE b8238
j8235   .BYTE $02    ;JAM 
        TAY 
b8238   =*+$01
        STA $FAA2
        TXS 
        STX a9D
        STX aCC
        LDX #$00
        STX a3B
        STX a99
        LDA #$03
        STA $0287
        JSR s8D63
b824D   .BYTE $02    ;JAM 
        .BYTE $12    ;JAM 
        BNE b827A
        .BYTE $0F,$D0,$F9 ;SLO $F9D0
        JSR $FFE4 ;$FFE4 - get a byte from channel          
        BEQ b824D
        STA a39
        AND #$7F
        CMP #$11
        BNE b8270
        LDA #$03
        CMP a9A
        BNE b8270
        JSR s8D63
        JSR s8167
        JSR s8D63
b8270   LDA a39
        CMP #$0D
        BEQ b827C
        JSR s8D5D
        .BYTE $02    ;JAM 
b827C   =*+$02
b827A   EOR a2082
        .BYTE $63,$8D ;RRA (p8D,X)
        .BYTE $02    ;JAM 
        STX f8D,Y
        BNE b8287
b8284   JSR s85A9
b8287   CMP #$20
        BEQ b8284
        LDX #$1C
b828D   CMP f8822,X
        BNE b82A5
        STA a39
        TXA 
        ASL 
        TAX 
        LDA f883F,X
        STA aC1
        INX 
        LDA f883F,X
        STA aC2
        JMP ($00C1)

b82A5   DEX 
        BPL b828D
        JMP j85C0

;-------------------------------
; s82AB
;-------------------------------
s82AB   
        LDA aC1
        STA $0120
        LDA aC2
        STA $0121
        RTS 

;-------------------------------
; s82B6
;-------------------------------
s82B6   
        LDA $0129
        LDY $012A
        JMP j82C3

;-------------------------------
; s82BF
;-------------------------------
s82BF   
        LDA aC3
        LDY aC4
j82C3   SEC 
        SBC aC1
        STA $012D
        TYA 
        BPL b82CE
        EOR aC2
b82CE   PHA 
        TYA 
        SBC aC2
        TAY 
        PLA 
        BPL b82D7
        SEC 
b82D7   TYA 
        ORA $012D
        RTS 

;-------------------------------
; s82DC
;-------------------------------
s82DC   
        STA a3A
        LDY #$00
b82E0   JSR s86F1
        LDA (pC1),Y
        JSR s8502
        INY 
        CPY a3A
        BNE b82E0
        JMP s86F1

;-------------------------------
; s82F0
;-------------------------------
s82F0   
        JSR s8309
        STA aC3
        STX aC4
;-------------------------------
; s82F7
;-------------------------------
s82F7   
        JSR s853F
        BCC b8300
        STA aC3
        STX aC4
b8300   RTS 

;-------------------------------
; s8301
;-------------------------------
s8301   
        JSR s853F
b8304   STA aC1
        STX aC2
        RTS 

;-------------------------------
; s8309
;-------------------------------
s8309   
        JSR s853F
        BCS b8304
b830E   JMP j85C0

;-------------------------------
; s8311
;-------------------------------
s8311   
        STA a3A
b8313   JSR s85A9
        JSR s8568
        LDX #$00
        BCC b832A
        STA (pC1,X)
        SBC (pC1,X)
        BNE b830E
        JSR s8626
        DEC a3A
        BNE b8313
b832A   JMP s86E0

;-------------------------------
; s832D
;-------------------------------
s832D   
        LDA a39
        JSR s8528
        CMP #$3B
        BEQ b8366
        JSR s84EA
        LDA a39
        CMP #$3A
        BEQ b838E
        CMP #$27
        BEQ b8346
        JMP j85D6

b8346   JMP j83C7

;-------------------------------
; s8349
;-------------------------------
s8349   
        LDA #<$0122
        STA aC1
        LDA #>$0122
        STA aC2
        LDA #$05
        RTS 

j8354   LDX #$00
b8356   LDA f8808,X
        JSR $FFD2 ;$FFD2 - output character                 
        INX 
        CPX #$1A
        BNE b8356
        LDA #$3B
        JSR s8522
b8366   LDA $0121
        JSR s8502
        LDA $0120
        JSR s8502
        JSR s86F1
        LDA $0315    ;IRQ
        JSR s8502
        LDA $0314    ;IRQ
        JSR s8502
        JSR s8349
        JSR s82DC
        BNE b83A9
;-------------------------------
; s8389
;-------------------------------
s8389   
        LDA #$3A
        JSR s84E3
b838E   LDA #$08
        JSR s82DC
        LDA #$07
        BNE b83CC
;-------------------------------
; s8397
;-------------------------------
s8397   
        JSR $FFE1 ;$FFE1 - check stop key                   
        BEQ b83A6
        JSR s82BF
        BCC b83A6
        LDA a3B
        BNE b83A6
        RTS 

b83A6   JSR s8DAE
b83A9   JMP j8235

        JSR s82F0
b83AF   JSR s8397
j83B2   JSR s8389
        BNE b83AF
        JSR s82F0
b83BA   JSR s8397
j83BD   JSR s83C2
        BNE b83BA
;-------------------------------
; s83C2
;-------------------------------
s83C2   
        LDA #$27
        JSR s84E3
j83C7   JSR s86F1
        LDA #$1F
b83CC   STA a3A
        LDY #$FF
b83D0   INY 
        LDA (pC1),Y
        JSR s83DE
        CPY a3A
        BNE b83D0
        TYA 
        JMP s8626

;-------------------------------
; s83DE
;-------------------------------
s83DE   
        PHA 
        AND #$7F
        CMP #$20
        BCS b83F1
        LDX #$12
        PLA 
        ADC #$40
        JSR s8519
        LDA #$92
        BNE b83F8
b83F1   CMP #$60
        PLA 
        BCC b83F8
        LDA #$2E
b83F8   JSR $FFD2 ;$FFD2 - output character                 
        LDA #$00
        STA aD4
        RTS 

        JSR s8301
        BCC b8408
        JSR s82AB
b8408   JSR s855F
        BCC b8415
        SEI 
        STA $0314    ;IRQ
        STX $0315    ;IRQ
        CLI 
b8415   JSR s8349
        BNE b8428
        LDA #$08
        BIT $03A9
        PHA 
        JSR s8309
        STA aC3
        STX aC4
        PLA 
b8428   JSR s8311
        LDA aC3
        STA aC1
        LDA aC4
        STA aC2
j8433   JSR s8DAE
        JSR s832D
        JSR s84E5
        JSR s86F1
        JMP b8238

;-------------------------------
; s8442
;-------------------------------
s8442   
        LDY #$00
        STY aB7
        LDA #>$0200
        STA aBC
        LDA #<$0200
        STA aBB
b844E   JSR $FFCF ;$FFCF - input character                  
        CMP #$20
        BEQ b844E
        CMP #$0D
        BEQ b8474
        CMP #$22
        BNE b8471
b845D   JSR $FFCF ;$FFCF - input character                  
        CMP #$22
        BEQ b8474
        CMP #$0D
        BEQ b8474
        STA (pBB),Y
        INC aB7
        INY 
        CPY #$14
        BNE b845D
b8471   JMP j85C0

b8474   RTS 

        LDY #$01
        STY aB9
        STY aBA
        JSR s8442
        CMP #$0D
        BNE b8499
b8482   LDA a39
        CMP #$4C
        BNE b8471
        JSR j8DA8
        LDA #$00
        JSR $FFD5 ;$FFD5 - load after call SETLFS,SETNAM    
        LDA a90
        AND #$10
b8494   BNE b8471
        JMP j8235

b8499   JSR $FFCF ;$FFCF - input character                  
        CMP #$0D
        BEQ b8482
        CMP #$20
b84A2   BNE b8494
        JSR s8568
        AND #$0F
b84A9   BEQ b8471
        CMP #$03
        BEQ b84A9
        STA aBA
        JSR $FFCF ;$FFCF - input character                  
        CMP #$0D
        BEQ b8482
        CMP #$20
b84BA   BNE b84A2
        JSR s82F0
        BCC b8482
        PHA 
        TXA 
        TAY 
        PLA 
        TAX 
        CPY a8840
        BCC b84D2
        LDA a8842
        CMP aC2
        NOP 
        NOP 
b84D2   LDA a39
        CMP #$53
        BNE b84BA
        JSR j8DA8
        LDA #$C1
        JSR $FFD8 ;$FFD8 - save after call SETLFS,SETNAM    
        JMP j8235

;-------------------------------
; s84E3
;-------------------------------
s84E3   
        STA a39
;-------------------------------
; s84E5
;-------------------------------
s84E5   
        LDA a39
        JSR s8522
;-------------------------------
; s84EA
;-------------------------------
s84EA   
        LDA aC2
        CMP a8840
        BCC b84FB
        CMP a8842
        BEQ b84F8
        BCS b84FB
b84F8   JMP b84FB

b84FB   LDA aC2
        JSR s8502
        LDA aC1
;-------------------------------
; s8502
;-------------------------------
s8502   
        PHA 
        LSR 
        LSR 
        LSR 
        LSR 
        JSR s850D
        PLA 
        AND #$0F
;-------------------------------
; s850D
;-------------------------------
s850D   
        CLC 
        ADC #$F6
        BCC b8514
        ADC #$06
b8514   ADC #$3A
        JMP $FFD2 ;$FFD2 - output character                 

;-------------------------------
; s8519
;-------------------------------
s8519   
        PHA 
        TXA 
        JSR $FFD2 ;$FFD2 - output character                 
b851E   PLA 
        JMP $FFD2 ;$FFD2 - output character                 

;-------------------------------
; s8522
;-------------------------------
s8522   
        PHA 
        JSR s86E0
        BNE b851E
;-------------------------------
; s8528
;-------------------------------
s8528   
        PHA 
        LDA a9A
        CMP #$03
        BNE b851E
        TXA 
        PHA 
        TYA 
        PHA 
        LDX aD6
        JSR $E9FF
        PLA 
        TAY 
        PLA 
        TAX 
        JMP b851E

;-------------------------------
; s853F
;-------------------------------
s853F   
        LDA #$00
        STA $0100
b8544   JSR $FFCF ;$FFCF - input character                  
        CMP #$20
        BEQ b8544
        CMP #$24
        BEQ b8562
        CMP #$0D
        BNE b8555
        CLC 
b8554   RTS 

b8555   JSR s8144
        BCC b8554
        JSR s8581
        BCS b8567
;-------------------------------
; s855F
;-------------------------------
s855F   
        JSR s85A9
b8562   JSR s8568
        BCC b8580
b8567   TAX 
;-------------------------------
; s8568
;-------------------------------
s8568   
        LDA #$00
        STA $0100
        JSR s85A9
;-------------------------------
; s8570
;-------------------------------
s8570   
        CMP #$24
        BEQ s8568
        CMP #$20
        BNE s8581
        JSR s85A9
        CMP #$20
        BNE b858E
        CLC 
b8580   RTS 

;-------------------------------
; s8581
;-------------------------------
s8581   
        JSR s8596
        ASL 
        ASL 
        ASL 
        ASL 
        STA $0100
        JSR s85A9
b858E   JSR s8596
        ORA $0100
        SEC 
        RTS 

;-------------------------------
; s8596
;-------------------------------
s8596   
        CMP #$30
        BCC j85C0
        CMP #$3A
        PHP 
        AND #$0F
        PLP 
        BCC b85A4
        ADC #$08
b85A4   CMP #$10
        BCS j85C0
        RTS 

;-------------------------------
; s85A9
;-------------------------------
s85A9   
        LDA #$02
        NOP 
        NOP 
        NOP 
        CMP j8235
        BNE b85B8
        JSR s887C
        BPL j85C0
b85B8   JSR $FFCF ;$FFCF - input character                  
        CMP #$0D
        BEQ b85C3
        RTS 

j85C0   JSR s86F7
b85C3   JMP j8235

        JSR s82F0
b85C9   JSR s8397
j85CC   JSR s85D1
        BNE b85C9
;-------------------------------
; s85D1
;-------------------------------
s85D1   
        LDA #$2C
;-------------------------------
; s85D3
;-------------------------------
s85D3   
        JSR s84E3
j85D6   JSR s863F
        PHA 
        JSR s8689
        PLA 
        JSR s86A4
        LDX #$06
b85E3   CPX #$03
        BNE b85F9
        LDY a3E
        BEQ b85F9
b85EB   LDA a3D
        CMP #$E8
        LDA (pC1),Y
        BCS b8610
        JSR s8502
        DEY 
        BNE b85EB
b85F9   ASL a3D
        BCC b860B
        LDA f877B,X
        JSR $FFD2 ;$FFD2 - output character                 
        LDA f8781,X
        BEQ b860B
        JSR $FFD2 ;$FFD2 - output character                 
b860B   DEX 
        BNE b85E3
        BEQ s8620
b8610   JSR s8633
        TAX 
        INX 
        BNE b8618
        INY 
b8618   TYA 
        JSR s8502
        TXA 
        JSR s8502
;-------------------------------
; s8620
;-------------------------------
s8620   
        LDA a3E
        BNE s8626
;-------------------------------
; s8624
;-------------------------------
s8624   
        LDA #$00
;-------------------------------
; s8626
;-------------------------------
s8626   
        JSR s8632
        STA aC1
        STY aC2
        BNE b8631
        INC a3B
b8631   RTS 

;-------------------------------
; s8632
;-------------------------------
s8632   
        SEC 
;-------------------------------
; s8633
;-------------------------------
s8633   
        LDY aC2
        TAX 
        BPL b8639
        DEY 
b8639   ADC aC1
        BCC b863E
        INY 
b863E   RTS 

;-------------------------------
; s863F
;-------------------------------
s863F   
        LDX #$00
        LDA (pC1,X)
;-------------------------------
; s8643
;-------------------------------
s8643   
        TAY 
        LSR 
        BCC b8652
        LSR 
        BCS b8661
        CMP #$22
        BEQ b8661
        AND #$07
        ORA #$80
b8652   LSR 
        TAX 
        LDA f872A,X
        BCS b865D
        LSR 
        LSR 
        LSR 
        LSR 
b865D   AND #$0F
        BNE b8665
b8661   LDY #$80
        LDA #$00
b8665   TAX 
        LDA f876E,X
        STA a3D
        AND #$03
        STA a3E
        TYA 
        AND #$8F
        TAX 
        TYA 
        LDY #$03
        CPX #$8A
        BEQ b8685
b867A   LSR 
        BCC b8685
        LSR 
b867E   LSR 
        ORA #$20
        DEY 
        BNE b867E
        INY 
b8685   DEY 
        BNE b867A
        RTS 

;-------------------------------
; s8689
;-------------------------------
s8689   
        LDY a3E
        INY 
        TYA 
        JSR s82DC
        SEC 
        LDA #$02
        SBC a3E
        BEQ b86A3
        ASL 
        ORA #$02
        ORA a3E
        TAX 
b869D   JSR s86F1
        DEX 
        BNE b869D
b86A3   RTS 

;-------------------------------
; s86A4
;-------------------------------
s86A4   
        TAY 
        LDX #$03
        LDA f8788,Y
        STA $0129
        LDA f87C8,Y
        STA $012A
b86B3   LDA #$00
        LDY #$05
b86B7   ASL $012A
        ROL $0129
        ROL 
        DEY 
        BNE b86B7
        ADC #$3F
        JSR $FFD2 ;$FFD2 - output character                 
        DEX 
        BNE b86B3
        JMP s86F1

f86CC   LDX #$19
        STX a16
        PLA 
        TAY 
        PLA 
        LDX #$FA
        TXS 
        PHA 
        TYA 
        PHA 
        LDA #$00
        STA a3E
        STA a10
        RTS 

;-------------------------------
; s86E0
;-------------------------------
s86E0   
        LDA #$0D
        JSR s86F9
        BIT a13
        BPL b86EE
        LDA #$0A
        JSR s86F9
b86EE   EOR #$FF
        RTS 

;-------------------------------
; s86F1
;-------------------------------
s86F1   
        LDA #$20
        BIT a1DA9
;-------------------------------
; s86F7
;-------------------------------
s86F7   =*+$01
        BIT a3FA9
;-------------------------------
; s86F9
;-------------------------------
s86F9   
        JSR $E10C
        AND #$FF
        RTS 

        .BYTE $4F,$4E,$0D,$0D,$20,$20,$20,$20
        .BYTE $20,$20,$20,$20,$20,$12,$20,$20
        .BYTE $20,$28,$43,$29,$31,$39,$38,$33
        .BYTE $20,$20,$48,$2E,$45,$2E,$53,$2E
        .BYTE $20,$20,$20,$8D,$20,$4F,$CB,$42
        .BYTE $59,$45,$AE
f872A   .BYTE $40,$02,$45,$03,$D0,$08,$40,$09
        .BYTE $30,$22,$45,$33,$D0,$08,$40,$09
        .BYTE $40,$02,$45,$33,$D0,$08,$40,$09
        .BYTE $40,$02,$45,$B3,$D0,$08,$40,$09
        .BYTE $00,$22,$44,$33,$D0,$8C,$44,$00
        .BYTE $11,$22,$44,$33,$D0,$8C,$44,$9A
        .BYTE $10,$22,$44,$33,$D0,$08,$40,$09
        .BYTE $10,$22,$44,$33,$D0,$08,$40,$09
        .BYTE $62,$13,$78,$A9
f876E   .BYTE $00,$21,$81,$82,$00,$00,$59,$4D
        .BYTE $91,$92,$86,$4A,$85
f877B   .BYTE $9D,$2C,$29,$2C,$23,$28
f8781   .BYTE $24,$59,$00,$58,$24,$FA,$FA
f8788   .BYTE $1C,$8A,$1C,$23,$5D,$8B,$1B,$A1
        .BYTE $9D,$8A,$1D,$23,$9D,$8B,$1D,$A1
        .BYTE $00,$29,$19,$AE,$69,$A8,$19,$23
        .BYTE $24,$53,$1B,$23,$24,$53,$19,$A1
        .BYTE $00,$1A,$5B,$5B,$A5,$69,$24,$24
        .BYTE $AE,$AE,$A8,$AD,$29,$00,$7C,$00
        .BYTE $15,$9C,$6D,$9C,$A5,$69,$29,$53
        .BYTE $84,$13,$34,$11,$A5,$69,$23,$A0
f87C8   .BYTE $D8,$62,$5A,$48,$26,$62,$94,$88
        .BYTE $54,$44,$C8,$54,$68,$44,$E8,$94
        .BYTE $00,$B4,$08,$84,$74,$B4,$28,$6E
        .BYTE $74,$F4,$CC,$4A,$72,$F2,$A4,$8A
        .BYTE $00,$AA,$A2,$A2,$74,$74,$74,$72
        .BYTE $44,$68,$B2,$32,$B2,$00,$22,$00
        .BYTE $1A,$1A,$26,$26,$72,$72,$88,$C8
        .BYTE $C4,$CA,$26,$48,$44,$44,$A2,$C8
f8808   .BYTE $0D,$20,$20,$50,$43,$20,$20,$49
        .BYTE $52,$51,$20,$20,$53,$52,$20,$41
        .BYTE $43,$20,$58,$52,$20,$59,$52,$20
        .BYTE $53,$50
f8822   .BYTE $41,$42,$43,$44,$45,$46,$47,$48
        .BYTE $49,$4C,$4D,$4E,$4F,$50,$51,$52
        .BYTE $53,$54,$55,$56,$57,$58,$3A,$3B
        .BYTE $2C,$2B,$2D,$24,$23
f883F   .BYTE $09
a8840   .BYTE $80,$A3
a8842   .BYTE $8F,$FB,$89,$C6,$85,$8C,$88,$6D
        .BYTE $8A,$48,$8F,$98,$8A,$B7,$83,$75
        .BYTE $84,$AC,$83,$8F,$88,$8C,$8B,$F4
        .BYTE $8B,$39,$8F,$54,$83,$75,$84,$FE
        .BYTE $89,$FF,$8C,$47,$8C,$4B,$8F,$16
        .BYTE $8F,$1A,$84,$00,$84,$1D,$84,$F5
        .BYTE $8A,$17,$8B,$2A,$8B,$3F,$8B
;-------------------------------
; s8879
;-------------------------------
s8879   
        LDX #$57
        .BYTE $2C
;-------------------------------
; s887C
;-------------------------------
s887C   
        LDX #$56
b887E   LDA f86CC,X
        PHP 
        AND #$7F
        JSR $FFD2 ;$FFD2 - output character                 
        INX 
        PLP 
        BPL b887E
        RTS 

        LDA #$FF
        BIT @w$00A9
        STA a3F
        LDA #$00
        STA $0128
        JSR s89D6
        STA $0131
        STX $0132
        JSR s853F
        STA $012F
        STX $0130
        JSR s853F
        STA aAE
        STX aAF
        JSR $FFCF ;$FFCF - input character                  
        CMP #$0D
        BEQ b88C2
        JSR $FFCF ;$FFCF - input character                  
        CMP #$57
        BNE b88C2
        INC $0128
b88C2   JSR s8157
b88C5   LDX a3B
        BNE b88DF
        JSR s82B6
        BCC b88DF
        LDY $0128
        BNE b88E8
        JSR s863F
        TAX 
        LDA f8788,X
        BNE b88E2
        JSR s85D1
b88DF   JMP j8235

b88E2   LDY a3E
        CPY #$02
        BNE b891A
b88E8   STY a3E
        DEY 
        SEC 
        LDA (pC1),Y
        TAX 
        SBC $012F
        INY 
        LDA (pC1),Y
        SBC $0130
        BCC b891A
        DEY 
        LDA aAE
        SBC (pC1),Y
        INY 
        LDA aAF
        SBC (pC1),Y
        BCC b891A
        DEY 
        BIT a3F
        BMI b891F
        CLC 
        TXA 
        ADC $0131
        STA (pC1),Y
        INY 
        LDA (pC1),Y
        ADC $0132
        STA (pC1),Y
b891A   JSR s8620
        BNE b88C5
b891F   LDA $0131
        STA aBB
        LDA $0132
        STA aBC
        DEY 
        BPL b8935
        TXA 
        JSR s8D3A
        INC a3E
        TAX 
        LDY #$00
b8935   TXA 
j8936   CMP (pBB),Y
        BNE b8952
        INY 
        LDA (pBB),Y
        INY 
        CMP (pC1),Y
        BNE b8952
        LDA (pBB),Y
        TAX 
        INY 
        LDA (pBB),Y
        DEY 
        STA (pC1),Y
        DEY 
        TXA 
        STA (pC1),Y
        INY 
        BNE b891A
b8952   LDY #$01
        LDA (pBB),Y
        DEY 
        ORA (pBB),Y
        BEQ b8968
        CLC 
        LDA #$04
        ADC aBB
        STA aBB
        BCC b8935
        INC aBC
        BCS b8935
b8968   LDY #$04
        STA (pBB),Y
        INY 
        STA (pBB),Y
        LDA $0128
        BEQ b8983
        LDA #$3F
        JSR s8522
        JSR s89C9
        JSR s89C9
        LDX #$07
        BNE b89A2
b8983   LDA $0129
        PHA 
        LDA $012A
        PHA 
        LDA #$3F
        JSR s85D3
        PLA 
        STA $012A
        PLA 
        STA $0129
        LDA #$FF
        CLC 
        SBC a3E
        JSR s8626
        LDX #$10
b89A2   JSR s86E0
        LDA #$91
b89A7   JSR $FFD2 ;$FFD2 - output character                 
        LDA #$1D
        DEX 
        BNE b89A7
        LDY #$03
b89B1   JSR s8568
        BCC b89B1
        STA (pBB),Y
        DEY 
        CPY #$02
        BEQ b89B1
        INY 
b89BE   LDA (pC1),Y
        TAX 
        DEY 
        STA (pBB),Y
        BNE b89BE
        JMP j8936

;-------------------------------
; s89C9
;-------------------------------
s89C9   
        LDY #$02
b89CB   LDA (pC1),Y
        JSR s8502
        DEY 
        BNE b89CB
        JMP s86F1

;-------------------------------
; s89D6
;-------------------------------
s89D6   
        JSR s82F7
        BCC b89F8
        JSR s853F
        BCC b89F8
        STA $0129
        STX $012A
        CPX a8840
        BCC b89F2
        LDX a8842
        CPX aC4
        NOP 
        NOP 
b89F2   JMP s8301

        JSR j8DA8
b89F8   JMP j85C0

        LDA #$00
        BIT $01A9
        STA $0128
        JSR s89D6
        JSR s86E0
        JSR s82BF
        JSR s8157
        BCC b8A28
b8A11   JSR s82B6
        BCC b8A6A
        JSR s8A4F
        INC aC3
        BNE b8A1F
        INC aC4
b8A1F   LDA a3B
        BNE b8A6A
        JSR s8626
        BNE b8A11
b8A28   JSR s82B6
        CLC 
        LDA $012D
        ADC aC3
        STA aC3
        TYA 
        ADC aC4
        STA aC4
        JSR s8D4B
b8A3B   JSR s8A4F
        JSR s82B6
        BCS b8A6A
        JSR s8D37
        JSR s8D3A
        LDY a3B
        BNE b8A6A
        BEQ b8A3B
;-------------------------------
; s8A4F
;-------------------------------
s8A4F   
        LDX #$00
        LDA (pC1,X)
        LDY $0128
        BEQ b8A5A
        STA (pC3,X)
b8A5A   CMP (pC3,X)
        BEQ b8A69
;-------------------------------
; s8A5E
;-------------------------------
s8A5E   
        JSR s84EA
        JSR s86F1
        JSR $FFE1 ;$FFE1 - check stop key                   
        BEQ b8A6A
b8A69   RTS 

b8A6A   JMP j8235

        JSR s82F0
        JSR s85A9
        JSR s8568
        BCC b8A95
        STA $0128
b8A7B   LDX a3B
        BNE b8A6A
        JSR s82BF
        BCC b8A6A
        LDA $0128
        STA (pC1,X)
        CMP (pC1,X)
        BEQ b8A90
        JSR s8A5E
b8A90   JSR s8624
        BNE b8A7B
b8A95   JMP j85C0

        JSR s82F0
        LDX #$00
b8A9D   JSR s85A9
        CMP #$20
        BEQ b8A9D
        TAY 
        CMP #$22
        BEQ b8AB9
        STX $0100
        JSR s8581
        BCC b8A95
b8AB1   STA $0200,X
        INX 
        CPX #$20
        BCS b8ACD
b8AB9   JSR $FFCF ;$FFCF - input character                  
        CMP #$0D
        BEQ b8ACD
        CMP #$22
        BEQ b8ACD
        CPY #$22
        BEQ b8AB1
        JSR s8568
        BCS b8AB1
b8ACD   STX a3C
        JSR s86E0
b8AD2   LDX #$00
        LDY #$00
b8AD6   LDA (pC1),Y
        CMP $0200,X
        BNE b8AE6
        INY 
        INX 
        CPX a3C
        BNE b8AD6
        JSR s8A5E
b8AE6   JSR s8624
        LDY a3B
        BNE b8AF2
        JSR s82BF
        BCS b8AD2
b8AF2   JMP j8235

        JSR s82F0
        CLC 
        LDA aC3
        ADC aC1
        STA aC1
        LDA aC4
        ADC aC2
        STA aC2
j8B05   JSR s86F1
        LDX #$3D
        LDA #$24
        JSR s8519
        JSR b84FB
        LDX aC2
        JMP j8B2D

        JSR s82F0
        JSR s8157
b8B1D   JSR s82BF
        STY aC2
        LDA $012D
        STA aC1
        JMP j8B05

        JSR s8309
j8B2D   JSR s86F1
        TXA 
        LDX aC1
        JSR sBDCD
        JMP j8235

b8B39   LDA a3A
        BEQ j8B05
        BNE b8B1D
        LDA #$00
        STA aC1
        STA aC2
        STA aC3
        STA aC4
        STA a3A
b8B4B   JSR $FFCF ;$FFCF - input character                  
        CMP #$0D
        BEQ b8B39
        CMP #$2D
        BNE b8B5A
        EOR a3A
        STA a3A
b8B5A   CMP #$30
        BCC b8B4B
        CMP #$3A
        BCS b8B39
        SBC #$2F
        STA a3B
        LDA aC2
        STA aC3
        LDA aC1
        ASL 
        ROL aC3
        ASL 
        ROL aC3
        ADC aC1
        STA aC1
        LDA aC3
        ADC aC2
        STA aC2
        ASL aC1
        ROL aC2
        LDA aC1
        ADC a3B
        STA aC1
        BCC b8B4B
        INC aC2
        BCS b8B4B
        JSR s8B92
        JMP j8235

;-------------------------------
; s8B92
;-------------------------------
s8B92   
        LDA #$00
        STA $0100
        JSR $FFCF ;$FFCF - input character                  
        CMP #$0D
        BNE b8BAB
        LDX a13
        BNE b8BBE
        STA $0277
        INC aC6
        LDA #$04
        BNE b8BB5
b8BAB   JSR s8570
        CMP #$04
        BCS b8BB5
b8BB2   JMP j85C0

b8BB5   TAX 
        AND #$7F
        CMP #$3F
        BCC b8BCB
        BNE b8BB2
b8BBE   LDA aB8
        JSR $FFC3 ;$FFC3 - close a logical file             
        JSR $FFCC ;$FFCC - restore default devices          
        STA a13
        JMP j8235

b8BCB   STA aBA
        STX aB8
        STX a13
        LDX #$FF
        STX aB9
        INX 
        STX aB7
        JSR $FFCF ;$FFCF - input character                  
        CMP #$0D
        BEQ b8BE7
        JSR s8568
        STA aB9
        JSR s8442
b8BE7   LDA aB8
        JSR $FFC3 ;$FFC3 - close a logical file             
        JSR $FFC0 ;$FFC0 - open log.file after SETLFS,SETNAM
        LDX aB8
        JMP $FFC9 ;$FFC9 - open channel for output          

        JSR s8B92
        LDA $0288
        STA aC2
        LDX #$18
        LDA #$00
        STA aC1
b8C02   LDY #$00
b8C04   LDA (pC1),Y
        JSR s8C20
        INY 
        CPY #$28
        BCC b8C04
        JSR s86E0
        DEX 
        BMI b8BBE
        TYA 
        CLC 
        ADC aC1
        STA aC1
        BCC b8C02
        INC aC2
        BNE b8C02
;-------------------------------
; s8C20
;-------------------------------
s8C20   
        PHP 
        AND #$7F
        CMP #$40
        BCC b8C29
        ORA #$80
b8C29   CMP #$20
        BCS b8C2F
        ADC #$40
b8C2F   CMP #$22
        BNE b8C35
        LDA #$27
b8C35   PLP 
        BPL b8C44
        PHA 
        LDA #$12
        JSR $FFD2 ;$FFD2 - output character                 
        PLA 
        JSR $FFD2 ;$FFD2 - output character                 
        LDA #$92
b8C44   JMP $FFD2 ;$FFD2 - output character                 

        JSR s82F0
        LDA aC1
        STA $0129
        LDA aC2
        STA $012A
b8C54   JSR $FFE1 ;$FFE1 - check stop key                   
        BNE b8C5C
        JMP j8235

b8C5C   LDA #$2E
        JSR $E716
        LDA #$00
        TAY 
b8C64   STA a39
        LDX #$02
        STX a3A
b8C6A   JSR s8CE4
        LDA a39
        EOR #$FF
        STA a3C
b8C73   STA (pC1),Y
        JSR s8CF1
        BCS b8C73
        JSR s8CE4
b8C7D   LDA a39
        DEX 
        BPL b8C86
        STA (pC1),Y
        LDX #$02
b8C86   JSR s8CF1
        BCS b8C7D
        JSR s8CE4
b8C8E   LDA a3C
        DEX 
        BPL b8C97
        LDX #$02
        LDA a39
b8C97   CMP (pC1),Y
        BEQ b8CA1
        JSR s8CB2
        JSR s8CBC
b8CA1   JSR s8CF1
        BCS b8C8E
        DEC a3A
        BPL b8C6A
        LDA a39
        EOR #$FF
        BMI b8C64
        BPL b8C54
;-------------------------------
; s8CB2
;-------------------------------
s8CB2   
        PHA 
        TXA 
        PHA 
        JSR s8A5E
        PLA 
        TAX 
        PLA 
        RTS 

;-------------------------------
; s8CBC
;-------------------------------
s8CBC   
        PHA 
        EOR (pC1),Y
        STA a3D
        LDY #$08
b8CC3   ASL a3D
        BCC b8CCC
        LDA #$12
        JSR $FFD2 ;$FFD2 - output character                 
b8CCC   PLA 
        ASL 
        PHA 
        LDA #$30
        BCC b8CD5
        LDA #$31
b8CD5   JSR $FFD2 ;$FFD2 - output character                 
        LDA #$92
        JSR $FFD2 ;$FFD2 - output character                 
        DEY 
        BNE b8CC3
        PLA 
        JMP s86E0

;-------------------------------
; s8CE4
;-------------------------------
s8CE4   
        LDA $0129
        STA aC1
        LDA $012A
        STA aC2
        LDX a3A
        RTS 

;-------------------------------
; s8CF1
;-------------------------------
s8CF1   
        INC aC1
        BNE b8CF7
        INC aC2
b8CF7   PHA 
        JSR s82BF
        PLA 
        LDY #$00
        RTS 

        LDX #$0F
b8D01   JSR s8D27
b8D04   TXA 
        STA (pC1),Y
        JSR s8CF1
        BCS b8D04
        JSR s8D27
b8D0F   TXA 
        EOR (pC1),Y
        AND #$0F
        BEQ b8D19
        JSR s8CB2
b8D19   JSR s8CF1
        BCS b8D0F
        DEX 
        BPL b8D01
        JSR s8879
        JMP j8235

;-------------------------------
; s8D27
;-------------------------------
s8D27   
        LDY #$FF
        STY aC3
        INY 
        STY aC1
        LDA #$D8
        STA aC2
        LDA #$DB
        STA aC4
        RTS 

;-------------------------------
; s8D37
;-------------------------------
s8D37   
        LDX #$02
;-------------------------------
; s8D3A
;-------------------------------
s8D3A   =*+$01
        BIT @w$00A2
        LDY fC1,X
        BNE b8D48
        LDY fC2,X
        BNE b8D46
        INC a3B
b8D46   DEC fC2,X
b8D48   DEC fC1,X
        RTS 

;-------------------------------
; s8D4B
;-------------------------------
s8D4B   
        LDX #$02
b8D4D   LDA fC0,X
        PHA 
        LDA $0128,X
        STA fC0,X
        PLA 
        STA $0128,X
        DEX 
        BNE b8D4D
        RTS 

;-------------------------------
; s8D5D
;-------------------------------
s8D5D   
        JSR s8D63
        .BYTE $02    ;JAM 
        ASL fE7,X
;-------------------------------
; s8D63
;-------------------------------
s8D63   
        PHA 
        TSX 
        LDA $0102,X
        STA a3F
        LDA $0103,X
        STA a40
        LDY #$01
        LDA #$02
        NOP 
        NOP 
        CMP (p3F),Y
        BNE b8D7E
        LDX #$5A
        JMP b887E

b8D7E   LDY aD3
        LDA (pD1),Y
        EOR #$80
        STA (pD1),Y
        JSR $EA24
        LDA (pF3),Y
        LDX $0287
        STA $0287
        TXA 
        STA (pF3),Y
        PLA 
        RTS 

;-------------------------------
; s8D96
;-------------------------------
s8D96   
        JSR j8DA8
        SEI 
        STA $0277
        LDA #$01
        STA aC6
        CLI 
        JSR s8DAE
        JMP $FFCF ;$FFCF - input character                  

j8DA8   LDA #$0D
;-------------------------------
; s8DAB
;-------------------------------
s8DAB   =*+$01
        BIT a13A9
;-------------------------------
; s8DAE
;-------------------------------
s8DAE   =*+$01
        BIT a91A9
        JMP $E716

p8DB3   JSR $FFCC ;$FFCC - restore default devices          
        CLD 
        PLA 
        STA $0125
        PLA 
        STA $0124
        PLA 
        STA $0123
        PLA 
        STA $0122
        PLA 
        CLC 
        ADC #$FF
        STA $0120
        PLA 
        ADC #$FF
        STA $0121
        LDA #$42
        JMP j8E46

        LDA #$FF
        PHA 
        PHA 
        LDA #$00
        STA $0127
        STA $0123
        PHP 
        PLA 
        AND #$EF
        STA $0122
        STX $0124
        STY $0125
        PLA 
        CLC 
        ADC #$01
        STA $0120
        PLA 
        ADC #$00
        STA $0121
        LDY $0127
        BPL b8E07
        JMP j8E97

b8E07   JSR $FD50 ;$FD50 (jmp) - RAM test & search RAM end        
        JSR $E453
        JSR $E3BF
j8E10   SEI 
        JSR $FDA3 ;$FDA3 (jmp) - initialize CIA & IRQ             
        JSR s8FD4
        JSR $E518
        CLI 
        LDA $0127
        BNE b8E23
        JSR f86CC
b8E23   LDA #<p8E60
        STA $0318    ;NMI
        LDA #>p8E60
        STA $0319    ;NMI
        LDA #$00
        STA $D020    ;Border Color
        STA $D021    ;Background Color 0
        LDA #$01
        STA $0286
        LDA #$53
        LDY $0127
        BNE j8E46
        JSR s887C
        LDA #$43
j8E46   STA $0127
        JSR s8FBD
        STA a3A
        TSX 
        STX $0126
        CLI 
        JSR s86E0
        LDX a3A
        LDA #$2A
        JSR s8519
        JMP j8354

p8E60   PHA 
        TXA 
        PHA 
        TYA 
        PHA 
        LDY $DD0D    ;CIA2: CIA Interrupt Control Register
        BMI b8E79
b8E6A   LDA $0127
        BEQ b8E72
        JMP $FEB6

b8E72   LDY #$10
        STY $0127
        BNE b8E7E
b8E79   TYA 
        AND #$01
        BEQ b8E6A
b8E7E   CLD 
        PLA 
        STA $0125
        PLA 
        STA $0124
        PLA 
        STA $0123
        PLA 
        STA $0122
        PLA 
        STA $0120
        PLA 
        STA $0121
j8E97   TSX 
        STX $0126
        LDA #$7F
        STA $DD0D    ;CIA2: CIA Interrupt Control Register
        CLI 
        CPY #$10
        BNE b8EA8
        JMP j8E10

b8EA8   JSR s8FBD
        BIT $0127
        BVC b8ED9
        LDA $0121
        CMP $0134
        BNE b8ECD
        LDA $0120
        CMP $0133
        BNE b8ECD
        LDA $012B
        BNE b8ECA
        DEC $012C
        BMI b8ED4
b8ECA   DEC $012B
b8ECD   JSR $FFE1 ;$FFE1 - check stop key                   
        BEQ b8EFA
        BNE b8F06
b8ED4   LDA #$80
        STA $0127
b8ED9   BPL b8F08
        JSR s86E0
        JSR s8349
        JSR s82DC
        LDA $0120
        LDX $0121
        STA aC1
        STX aC2
        JSR s85D1
b8EF1   JSR $FFE4 ;$FFE4 - get a byte from channel          
        BEQ b8EF1
        CMP #$03
        BNE b8EFD
b8EFA   JMP j8235

b8EFD   CMP #$4A
        BNE b8F06
        LDA #$01
        STA $0127
b8F06   BNE b8F62
b8F08   LDA #$8D
        PHA 
        LDA #$E1
        PHA 
        TSX 
        STX $0126
        LDA #$80
        BNE b8F32
        JSR $FFCF ;$FFCF - input character                  
        LDX #$02
        CMP #$43
        BNE b8F21
        LDX #$00
b8F21   LDA fA000,X
        STA $0120
        LDA fA001,X
        STA $0121
        JSR s8FD4
        LDA #$00
b8F32   STA $0127
        LDX #$7F
        BNE b8F71
        LDA $0135
        LDX $0136
        STA $012B
        STX $012C
        LDA #$40
        BIT @w$00A9
        BIT a80A9
        STA $0127
        JSR s8301
        BCC b8F58
        JSR s82AB
b8F58   JSR s86E0
        LDX #$7F
        LDA $0127
        BEQ b8F71
b8F62   LDX #$81
        LDA #$08
b8F66   BIT $D012    ;Raster Position
        BEQ b8F66
b8F6B   BIT $D012    ;Raster Position
        BNE b8F6B
        SEI 
b8F71   LDA #$00
        STA $DD05    ;CIA2: Timer A: High-Byte
        LDA #$7F
        STA $DD0D    ;CIA2: CIA Interrupt Control Register
        BIT $DD0D    ;CIA2: CIA Interrupt Control Register
        STX $DD0D    ;CIA2: CIA Interrupt Control Register
        JSR s8FBD
        LDX $0126
        TXS 
        LDA $0122
        PHA 
        LDX $0124
        LDY $0125
        LDA #$0A
        STA $DD04    ;CIA2: Timer A: Low-Byte
        LDA #$19
        STA $DD0E    ;CIA2: CIA Control Register A
        LDA $0123
        PLP 
        JMP ($0120)

        JSR s8309
        STA $0133
        STX $0134
        JSR s853F
        BCS b8FB4
        LDA #$00
        TAX 
b8FB4   STA $0135
        STX $0136
        JMP j8235

;-------------------------------
; s8FBD
;-------------------------------
s8FBD   
        PHA 
        TYA 
        PHA 
        LDX #$09
b8FC2   LDA $0137,X
        LDY f39,X
        STA f39,X
        TYA 
        STA $0137,X
        DEX 
        BPL b8FC2
        PLA 
        TAY 
        PLA 
        RTS 

;-------------------------------
; s8FD4
;-------------------------------
s8FD4   
        JSR $FD15 ;$FD15 (jmp) - restore default I/O vectors      
        LDA #<p8DB3
        STA $0316
        LDA #>p8DB3
        STA $0317
        RTS 

        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $54,$4D,$50,$01,$09,$41
f9000   .BYTE $20,$20,$20,$4C,$4E,$20,$20,$50
        .BYTE $52,$20,$20,$20,$20,$20,$20,$20
        .BYTE $20,$20,$20,$20,$20,$20,$20,$20
        .BYTE $20,$20,$20,$20,$20,$20,$40,$41
        .BYTE $20,$20,$20,$20,$20,$20,$20,$20
        .BYTE $20,$20,$20,$20,$20,$20,$20,$20
        .BYTE $20,$20,$20,$20,$20,$20,$20,$20
        .BYTE $20,$20,$4C,$4E,$20,$20,$20,$20
f9040   .BYTE $20,$20,$20,$4D,$4F,$20,$20,$51
        .BYTE $53,$20,$20,$20,$20,$20,$20,$20
        .BYTE $20,$20,$20,$20,$20,$20,$20,$20
        .BYTE $20,$54,$20,$20,$20,$40,$42,$42
        .BYTE $41,$20,$20,$20,$20,$20,$20,$20
        .BYTE $20,$20,$20,$20,$20,$20,$54,$20
        .BYTE $20,$20,$20,$20,$20,$20,$54,$20
        .BYTE $20,$20,$4D,$4F,$20,$20,$20,$20
f9080   .BYTE $20,$20,$20,$20,$20,$20,$20,$20
        .BYTE $20,$20,$20,$20,$20,$20,$20,$20
        .BYTE $20,$20,$20,$20,$20,$1E,$20,$20
        .BYTE $20,$20,$20,$20,$40,$42,$42,$42
        .BYTE $42,$41,$20,$20,$20,$20,$20,$20
        .BYTE $20,$20,$20,$20,$20,$20,$20,$20
        .BYTE $20,$20,$20,$20,$20,$20,$1E,$20
        .BYTE $20,$20,$20,$20,$20,$20,$20,$20
f90C0   .BYTE $20,$20,$20,$20,$20,$20,$20,$20
        .BYTE $20,$20,$20,$20,$20,$20,$20,$20
        .BYTE $20,$20,$20,$20,$20,$20,$20,$20
        .BYTE $20,$20,$1C,$40,$42,$42,$42,$42
        .BYTE $42,$42,$41,$20,$20,$20,$20,$20
        .BYTE $20,$1C,$20,$20,$20,$20,$20,$20
        .BYTE $20,$20,$20,$20,$20,$20,$20,$20
        .BYTE $20,$20,$20,$20,$20,$20,$20,$20
f9100   .BYTE $20,$20,$20,$20,$20,$20,$20,$20
        .BYTE $20,$20,$20,$20,$20,$20,$20,$20
        .BYTE $20,$20,$20,$20,$20,$20,$20,$20
        .BYTE $20,$20,$40,$42,$42,$42,$56,$58
        .BYTE $42,$42,$42,$41,$20,$20,$20,$20
        .BYTE $20,$20,$20,$20,$1C,$20,$20,$20
        .BYTE $20,$20,$20,$20,$20,$20,$20,$20
        .BYTE $20,$20,$20,$20,$20,$20,$20,$20
f9140   .BYTE $20
f9141   .BYTE $20,$20,$20,$20,$20,$20,$20,$20
        .BYTE $20,$20,$20,$20,$20,$1D,$20,$20
        .BYTE $20,$20,$20,$20,$20,$20,$20,$20
        .BYTE $40,$42,$42,$42,$42,$57,$59,$42
        .BYTE $42,$42,$42,$41,$20,$20,$20,$20
        .BYTE $20,$20,$20,$20,$20,$20,$20,$20
        .BYTE $20,$20,$20,$20,$20,$20,$20,$20
        .BYTE $20,$20,$20,$20,$20,$20,$20
f9180   .BYTE $20,$20,$20,$20,$20,$20,$20,$20
        .BYTE $20,$20,$20,$20,$20,$20,$20,$20
        .BYTE $20,$20,$20,$20,$20,$20,$20,$20
        .BYTE $40,$42,$42,$42,$42,$42,$42,$42
        .BYTE $42,$42,$42,$42,$42,$41,$20,$20
        .BYTE $20
a91A9   .BYTE $20,$20,$20,$20,$20,$20,$20,$1B
        .BYTE $20,$20,$20,$20,$20,$20,$20,$20
        .BYTE $20,$20,$20,$20,$20,$20,$20
f91C0   .BYTE $20,$20,$20,$20,$20,$20,$20,$20
        .BYTE $20,$20,$20,$20,$20,$20,$20,$20
        .BYTE $1B,$20,$20,$20,$20,$20,$20,$40
        .BYTE $42,$42,$42,$42,$42,$42,$42,$42
        .BYTE $42,$42,$42,$42,$42,$42,$41,$20
        .BYTE $20,$20,$20,$20,$20,$20,$20,$20
        .BYTE $20,$20,$1B,$20,$20,$20,$20,$20
        .BYTE $20,$20,$20,$20,$20,$20,$20,$20
f9200   .BYTE $43,$44,$44,$43,$44,$43,$43,$44
        .BYTE $44,$43,$43,$43,$44,$43,$44,$43
        .BYTE $44,$43,$44,$43,$44,$43,$45,$42
        .BYTE $42,$42,$42,$42,$42,$42,$42,$42
        .BYTE $42,$42,$42,$42,$42,$42,$42,$46
        .BYTE $43,$44,$44,$43,$44,$43,$43,$44
        .BYTE $44,$43,$43,$43,$44,$43,$44,$43
        .BYTE $44,$43,$44,$43,$44,$43,$44,$43
        .BYTE $20,$20,$20,$20,$20,$20,$20,$20
        .BYTE $20,$20,$20,$20,$20,$20,$20,$20
        .BYTE $20,$20,$20,$20,$20,$20,$20,$20
        .BYTE $20,$20,$20,$20,$20,$20,$20,$20
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $01,$01,$01,$01,$01,$01,$01,$02
        .BYTE $02,$02,$02,$02,$02,$02,$02,$03
        .BYTE $03,$03,$03,$03,$03,$03,$04,$04
        .BYTE $04,$04,$04,$04,$04,$04,$05,$05
        .BYTE $05,$05,$05,$05,$05,$06,$06,$06
        .BYTE $06,$06,$06,$06,$06,$07,$07,$07
        .BYTE $07,$07,$07,$07,$08,$08,$08,$08
        .BYTE $00,$00,$00,$00,$00,$00,$00,$01
        .BYTE $01,$01,$01,$01,$01,$02,$02,$02
        .BYTE $02,$02,$02,$03,$03,$03,$03,$03
        .BYTE $03,$04,$04,$04,$04,$04,$04,$04
        .BYTE $05,$05,$05,$05,$05,$05,$06,$06
        .BYTE $06,$06,$06,$06,$07,$07,$07,$07
        .BYTE $07,$07,$08,$08,$08,$08,$08,$08
        .BYTE $09,$09,$09,$09,$09,$09,$09,$0A
        .BYTE $00,$00,$00,$00,$00,$01,$01,$01
        .BYTE $01,$01,$02,$02,$02,$02,$02,$03
        .BYTE $03,$03,$03,$03,$04,$04,$04,$04
        .BYTE $04,$05,$05,$05,$05,$05,$06,$06
        .BYTE $06,$06,$06,$07,$07,$07,$07,$08
        .BYTE $08,$08,$08,$08,$09,$09,$09,$09
        .BYTE $09,$0A,$0A,$0A,$0A,$0A,$0B,$0B
        .BYTE $0B,$0B,$0B,$0C,$0C,$0C,$0C,$0C
        .BYTE $00,$00,$00,$00,$01,$01,$01,$01
        .BYTE $02,$02,$02,$02,$03,$03,$03,$04
        .BYTE $04,$04,$04,$05,$05,$05,$05,$06
        .BYTE $06,$06,$06,$07,$07,$07,$08,$08
        .BYTE $08,$08,$09,$09,$09,$09,$0A,$0A
        .BYTE $0A,$0A,$0B,$0B,$0B,$0C,$0C,$0C
        .BYTE $0C,$0D,$0D,$0D,$0D,$0E,$0E,$0E
        .BYTE $0E,$0F,$0F,$0F,$10,$10,$10,$10
        .BYTE $00,$00,$00,$01,$01,$01,$02,$02
        .BYTE $02,$03,$03,$03,$04,$04,$04,$05
        .BYTE $05,$05,$06,$06,$06,$07,$07,$07
        .BYTE $08,$08,$09,$09,$09,$0A,$0A,$0A
        .BYTE $0B,$0B,$0B,$0C,$0C,$0C,$0D,$0D
        .BYTE $0D,$0E,$0E,$0E,$0F,$0F,$0F,$10
        .BYTE $10,$10,$11,$11,$12,$12,$12,$13
        .BYTE $13,$13,$14,$14,$14,$15,$15,$15
        .BYTE $00,$00,$00,$01,$01,$02,$02,$03
        .BYTE $03,$03,$04,$04,$05,$05,$06,$06
        .BYTE $07,$07,$07,$08,$08,$09,$09,$0A
        .BYTE $0A,$0B,$0B,$0B,$0C,$0C,$0D,$0D
        .BYTE $0E,$0E,$0E,$0F,$0F,$10,$10,$11
        .BYTE $11,$12,$12,$12,$13,$13,$14,$14
        .BYTE $15,$15,$16,$16,$16,$17,$17,$18
        .BYTE $18,$19,$19,$1A,$1A,$1A,$1B,$1B
        .BYTE $00,$00,$01,$01,$02,$02,$03,$03
        .BYTE $04,$04,$05,$06,$06,$07,$07,$08
        .BYTE $08,$09,$09,$0A,$0B,$0B,$0C,$0C
        .BYTE $0D,$0D,$0E,$0E,$0F,$0F,$10,$11
        .BYTE $11,$12,$12,$13,$13,$14,$14,$15
        .BYTE $16,$16,$17,$17,$18,$18,$19,$19
        .BYTE $1A,$1A,$1B,$1C,$1C,$1D,$1D,$1E
        .BYTE $1E,$1F,$1F,$20,$21,$21,$22,$22
        .BYTE $00,$00,$01,$02,$02,$03,$04,$04
        .BYTE $05,$06,$06,$07,$08,$08,$09,$0A
        .BYTE $0A,$0B,$0C,$0C,$0D,$0E,$0E,$0F
        .BYTE $10,$10,$11,$12,$12,$13,$14,$14
        .BYTE $15,$16,$16,$17,$18,$18,$19,$1A
        .BYTE $1A,$1B,$1C,$1C,$1D,$1E,$1F,$1F
        .BYTE $20,$21,$21,$22,$23,$23,$24,$25
        .BYTE $25,$26,$27,$27,$28,$29,$29,$2A
        .BYTE $00,$00,$01,$02,$03,$04,$04,$05
        .BYTE $06,$07,$08,$08,$09,$0A,$0B,$0C
        .BYTE $0C,$0D,$0E,$0F,$10,$11,$11,$12
        .BYTE $13,$14,$15,$15,$16,$17,$18,$19
        .BYTE $19,$1A,$1B,$1C,$1D,$1D,$1E,$1F
        .BYTE $20,$21,$22,$22,$23,$24,$25,$26
        .BYTE $26,$27,$28,$29,$2A,$2A,$2B,$2C
        .BYTE $2D,$2E,$2F,$2F,$30,$31,$32,$33
        .BYTE $00,$00,$01,$02,$03,$04,$05,$06
        .BYTE $07,$08,$09,$0A,$0B,$0C,$0D,$0E
        .BYTE $0F,$10,$11,$12,$13,$14,$15,$16
        .BYTE $16,$17,$18,$19,$1A,$1B,$1C,$1D
        .BYTE $1E,$1F,$20,$21,$22,$23,$24,$25
        .BYTE $26,$27,$28,$29,$2A,$2B,$2C,$2D
        .BYTE $2D,$2E,$2F,$30,$31,$32,$33,$34
        .BYTE $35,$36,$37,$38,$39,$3A,$3B,$3C
        .BYTE $00,$01,$02,$03,$04,$05,$06,$07
        .BYTE $08,$0A,$0B,$0C,$0D,$0E,$0F,$10
        .BYTE $11,$12,$14,$15,$16,$17,$18,$19
        .BYTE $1A,$1B,$1D,$1E,$1F,$20,$21,$22
        .BYTE $23,$24,$25,$27,$28,$29,$2A,$2B
        .BYTE $2C,$2D,$2E,$2F,$31,$32,$33,$34
        .BYTE $35,$36,$37,$38,$3A,$3B,$3C,$3D
        .BYTE $3E,$3F,$40,$41,$42,$44,$45,$46
        .BYTE $00,$01,$02,$03,$05,$06,$07,$08
        .BYTE $0A,$0B,$0C,$0E,$0F,$10,$11,$13
        .BYTE $14,$15,$17,$18,$19,$1A,$1C,$1D
        .BYTE $1E,$20,$21,$22,$23,$25,$26,$27
        .BYTE $29,$2A,$2B,$2C,$2E,$2F,$30,$32
        .BYTE $33,$34,$35,$37,$38,$39,$3A,$3C
        .BYTE $3D,$3E,$40,$41,$42,$43,$45,$46
        .BYTE $47,$49,$4A,$4B,$4C,$4E,$4F,$50
        .BYTE $00,$01,$02,$04,$05,$07,$08,$0A
        .BYTE $0B,$0D,$0E,$10,$11,$12,$14,$15
        .BYTE $17,$18,$1A,$1B,$1D,$1E,$20,$21
        .BYTE $22,$24,$25,$27,$28,$2A,$2B,$2D
        .BYTE $2E,$30,$31,$32,$34,$35,$37,$38
        .BYTE $3A,$3B,$3D,$3E,$40,$41,$42,$44
        .BYTE $45,$47,$48,$4A,$4B,$4D,$4E,$50
        .BYTE $51,$52,$54,$55,$57,$58,$5A,$5B
        .BYTE $00,$01,$03,$04,$06,$08,$09,$0B
        .BYTE $0D,$0E,$10,$11,$13,$15,$16,$18
        .BYTE $1A,$1B,$1D,$1F,$20,$22,$23,$25
        .BYTE $27,$28,$2A,$2C,$2D,$2F,$31,$32
        .BYTE $34,$35,$37,$39,$3A,$3C,$3E,$3F
        .BYTE $41,$43,$44,$46,$47,$49,$4B,$4C
        .BYTE $4E,$50,$51,$53,$54,$56,$58,$59
        .BYTE $5B,$5D,$5E,$60,$62,$63,$65,$66
        .BYTE $00,$01,$03,$05,$07,$09,$0A,$0C
        .BYTE $0E,$10,$12,$13,$15,$17,$19,$1B
        .BYTE $1D,$1E,$20,$22,$24,$26,$27,$29
        .BYTE $2B,$2D,$2F,$31,$32,$34,$36,$38
        .BYTE $3A,$3B,$3D,$3F,$41,$43,$45,$46
        .BYTE $48,$4A,$4C,$4E,$4F,$51,$53,$55
        .BYTE $57,$58,$5A,$5C,$5E,$60,$62,$63
        .BYTE $65,$67,$69,$6B,$6C,$6E,$70,$72
        .BYTE $50,$02,$04,$06,$08,$0A,$0C,$0E
        .BYTE $10,$12,$14,$16,$18,$1A,$1C,$1E
        .BYTE $20,$22,$24,$26,$28,$2A,$2C,$2E
        .BYTE $30,$32,$34,$36,$38,$3A,$3C,$3E
        .BYTE $40,$42,$44,$46,$48,$4A,$4C,$4E
        .BYTE $50,$52,$54,$56,$58,$5A,$5C,$5E
        .BYTE $60,$62,$64,$66,$68,$6A,$6C,$6E
        .BYTE $70,$72,$74,$76,$78,$7A,$7C,$7E
f9660   .BYTE $20,$20,$90,$92,$20,$20,$20,$20
        .BYTE $20,$20,$20,$20,$20,$20,$20,$20
        .BYTE $20,$20,$20,$20,$20,$20,$20,$20
        .BYTE $20,$94,$96,$20,$20,$20,$20,$20
        .BYTE $20,$20,$20,$20,$20,$20,$20,$20
f9688   .BYTE $20,$20,$91,$93,$20,$20,$20,$20
        .BYTE $20,$20,$94,$96,$20,$20,$20,$20
        .BYTE $20,$20,$20,$20,$20,$20,$20,$20
        .BYTE $20,$95,$97,$20,$20,$20,$20,$20
        .BYTE $20,$20,$20,$20,$20,$20,$20,$20
f96B0   .BYTE $20,$20,$20,$20,$20,$20,$20,$20
        .BYTE $20,$20,$95,$97,$20,$20,$20,$20
        .BYTE $20,$20,$20,$20,$20,$20,$20,$20
        .BYTE $20,$20,$20,$20,$20,$20,$20,$20
        .BYTE $20,$20,$20,$20,$94,$96,$20,$20
f96D8   .BYTE $20,$20,$20,$20,$20,$89,$98,$20
        .BYTE $20,$20,$20,$20,$20,$20,$20,$20
        .BYTE $20,$20,$20,$20,$20,$20,$20,$20
        .BYTE $20,$20,$20,$20,$20,$8C,$8E,$20
        .BYTE $20,$20,$20,$20,$95,$97,$20,$20
f9700   .BYTE $20,$20,$20,$20,$86,$8A,$88,$98
        .BYTE $20,$20,$20,$20,$8C,$8E,$20,$20
        .BYTE $20,$94,$96,$20,$20,$20,$20,$20
        .BYTE $20,$20,$20,$20,$20,$8D,$8F,$94
        .BYTE $96,$20,$20,$20,$20,$20,$20,$20
f9728   .BYTE $94,$96,$20,$86,$8B,$88,$88,$88
        .BYTE $98,$20,$20,$20,$8D,$8F,$20,$20
        .BYTE $20,$95,$97,$20,$20,$20,$20,$20
        .BYTE $20,$20,$20,$20,$20,$8D,$8F,$95
        .BYTE $97,$20,$20,$89,$98,$20,$20,$20
f9750   .BYTE $95,$97,$86,$87,$8A,$88,$88,$88
        .BYTE $88,$98,$20,$20,$8D,$8F,$20,$20
        .BYTE $20,$20,$20,$20,$89,$98,$20,$20
        .BYTE $8C,$8E,$20,$20,$20,$8D,$8F,$20
        .BYTE $20,$20,$86,$8A,$88,$98,$20,$20
f9778   .BYTE $20,$86,$87,$8B,$88,$88,$88,$88
        .BYTE $88,$88,$98,$20,$8D,$8F,$20,$20
        .BYTE $20,$20,$20,$86,$8A,$88,$98,$20
        .BYTE $8D,$8F,$8C,$8E,$20,$8D,$8F,$20
        .BYTE $20,$86,$8B,$88,$88,$88,$98,$20
f97A0   .BYTE $86,$87,$87,$8A,$88,$88,$88,$88
        .BYTE $88,$88,$88,$98,$8D,$8F,$20,$89
        .BYTE $98,$20,$86,$8B,$88,$88,$88,$98
        .BYTE $8D,$8F,$8D,$8F,$20,$8D,$8F,$20
        .BYTE $86,$87,$8A,$88,$88,$88,$88,$98
        .BYTE $00,$FF,$00,$FF,$00,$BF,$20,$FE
        .BYTE $20,$FF,$00,$FF,$00,$BD,$00,$FF
        .BYTE $00,$FF,$00,$DF,$00,$BD,$1D,$BD
        .BYTE $00,$FF,$00,$FF,$00,$FF,$01,$FF
        .BYTE $00,$FF,$40,$FF,$00,$FF,$41,$DC
        .BYTE $00,$FF,$00,$FF,$00,$FF,$00,$FF
        .BYTE $40,$FF,$00,$FF,$00,$BD,$FF,$FF
        .BYTE $F7,$00,$FF,$00,$96,$00,$FE,$00
        .BYTE $BF,$00,$FE,$00,$BD,$00,$FF,$00
        .BYTE $7E,$20,$FE,$00,$FF,$00,$DE,$20
        .BYTE $FF,$00,$FE,$80,$3D,$00,$BE,$00
        .BYTE $FE,$00,$5E,$20,$FA,$00,$46,$C0
        .BYTE $7E,$00,$DE,$80,$EA,$20,$DE,$A0
        .BYTE $3D,$80,$DE,$A0,$5E,$00,$DE,$00
        .BYTE $5E,$00,$FE,$00,$BF,$40,$BF,$00
        .BYTE $FF,$9C,$FF,$00,$FF,$00,$00,$00
        .BYTE $FF,$00,$FF,$00,$FF,$00,$FE,$00
        .BYTE $FE,$00,$FE,$00,$FF,$00,$FE,$00
        .BYTE $BF,$00,$FE,$00,$FF,$40,$E2,$40
        .BYTE $FE,$00,$FE,$00,$FE,$00,$FE,$00
        .BYTE $FE,$00,$BD,$00,$FE,$00,$3E,$21
        .BYTE $BE,$00,$FE,$00,$FE,$00,$FE,$00
        .BYTE $BD,$00,$FF,$00,$BF,$00,$00,$00
        .BYTE $08,$BD,$00,$FF,$E8,$BF,$A1,$7F
        .BYTE $42,$FF,$A0,$5F,$02,$BF,$20,$BD
        .BYTE $81,$5E,$00,$FF,$00,$BF,$81,$BF
        .BYTE $00,$7F,$A0,$37,$82,$BF,$41,$BF
        .BYTE $00,$FF,$00,$7F,$84,$BD,$19,$1F
        .BYTE $00,$98,$00,$5F,$15,$BF,$03,$FF
        .BYTE $02,$FF,$00,$5F,$00,$FF,$00,$BD
        .BYTE $A0,$BF,$80,$FF,$00,$39,$00,$BF
        .BYTE $00,$02,$00,$DF,$00,$FF,$BF,$FF
        .BYTE $00,$FF,$00,$FF,$00,$BF,$20,$FF
        .BYTE $A0,$FF,$00,$FF,$00,$BD,$00,$FF
        .BYTE $00,$FF,$00,$DF,$00,$BD,$1D,$BD
        .BYTE $00,$FF,$00,$FF,$00,$FF,$01,$FF
        .BYTE $00,$FF,$42,$DF,$00,$FF,$C9,$DE
        .BYTE $00,$FF,$00,$FF,$00,$FF,$00,$FF
        .BYTE $42,$FF,$00,$FF,$42,$BD,$FF,$FF
        .BYTE $F7,$00,$FF,$00,$96,$00,$FE,$00
        .BYTE $BF,$00,$FE,$00,$FD,$00,$FF,$00
        .BYTE $5E,$21,$DE,$00,$FF,$00,$DE,$20
        .BYTE $FF,$00,$FE,$80,$3D,$00,$BE,$00
        .BYTE $FE,$00,$5E,$20,$FA,$00,$46,$40
        .BYTE $7E,$00,$DE,$80,$EA,$20,$DE,$A0
        .BYTE $3D,$80,$5E,$A0,$5E,$00,$DE,$00
        .BYTE $5E,$00,$FE,$00,$BF,$40,$BF,$00
        .BYTE $FF,$98,$FF,$00,$FF,$00,$00,$00
        .BYTE $FF,$00,$FF,$00,$FF,$00,$FE,$00
        .BYTE $FE,$00,$FE,$00,$FF,$00,$FE,$00
        .BYTE $BF,$00,$FE,$00,$FF,$40,$62,$40
        .BYTE $7E,$00,$FE,$00,$FE,$00,$FE,$00
        .BYTE $FE,$00,$BD,$00,$7E,$00,$3E,$21
        .BYTE $FF,$00,$FE,$00,$FE,$00,$FE,$00
        .BYTE $BD,$00,$FF,$00,$BF,$00,$00,$00
        .BYTE $08,$BD,$00,$FF,$E8,$FD,$A0,$7F
        .BYTE $00,$FF,$A0,$7F,$02,$BF,$20,$BD
        .BYTE $81,$5E,$00,$FF,$00,$BD,$81,$BF
        .BYTE $00,$7F,$A0,$37,$82,$BD,$01,$BD
        .BYTE $00,$FF,$00,$7F,$84,$BD,$19,$1F
        .BYTE $00,$BC,$00,$5F,$15,$BF,$00,$FF
        .BYTE $00,$FF,$00,$5F,$00,$FF,$00,$BD
        .BYTE $A0,$BF,$80,$FF,$00,$3D,$00,$BF
        .BYTE $00,$02,$00,$FF,$00,$FF,$BF,$FF
        .BYTE $00,$FF,$00,$FF,$00,$BF,$20,$FF
        .BYTE $A0,$FF,$00,$FF,$00,$BD,$00,$FF
        .BYTE $00,$FF,$00,$DF,$00,$BD,$1D,$BD
        .BYTE $00,$FF,$00,$FF,$00,$7F,$00,$FF
        .BYTE $00,$FF,$42,$FF,$00,$FF,$C0,$DE
        .BYTE $00,$FF,$00,$FF,$00,$FF,$00,$FF
        .BYTE $40,$FF,$00,$FF,$00,$BD,$FF,$FF
        .BYTE $F7,$00,$FF,$00,$96,$00,$FE,$00
        .BYTE $BF,$00,$FE,$00,$FD,$00,$FF,$40
        .BYTE $7E,$20,$DE,$00,$FF,$00,$DE,$20
        .BYTE $FF,$00,$FE,$88,$3F,$00,$BE,$40
        .BYTE $FE,$00,$5E,$20,$FA,$00,$46,$C0
        .BYTE $7E,$42,$DE,$80,$EA,$60,$DE,$A0
        .BYTE $3F,$80,$5E,$A0,$5E,$00,$DE,$40
        .BYTE $5E,$00,$FE,$00,$BF,$C0,$BF,$00
p9A40   .BYTE $00,$FF,$00,$07,$FF,$E0,$0F,$FF
        .BYTE $F0,$0F,$3C,$F0,$0E,$18,$70,$07
        .BYTE $3C,$E0,$03,$FF,$C0,$00,$E7,$00
        .BYTE $00,$C3,$00,$00,$FF,$00,$01,$54
        .BYTE $80,$01,$00,$80,$00,$D5,$00,$20
        .BYTE $7E,$1E,$70,$00,$3C,$7C,$00,$E0
        .BYTE $2F,$07,$80,$03,$9E,$00,$00,$E0
        .BYTE $00,$03,$3E,$00,$03,$CF,$00,$40
        .BYTE $00,$FF,$00,$07,$FF,$E0,$0F,$FF
        .BYTE $F0,$0F,$3C,$F0,$0E,$DB,$70,$07
        .BYTE $3C,$E0,$03,$E7,$C0,$01,$C3,$80
        .BYTE $00,$C3,$00,$00,$FF,$00,$01,$54
        .BYTE $80,$01,$00,$86,$01,$00,$8E,$01
        .BYTE $AB,$0C,$00,$7E,$18,$78,$00,$30
        .BYTE $7F,$00,$E0,$37,$E1,$80,$00,$3C
        .BYTE $00,$00,$07,$F0,$00,$18,$78,$40
        .BYTE $00,$18,$00,$00,$3C,$00,$00,$7E
        .BYTE $00,$00,$00,$00,$00,$FF,$00,$01
        .BYTE $FF,$80,$03,$C3,$C0,$07,$E7,$E0
        .BYTE $0F,$E7,$F0,$1F,$E7,$F8,$3F,$C3
        .BYTE $FC,$7F,$FF,$FE,$FF,$FF,$FF,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$40
        .BYTE $00,$00,$00,$00,$18,$00,$00,$3C
        .BYTE $00,$00,$7E,$00,$00,$FF,$00,$01
        .BYTE $E7,$80,$03,$E7,$C0,$07,$FF,$E0
        .BYTE $0F,$C7,$F0,$1F,$E7,$F8,$3F,$E7
        .BYTE $FC,$7F,$C7,$FE,$FF,$FF,$FF,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$40
        .BYTE $00,$00,$00,$03,$80,$60,$07,$C0
        .BYTE $70,$07,$C0,$5C,$07,$C0,$7C,$0F
        .BYTE $E0,$E0,$0E,$E8,$E0,$1D,$F7,$E0
        .BYTE $1B,$77,$C0,$3B,$7B,$80,$3B,$38
        .BYTE $00,$36,$18,$00,$36,$38,$00,$16
        .BYTE $30,$00,$38,$38,$00,$38,$38,$00
        .BYTE $18,$30,$00,$18,$30,$00,$38,$30
        .BYTE $00,$70,$38,$00,$00,$1C,$00,$40
        .BYTE $00,$00,$00,$03,$80,$00,$07,$C0
        .BYTE $60,$07,$C0,$70,$07,$C0,$5C,$0F
        .BYTE $E0,$78,$0F,$E0,$70,$1D,$F6,$F0
        .BYTE $1D,$B7,$E0,$3D,$BB,$E0,$39,$BB
        .BYTE $C0,$30,$D8,$00,$38,$D8,$00,$18
        .BYTE $D0,$00,$38,$18,$00,$38,$38,$00
        .BYTE $18,$30,$00,$18,$30,$00,$18,$38
        .BYTE $00,$38,$1C,$00,$70,$00,$00,$40
        .BYTE $18,$00,$30,$18,$00,$60,$38,$30
        .BYTE $E0,$28,$60,$E0,$6C,$6C,$A0,$64
        .BYTE $F9,$A0,$67,$FD,$60,$3F,$FF,$C0
        .BYTE $19,$FB,$80,$1C,$55,$80,$1B,$8D
        .BYTE $80,$1B,$FD,$80,$0B,$1B,$00,$0C
        .BYTE $E7,$00,$0F,$FF,$00,$0F,$77,$00
        .BYTE $0C,$73,$00,$0C,$8B,$00,$01,$FA
        .BYTE $00,$03,$6C,$00,$01,$F8,$00,$40
        .BYTE $C0,$00,$18,$60,$C0,$30,$70,$60
        .BYTE $70,$58,$60,$E0,$6C,$6C,$A0,$66
        .BYTE $FD,$A0,$27,$FD,$60,$3F,$FF,$E0
        .BYTE $19,$9B,$C0,$1C,$05,$80,$1B,$6D
        .BYTE $80,$1B,$FD,$80,$1B,$1B,$00,$0C
        .BYTE $E7,$00,$0F,$FF,$00,$0F,$77,$00
        .BYTE $0C,$93,$00,$05,$FA,$00,$03,$6C
        .BYTE $00,$03,$6C,$00,$01,$F8,$00,$40
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$3C,$00,$00,$7E,$00
        .BYTE $00,$7E,$00,$00,$7E,$00,$00,$3C
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $3F,$80,$00,$60,$E0,$00,$1B,$70
        .BYTE $00,$1B,$70,$00,$3B,$70,$00,$1B
        .BYTE $70,$00,$3F,$E0,$00,$E0,$03,$00
        .BYTE $C0,$FE,$00,$61,$B0,$00,$00,$30
        .BYTE $00,$00,$70,$00,$00,$30,$00,$00
        .BYTE $36,$06,$00,$FC,$7C,$03,$86,$CC
        .BYTE $03,$01,$8C,$01,$81,$CE,$00,$01
        .BYTE $CE,$00,$00,$CC,$00,$00,$78,$00
        .BYTE $00,$7C,$00,$03,$FF,$80,$0F,$EF
        .BYTE $E0,$1F,$9F,$F0,$1F,$FF,$F0,$3F
        .BYTE $FF,$00,$3F,$F0,$00,$3F,$F0,$00
        .BYTE $7F,$FF,$00,$7F,$FF,$F0,$DF,$FF
        .BYTE $F0,$CF,$FF,$E0,$CF,$FF,$E0,$D8
        .BYTE $7C,$60,$6C,$C6,$30,$D8,$63,$60
        .BYTE $CE,$33,$30,$63,$66,$30,$C6,$63
        .BYTE $30,$06,$31,$98,$00,$18,$00,$00
        .BYTE $00,$7C,$00,$03,$FF,$80,$0F,$DF
        .BYTE $C0,$1F,$3F,$00,$1F,$FC,$00,$3F
        .BYTE $F0,$00,$3F,$C0,$00,$3F,$C0,$00
        .BYTE $7F,$F0,$00,$7F,$FC,$00,$DF,$FF
        .BYTE $00,$CF,$FF,$C0,$CF,$FF,$E0,$6C
        .BYTE $7C,$60,$6C,$C6,$60,$C6,$C6,$30
        .BYTE $CC,$66,$60,$C6,$63,$60,$CC,$63
        .BYTE $30,$6C,$C3,$60,$00,$61,$80,$00
        .BYTE $00,$00,$00,$00,$00,$00,$38,$00
        .BYTE $1C,$6F,$00,$36,$DD,$80,$FB,$DD
        .BYTE $81,$BB,$DD,$81,$BB,$61,$E3,$86
        .BYTE $3C,$36,$1C,$07,$DD,$F0,$00,$C1
        .BYTE $80,$01,$B6,$C0,$01,$80,$C0,$00
        .BYTE $C1,$80,$00,$C1,$80,$00,$D5,$80
        .BYTE $00,$77,$00,$00,$3E,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$1F,$FF,$FE,$19,$7F
        .BYTE $FE,$1D,$FF,$FE,$1D,$FF,$FE,$1F
        .BYTE $FF,$FE,$3F,$FF,$FC,$3F,$FF,$FC
        .BYTE $63,$3F,$38,$7F,$FF,$F8,$CD,$3E
        .BYTE $70,$FF,$FF,$F0,$C2,$7E,$70,$FF
        .BYTE $FF,$F0,$C6,$FE,$70,$FF,$FF,$F0
        .BYTE $66,$BF,$38,$7F,$FF,$F8,$39,$00
        .BYTE $0C,$1F,$FF,$FE,$00,$00,$00,$00
        .BYTE $00,$00,$00,$3F,$FF,$FC,$32,$FF
        .BYTE $FC,$3B,$FF,$FC,$1D,$FF,$FE,$1F
        .BYTE $FF,$FE,$1F,$FF,$FE,$3F,$FF,$FC
        .BYTE $31,$9F,$9C,$3F,$FF,$FC,$66,$9F
        .BYTE $38,$7F,$FF,$F8,$61,$3F,$38,$FF
        .BYTE $FF,$F0,$C6,$FE,$70,$FF,$FF,$F0
        .BYTE $CD,$7E,$70,$FF,$FF,$F0,$72,$00
        .BYTE $18,$7F,$FF,$F8,$00,$00,$00,$00
        .BYTE $18,$00,$7D,$30,$00,$79,$03,$00
        .BYTE $0F,$01,$80,$EF,$19,$81,$E8,$31
        .BYTE $87,$DF,$63,$1F,$9F,$66,$3F,$07
        .BYTE $30,$FE,$00,$01,$FC,$00,$07,$F8
        .BYTE $00,$09,$F8,$00,$1E,$F0,$00,$35
        .BYTE $60,$00,$26,$C0,$00,$35,$80,$00
        .BYTE $0E,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $30,$00,$FB,$60,$60,$F7,$C0,$C0
        .BYTE $FF,$70,$60,$FF,$18,$30,$C0,$0C
        .BYTE $60,$1C,$39,$C0,$F9,$63,$07,$F7
        .BYTE $30,$3F,$CF,$00,$FF,$80,$05,$7F
        .BYTE $00,$01,$3C,$00,$0A,$98,$00,$15
        .BYTE $30,$00,$02,$80,$00,$04,$80,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $7F,$FF,$F0,$60,$F3,$18,$60,$F3
        .BYTE $0C,$60,$F3,$06,$60,$F3,$06,$60
        .BYTE $FF,$06,$60,$00,$06,$60,$00,$06
        .BYTE $60,$00,$06,$60,$00,$06,$63,$FF
        .BYTE $C6,$63,$6B,$C6,$63,$FF,$C6,$63
        .BYTE $37,$C6,$63,$FF,$C6,$63,$45,$C6
        .BYTE $63,$FF,$C6,$7F,$FF,$FE,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $7F,$FF,$F0,$67,$D8,$18,$67,$B8
        .BYTE $0C,$67,$D8,$06,$67,$B8,$06,$67
        .BYTE $F8,$06,$60,$00,$06,$60,$00,$06
        .BYTE $60,$00,$06,$60,$00,$06,$63,$FF
        .BYTE $C6,$63,$6B,$C6,$63,$FF,$C6,$63
        .BYTE $37,$C6,$63,$FF,$C6,$63,$45,$C6
        .BYTE $63,$FF,$C6,$7F,$FF,$FE,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $1C,$00,$70,$36,$00,$D8,$06,$00
        .BYTE $C0,$03,$01,$80,$03,$01,$80,$01
        .BYTE $83,$00,$01,$83,$00,$01,$83,$00
        .BYTE $00,$C6,$00,$00,$C6,$00,$00,$C6
        .BYTE $00,$00,$FE,$00,$01,$FF,$00,$01
        .BYTE $7D,$00,$00,$BA,$00,$00,$FE,$00
        .BYTE $00,$FE,$00,$00,$FE,$00,$00,$6C
        .BYTE $00,$00,$82,$00,$00,$FE,$00,$BD
        .BYTE $03,$FF,$E0,$03,$FF,$E0,$03,$FF
        .BYTE $E0,$06,$DB,$70,$07,$6D,$B0,$03
        .BYTE $DB,$60,$03,$6D,$E0,$03,$DB,$60
        .BYTE $03,$6D,$E0,$03,$DB,$60,$01,$ED
        .BYTE $C0,$01,$DB,$C0,$01,$ED,$C0,$01
        .BYTE $DB,$C0,$01,$ED,$C0,$01,$DB,$C0
        .BYTE $01,$ED,$C0,$01,$FF,$C0,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$BD
        .BYTE $03,$FF,$E0,$03,$00,$60,$03,$60
        .BYTE $60,$06,$03,$30,$06,$30,$30,$03
        .BYTE $00,$60,$03,$FF,$E0,$03,$FF,$E0
        .BYTE $03,$FF,$E0,$03,$DB,$60,$01,$ED
        .BYTE $C0,$01,$DB,$C0,$01,$ED,$C0,$01
        .BYTE $DB,$C0,$01,$ED,$C0,$01,$DB,$C0
        .BYTE $01,$ED,$C0,$01,$FF,$C0,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$BD
        .BYTE $03,$FF,$E0,$03,$00,$60,$03,$60
        .BYTE $60,$06,$03,$30,$06,$30,$30,$03
        .BYTE $00,$60,$03,$0C,$60,$03,$00,$60
        .BYTE $03,$30,$60,$03,$06,$60,$01,$80
        .BYTE $C0,$01,$80,$C0,$01,$80,$C0,$01
        .BYTE $FF,$C0,$01,$FF,$C0,$01,$FF,$C0
        .BYTE $01,$ED,$C0,$01,$FF,$C0,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$43
fA000   .BYTE $4C
fA001   .BYTE $25,$A0
aA003   .BYTE $00
;-------------------------------
; sA004
;-------------------------------
sA004   
        LDX #$00
bA006   LDA fA01E,X
        STA f4122,X
        LDA fA021,X
        STA f410A,X
        LDA fA023,X
        STA f4116,X
        INX 
        CPX #$02
        BNE bA006
        RTS 

fA01E   .BYTE $F0,$FF,$FF
fA021   .BYTE $42,$42
fA023   .BYTE $A3,$A3
        LDA #$00
        STA $D404    ;Voice 1: Control Register
        STA $D40B    ;Voice 2: Control Register
        STA $D412    ;Voice 3: Control Register
        STA $D405    ;Voice 1: Attack / Decay Cycle Control
        STA $D40C    ;Voice 2: Attack / Decay Cycle Control
        STA $D413    ;Voice 3: Attack / Decay Cycle Control
        LDA aA003
        BNE bA043
        LDA #$01
        STA aA7C9
bA043   LDA #$27
        SEC 
        SBC a41AF
        ROR 
        ROR 
        ROR 
        AND #$07
        CLC 
        ADC #$02
        STA aA7C7
        LDA #$0F
        STA $D418    ;Select Filter Mode and Volume
        LDA #$21
        STA $D404    ;Voice 1: Control Register
        STA $D40B    ;Voice 2: Control Register
        STA $D412    ;Voice 3: Control Register
        LDA #$F0
        STA $D414    ;Voice 3: Sustain / Release Cycle Control
        STA $D40D    ;Voice 2: Sustain / Release Cycle Control
        STA $D406    ;Voice 1: Sustain / Release Cycle Control
        JMP jA141

aA072   .BYTE $00
aA073   .BYTE $00
aA074   .BYTE $00
aA075   .BYTE $00
;-------------------------------
; sA076
;-------------------------------
sA076   
        LDY aA072
        LDX aA073
        LDA $0340,X
        STA a02
        LDA $0360,X
        STA a03
        LDA aA075
        STA (p02),Y
        LDA a03
        CLC 
        ADC #$D4
        STA a03
        LDA aA074
        STA (p02),Y
        RTS 

aA098   .BYTE $00
aA099   .BYTE $00
;-------------------------------
; sA09A
;-------------------------------
sA09A   
        LDA #<$0303
        STA aA098
bA09F   LDA #>$0303
        STA aA099
bA0A4   JSR sA076
        INC aA072
        DEC aA099
        BNE bA0A4
        DEC aA072
        DEC aA072
        DEC aA072
        INC aA073
        DEC aA098
        BNE bA09F
        RTS 

fA0C1   .BYTE $02,$08,$07,$05,$0E,$04,$06,$00
;-------------------------------
; sA0C9
;-------------------------------
sA0C9   
        LDY #$00
bA0CB   LDA (p04),Y
        CLC 
        ADC #$A5
        STA aA075
        LDA (p04),Y
        TAX 
        LDA fA0C1,X
        STA aA074
        TYA 
        AND #$07
        ASL 
        ASL 
        CLC 
        ADC #$04
        STA aA072
        TYA 
        ROR 
        AND #$3C
        STA aA073
        TYA 
        PHA 
        JSR sA09A
        PLA 
        TAY 
        INY 
        CPY #$28
        BNE bA0CB
        RTS 

;-------------------------------
; sA0FB
;-------------------------------
sA0FB   
        LDX #$00
        LDA $D016    ;VIC Control Register 2
        AND #$F8
        ORA #$08
        STA $D016    ;VIC Control Register 2
pA108   =*+$01
bA107   LDA #$20
        STA SCREEN_RAM + $0000,X
        STA SCREEN_RAM + $0100,X
        STA SCREEN_RAM + $0200,X
        STA SCREEN_RAM + $0248,X
        LDA #$01
        STA $D800,X
        STA $D900,X
        STA $DA00,X
        STA $DA48,X
        DEX 
        BNE bA107
        LDA #$FF
        STA $D01C    ;Sprites Multi-Color Mode Select
        LDA #$00
        STA $D01D    ;Sprites Expand 2x Horizontal (X)
        STA $D017    ;Sprites Expand 2x Vertical (Y)
        STA aA76C
        LDA #$06
        STA $D025    ;Sprite Multi-Color Register 0
        LDA #$0E
        STA $D026    ;Sprite Multi-Color Register 1
        RTS 

jA141   SEI 
        JSR sA0FB
        JSR sA2A3
        JSR sA004
        JSR sA838
        JSR sA7CA
        JSR sA0C9
        CLI 
        LDA #$01
        STA aA003
jA15A   JSR sA76D
        JSR sAA8D
        JMP jA15A

pA163   .BYTE $00,$00,$00,$00,$00,$01,$01,$01
        .BYTE $02,$02,$02,$03,$03,$03,$03,$03
        .BYTE $04,$04,$04,$04,$04,$05,$05,$05
        .BYTE $06,$06,$06,$00,$00,$00,$00,$00
        .BYTE $01,$01,$01,$01,$01,$02,$02,$02
        .BYTE $00,$01,$02,$03,$04,$05,$06,$00
        .BYTE $01,$02,$03,$04,$05,$06,$00,$01
        .BYTE $02,$03,$04,$05,$06,$00,$01,$02
        .BYTE $03,$04,$05,$06,$00,$01,$02,$03
        .BYTE $04,$05,$06,$00,$01,$02,$03,$04
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$01,$02,$01,$02,$01,$02,$00
        .BYTE $00,$03,$04,$03,$04,$03,$04,$00
        .BYTE $00,$05,$06,$05,$06,$05,$06,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$01,$01,$00,$00,$00
        .BYTE $02,$02,$03,$04,$04,$03,$02,$02
        .BYTE $05,$06,$07,$07,$07,$07,$06,$05
        .BYTE $02,$02,$03,$04,$04,$03,$02,$02
        .BYTE $00,$00,$00,$01,$01,$00,$00,$00
        .BYTE $00,$01,$02,$03,$03,$02,$01,$00
        .BYTE $02,$03,$04,$05,$05,$04,$03,$02
        .BYTE $04,$05,$06,$07,$07,$06,$05,$04
        .BYTE $02,$03,$04,$05,$05,$04,$03,$02
        .BYTE $00,$01,$02,$03,$03,$02,$01,$00
        .BYTE $07,$07,$01,$02,$03,$03,$07,$07
        .BYTE $07,$07,$03,$03,$03,$03,$07,$07
        .BYTE $04,$05,$06,$00,$00,$06,$05,$04
        .BYTE $07,$07,$03,$03,$03,$03,$07,$07
        .BYTE $07,$07,$03,$03,$02,$01,$07,$07
        .BYTE $07,$07,$07,$07,$07,$07,$07,$07
        .BYTE $07,$00,$07,$07,$07,$07,$01,$07
        .BYTE $07,$07,$07,$02,$07,$07,$07,$07
        .BYTE $07,$07,$03,$07,$07,$04,$07,$07
        .BYTE $07,$07,$07,$05,$07,$07,$06,$07
        .BYTE $00,$06,$00,$00,$00,$00,$06,$00
        .BYTE $06,$01,$02,$05,$01,$04,$02,$06
        .BYTE $07,$00,$03,$07,$00,$01,$06,$07
        .BYTE $06,$02,$01,$06,$04,$02,$03,$06
        .BYTE $00,$06,$00,$00,$00,$00,$06,$00
;-------------------------------
; sA2A3
;-------------------------------
sA2A3   
        LDA #$00
        STA $D020    ;Border Color
        STA $D021    ;Background Color 0
        LDA #$18
        STA $D018    ;VIC Memory Control Register
        RTS 

;-------------------------------
; sA2B1
;-------------------------------
sA2B1   
        TXA 
        PHA 
        LDA fA36D,X
        BEQ bA2D2
        TAX 
bA2B9   LDY #$00
        LDA (p06),Y
        PHA 
bA2BE   INY 
        LDA (p06),Y
        DEY 
        STA (p06),Y
        INY 
        CPY #$07
        BNE bA2BE
        PLA 
        STA (p06),Y
        DEX 
        BNE bA2B9
        PLA 
        TAX 
        PHA 
bA2D2   LDA fA375,X
        BEQ bA2EF
        TAX 
bA2D8   LDY #$07
        LDA (p06),Y
        PHA 
bA2DD   DEY 
        LDA (p06),Y
        INY 
        STA (p06),Y
        DEY 
        BNE bA2DD
        PLA 
        STA (p06),Y
        DEX 
        BNE bA2D8
        PLA 
        TAX 
        PHA 
bA2EF   LDA fA365,X
        BEQ bA309
        TAX 
bA2F5   LDY #$00
bA2F7   LDA (p06),Y
        ASL 
        ADC #$00
        STA (p06),Y
        INY 
        CPY #$08
        BNE bA2F7
        DEX 
        BNE bA2F5
        PLA 
        TAX 
        PHA 
bA309   LDA fA35D,X
        BEQ bA323
        TAX 
bA30F   LDY #$00
bA311   LDA (p06),Y
        CLC 
        ROR 
        BCC bA319
        ORA #$80
bA319   STA (p06),Y
        INY 
        CPY #$08
        BNE bA311
        DEX 
        BNE bA30F
bA323   PLA 
        TAX 
        RTS 

;-------------------------------
; sA326
;-------------------------------
sA326   
        LDX #$00
bA328   LDA #$25
        STA a07
        LDA fA33A,X
        STA a06
        JSR sA2B1
        INX 
        CPX #$08
        BNE bA328
        RTS 

fA33A   .BYTE $28,$30,$38,$40,$48,$50,$58,$60
        JSR sA88C
        JSR s4135
        JSR sA405
        JSR sA5A5
        JSR sA944
        JSR sA326
        JSR sAA00
        JSR $FF9F ;$FF9F - scan keyboard                    
        JMP j4132

fA35D   .BYTE $00,$00,$00,$00,$00,$00,$00,$00
fA365   .BYTE $00,$00,$00,$00,$00,$00,$00,$00
fA36D   .BYTE $00,$00,$00,$00,$00,$00,$00,$00
fA375   .BYTE $00,$00,$00,$00,$00,$00,$00,$00
jA37D   LDA aA40D
        ASL 
        ASL 
        CLC 
        ADC #$03
        STA aA072
        LDA aA40E
        ASL 
        ASL 
        STA aA073
        LDA #$42
        STA aA075
        LDX aA40F
        LDA fA487,X
        STA aA074
        JSR sA076
        INC aA073
        JSR sA076
        INC aA073
        JSR sA076
        LDA aA072
        CLC 
        ADC #$04
        STA aA072
        JSR sA076
        DEC aA073
        JSR sA076
        DEC aA073
        JSR sA076
        RTS 

;-------------------------------
; sA3C6
;-------------------------------
sA3C6   
        LDA aA40D
        ASL 
        ASL 
        CLC 
        ADC #$03
        STA aA072
        LDA aA40E
        ASL 
        ASL 
        STA aA073
        LDA #$20
        STA aA075
        JSR sA076
        INC aA073
        JSR sA076
        INC aA073
        JSR sA076
        LDA aA072
        CLC 
        ADC #$04
        STA aA072
        JSR sA076
        DEC aA073
        JSR sA076
        DEC aA073
        JMP sA076

;-------------------------------
; sA405
;-------------------------------
sA405   
        DEC aA40B
        BEQ bA411
        RTS 

aA40B   .BYTE $03
aA40C   .BYTE $FF
aA40D   .BYTE $00
aA40E   .BYTE $00
aA40F   .BYTE $00
aA410   .BYTE $04
bA411   LDA #$03
        STA aA40B
        JSR sA3C6
        LDA $DC00    ;CIA1: Data Port Register A
        STA aA40C
        INC aA40F
        LDA aA40F
        AND #$07
        STA aA40F
        LDA aA40C
        AND #$10
        BEQ bA481
        LDA aA40C
        AND #$01
        BNE bA447
        DEC aA40E
        LDA aA40E
        CMP #$FF
        BNE bA447
        LDA #$04
        STA aA40E
bA447   LDA aA40C
        AND #$02
        BNE bA45D
        INC aA40E
        LDA aA40E
        CMP #$05
        BNE bA45D
        LDA #$00
        STA aA40E
bA45D   LDA aA40C
        AND #$04
        BNE bA46F
        DEC aA40D
        LDA aA40D
        AND #$07
        STA aA40D
bA46F   LDA aA40C
        AND #$08
        BNE bA481
        INC aA40D
        LDA aA40D
        AND #$07
        STA aA40D
bA481   JSR sA48F
        JMP jA37D

fA487   .BYTE $00,$0B,$0C,$0F,$01,$0F,$0C,$0B
;-------------------------------
; sA48F
;-------------------------------
sA48F   
        DEC aA495
        BEQ bA496
        RTS 

aA495   .BYTE $03
bA496   LDA #$03
        STA aA495
        LDA aA40C
        AND #$10
        BEQ bA4A3
        RTS 

bA4A3   LDA aA40E
        ASL 
        ASL 
        ASL 
        ORA aA40D
        TAY 
        LDA (p04),Y
        TAX 
        LDA aA40C
        AND #$01
        BNE bA4D3
        JSR sA998
        LDA fA375,X
        BEQ bA4C5
        DEC fA375,X
        JMP bA4D3

bA4C5   INC fA36D,X
        LDA fA36D,X
        CMP aA410
        BNE bA4D3
        DEC fA36D,X
bA4D3   LDA aA40C
        AND #$02
        BNE bA4F6
        JSR sA9A9
        LDA fA36D,X
        BEQ bA4E8
        DEC fA36D,X
        JMP bA4F6

bA4E8   INC fA375,X
        LDA fA375,X
        CMP aA410
        BNE bA4F6
        DEC fA375,X
bA4F6   LDA aA40C
        AND #$04
        BNE bA516
        LDA fA35D,X
        BEQ bA508
        DEC fA35D,X
        JMP bA516

bA508   INC fA365,X
        LDA fA365,X
        CMP aA410
        BNE bA516
        DEC fA365,X
bA516   LDA aA40C
        AND #$08
        BNE bA534
        LDA fA365,X
        BEQ bA526
        DEC fA365,X
        RTS 

bA526   INC fA35D,X
        LDA fA35D,X
        CMP aA410
        BNE bA534
        DEC fA35D,X
bA534   RTS 

fA535   .BYTE $01,$02,$04,$08,$10,$20,$40,$80
bA53D   LDA fA535,X
        EOR #$FF
        AND $D015    ;Sprite display Enable
        STA $D015    ;Sprite display Enable
        RTS 

;-------------------------------
; sA549
;-------------------------------
sA549   
        TXA 
        ASL 
        TAY 
        LDA fA58D,X
        BEQ bA53D
        ASL 
        STA $D000,Y  ;Sprite 0 X Pos
        BCC bA563
        LDA fA535,X
        ORA $D010    ;Sprites 0-7 MSB of X coordinate
        STA $D010    ;Sprites 0-7 MSB of X coordinate
        JMP jA56E

bA563   LDA fA535,X
        EOR #$FF
        AND $D010    ;Sprites 0-7 MSB of X coordinate
        STA $D010    ;Sprites 0-7 MSB of X coordinate
jA56E   LDA fA595,X
        STA $D001,Y  ;Sprite 0 Y Pos
        LDA fA59D,X
        STA SCREEN_RAM + $03F8,X
        LDY aA40F
        LDA fA487,Y
        STA $D027,X  ;Sprite 0 Color
        LDA fA535,X
        ORA $D015    ;Sprite display Enable
        STA $D015    ;Sprite display Enable
        RTS 

fA58D   .BYTE $00,$30,$00,$50,$00,$00,$00,$00
fA595   .BYTE $20,$30,$40,$50,$60,$70,$80,$90
fA59D   .BYTE $B7,$B8,$B9,$BA,$BB,$BC,$BD,$BE
;-------------------------------
; sA5A5
;-------------------------------
sA5A5   
        LDX #$00
        LDA #$00
        ORA aA76C
        STA aA76B
bA5AF   JSR sA549
        LDA fA58D,X
        BEQ bA5C0
        JSR sA5E8
        JSR sA6E7
        JSR sA66C
bA5C0   INX 
        CPX #$08
        BNE bA5AF
        LDA aA76B
        BNE bA5D7
        BNE bA5D7
        LDA #$01
        STA aA76C
        JSR sA83E
        JSR sA7D5
bA5D7   RTS 

fA5D8   .BYTE $00,$03,$00,$01,$00,$00,$00,$00
fA5E0   .BYTE $00,$FF,$00,$01,$00,$00,$00,$00
;-------------------------------
; sA5E8
;-------------------------------
sA5E8   
        DEC fA651,X
        BNE bA622
        LDA #$02
        STA fA651,X
        JSR sA659
jA5F5   LDA fA58D,X
        CLC 
        ADC fA5D8,X
        STA fA58D,X
        AND #$F8
        CMP #$08
        BEQ bA609
        CMP #$98
        BNE bA622
bA609   LDA fA5D8,X
        EOR #$FF
        CLC 
        ADC #$01
        STA fA5D8,X
        LDA fA6D7,X
        EOR #$FF
        CLC 
        ADC #$01
        STA fA6D7,X
        JMP jA5F5

bA622   LDA fA595,X
        CLC 
        ADC fA5E0,X
        STA fA595,X
        AND #$F0
        CMP #$10
        BEQ bA637
        CMP #$D0
        BEQ bA637
        RTS 

bA637   LDA fA5E0,X
        EOR #$FF
        CLC 
        ADC #$01
        STA fA5E0,X
        LDA fA6DF,X
        EOR #$FF
        CLC 
        ADC #$01
        STA fA6DF,X
        JMP bA622

        RTS 

fA651   .BYTE $01,$01,$01,$01,$01,$01,$01,$01
;-------------------------------
; sA659
;-------------------------------
sA659   
        INC fA59D,X
        LDA fA59D,X
        CMP #$C0
        BEQ bA664
        RTS 

bA664   LDA #$B7
        STA fA59D,X
        RTS 

aA66A   .BYTE $00
aA66B   .BYTE $00
;-------------------------------
; sA66C
;-------------------------------
sA66C   
        TXA 
        PHA 
        LDA fA58D,X
        BNE bA676
        PLA 
        TAX 
        RTS 

bA676   SEC 
        SBC #$08
        ROR 
        ROR 
        AND #$3F
        STA aA66A
        LDA fA595,X
        SEC 
        SBC #$2C
        ROR 
        ROR 
        ROR 
        AND #$1F
        CLC 
        ADC #$00
        STA aA66B
        LDY aA66A
        LDX aA66B
        LDA $0340,X
        STA a02
        LDA $0360,X
        STA a03
        LDA (p02),Y
        CMP #$20
        BEQ bA6D4
        SEC 
        SBC #$A5
        STA aA66A
        AND #$F8
        BNE bA6D4
        LDA aA66A
        TAY 
        PLA 
        TAX 
        PHA 
        LDA fA35D,Y
        CLC 
        ADC fA6D7,X
        SEC 
        SBC fA365,Y
        STA fA5D8,X
        LDA fA375,Y
        CLC 
        ADC fA6DF,X
        SEC 
        SBC fA36D,Y
        STA fA5E0,X
bA6D4   PLA 
        TAX 
        RTS 

fA6D7   .BYTE $00,$03,$00,$01,$00,$00,$00,$00
fA6DF   .BYTE $00,$FF,$00,$01,$00,$00,$00,$00
;-------------------------------
; sA6E7
;-------------------------------
sA6E7   
        LDA fA5D8,X
        BEQ bA6F2
bA6EC   LDA #$01
        STA aA76B
        RTS 

bA6F2   LDA fA5E0,X
        BNE bA6EC
        LDA fA726,X
        BNE bA705
        JSR sA737
        LDA #$FF
        STA fA726,X
        RTS 

bA705   CMP #$FF
        BNE bA718
        LDA aA736
        STA fA726,X
        LDA #$00
        STA fA72E,X
        JSR sA8BC
        RTS 

bA718   INC fA72E,X
        BNE bA720
        DEC fA726,X
bA720   LDA #$0B
        STA $D027,X  ;Sprite 0 Color
        RTS 

fA726   .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
fA72E   .BYTE $29,$07,$09,$01,$A8,$B9,$D9,$40
aA736   .BYTE $07
;-------------------------------
; sA737
;-------------------------------
sA737   
        JSR sA764
        AND #$07
        SEC 
        SBC #$03
        CMP #$04
        BNE bA745
        AND #$03
bA745   ORA #$01
        STA fA6D7,X
        STA fA5D8,X
        JSR sA764
        AND #$07
        SEC 
        SBC #$03
        CMP #$04
        BNE bA75B
        AND #$03
bA75B   ORA #$01
        STA fA6DF,X
        STA fA5E0,X
        RTS 

aA765   =*+$01
;-------------------------------
; sA764
;-------------------------------
sA764   
        LDA $EF00
        INC aA765
        RTS 

aA76B   .BYTE $00
aA76C   .BYTE $00
;-------------------------------
; sA76D
;-------------------------------
sA76D   
        LDA aA76C
        BNE bA773
        RTS 

bA773   LDA #$08
        SEC 
        SBC aA7C9
        ROR 
        AND #$03
        CLC 
        ADC #$03
        STA aA837
        LDA aA7C7
        ASL 
        ASL 
        ASL 
        ASL 
        ORA aA837
        STA aA837
        LDA a41AF
        ASL 
        ORA #$01
        STA aAA66
bA798   JSR sA80D
        JSR sA879
        DEC aAA66
        BNE bA798
        SEI 
        LDA #$00
        LDA #$00
        STA aA76C
        LDY aA7C9
        DEY 
        JSR sAA77
        INC aA7C9
        LDY aA7C9
        DEY 
        TYA 
        AND #$07
        STA aA7C9
        INC aA7C9
        PLA 
        PLA 
        JMP jA141

aA7C7   .BYTE $03
aA7C8   .BYTE $01
aA7C9   .BYTE $01
;-------------------------------
; sA7CA
;-------------------------------
sA7CA   
        LDA aA003
        BNE bA7EA
        JSR sA7D5
        JMP bA7EA

;-------------------------------
; sA7D5
;-------------------------------
sA7D5   
        LDX #$00
        TXA 
bA7D8   STA fA35D,X
        STA fA365,X
        STA fA36D,X
        STA fA375,X
        INX 
        CPX #$08
        BNE bA7D8
        RTS 

bA7EA   LDA #<pA163
        STA a04
        LDA #>pA163
        STA a05
        LDY aA7C9
        DEY 
        TYA 
        AND #$07
        TAY 
        BEQ bA80C
bA7FC   LDA a04
        CLC 
        ADC #$28
        STA a04
        LDA a05
        ADC #$00
        STA a05
        DEY 
        BNE bA7FC
bA80C   RTS 

;-------------------------------
; sA80D
;-------------------------------
sA80D   
        LDA aA837
        AND #$0F
        TAX 
        LDA aA837
        ROR 
        ROR 
        ROR 
        ROR 
        AND #$0F
        TAY 
bA81D   TXA 
        PHA 
bA81F   INC SCREEN_RAM + $03B7,X
        LDA SCREEN_RAM + $03B7,X
        CMP #$3A
        BNE bA831
        LDA #$30
        STA SCREEN_RAM + $03B7,X
        DEX 
        BNE bA81F
bA831   PLA 
        TAX 
        DEY 
        BNE bA81D
        RTS 

aA837   .BYTE $00
;-------------------------------
; sA838
;-------------------------------
sA838   
        LDA aA003
        BEQ sA83E
        RTS 

;-------------------------------
; sA83E
;-------------------------------
sA83E   
        LDX #$00
bA840   LDA #$00
        STA fA58D,X
        STA fA5D8,X
        STA fA6D7,X
        LDA #$FF
        STA fA726,X
        INX 
        CPX #$08
        BNE bA840
        LDX #$00
bA857   JSR sA764
        AND #$1F
        ADC #$30
        STA fA58D,X
        JSR sA764
        AND #$3F
        ADC #$40
        STA fA595,X
        JSR sA737
        INX 
        CPX aA7C7
        BNE bA857
        RTS 

        .BYTE $07,$05 ;SLO a05
        .BYTE $04,$03 ;NOP a03
;-------------------------------
; sA879
;-------------------------------
sA879   
        TXA 
        PHA 
        TYA 
        PHA 
        LDX #$10
bA87F   LDY #$40
bA881   DEY 
        BNE bA881
        DEX 
        BNE bA87F
        PLA 
        TAY 
        PLA 
        TAX 
        RTS 

;-------------------------------
; sA88C
;-------------------------------
sA88C   
        LDA aA8B8
        BNE bA89A
jA891   LDA #$00
        STA $D020    ;Border Color
        STA $D021    ;Background Color 0
        RTS 

bA89A   LDA aA8BA
        BNE bA8B2
        LDA aA8B9
        STA aA8BA
        LDA aA8BB
        STA $D020    ;Border Color
        STA $D021    ;Background Color 0
        DEC aA8B8
        RTS 

bA8B2   DEC aA8BA
        JMP jA891

aA8B8   .BYTE $00
aA8B9   .BYTE $00
aA8BA   .BYTE $00
aA8BB   .BYTE $00
;-------------------------------
; sA8BC
;-------------------------------
sA8BC   
        JSR sA764
        AND #$0F
        BNE bA8C5
        ORA #$01
bA8C5   STA aA8BB
        JSR sA764
        AND #$1F
        ADC #$08
        STA aA8B8
        JSR sA764
        AND #$07
        CLC 
        ADC #$02
        STA aA8B9
        STA aA8BA
        RTS 

fA8E1   .BYTE $04,$04,$04,$04,$05,$05,$05,$06
        .BYTE $06,$07,$07,$07,$08,$08,$09,$09
        .BYTE $0A,$0B,$0B,$0C,$0D,$0E,$0E,$0F
        .BYTE $10,$11,$12,$13,$15,$16,$17,$19
        .BYTE $1A,$1C,$1D,$1F,$21,$23,$25,$27
        .BYTE $2A,$2C,$2F,$32,$35,$38,$3B,$3F
fA911   .BYTE $30,$70,$B4,$FB,$47,$98,$ED,$47
        .BYTE $A7,$0C,$77,$E9,$61,$E1,$68,$F7
        .BYTE $8F,$30,$DA,$8F,$4E,$18,$EF,$D2
        .BYTE $C3,$C3,$D1,$E7,$1F,$60,$B5,$1E
        .BYTE $9C,$31,$DF,$A5,$87,$86,$A2,$DF
        .BYTE $3E,$C1,$6B,$3C,$39,$63,$BE,$4B
aA941   .BYTE $00,$00,$00
;-------------------------------
; sA944
;-------------------------------
sA944   
        LDX aA941
        LDA fA8E1,X
        STA $D401    ;Voice 1: Frequency Control - High-Byte
        LDA fA911,X
        STA $D400    ;Voice 1: Frequency Control - Low-Byte
        LDA aA40D
        AND #$07
        TAY 
        LDA fA9B9,Y
        CLC 
        ADC aA941
        TAX 
        LDA fA911,X
        STA $D407    ;Voice 2: Frequency Control - Low-Byte
        LDA fA8E1,X
        STA $D408    ;Voice 2: Frequency Control - High-Byte
        LDA aA40D
        CMP #$05
        BNE bA97D
        LDA fA911,X
        CLC 
        ADC #$03
        STA $D407    ;Voice 2: Frequency Control - Low-Byte
aA97E   =*+$01
bA97D   LDA aA40E
        AND #$03
        TAY 
        LDA fA9C1,Y
        CLC 
        ADC aA941
        TAX 
        LDA fA911,X
        STA $D40E    ;Voice 3: Frequency Control - Low-Byte
        LDA fA8E1,X
        STA $D40F    ;Voice 3: Frequency Control - High-Byte
        RTS 

;-------------------------------
; sA998
;-------------------------------
sA998   
        INC aA941
        LDA aA941
        CMP #$18
        BEQ bA9A3
bA9A2   RTS 

bA9A3   LDA #$00
        STA aA941
        RTS 

;-------------------------------
; sA9A9
;-------------------------------
sA9A9   
        DEC aA941
        LDA aA941
        CMP #$FF
        BNE bA9A2
        LDA #$17
        STA aA941
        RTS 

fA9B9   .BYTE $03,$04,$0F,$10,$18,$00,$03,$04
fA9C1   .BYTE $07,$08,$13,$14,$A2,$28
bA9C7   LDA fA9D7,X
        AND #$3F
        STA SCREEN_RAM + $031F,X
        LDA #$01
        STA $DB1F,X
        DEX 
        BNE bA9C7
fA9D7   RTS 

        .TEXT "  F1: START   F7: SKILL   SKILL LEVEL 0 "
;-------------------------------
; sAA00
;-------------------------------
sAA00   
        BNE bAA03
        RTS 

bAA03   LDA currentPressedKey
        CMP #$04 ; F1
        BNE bAA2B
        LDX #$28
        LDA #$01
bAA0D   STA $DB1F,X
        DEX 
        BNE bAA0D
        LDA #$00
        STA aA76C
        LDA #$01
        STA aA7C8
        STA aA7C9
        LDX #$08
        LDA #$30
bAA24   STA SCREEN_RAM + $03DD,X
        DEX 
        BNE bAA24
bAA2A   RTS 

bAA2B   CMP #$03
        BNE bAA4C
        LDA aAA65
        BNE bAA2A
        INC aA7C7
        LDA aA7C7
        STA aAA65
        CMP #$08
        BNE bAA46
        LDA #$01
        STA aA7C7
bAA46   JSR sA7CA
        JMP sA838

bAA4C   CMP #$40
        BEQ bAA51
        RTS 

bAA51   LDA #$00
        STA aAA65
        LDY aA40F
        LDA fA487,Y
        LDX #$28
bAA5E   STA $DB1F,X
        DEX 
        BNE bAA5E
        RTS 

aAA65   .BYTE $00
aAA66   .BYTE $00
fAA67   .BYTE $00,$B1,$00,$B2,$00,$B3,$00,$B4
fAA6F   .BYTE $00,$00,$28,$28,$01,$01,$29,$29
;-------------------------------
; sAA77
;-------------------------------
sAA77   
        LDA fAA67,Y
        BNE bAA7D
        RTS 

bAA7D   LDA fAA6F,Y
        TAX 
        LDA fAA67,Y
        STA SCREEN_RAM + $0383,X
        LDA #$02
        STA $DB83,X
        RTS 

;-------------------------------
; sAA8D
;-------------------------------
sAA8D   
        LDA a4CE8
        BEQ bAA98
        LDX #$F8
        TXS 
        JMP jBA02

bAA98   LDA currentPressedKey
        CMP #$40
        BNE bAA9F
        RTS 

bAA9F   LDA #$00
        STA $D404    ;Voice 1: Control Register
        STA $D40B    ;Voice 2: Control Register
        STA $D412    ;Voice 3: Control Register
        LDA #$0F
        STA selectedSubGame
        JMP s413B

        .BYTE $12    ;JAM 
        BEQ bAAB7
        RTS 

        .BYTE $03
bAAB7   LDA #$03
        STA a12C6
        INC a12D8
        LDA a12D8
        AND #$0F
        STA a12D8
        RTS 

        .BYTE $00,$00,$01,$01
        BRK #$FF
        LDY #$00
        LDX #$0F
        LDA f0B52,Y
        PHA 
bAAD6   LDA f0B53,Y
        STA f0B52,Y
        STA f0B52,X
        DEX 
        INY 
        CPY #$08
        BNE bAAD6
        PLA 
        STA a0B59
        STA a0B5A
        STA a1071
        INC a1332
        LDA a1332
        AND #$0F
        TAX 
        LDA #$02
        STA f0B62,X
        DEX 
        TXA 
        AND #$4C
        .BYTE $04,$AB ;NOP $AB
aAB03   .BYTE $00
        JSR sB9E9
        LDA $D011    ;VIC Control Register 1
        ORA #$0B
        AND #$7B
        STA $D011    ;VIC Control Register 1
        JSR sB6CA
        LDA aAB03
        BNE bAB23
        LDA #$FF
        JSR sBBA5
        LDA #$00
        STA aBBA4
bAB23   SEI 
        JSR sAEFF
        JSR sAB3F
        JSR sAB61
        JSR sB5B0
        CLI 
        LDA #$01
        STA aAB03
jAB36   JSR sB954
        JSR sBB99
        JMP jAB36

;-------------------------------
; sAB3F
;-------------------------------
sAB3F   
        LDX #$00
        LDA $D01E    ;Sprite to Sprite Collision Detect
bAB44   LDA #$20
        STA SCREEN_RAM + $0000,X
        STA SCREEN_RAM + $0100,X
        STA SCREEN_RAM + $01D0,X
        DEX 
        BNE bAB44
        LDA #$00
        STA $D015    ;Sprite display Enable
        STA a40D7
        STA a4142
        JSR s6004
        RTS 

;-------------------------------
; sAB61
;-------------------------------
sAB61   
        LDX #$00
bAB63   LDA fAB7B,X
        STA f4122,X
        LDA fAB7E,X
        STA f410A,X
        LDA fAB80,X
        STA f4116,X
        INX 
        CPX #$02
        BNE bAB63
        RTS 

fAB7B   .BYTE $E0,$FF,$FF
fAB7E   .BYTE $82,$82
fAB80   .BYTE $AB,$AB
        JSR sABBA
        JSR s412C
        JSR stroboscopeOnOff
        JSR $FF9F ;$FF9F - scan keyboard                    
        JSR s4129
        JSR sAC1B
        JSR sADEA
        JSR sB0B1
        JSR sB118
        JSR sB348
        LDA $D01E    ;Sprite to Sprite Collision Detect
        STA aB347
        JSR sB49D
        JSR s4129
        JSR s4135
        JSR sB6FB
        JMP j4132

aABB5   .BYTE $60
aABB6   .BYTE $80
aABB7   .BYTE $B7
aABB8   .BYTE $00
aABB9   .BYTE $05
;-------------------------------
; sABBA
;-------------------------------
sABBA   
        LDA aABB5
        STA a403E
        LDA aABB6
        STA a403F
        LDA aABB7
        STA a4041
        LDA #$01
        STA a4043
        DEC aABB9
        BEQ bABD7
bABD6   RTS 

bABD7   INC aABB8
        LDA #$04
        STA aABB9
        LDA aABB8
        AND #$1F
        STA aABB8
        AND #$0F
        TAY 
        LDA f40FA,Y
        STA a4040
        LDA aABB8
        AND #$0F
        ROR 
        AND #$07
        TAY 
        LDA f40EA,Y
        STA $D025    ;Sprite Multi-Color Register 0
        LDA f40DA,Y
        STA $D026    ;Sprite Multi-Color Register 1
        INC aABB7
        LDA aABB7
        CMP #$C0
        BNE bABD6
        LDA #$B7
        STA aABB7
        RTS 

aAC15   .BYTE $00
aAC16   .BYTE $00
aAC17   .BYTE $10
aAC18   .BYTE $10
aAC19   .BYTE $06
aAC1A   .BYTE $03
;-------------------------------
; sAC1B
;-------------------------------
sAC1B   
        LDA aABB5
        CLC 
        ADC aAC15
        STA aABB5
        LDA aABB6
        CLC 
        ADC aAC16
        STA aABB6
        AND #$F0
        CMP #$20
        BEQ bAC3C
        CMP #$C0
        BEQ bAC43
        JMP jAC48

bAC3C   LDA #$BF
        STA aABB6
        BNE jAC48
bAC43   LDA #$30
        STA aABB6
jAC48   LDA aABB5
        AND #$F0
        CMP #$00
        BEQ bAC57
        CMP #$A0
        BEQ bAC5E
        BNE bAC63
bAC57   LDA #$9F
        STA aABB5
        BNE bAC63
bAC5E   LDA #$10
        STA aABB5
bAC63   DEC aAC19
        BNE bAC80
        LDA aAC17
        STA aAC19
        LDA aAC15
        BEQ bAC80
        AND #$80
        BNE bAC7D
        DEC aAC15
        DEC aAC15
bAC7D   INC aAC15
bAC80   DEC aAC1A
        BNE bAC9D
        LDA aAC18
        STA aAC1A
        LDA aAC16
        BEQ bAC9D
        AND #$80
        BNE bAC9A
        DEC aAC16
        DEC aAC16
bAC9A   INC aAC16
bAC9D   RTS 

fAC9E   .BYTE $00,$00,$00
fACA1   .BYTE $00,$00,$00
fACA4   .BYTE $00,$00,$00
fACA7   .BYTE $00,$00,$00
fACAA   .BYTE $C8,$CB,$CD
fACAD   .BYTE $00,$00,$00
fACB0   .BYTE $01,$02,$03
fACB3   .BYTE $01,$02,$03
;-------------------------------
; sACB6
;-------------------------------
sACB6   
        LDA $DC00    ;CIA1: Data Port Register A
        STA aADE8
        AND #$0F
        CMP #$0F
        BNE bAD01
        LDA #$00
        STA aACC8
        RTS 

aACC8   .BYTE $00
fACC9   .BYTE $0E,$06,$07,$05,$0D,$09,$0B,$0A
fACD1   .BYTE $FF,$FF,$00,$00,$00,$00,$00,$FF
fACD9   .BYTE $01,$01,$00,$00,$00,$00,$00,$01
fACE1   .BYTE $FF,$FF,$00,$FF,$FF,$FF,$00,$FF
fACE9   .BYTE $00,$00,$00,$00,$00,$FF,$FF,$FF
fACF1   .BYTE $00,$00,$00,$00,$00,$01,$01,$01
fACF9   .BYTE $00,$FF,$FF,$FF,$00,$FF,$FF,$FF
bAD01   LDA aACC8
        BEQ bAD0C
        DEC aACC8
        BEQ bAD0C
        RTS 

bAD0C   LDA #$07
        STA aACC8
        LDA aADE8
        AND #$0F
        LDX #$00
bAD18   CMP fACC9,X
        BEQ bAD23
        INX 
        CPX #$08
        BNE bAD18
        RTS 

bAD23   STX aADE9
        LDX #$00
bAD28   LDA fAC9E,X
        BEQ bAD33
        INX 
        CPX #$03
        BNE bAD28
        RTS 

bAD33   LDY #$12
bAD35   LDA fB6A0,Y
        STA f4019,Y
        DEY 
        BNE bAD35
        LDY aADE9
        LDA aABB5
        STA fAC9E,X
        LDA aABB6
        STA fACA1,X
        LDA #$04
        EOR fACE9,Y
        CLC 
        ADC fACF1,Y
        AND fACF9,Y
        STA fACA4,X
        LDA #$04
        EOR fACD1,Y
        CLC 
        ADC fACD9,Y
        AND fACE1,Y
        STA fACA7,X
        JSR sADF5
        LDY aADE7
        LDA fACAA,Y
        STA fACAD,X
        RTS 

;-------------------------------
; sAD78
;-------------------------------
sAD78   
        LDX #$00
bAD7A   LDA fAC9E,X
        BEQ bAD8B
        JSR sAD96
jAD82   INX 
        CPX #$03
        BNE bAD7A
        RTS 

fAD88   .BYTE $10,$20,$30
bAD8B   LDY fAD88,X
        LDA #$00
        STA a403E,Y
        JMP jAD82

;-------------------------------
; sAD96
;-------------------------------
sAD96   
        LDY fAD88,X
        LDA fAC9E,X
        STA a403E,Y
        LDA fACA1,X
        STA a403F,Y
        LDA fACAD,X
        STA a4041,Y
        LDA #$70
        STA a4043,Y
        LDA #$01
        STA a4040,Y
        LDA fAC9E,X
        CLC 
        ADC fACA4,X
        STA fAC9E,X
        LDA fACA1,X
        CLC 
        ADC fACA7,X
        STA fACA1,X
        AND #$F0
        CMP #$20
        BEQ bADE1
        CMP #$C0
        BEQ bADE1
        LDA fAC9E,X
        AND #$F0
        CMP #$00
        BEQ bADE1
        CMP #$A0
        BEQ bADE1
        RTS 

bADE1   LDA #$00
        STA fAC9E,X
        RTS 

aADE7   .BYTE $00
aADE8   .BYTE $00
aADE9   .BYTE $00
;-------------------------------
; sADEA
;-------------------------------
sADEA   
        JSR sACB6
        JSR sAD78
        RTS 

aADF1   .BYTE $00
aADF2   .BYTE $00
aADF3   .BYTE $00
aADF4   .BYTE $00
;-------------------------------
; sADF5
;-------------------------------
sADF5   
        LDA aAC16
        PHA 
        LDA aAC15
        PHA 
        LDA fACD1,Y
        EOR #$FF
        STA aADF4
        LDA fACE9,Y
        EOR #$FF
        STA aADF3
        LDA fACD9,Y
        EOR #$01
        STA aADF2
        LDA fACF1,Y
        EOR #$01
        STA aADF1
        TYA 
        PHA 
        LDY aADE7
        LDA fACB0,Y
        STA aAE79
        LDA fACB3,Y
        STA aAE7A
        PLA 
        TAY 
        LDA aAE79
        EOR aADF3
        CLC 
        ADC aADF1
        AND fACF9,Y
        ADC aAC15
        STA aAC15
        AND #$F8
        CMP #$08
        BEQ bAE4D
        CMP #$F0
        BNE bAE54
bAE4D   PLA 
        STA aAC15
        JMP jAE55

bAE54   PLA 
jAE55   LDA aAE7A
        EOR aADF4
        CLC 
        ADC aADF2
        AND fACE1,Y
        ADC aAC16
        STA aAC16
        AND #$F8
        CMP #$08
        BEQ bAE74
        CMP #$F0
        BEQ bAE74
        PLA 
        RTS 

bAE74   PLA 
        STA aAC16
        RTS 

aAE79   PHA 
aAE7A   CLC 
aAE7B   BRK #$AD
        INX 
        LDA a1029
        BEQ bAE89
        LDA #$00
        STA aAE7B
bAE88   RTS 

bAE89   LDA aAE7B
        BNE bAE88
        LDA #$01
        STA aAE7B
        INC aADE7
        LDA aADE7
        CMP #$03
        BNE bAE88
        LDA #$00
        STA aADE7
fAEA2   RTS 

fAEA3   .BYTE $D0
fAEA4   .BYTE $E8
fAEA5   .BYTE $60
fAEA6   .BYTE $20
fAEA7   .BYTE $41
fAEA8   .BYTE $C3
fAEA9   .BYTE $B9
fAEAA   .BYTE $B7
fAEAB   .BYTE $07
fAEAC   .BYTE $D1
fAEAD   .BYTE $FB
fAEAE   .BYTE $30
fAEAF   .BYTE $09,$F0,$02
fAEB2   .BYTE $10
fAEB3   .BYTE $06
fAEB4   .BYTE $C8
fAEB5   .BYTE $C0
fAEB6   .BYTE $08,$D0
fAEB8   .BYTE $F0
fAEB9   .BYTE $60,$A0,$00
bAEBC   LDA SCREEN_RAM + $03B7,Y
        STA (pFB),Y
        INY 
        CPY #$08
        BNE bAEBC
        LDX #$00
bAEC8   LDA SCREEN_RAM + $037D,X
        STA (pFB),Y
        INY 
        INX 
        CPX #$0A
        BNE bAEC8
        LDX #$00
bAED5   LDA SCREEN_RAM + $03A5,X
        STA (pFB),Y
        INX 
        INY 
        CPX #$0A
        BNE bAED5
        LDX #$00
bAEE2   LDA $DB7D,X
        STA (pFB),Y
        INX 
        INY 
        CPX #$0A
        BNE bAEE2
        LDX #$00
bAEEF   LDA $DBA5,X
        STA (pFB),Y
        INX 
        INY 
        CPX #$0A
        BNE bAEEF
        RTS 

        .BYTE $C0,$C0,$20,$2A
;-------------------------------
; sAEFF
;-------------------------------
sAEFF   
        LDX #$5C
        LDA aAB03
        BNE bAF0E
bAF06   LDA #$00
        STA fAEA2,X
        DEX 
        BNE bAF06
bAF0E   RTS 

fAF0F   .BYTE $00,$17,$2E,$45
pAF13   .BYTE $40
        .BYTE $40,$A0,$A3,$01,$03,$03,$10,$00
        .BYTE $00,$8F,$00,$00,$00,$00,$01,$00
        .BYTE $01,$00,$16,$00,$03,$03,$FF,$FF
        .BYTE $F7,$FB,$01,$00,$00,$08,$30,$00
        .BYTE $83,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$04,$04,$40,$40,$C0
        .BYTE $C2,$01,$03,$03,$00,$03,$00,$8F
        .BYTE $00,$00,$00,$00,$02,$01,$01,$01
        .BYTE $16,$00,$03,$03,$10,$10,$C2,$C4
        .BYTE $08,$00,$04,$20,$01,$00,$87,$00
        .BYTE $00,$00,$00,$03,$00,$02,$01,$26
        .BYTE $00,$04,$04,$10,$10,$C4,$C6,$07
        .BYTE $00,$FF,$00,$00,$01,$83,$00,$01
        .BYTE $00,$00,$00,$01,$01,$01,$36,$00
        .BYTE $06,$06,$10,$10,$C6,$C8,$0C,$00
        .BYTE $00,$08,$03,$00,$8F,$00,$00,$00
        .BYTE $00,$05,$00,$01,$01,$56,$00,$04
        .BYTE $04,$10,$10,$C9,$CA,$02,$00,$00
        .BYTE $00,$00,$01,$83,$09,$01,$00,$00
        .BYTE $00,$01,$01,$01,$56,$00,$00,$00
        .BYTE $10,$10,$CA,$CC,$07,$01,$00,$00
        .BYTE $00,$00,$83,$01,$02,$00,$00,$00
        .BYTE $02,$01,$01,$56,$00,$03,$03,$10
        .BYTE $10,$CC,$CD,$09,$03,$03,$00,$00
        .BYTE $00,$83,$00,$00,$00,$00,$00,$00
        .BYTE $05,$01,$15,$00,$00,$00,$10,$10
        .BYTE $CD,$CF,$01,$00,$03,$10,$01,$01
        .BYTE $83,$00,$02,$00,$00,$09,$02,$01
        .BYTE $01,$15,$00,$04,$04,$10,$10,$CF
        .BYTE $D1,$0E,$01,$01,$03,$03,$00,$83
        .BYTE $00,$00,$00,$00,$0A,$00,$01,$01
        .BYTE $25,$00,$04,$04,$10,$10,$D1,$D3
        .BYTE $06,$01,$01,$00,$00,$10,$83,$10
        .BYTE $01,$00,$00,$0B,$01,$01,$01,$15
        .BYTE $00,$02,$02,$10,$10,$D3,$D4,$0B
        .BYTE $00,$05,$00,$00,$00,$83,$00,$00
        .BYTE $00,$00,$00,$00,$01,$01,$55,$00
        .BYTE $00,$00,$10,$10,$D4,$D7,$09,$00
        .BYTE $00,$20,$03,$10,$83,$00,$01,$00
        .BYTE $00,$0D,$01,$01,$01,$45,$00,$03
        .BYTE $03,$10,$10,$A0,$A4,$01,$FD,$00
        .BYTE $00,$00,$00,$83,$00,$00,$00,$00
        .BYTE $00,$00,$01,$01,$45,$00,$02,$02
        .BYTE $10,$10,$A4,$A7,$01,$03,$00,$00
        .BYTE $00,$00,$83,$00,$00,$00,$00,$00
        .BYTE $00,$01,$01,$45,$00,$02,$02,$10
        .BYTE $10,$B0,$B1,$0A,$00,$00,$00,$00
        .BYTE $00,$8F,$00,$00,$00,$00,$00,$00
        .BYTE $01,$01,$15,$00,$00,$00,$10,$10
        .BYTE $B4,$B5,$08,$04,$01,$00,$00,$01
        .BYTE $83,$00,$01,$00,$00,$00,$01,$01
        .BYTE $01,$35,$00,$00,$00
;-------------------------------
; sB0B1
;-------------------------------
sB0B1   
        DEC aB0B7
        BEQ bB0BA
        RTS 

aB0B7   .BYTE $49
aB0B8   .BYTE $00,$02
bB0BA   LDA #$40
        STA aB0B7
        INC aB0B8
        LDA aB0B8
        AND #$03
        STA aB0B8
        TAX 
        LDA #<pAF13
        STA aB10C
        LDA #>pAF13
        STA aB10D
        LDA a41AF
        AND #$0F
        STA aB6F9
        LDA #$0F
        SEC 
        SBC aB6F9
        STA aB6F9
        CLC 
        ADC #$02
        TAY 
        BEQ bB100
bB0EC   LDA aB10C
        CLC 
        ADC #$17
        STA aB10C
        LDA aB10D
        ADC #$00
        STA aB10D
        DEY 
        BNE bB0EC
bB100   LDY fAF0F,X
        LDA fAEA3,Y
        BEQ bB109
        RTS 

bB109   LDX #$00
aB10C   =*+$01
aB10D   =*+$02
bB10B   LDA pAF13,X
        STA fAEA3,Y
        INY 
        INX 
        CPX #$17
        BNE bB10B
        RTS 

;-------------------------------
; sB118
;-------------------------------
sB118   
        LDA #$00
        STA aB137
bB11D   LDY aB137
        LDA fAF0F,Y
        TAY 
        LDA fAEA3,Y
        BEQ bB138
        JSR sB14B
jB12C   INC aB137
        LDA aB137
        CMP #$04
        BNE bB11D
        RTS 

aB137   .BYTE $00
bB138   LDX aB137
        LDA fB147,X
        TAX 
        LDA #$00
        STA a403E,X
        JMP jB12C

fB147   .BYTE $40,$50,$60,$70
;-------------------------------
; sB14B
;-------------------------------
sB14B   
        LDX aB137
        LDA fB147,X
        TAX 
        LDA fAEAD,Y
        AND #$80
        BEQ bB15C
        JSR sB192
bB15C   LDA fAEA3,Y
        STA a403E,X
        LDA fAEA4,Y
        STA a403F,X
        LDA fAEAD,Y
        AND #$40
        BEQ bB18F
        INC a4040,X
        LDA fAEA5,Y
        STA a4041,X
        LDA fAEAD,Y
        AND #$3F
        SEC 
        SBC #$01
        BEQ bB188
        ORA #$40
        STA fAEAD,Y
        RTS 

bB188   LDA fAEAC,Y
        STA fAEAD,Y
        RTS 

bB18F   JMP jB1E3

;-------------------------------
; sB192
;-------------------------------
sB192   
        LDA fAEAD,Y
        AND #$01
        BEQ bB1A3
        JSR sB1DC
        AND #$7F
        ADC #$40
        STA fAEA4,Y
bB1A3   LDA fAEAD,Y
        AND #$02
        BEQ bB1B4
        JSR sB1DC
        AND #$3F
aB1B0   =*+$01
        ADC #$30
        STA fAEA3,Y
bB1B4   LDA fAEAD,Y
        AND #$04
        BEQ bB1C5
        JSR sB1DC
        AND #$03
        SBC #$01
        STA fAEA9,Y
bB1C5   LDA fAEAD,Y
        AND #$08
        BEQ bB1D6
        JSR sB1DC
        AND #$03
        SBC #$01
        STA fAEA8,Y
bB1D6   LDA #$6F
        STA fAEAD,Y
        RTS 

aB1DD   =*+$01
;-------------------------------
; sB1DC
;-------------------------------
sB1DC   
        LDA $E000
        INC aB1DD
        RTS 

jB1E3   LDA fAEA7,Y
        STA a4040,X
        TYA 
        PHA 
        TXA 
        TAY 
        PLA 
        TAX 
        DEC fAEB9,X
        BNE bB20E
        LDA fAEB8,X
        STA fAEB9,X
        JSR sB2C9
        LDA a4041,Y
        CLC 
        ADC #$01
        CMP fAEA6,X
        BNE bB20B
        LDA fAEA5,X
bB20B   STA a4041,Y
bB20E   JSR sB414
        LDA fAEA3,X
        BEQ bB256
        CLC 
        ADC fAEA8,X
        STA fAEA3,X
        AND #$F0
        BEQ bB227
        CMP #$A0
        BEQ bB22E
        BNE bB233
bB227   LDA #$9F
        STA fAEA3,X
        BNE bB233
bB22E   LDA #$10
        STA fAEA3,X
bB233   LDA fAEA4,X
        CLC 
        ADC fAEA9,X
        STA fAEA4,X
        AND #$F0
        BEQ bB247
        CMP #$C0
        BEQ bB24E
        BNE bB253
bB247   LDA #$BF
        STA fAEA4,X
        BNE bB253
bB24E   LDA #$10
        STA fAEA4,X
bB253   JSR sB44B
bB256   RTS 

jB257   LDA fAEA3,X
        PHA 
        LDA fAEA4,X
        PHA 
        LDA fAEA8,X
        PHA 
        LDA fAEA9,X
        PHA 
        LDA #<pAF13
        STA aB291
        LDA #>pAF13
        STA aB292
        LDA aB2DF
        BEQ bB28C
bB276   LDA aB291
        CLC 
        ADC #$17
        STA aB291
        LDA aB292
        ADC #$00
        STA aB292
        DEC aB2DF
        BNE bB276
bB28C   TYA 
        PHA 
        LDY #$00
aB291   =*+$01
aB292   =*+$02
bB290   LDA p00,Y
        STA fAEA3,X
        INX 
        INY 
        CPY #$17
        BNE bB290
        TXA 
        SEC 
        SBC #$17
        TAX 
        PLA 
        TAY 
        PLA 
        STA fAEA9,X
        PLA 
        STA fAEA8,X
        PLA 
        STA fAEA4,X
        PLA 
        STA fAEA3,X
        LDA fAEAC,X
        STA fAEAD,X
        LDA fAEA5,X
        STA a4041,Y
        LDA fAEAB,X
        STA aB346
        JSR sB2E9
        RTS 

;-------------------------------
; sB2C9
;-------------------------------
sB2C9   
        LDA fAEAA,X
        BNE bB2CF
bB2CE   RTS 

bB2CF   DEC fAEAA,X
        BNE bB2CE
;-------------------------------
; sB2D4
;-------------------------------
sB2D4   
        LDA fAEB2,X
        STA aB2DF
        BEQ bB2E0
        JMP jB257

aB2DF   .BYTE $00
bB2E0   LDA #$00
        STA fAEA3,X
        STA a403E,Y
        RTS 

;-------------------------------
; sB2E9
;-------------------------------
sB2E9   
        LDA aB346
        AND #$01
        BEQ bB2FA
        JSR sB1DC
        AND #$03
        SBC #$01
        STA fAEA8,X
bB2FA   LDA aB346
        AND #$02
        BEQ bB30B
        JSR sB1DC
        AND #$03
        SBC #$01
        STA fAEA9,X
bB30B   LDA aB346
        AND #$04
        BEQ bB31C
        JSR sB1DC
        AND #$3F
        ADC #$20
        STA fAEB2,X
bB31C   LDA aB346
        AND #$08
        BEQ bB32D
        JSR sB1DC
        AND #$7F
        ADC #$20
        STA fAEB3,X
bB32D   LDA aB346
        AND #$10
        BEQ bB339
        LDA #$00
        STA fAEA8,X
bB339   LDA aB346
        AND #$20
        BEQ bB345
        LDA #$00
        STA fAEA9,X
bB345   RTS 

aB346   .BYTE $00
aB347   .BYTE $00
;-------------------------------
; sB348
;-------------------------------
sB348   
        LDA aB347
        AND #$F0
        BNE bB350
        RTS 

bB350   LDA aB347
        AND #$01
        BEQ bB35A
        JSR sB5CC
bB35A   LDX #$00
bB35C   LDA fB370,X
        AND aB347
        BEQ bB36A
        STX aB413
        JSR sB373
bB36A   INX 
        CPX #$03
        BNE bB35C
        RTS 

fB370   .BYTE $02,$04,$08
;-------------------------------
; sB373
;-------------------------------
sB373   
        TXA 
        PHA 
        LDA fAD88,X
        TAY 
        LDX #$00
bB37B   TXA 
        PHA 
        LDA fB147,X
        TAX 
        LDA a403E,X
        SEC 
        SBC a403E,Y
        AND #$F0
        BEQ bB39D
        CMP #$F0
        BEQ bB39D
jB390   PLA 
        TAX 
        INX 
        CPX #$04
        BNE bB37B
        LDY aB3B0
        PLA 
        TAX 
        RTS 

bB39D   LDA a403F,X
        SEC 
        SBC a403F,Y
        AND #$F0
        BEQ bB3B1
        CMP #$F0
        BEQ bB3B1
        JMP jB390

aB3AF   .BYTE $00
aB3B0   .BYTE $00
bB3B1   PLA 
        PHA 
        TAX 
        LDY fAF0F,X
        LDA a40D8
        BNE bB3C2
        LDA fAEB6,Y
        STA a40D8
bB3C2   LDA fAEB4,Y
        BNE bB3CD
        LDY fB147,X
        JMP jB3F4

bB3CD   LDA fB499,X
        BNE bB3DD
        LDA #$10
        STA fB499,X
        LDY fB147,X
        JSR sB551
bB3DD   LDY fB147,X
        JSR sB56E
        STX aB3AF
        LDX #$12
bB3E8   LDA fB68E,X
        STA f4007,X
        DEX 
        BNE bB3E8
        LDX aB3AF
jB3F4   LDA fAF0F,X
        TAX 
        LDA fAEB4,X
        STA fAEB2,X
        BEQ bB403
        JSR sB2D4
bB403   LDX aB413
        CPX #$04
        BEQ bB40F
        LDA #$00
        STA fAC9E,X
bB40F   PLA 
        PLA 
        TAX 
        RTS 

aB413   .BYTE $00
;-------------------------------
; sB414
;-------------------------------
sB414   
        DEC fAEAF,X
        BEQ bB41C
        JMP jB44A

bB41C   LDA fAEB3,X
        STA fAEAF,X
        LDA fAEAE,X
        BEQ bB436
        INC fAEAE,X
        LDA fAEAE,X
        CMP #$21
        BNE bB436
        LDA #$01
        STA fAEAE,X
bB436   LDA fAEAC,X
        BEQ jB44A
        INC fAEAC,X
        LDA fAEAC,X
        CMP #$21
        BNE jB44A
        LDA #$01
        STA fAEAC,X
jB44A   RTS 

;-------------------------------
; sB44B
;-------------------------------
sB44B   
        TYA 
        PHA 
        LDY fAEAC,X
        LDA fB476,Y
        CLC 
        ADC fAEA3,X
        STA aB497
        LDY fAEAE,X
        LDA fB476,Y
        CLC 
        ADC fAEA4,X
        STA aB498
        PLA 
        TAY 
        LDA aB497
        STA a403E,Y
        LDA aB498
        STA a403F,Y
        RTS 

fB476   .BYTE $00,$01,$04,$06,$07,$07,$08,$08
        .BYTE $08,$08,$08,$08,$07,$07,$06,$04
        .BYTE $01,$FF,$FC,$FA,$F9,$F9,$F8,$F8
        .BYTE $F8,$F8,$F8,$F8,$F9,$F9,$FA,$FC
        .BYTE $FF
aB497   .BYTE $00
aB498   .BYTE $00
fB499   .BYTE $00,$00,$00,$00
;-------------------------------
; sB49D
;-------------------------------
sB49D   
        LDX #$00
bB49F   LDA fB499,X
        BEQ bB4A7
        JSR sB4B6
bB4A7   INX 
        CPX #$04
        BNE bB49F
        RTS 

fB4AD   .BYTE $00,$00,$00,$00
fB4B1   .BYTE $00,$00,$00,$00
aB4B5   .BYTE $00
;-------------------------------
; sB4B6
;-------------------------------
sB4B6   
        LDA #$10
        SEC 
        SBC fB499,X
        STA aB4B5
        JSR sB4CE
        INC aB4B5
        DEC fB499,X
        BNE bB4CB
        RTS 

bB4CB   JMP jB546

;-------------------------------
; sB4CE
;-------------------------------
sB4CE   
        LDA #$20
        STA a07
jB4D2   LDA fB4AD,X
        STA a04
        LDA fB4B1,X
        SEC 
        SBC aB4B5
        STA a05
        JSR sB52D
        LDA a04
        CLC 
        ADC aB4B5
        STA a04
        JSR sB52D
        LDA a05
        CLC 
        ADC aB4B5
        STA a05
        JSR sB52D
        LDA a05
        CLC 
        ADC aB4B5
        STA a05
        JSR sB52D
        LDA a04
        SEC 
        SBC aB4B5
        STA a04
        JSR sB52D
        LDA a04
        SEC 
        SBC aB4B5
        STA a04
        JSR sB52D
        LDA a05
        SEC 
        SBC aB4B5
        STA a05
        JSR sB52D
        LDA a05
        SEC 
        SBC aB4B5
        STA a05
;-------------------------------
; sB52D
;-------------------------------
sB52D   
        LDA a04
        BMI bB53D
        CMP #$28
        BPL bB53D
        LDA a05
        BMI bB53D
        CMP #$14
        BMI bB53E
bB53D   RTS 

bB53E   TXA 
        PHA 
        JSR s4198
        PLA 
        TAX 
        RTS 

jB546   LDA #<p2A01
        STA a06
        LDA #>p2A01
        STA a07
        JMP jB4D2

;-------------------------------
; sB551
;-------------------------------
sB551   
        LDA a403E,Y
        SEC 
        SBC #$08
        ROR 
        ROR 
        AND #$3F
        STA fB4AD,X
        LDA a403F,Y
        SEC 
        SBC #$2C
        ROR 
        ROR 
        ROR 
        AND #$1F
        STA fB4B1,X
        RTS 

aB56D   .BYTE $FF
;-------------------------------
; sB56E
;-------------------------------
sB56E   
        INC aB56D
        TXA 
        PHA 
        LDX aB56D
        LDA #$3D
        STA SCREEN_RAM + $0321,X
        LDA #$04
        STA $DB21,X
        CPX #$26
        BEQ bB587
        PLA 
        TAX 
        RTS 

bB587   LDA #$20
        STA SCREEN_RAM + $0321,X
        DEC aB56D
        DEX 
        CPX #$FF
        BNE bB587
        TYA 
        PHA 
        JSR sB9AF
        LDA #<pB9CB
        STA a1B
        LDA #>pB9CB
        STA a1C
        LDA #$01
        STA a4141
        LDA #$53
        STA a40D8
        PLA 
        TAY 
        PLA 
        TAX 
        RTS 

;-------------------------------
; sB5B0
;-------------------------------
sB5B0   
        LDX #$00
        LDA aB56D
        CMP #$FF
        BEQ bB5CB
bB5B9   LDA #$3D
        STA SCREEN_RAM + $0321,X
        LDA #$04
        STA $DB21,X
        CPX aB56D
        BEQ bB5CB
        INX 
        BNE bB5B9
bB5CB   RTS 

;-------------------------------
; sB5CC
;-------------------------------
sB5CC   
        LDX #$00
bB5CE   LDY fB147,X
        LDA a403E,Y
        SEC 
        SBC a403E
        AND #$F0
        BEQ bB5E6
        CMP #$F0
        BEQ bB5E6
bB5E0   INX 
        CPX #$04
        BNE bB5CE
        RTS 

bB5E6   LDA a403F,Y
        SEC 
        SBC a403F
        AND #$F0
        BEQ bB5F5
        CMP #$F0
        BNE bB5E0
bB5F5   LDY fAF0F,X
        LDA fAEAD,Y
        AND #$C0
        BNE bB5E0
        LDA fAEB5,Y
        CMP #$01
        BNE bB616
        LDA #$04
        STA aB413
        LDA #$01
        STA fAEB4,Y
        JSR sB623
        JMP bB3CD

bB616   CMP #$00
        BEQ bB5E0
        STA fAEB2,Y
        JSR sB2D4
        PLA 
        PLA 
        RTS 

;-------------------------------
; sB623
;-------------------------------
sB623   
        TXA 
        PHA 
        TYA 
        PHA 
        LDA a41AF
        ROR 
        ROR 
        AND #$0F
        TAY 
        LDA fB67F,Y
        TAY 
        LDX aB56D
bB636   CPX #$FF
        BEQ bB646
        LDA #$20
        STA SCREEN_RAM + $0321,X
        DEX 
        DEC aB56D
        DEY 
        BNE bB636
bB646   LDA aAC15
        EOR #$FF
        CLC 
        ADC #$01
        STA aAC15
        LDA aAC16
        CLC 
        EOR #$FF
        CLC 
        ADC #$01
        STA aAC16
        LDY #$12
bB65F   LDA fB6B2,Y
        STA f402B,Y
        DEY 
        BNE bB65F
        LDA a4141
        BNE bB67A
        LDA #<pB6C5
        STA a1B
        LDA #>pB6C5
        STA a1C
        LDA #$01
        STA a4141
bB67A   PLA 
        TAY 
        PLA 
        TAX 
        RTS 

fB67F   .BYTE $0A,$09,$08,$07,$06,$05,$04,$03
        .BYTE $03,$02,$02,$02,$02,$02,$02
fB68E   .BYTE $01,$81,$0F,$0A,$01,$80,$81,$08
        .BYTE $06,$00,$01,$10,$10,$FF,$0C,$00
        .BYTE $0C,$00
fB6A0   .BYTE $01,$88,$0F,$07,$01,$20,$81,$55
        .BYTE $07,$00,$01,$10,$70,$05,$0C,$10
        .BYTE $05,$00
fB6B2   .BYTE $01,$8F,$0F,$0A,$01,$0E,$81,$FF
        .BYTE $0C,$00,$03,$80,$30,$41,$10,$0C
        .BYTE $0C,$00,$01
pB6C5   .BYTE $00,$01,$01,$00,$FF
;-------------------------------
; sB6CA
;-------------------------------
sB6CA   
        LDA #>p9A40
        STA aFC
        LDA #<p9A40
        STA aFB
        LDA #>p3000
        STA aFE
        LDA #<p3000
        STA aFD
        LDY #$00
bB6DC   LDA (pFB),Y
        PHA 
        LDA (pFD),Y
        STA (pFB),Y
        PLA 
        STA (pFD),Y
        INC aFB
        BNE bB6EC
        INC aFC
bB6EC   INC aFD
        BNE bB6F2
        INC aFE
bB6F2   LDA aFC
        CMP #$A0
        BNE bB6DC
        RTS 

aB6F9   .BYTE $00
aB6FA   .BYTE $00
;-------------------------------
; sB6FB
;-------------------------------
sB6FB   
        LDA #<pB753
        STA aFB
        LDA #>pB753
        STA aFC
        LDA currentPressedKey
        CMP #$40
        BEQ bB70C
        JMP jB95D

bB70C   LDY aB6F9
        BEQ bB721
bB711   LDA aFB
        CLC 
        ADC #$20
        STA aFB
        LDA aFC
        ADC #$00
        STA aFC
        DEY 
        BNE bB711
bB721   INC aB6FA
        INC aB953
        LDA aB953
        AND #$2F
        STA aB953
        LDX #$00
        LDY aB6FA
bB734   TYA 
        AND #$1F
        TAY 
        LDA (pFB),Y
        AND #$3F
        STA SCREEN_RAM + $03C0,X
        TYA 
        PHA 
        LDY aB953
        LDA f40DA,Y
        STA $DBC0,X
        PLA 
        TAY 
        INY 
        INX 
        CPX #$28
        BNE bB734
        RTS 

pB753   .TEXT " THE BONEHEADS                   THE I I"
        .TEXT "N THE PYRAMID            WHAT A LOVELY B"
        .TEXT "EASTIE           SAY HI TO THE AARDVARK!"
        .TEXT "!        DIO  D I O    D    I    O      "
        .TEXT " NEVER WITHOUT A BEARDED PACMAN  AN ELK "
        .TEXT "                         MY COMPUNET PHO"
        .TEXT "NE BILL          THE LARGE ROLL-UP      "
        .TEXT "         THOSE 3.5 INCH FLOPPY DISKS    "
        .TEXT " A HORNY BEASTIE                 PROGRAM"
        .TEXT "MERS LIVE ON BEER       EVERYBODYS FAVOU"
        .TEXT "RITE BEASTIE     CIPPY IN A HURRY IS HE "
        .TEXT "         A PASSAGE TO BANGKOK           "
        .TEXT " WE ALL LOVE COUGARS GRAPHIC    "
aB953   .TEXT $00
;-------------------------------
; sB954
;-------------------------------
sB954   
        LDA a40D8
        BNE bB95A
        RTS 

bB95A   JMP j413E

jB95D   LDX #$28
        LDA #$20
bB961   STA SCREEN_RAM + $03BF,X
        DEX 
        BNE bB961
        RTS 

fB968   .BYTE $3B,$08,$0B,$10,$13,$03
jB96E   LDA currentPressedKey
        PHA 
        CMP #$40
        BNE bB977
        PLA 
        RTS 

bB977   LDX #$00
bB979   CMP fB968,X
        BEQ bB985
        INX 
        CPX #$06
        BNE bB979
        PLA 
        RTS 

bB985   SEI 
        JSR sB6CA
        JSR jB95D
        PLA 
        JMP s413B

fB990   .BYTE $AD,$AF,$AE,$B0
fB994   .BYTE $00,$01,$28,$29
;-------------------------------
; sB998
;-------------------------------
sB998   
        LDA fB990,Y
        BNE bB99E
        RTS 

bB99E   LDA fB994,Y
        TAX 
        LDA fB990,Y
        STA SCREEN_RAM + $0385,X
        LDA #$0E
        STA $DB85,X
        RTS 

aB9AE   .BYTE $00
;-------------------------------
; sB9AF
;-------------------------------
sB9AF   
        LDA #$02
        STA aBBA4
bB9B4   LDY aB9AE
        JSR sB998
        INC aB9AE
        DEC aBBA4
        BNE bB9B4
        LDA aB9AE
        AND #$03
        STA aB9AE
        RTS 

pB9CB   .BYTE $00,$00,$02,$02,$00,$00,$08,$08
        .BYTE $00,$00,$07,$07,$00,$00,$05,$05
        .BYTE $00,$00,$0E,$0E,$00,$00,$04,$04
        .BYTE $00,$00,$06,$06,$00,$FF
;-------------------------------
; sB9E9
;-------------------------------
sB9E9   
        LDX #$00
bB9EB   LDY fB147,X
        TXA 
        PHA 
        LDA fAF0F,X
        TAX 
        LDA fAEA5,X
        STA a4041,Y
        PLA 
        TAX 
        INX 
        CPX #$04
        BNE bB9EB
        RTS 

jBA02   SEI 
        LDA #<pB9CB
        STA a1B
        LDA #>pB9CB
        STA a1C
        LDA #$01
        STA a4141
        JSR sAB3F
        LDA $D016    ;VIC Control Register 2
        AND #$E8
        STA $D016    ;VIC Control Register 2
        LDX #$00
bBA1D   LDA fBA35,X
        STA f4122,X
        LDA #$3C
        STA f410A,X
        LDA #$BA
        STA f4116,X
        INX 
        CPX #$06
        BNE bBA1D
        JMP jBA48

fBA35   .BYTE $F0,$FF,$FF,$FF,$FF,$FF,$FF,$20
        .BYTE $29,$41,$20,$9D,$B4,$20,$2F,$41
        .BYTE $4C,$32,$41
jBA48   LDX #$00
        CLI 
        LDA #$20
bBA4D   STA SCREEN_RAM + $0000,X
        STA SCREEN_RAM + $0100,X
        STA SCREEN_RAM + $01D0,X
        DEX 
        BNE bBA4D
        LDA #$40
        STA aBA9F
bBA5E   LDX #$00
bBA60   LDA fB499,X
        BEQ bBA6C
        INX 
        CPX #$04
        BNE bBA60
        BEQ bBA5E
bBA6C   JSR sB1DC
        AND #$0F
        ORA #$01
        STA fB499,X
        JSR sB1DC
        AND #$1F
        ADC #$04
        STA fB4AD,X
        JSR sB1DC
        AND #$0F
        ADC #$03
        STA fB4B1,X
        DEC aBA9F
        BNE bBA5E
        LDX #$04
        LDA #$00
bBA93   STA aB498,X
        DEX 
        BNE bBA93
        JSR sBAA0
        JMP TitleScreenLoop

aBA9F   .BYTE $00
;-------------------------------
; sBAA0
;-------------------------------
sBAA0   
        JSR sAB3F
        LDA #$00
        STA aBA9F
bBAA8   LDA #$00
        STA aBB16
bBAAD   LDA aBB16
        STA a04
        LDA aBA9F
        STA a05
        LDA aBA9F
        ROR 
        AND #$0F
        TAX 
        LDA f40DD,X
        BNE bBAC5
        LDA #<pA108
bBAC5   STA a06
        LDA #>pA108
        STA a07
        JSR sBAEB
        INC aBB16
        INC aBB16
        LDA aBB16
        CMP #$28
        BNE bBAAD
        INC aBA9F
        INC aBA9F
        LDA aBA9F
        CMP #$14
        BNE bBAA8
        JMP jBB17

;-------------------------------
; sBAEB
;-------------------------------
sBAEB   
        JSR sBB02
        INC a05
        INC a07
        JSR sBB02
        INC a04
        DEC a05
        INC a07
        JSR sBB02
        INC a07
        INC a05
;-------------------------------
; sBB02
;-------------------------------
sBB02   
        LDA a04
        BMI bBB15
        CMP #$28
        BPL bBB15
        LDA a05
        BMI bBB15
        CMP #$15
        BPL bBB15
        JSR s4198
bBB15   RTS 

aBB16   .BYTE $00
jBB17   LDA #$20
        STA a07
        LDA #>p090A
        STA a05
bBB1F   LDA #<p090A
        STA a04
bBB23   JSR s4198
        INC a04
        LDA a04
        CMP #$1C
        BNE bBB23
        INC a05
        LDA a05
        CMP #$0C
        BNE bBB1F
        LDA #<$010A
        STA a05
        LDA #>$010A
        STA a06
        LDA #$0B
        STA a04
        LDX #$00
bBB44   LDA fBB5C,X
        AND #$3F
        STA a07
        TXA 
        PHA 
        JSR s4198
        PLA 
        TAX 
        INX 
        INC a04
        CPX #$10
        BNE bBB44
        JMP jBB6C

fBB5C   .TEXT "JUEGO TERMINADO!"
jBB6C   LDA #$10
        STA aBA9F
bBB71   LDA #<pB6C5
        STA a1B
        LDA #>pB6C5
        STA a1C
        LDA #$01
        STA a4141
        LDX #$12
bBB80   LDA fB6B2,X
        STA f402B,X
        DEX 
        BNE bBB80
        LDX #$00
        LDY #$00
bBB8D   DEY 
        BNE bBB8D
        DEX 
        BNE bBB8D
        DEC aBA9F
        BNE bBB71
        RTS 

;-------------------------------
; sBB99
;-------------------------------
sBB99   
        LDA a4CE8
        BEQ bBBA1
        JMP jBBAE

bBBA1   JMP jB96E

aBBA4   .BYTE $00
;-------------------------------
; sBBA5
;-------------------------------
sBBA5   
        STA aB56D
        LDA #$00
        STA aB9AE
        RTS 

jBBAE   SEI 
        JSR jB95D
        JSR sB6CA
        LDX #$F8
        TXS 
        JMP jBA02

        STA a09AE
        JSR s0C7B
        AND #$03
        CLC 
        ADC #$01
        STA a18DA
        RTS 

        .BYTE $00,$00,$02,$00,$02,$00,$02,$00
        .BYTE $07,$00,$07,$00,$07,$00,$05,$00
        .BYTE $05,$00,$05,$00,$FF,$81,$0F,$AA
        .BYTE $01,$A0,$21,$04,$05,$00,$FF,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$81
        .BYTE $0F,$99,$01,$10,$11,$FF,$0C,$00
        .BYTE $01,$80,$10,$40,$04,$FF,$0C,$00
        .BYTE $01,$88,$0F,$0A,$01,$E0,$81,$80
        .BYTE $04,$00,$02,$10,$10,$FF,$0C,$FA
        .BYTE $02,$00,$01,$81,$7F,$06,$01,$60
        .BYTE $81,$06,$0C,$00,$01,$20,$80,$40
        .BYTE $03,$00,$03,$00,$01,$A2,$12,$BD
        .BYTE $24,$19,$9D,$07,$40,$CA,$D0,$F7
        .BYTE $60,$81,$7F,$0C,$01,$10,$21,$80
        .BYTE $02,$04,$0C,$10,$30,$80,$02,$FC
        .BYTE $0C,$00,$01,$81,$0F,$0A,$01,$C0
        .BYTE $81,$01,$04,$00,$02,$10,$10,$20
        .BYTE $03,$03,$10,$00,$01,$81,$2F,$09
        .BYTE $01,$A0,$21,$03,$03,$08,$03,$10
        .BYTE $C0,$08,$04,$F0,$0C,$00,$01,$A2
        .BYTE $12
bBC6B   LDA f1966,X
        STA f4007,X
        DEX 
        BNE bBC6B
        RTS 

        .BYTE $8F,$0F,$0A,$01,$20,$11,$FF,$0C
        .BYTE $00,$01,$10,$50,$22,$06,$E0,$20
        .BYTE $00,$01,$8C,$F6,$0C,$A0,$12,$B9
        .BYTE $84,$19,$99,$2B,$40,$88,$D0,$F7
        .BYTE $AC,$F6,$0C,$60,$00,$AD,$A9,$19
        .BYTE $D0,$09,$AD,$D8,$40,$D0,$01,$60
        .BYTE $4C,$3E,$41,$AD,$D8,$40,$48,$F0
        .BYTE $03,$20,$3E,$41,$68,$8D,$D8,$40
        .BYTE $CE,$A9,$19,$D0,$EE,$A9,$00,$8D
        .BYTE $D8,$40,$60,$AA,$A0,$D0,$C5,$D2
        .BYTE $C6,$C5,$C3,$D4,$A0,$AA,$81,$0F
        .BYTE $0A,$01,$40,$81,$FF,$10,$00,$01
        .BYTE $20,$C0,$FC,$06,$10,$F0,$00,$01
        .BYTE $AE,$07,$1A,$E0,$04,$D0,$01,$60
        .BYTE $BC,$08,$1A,$BD,$0C,$1A,$99,$81
        .BYTE $07,$A9,$07,$99,$81,$DB,$EE,$07
        .BYTE $1A
        .BYTE $60,$00,$00,$28,$01,$29,$A1,$A2
        .BYTE $A3,$A4,$A3,$02,$FF,$00,$BF,$00
        .BYTE $FF,$00,$BF,$00,$FF,$00,$FF,$00
        .BYTE $FF,$00,$FF,$00,$FF,$00,$FF,$02
        .BYTE $FF,$00,$FF,$00,$FF,$00,$FF,$20
        .BYTE $BD,$00,$FF,$00,$FF,$00,$BF,$80
        .BYTE $FF,$00,$9F,$82,$FF,$00,$FF,$00
        .BYTE $FD,$00,$BD,$00,$FF,$00,$FF,$00
        .BYTE $FF,$00,$FF,$02,$FF,$00,$FF,$00
        .BYTE $BD,$00,$FF,$00,$FF,$00,$FF,$00
        .BYTE $FF,$00,$FF,$00,$FF,$00,$FF,$00
        .BYTE $FF,$00,$FF,$00,$FF,$00,$FF,$00
        .BYTE $FF,$00,$FF,$00,$FF,$00,$FF,$C1
        .BYTE $FF,$00,$FF,$00,$FF,$00,$FF,$00
        .BYTE $FF,$00,$FF,$00,$FF,$00,$FF,$00
        .BYTE $BF,$80,$FF,$00,$FF,$00,$FF,$00
        .BYTE $FF,$00,$BF,$00,$FF,$00,$FF,$40
        .BYTE $BF,$00,$1C,$BD,$00,$FF,$00,$BD
        .BYTE $00,$FF,$00,$AD,$00,$FF,$00,$BD
        .BYTE $00,$FF,$00,$DF,$00,$FF,$00,$FD
        .BYTE $00,$DF,$00,$FE,$00,$FF,$00,$95
        .BYTE $02,$FF,$00,$DF,$00,$FF,$00,$1E
        .BYTE $00,$FF,$80,$1C,$00,$CF,$00,$BD
        .BYTE $02,$9F,$82,$FF,$00,$FF,$00,$BD
        .BYTE $00,$FF,$00,$BD,$02,$FF,$00,$9D
        .BYTE $02,$BD,$00,$FF,$00,$FF,$00,$FF
        .BYTE $00,$FF,$00,$EF,$00,$FF,$00
;-------------------------------
; sBDCD
;-------------------------------
sBDCD   
        .BYTE $FF,$00,$FF,$00,$FF,$00,$FF,$00
        .BYTE $FF,$00,$FF,$00,$FE,$00,$FF,$00
        .BYTE $01,$00,$FF,$00,$FF,$00,$FF,$00
        .BYTE $FF,$00,$FF,$00,$FF,$00,$FF,$00
        .BYTE $FF,$00,$4E,$00,$FF,$00,$FF,$00
        .BYTE $FF,$00,$FF,$00,$FF,$00,$FF,$00
        .BYTE $BD,$00,$BF,$A3,$02,$FF,$00,$BF
        .BYTE $00,$FF,$00,$BF,$90,$FF,$00,$FF
        .BYTE $00,$FF,$00,$FF,$00,$FF,$00,$FF
        .BYTE $02,$FF,$00,$FF,$00,$FF,$00,$FF
        .BYTE $60,$BD,$00,$FF,$00,$FF,$00,$BF
        .BYTE $A0,$FF,$04,$17,$82,$FF,$00,$FF
        .BYTE $00,$FD,$00,$9D,$00,$FF,$00,$FF
        .BYTE $00,$FF,$00,$FF,$02,$FD,$00,$FF
        .BYTE $00,$BD,$00,$FF,$00,$FF,$00,$FF
        .BYTE $00,$FF,$00,$FF,$10,$FF,$00,$FF
        .BYTE $00,$FF,$00,$FF,$00,$FF,$00,$FF
        .BYTE $00,$FF,$00,$FF,$00,$FF,$00,$FF
        .BYTE $E5,$FF,$00,$FF,$00,$FF,$00,$FF
        .BYTE $00,$FF,$00,$FF,$00,$FF,$00,$FF
        .BYTE $00,$BF,$A0,$FF,$00,$FF,$00,$FF
        .BYTE $00,$FF,$00,$BF,$00,$FF,$00,$FF
        .BYTE $40,$BD,$00,$1C,$BD,$00,$FF,$00
        .BYTE $BD,$00,$FF,$00,$2D,$00,$FF,$00
        .BYTE $BD,$00,$FF,$00,$DF,$00,$FF,$00
        .BYTE $FD,$00,$DF,$00,$FA,$00,$FF,$00
        .BYTE $95,$02,$FF,$00,$5F,$00,$FF,$00
        .BYTE $1E,$00,$FF,$A8,$00,$00,$CF,$00
        .BYTE $BD,$02,$1F,$82,$FF,$00,$FF,$00
        .BYTE $BD,$00,$FF,$00,$BD,$02,$FF,$00
        .BYTE $1D,$02,$3D,$00,$FF,$00,$FF,$00
        .BYTE $FF,$00,$FF,$00,$EF,$00,$FF,$00
        .BYTE $FF,$00,$FF,$00,$FF,$00,$FF,$00
        .BYTE $FF,$00,$FF,$00,$FE,$00,$FF,$00
        .BYTE $01,$00,$FF,$00,$FF,$00,$FF,$00
        .BYTE $FF,$00,$FF,$00,$FF,$00,$FF,$00
        .BYTE $FF,$00,$4A,$00,$FF,$00,$FF,$00
        .BYTE $FF,$00,$FF,$00,$FF,$00,$FF,$00
        .BYTE $BD,$00,$BF,$AE,$02,$FF,$00,$BF
        .BYTE $00,$FF,$00,$BF,$00,$FF,$00,$FF
        .BYTE $00,$FF,$00,$FF,$00,$FF,$00,$FF
        .BYTE $02,$FF,$00,$FF,$00,$FF,$00,$FF
        .BYTE $00,$BF,$00,$FF,$00,$FF,$00,$BF
        .BYTE $00,$FF,$00,$BF,$A2,$FF,$00,$FF
        .BYTE $00,$FF,$00,$3B,$00,$FF,$00,$FF
        .BYTE $00,$FF,$00,$FF,$02,$FF,$00,$FF
        .BYTE $40,$BF,$00,$BF,$00,$FF,$00,$FF
        .BYTE $00,$FF,$00,$FF,$00,$FF,$00,$FF
        .BYTE $00,$FF,$00,$FF,$00,$FF,$00,$FF
        .BYTE $00,$FF,$00,$FF,$00,$FF,$00,$FF
        .BYTE $00,$FF,$00,$FF,$00,$FF,$00,$FF
        .BYTE $00,$FF,$00,$FF,$00,$FF,$00,$FF
        .BYTE $00,$BF,$00,$FF,$00,$FF,$00,$FF
        .BYTE $00,$FF,$00,$BF,$00,$FF,$00,$FF
        .BYTE $00,$BD,$00,$1C,$BD,$00,$FF,$00
        .BYTE $FF,$00,$FF,$00,$FF,$00,$FF,$00
        .BYTE $FF,$00,$FF,$00,$FF,$00,$FF,$00
        .BYTE $FD,$00,$FF,$00,$FF,$00,$FF,$00
        .BYTE $9F,$00,$FF,$00,$FF,$00,$FF,$00
        .BYTE $9F,$00,$FB,$80,$01,$00,$FF,$00
        .BYTE $FF,$02,$BF,$8E,$FF,$00,$FF,$00
        .BYTE $BD,$00,$FF,$00,$BD,$00,$FF,$00
        .BYTE $1F,$00,$FF,$00,$FF,$00,$FF,$00
        .BYTE $FF,$00,$FF,$00,$FF,$00,$FF,$00
        .BYTE $FF,$00,$FF,$00,$FF,$00,$FF,$00
        .BYTE $FF,$00,$FF,$00,$FF,$00,$FF,$00
        .BYTE $9D,$00,$FF,$00,$FF,$00,$FF,$00
        .BYTE $FF,$00,$FF,$00,$FF,$00,$FF,$00
        .BYTE $FF,$00,$DF,$00,$FF,$00,$FF,$00
        .BYTE $FF,$00,$FF,$00,$FF,$00,$FF,$00
        .BYTE $BF,$C2,$00
;-------------------------------
; TitleScreenLoop
;-------------------------------
TitleScreenLoop
        JMP jC004

selectedLevel   .BYTE $00
jC004   LDA $D011    ;VIC Control Register 1
        ORA #$0B
        AND #$7B
        STA $D011    ;VIC Control Register 1
jC00E   SEI 
        LDA #$00
        STA aC2EA
        JSR AnimateScreenDissolve
        JSR sC034
        JSR sC119
        CLI 
        JSR DrawTitleScreen
jC021   LDA aC2EA
        CMP #$02
        BNE bC02E
        LDX #$F8
        TXS 
        JMP jC00E

bC02E   JSR CheckTitleScreenInput
        JMP jC021

;-------------------------------
; sC034
;-------------------------------
sC034   
        LDX #$00
bC036   LDA fC050,X
        STA f4122,X
        LDA fC053,X
        STA f410A,X
        LDA fC3FB,X
        STA f4116,X
        INX 
        CPX #$02
        BNE bC036
        JMP jC3A6

fC050   .BYTE $E0,$FF,$FF
fC053   .BYTE $55,$55,$20,$9F,$FF,$20,$EB,$C2
        .BYTE $4C,$32,$41
;-------------------------------
; AnimateScreenDissolve
;-------------------------------
AnimateScreenDissolve   
        SEI 
        LDA #>SCREEN_RAM + $0000
        STA aFC
        LDA #<SCREEN_RAM + $0000
        STA aFB
        JSR sC325
        LDA #$00
        STA $D015    ;Sprite display Enable
        LDA #$00
        STA $D020    ;Border Color
        STA $D021    ;Background Color 0
        STA $D017    ;Sprites Expand 2x Vertical (Y)
        STA $D01C    ;Sprites Multi-Color Mode Select
        STA $D01D    ;Sprites Expand 2x Horizontal (X)
        LDA #$08
        STA $D404    ;Voice 1: Control Register
        STA $D40B    ;Voice 2: Control Register
        STA $D412    ;Voice 3: Control Register
        LDA $D016    ;VIC Control Register 2
        AND #$E8
        ORA #$08
        STA $D016    ;VIC Control Register 2
        LDY #$00
bC097   JSR sC0C6
        AND #$07
        TAX 
        LDA #$42
        STA (pFB),Y
        LDA aFC
        PHA 
        CLC 
        ADC #$D4
        STA aFC
        LDA f40FB,X
        STA (pFB),Y
        PLA 
        STA aFC
        INC aFB
        BNE bC0B7
        INC aFC
bC0B7   LDA aFC
        CMP #$06
        BNE bC097
        LDA aFB
        CMP #$F8
        BNE bC097
        JMP DrawColorsForAnimatedScreenDissolve

aC0C7   =*+$01
;-------------------------------
; sC0C6
;-------------------------------
sC0C6   
        LDA $EEF8
        INC aC0C7
        RTS 

;-------------------------------
; DrawColorsForAnimatedScreenDissolve
;-------------------------------
DrawColorsForAnimatedScreenDissolve
        LDA #$07
        STA aC118
bC0D2   LDA #>$D800
        STA aFC
        LDA #<$D800
        STA aFB
        LDY #$00
bC0DC   LDA (pFB),Y
        AND #$0F
        LDX #$00
bC0E2   CMP f40FA,X
        BEQ bC0EC
        INX 
        CPX #$08
        BNE bC0E2
bC0EC   CPX #$00
        BEQ bC0F6
        DEX 
        LDA f40FA,X
        STA (pFB),Y
bC0F6   INC aFB
        BNE bC0FC
        INC aFC
bC0FC   LDA aFC
        CMP #$DA
        BNE bC0DC
        LDA aFB
        CMP #$F8
        BNE bC0DC
        LDX #$08
        LDY #$00
bC10C   DEY 
        BNE bC10C
        DEX 
        BNE bC10C
        DEC aC118
        BNE bC0D2
        RTS 

aC118   .BYTE $00
;-------------------------------
; sC119
;-------------------------------
sC119   
        LDX #$00
bC11B   LDA #$20
        STA SCREEN_RAM + $0000,X
        STA SCREEN_RAM + $0100,X
        STA SCREEN_RAM + $01F8,X
        LDA #$0C
        STA $D800,X
        STA $D900,X
        STA $D9F8,X
        DEX 
        BNE bC11B
        JSR sC4D9
        LDA #$08
        STA aC2E8
        RTS 

;-------------------------------
; DrawTitleScreen
;-------------------------------
DrawTitleScreen   
        LDX #$00
bC13F   LDA fC165,X
        AND #$3F
        STA SCREEN_RAM + $0140,X
        LDA fC18D,X
        AND #$3F
        STA SCREEN_RAM + $0190,X
        LDA fC1B5,X
        AND #$3F
        STA SCREEN_RAM + $01E0,X
        INX 
        CPX #$28
        BNE bC13F
        JSR sC21C
        JSR sC26C
        JMP DrawCredits

fC165   .TEXT " PRESS KEYS 1-6 TO ACTIVATE SUBGAMES..  "
fC18D   .TEXT " PRESS F1 FOR LEVEL: CURRENT LEVEL 1    "
fC1B5   .TEXT " PRESS F3 FOR STROBOSCOPICS: NOW ON     "
;-------------------------------
; CheckTitleScreenInput
;-------------------------------
CheckTitleScreenInput   
        LDA currentPressedKey
        CMP #$40
        BNE bC1E9
        LDA #$00
        STA aC26B
bC1E8   RTS 

bC1E9   LDY aC26B
        BNE bC1E8
        STA lastPressedKey
        LDA aC2EA
        BEQ bC201
        LDA #<$0101
        STA aC2E8
        LDA #>$0101
        STA aC2E9
        RTS 

bC201   LDA #$08
        STA aC2E8
        LDA lastPressedKey
        CMP #$04 ;F1
        BNE bC22C
        INC selectedLevel
        LDA selectedLevel
        CMP #$05 ; Cycle levels through 1 to 5
        BNE sC21C
        LDA #$00
        STA selectedLevel
;-------------------------------
; sC21C
;-------------------------------
sC21C   
        LDA #$31
        CLC 
        ADC selectedLevel
        STA SCREEN_RAM + $01B3
        STA aC26B
        JSR sC35F
        RTS 

bC22C   CMP #$05 ;F3 pressed?
        BNE bC260
        LDA stroboscopeOnOff ; F3 pressed!
        CMP #$4C
        BEQ bC24F
        LDA #$4C
        STA stroboscopeOnOff
bC23C   LDA #<p0E0F
        STA SCREEN_RAM + $0201
        LDA #>p0E0F
        STA SCREEN_RAM + $0202
        LDA #$20
        STA SCREEN_RAM + $0203
        STA aC26B
        RTS 

bC24F   LDA #$60
        STA stroboscopeOnOff
bC254   LDA #$06
        STA SCREEN_RAM + $0202
        STA SCREEN_RAM + $0203
        STA aC26B
        RTS 

bC260   LDA #$07
        STA selectedSubGame
        JSR s4B1B
        JMP s413B

aC26B   .BYTE $00
;-------------------------------
; sC26C
;-------------------------------
sC26C   
        JSR sC35F
        LDA stroboscopeOnOff
        CMP #$4C
        BEQ bC23C
        BNE bC254
;-------------------------------
; sC278
;-------------------------------
sC278   
        SEI 
        LDA #$C8
        STA aFC
        LDA #$04
        STA aFE
        LDA #$00
        STA aFB
        STA aFD
        LDY #$00
bC289   LDA (pFD),Y
        PHA 
        LDA (pFB),Y
        STA (pFD),Y
        PLA 
        STA (pFB),Y
        DEY 
        BNE bC289
        INC aFC
        INC aFE
        LDA aFE
        CMP #$08
        BNE bC289
        LDA #$CC
        STA aFC
        LDA #$20
        STA aFE
        LDA #$00
        STA aFB
        STA aFD
        LDY #$00
        LDA a01
        AND #$FD
        STA a01
bC2B6   LDA (pFD),Y
        PHA 
        LDA (pFB),Y
        STA (pFD),Y
        PLA 
        STA (pFB),Y
        DEY 
        BNE bC2B6
        INC aFC
        INC aFE
        LDA aFC
        CMP #$D0
        BNE bC2CF
        LDA #$E0
bC2CF   STA aFC
        CMP #$FC
        BNE bC2B6
        LDA a01
        ORA #$02
        STA a01
        CLI 
        RTS 

;-------------------------------
; sC2DD
;-------------------------------
sC2DD   
        LDA $D011    ;VIC Control Register 1
        ORA #$20
        AND #$7F
        STA $D011    ;VIC Control Register 1
        RTS 

aC2E8   .BYTE $07
aC2E9   .BYTE $0E
aC2EA   .BYTE $00
        JSR sC503
        DEC aC2E9
        BEQ bC2F4
bC2F3   RTS 

bC2F4   DEC aC2E8
        BNE bC2F3
        LDA #$08
        STA aC2E8
        LDA aC2EA
        BNE bC30D
        JSR sC278
        JSR sC2DD
        INC aC2EA
        RTS 

bC30D   JSR sC278
        LDA $D011    ;VIC Control Register 1
        AND #$5F
        STA $D011    ;VIC Control Register 1
        LDA #$02
        STA aC2EA
        STA aC26B
        RTS 

lastPressedKey   .BYTE $00,$4C,$32,$41
;-------------------------------
; sC325
;-------------------------------
sC325   
        LDX #$00
bC327   LDA #$22
        STA f410A,X
        LDA #$C3
        STA f4116,X
        INX 
        CPX #$06
        BNE bC327
        LDA $D016    ;VIC Control Register 2
        AND #$EF
        STA $D016    ;VIC Control Register 2
        JMP s6004

;-------------------------------
; sC341
;-------------------------------
sC341   
        LDA #<p5B09
        STA aFB
        LDA #>p5B09
        STA aFC
        LDY selectedLevel
        BEQ bC35E
bC34E   LDA aFB
        CLC 
        ADC #$30
        STA aFB
        LDA aFC
        ADC #$00
        STA aFC
        DEY 
        BNE bC34E
bC35E   RTS 

;-------------------------------
; sC35F
;-------------------------------
sC35F   
        JSR sC341
bC362   LDA (pFB),Y
        STA SCREEN_RAM + $028A,Y
        LDA #$01
        STA $DA8A,Y
        INY 
        CPY #$08
        BNE bC362
        LDX #$00
bC373   LDA (pFB),Y
        STA SCREEN_RAM + $026B,X
        TYA 
        PHA 
        CLC 
        ADC #$14
        TAY 
        LDA (pFB),Y
        STA $DA6B,X
        PLA 
        TAY 
        INY 
        INX 
        CPY #$12
        BNE bC373
        LDX #$00
bC38D   LDA (pFB),Y
        STA SCREEN_RAM + $0293,X
        TYA 
        PHA 
        CLC 
        ADC #$14
        TAY 
        LDA (pFB),Y
        STA $DA93,X
        PLA 
        TAY 
        INY 
        INX 
        CPY #$1C
        BNE bC38D
        RTS 

jC3A6   JSR sC341
bC3A9   LDA SCREEN_RAM + $03B7,Y
        CMP (pFB),Y
        BMI bC3B9
        BEQ bC3B4
        BPL bC3BA
bC3B4   INY 
        CPY #$08
        BNE bC3A9
bC3B9   RTS 

bC3BA   LDY #$00
bC3BC   LDA SCREEN_RAM + $03B7,Y
        STA (pFB),Y
        INY 
        CPY #$08
        BNE bC3BC
        LDX #$00
bC3C8   LDA SCREEN_RAM + $037D,X
        STA (pFB),Y
        INY 
        INX 
        CPX #$0A
        BNE bC3C8
        LDX #$00
bC3D5   LDA SCREEN_RAM + $03A5,X
        STA (pFB),Y
        INX 
        INY 
        CPX #$0A
        BNE bC3D5
        LDX #$00
bC3E2   LDA $DB7D,X
        STA (pFB),Y
        INX 
        INY 
        CPX #$0A
        BNE bC3E2
        LDX #$00
bC3EF   LDA $DBA5,X
        STA (pFB),Y
        INX 
        INY 
        CPX #$0A
        BNE bC3EF
        RTS 

fC3FB   CPY #$C0
fC3FD   .TEXT " *** B A T A L Y X ***  A GAME SYSTEM   "
fC425   .TEXT "      CREATED BY  Y A K  THE HAIRY      "
fC44D   .TEXT "     SYNERGY BY JEFF MINTER AGAIN!!     "
fC475   .TEXT "   HIGHEST SCORE FOR THE CURRENT LEVE"
        .TEXT "L  "
;-------------------------------
; DrawCredits
;-------------------------------
DrawCredits
        LDX #$00
bC49F   LDA fC3FD,X
        AND #$3F
        STA SCREEN_RAM + $0028,X
        LDA #$07
        STA $D828,X
        LDA fC425,X
        AND #$3F
        STA SCREEN_RAM + $0078,X
        LDA #$04
        STA $D878,X
        LDA fC44D,X
        AND #$3F
pC4C0   =*+$02
        STA SCREEN_RAM + $00C8,X
        LDA #$03
        STA $D8C8,X
        LDA fC475,X
        AND #$3F
        STA SCREEN_RAM + $02F8,X
        LDA #$0E
        STA $DAF8,X
        INX 
        CPX #$28
        BNE bC49F
        RTS 

;-------------------------------
; sC4D9
;-------------------------------
sC4D9   
        LDA #$00
        STA aC500
        LDX #$00
bC4E0   LDA f40DA,X
        STA $D028,X  ;Sprite 1 Color
        INX 
        CPX #$07
        BNE bC4E0
        LDA #$01
        STA $D027    ;Sprite 0 Color
        LDA #>p5C00
        STA aC502
        LDA #<p5C00
        STA aC501
        LDA #$00
        STA aC51C
        RTS 

aC500   .BYTE $00
aC501   .BYTE $00
aC502   .BYTE $5C
;-------------------------------
; sC503
;-------------------------------
sC503   
        LDA aC500
        CMP #$00
        BNE bC567
        LDA #$00
        STA $D015    ;Sprite display Enable
        LDA $DC00    ;CIA1: Data Port Register A
        AND #$10
        BEQ bC51D
        LDA #$00
        STA aC51C
bC51B   RTS 

aC51C   .BYTE $00
bC51D   LDA aC51C
        BNE bC51B
        LDA #$01
        STA aC51C
        LDA #$08
        STA aC2E8
jC52C   LDA aC501
        STA aFB
        LDA aC502
        STA aFC
        LDY #$00
        LDA (pFB),Y
        CMP #$FF
        BNE bC54B
        LDA #>p5C00
        STA aC502
        LDA #<p5C00
        STA aC501
        JMP jC52C

bC54B   TAY 
        LDA fC591,Y
        LDX #$00
bC551   STA SCREEN_RAM + $03F8,X
        INX 
        CPX #$08
        BNE bC551
        INC aC501
        BNE bC561
        INC aC502
bC561   LDA #$FC
        STA aC500
        RTS 

bC567   LDX #$00
bC569   TXA 
        ASL 
        TAY 
        ASL 
        STA aC596
        LDA aC500
        CLC 
        ADC aC596
        STA $D001,Y  ;Sprite 0 Y Pos
        LDA #$B0
        STA $D000,Y  ;Sprite 0 X Pos
        INX 
        CPX #$08
        BNE bC569
        LDA #$FF
        STA $D015    ;Sprite display Enable
        DEC aC500
        DEC aC500
fC591   =*+$02
        DEC aC500
        DEC aC500
        RTS 

aC596   BRK #$C5
        CPX #$EA
        .BYTE $EF,$F0,$F5 ;ISC $F5F0
        .BYTE $FF,$A0,$A4 ;ISC $A4A0,X
        TAY 
        LDY aB1B0
        .BYTE $B2    ;JAM 
        LDY fB5,X
        LDX fD4,Y
        .BYTE $B3,$DA ;LAX ($DA),Y
        .BYTE $F3,$F6 ;ISC ($F6),Y
        .BYTE $F7,$FA ;ISC $FA,X
bC5AF   .BYTE $FB,$FD,$BB ;ISC $BBFD,Y
        LDA fA58D,X
        BEQ bC5C0
        JSR sA5E8
        JSR sA6E7
        JSR sA66C
bC5C0   INX 
        CPX #$08
        BNE bC5AF
        LDA aA76B
        BNE bC5D7
        BNE bC5D7
        LDA #$01
        STA aA76C
        JSR sA83E
        JSR sA7D5
bC5D7   RTS 

        .BYTE $00,$03,$00,$01,$00,$00,$00,$00
        .BYTE $00,$FF,$00,$01,$00,$00,$00,$00
        .BYTE $DE,$51,$A6,$D0,$35,$A9,$02,$9D
        .BYTE $51,$A6,$20,$59,$A6,$BD,$8D,$A5
        .BYTE $18,$7D,$D8,$A5,$9D,$8D,$A5,$29
        .BYTE $BF,$42,$FF,$00,$FF,$00,$FF,$00
        .BYTE $FF,$00,$FF,$00,$FF,$00,$FF,$00
        .BYTE $FF,$00,$FF,$00,$FF,$00,$FF,$00
        .BYTE $FF,$40,$FF,$02,$FF,$00,$FF,$00
        .BYTE $FF,$00,$FF,$00,$FF,$00,$FF,$00
        .BYTE $FF,$00,$FF,$00,$FF,$00,$FF,$00
        .BYTE $FF,$00,$FF,$00,$BF,$00,$FF,$00
        .BYTE $FF,$40,$FF,$00,$FD,$42,$0A,$40
        .BYTE $BF,$42,$FF,$00,$FF,$00,$FF,$40
        .BYTE $FF,$42,$FF,$00,$FF,$00,$FF,$00
        .BYTE $FF,$00,$FF,$00,$FF,$00,$FF,$00
        .BYTE $FF,$00,$FF,$00,$FF,$00,$FF,$40
        .BYTE $FF,$00,$FF,$00,$FF,$00,$FF,$00
        .BYTE $FF,$00,$FF,$00,$FF,$00,$FF,$00
        .BYTE $FF,$00,$FF,$00,$FF,$00,$FF,$00
        .BYTE $FF,$00,$FF,$00,$FF,$00,$BF,$40
        .BYTE $00,$BD,$00,$FF,$00,$FF,$00,$FF
        .BYTE $00,$BD,$00,$FF,$00,$FF,$00,$FF
        .BYTE $00,$FF,$00,$FF,$00,$FF,$00,$FF
        .BYTE $00,$BF,$00,$FD,$00,$FF,$00,$FF
        .BYTE $00,$FF,$00,$FF,$00,$FF,$00,$FF
        .BYTE $00,$FF,$00,$FF,$00,$FF,$00,$FF
        .BYTE $00,$FF,$00,$FF,$00,$FF,$00,$FF
        .BYTE $00,$BF,$00,$FF,$80,$BD,$B5,$BD
        .BYTE $00,$BD,$00,$FF,$00,$FF,$00,$BF
        .BYTE $00,$BD,$00,$FF,$00,$FF,$00,$FF
        .BYTE $00,$FF,$00,$FF,$00,$FF,$00,$FF
        .BYTE $00,$FF,$00,$FF,$00,$FF,$00,$BD
        .BYTE $00,$FF,$00,$FF,$00,$FF,$00,$FF
        .BYTE $00,$FF,$00,$FF,$00,$FF,$00,$FF
        .BYTE $00,$FF,$00,$FF,$00,$FF,$00,$FF
        .BYTE $00,$FF,$00,$FF,$00,$FF,$00,$BD
        .BYTE $00,$E7,$00,$18,$FF,$E7,$00,$FD
        .BYTE $E7,$41,$00,$ED,$00,$32,$F7,$E7
        .BYTE $E7,$04,$00,$00,$00,$00,$E7,$FF
        .BYTE $E7,$08,$00,$00,$00,$00,$00,$EF
        .BYTE $00,$00,$00,$E7,$00,$00,$00,$E7
        .BYTE $00,$00,$00,$00,$00,$00,$08,$FF
        .BYTE $00,$C0,$E7,$00,$00,$05,$A5,$FF
        .BYTE $00,$00,$C1,$1A,$00,$EF,$26,$18
        .BYTE $00,$00,$00,$00,$00,$04,$00,$FF
        .BYTE $13,$00,$E7,$FF,$00,$00,$00,$10
        .BYTE $00,$00,$00,$00,$00,$80,$00,$AA
        .BYTE $00,$00,$00,$18,$01,$6F,$45,$3F
        .BYTE $00,$E7,$00,$00,$E7,$00,$00,$DF
        .BYTE $E7,$3F,$00,$E7,$E7,$00,$45,$FF
        .BYTE $00,$00,$00,$00,$E7,$E5,$00,$20
        .BYTE $FF,$F7,$45,$E7,$E7,$00,$F7,$FF
        .BYTE $FF,$FF,$FF,$FF,$08,$FF,$18,$FF
        .BYTE $08,$18,$18,$FF,$41,$18,$5B,$18
        .BYTE $FF,$FF,$FF,$18,$18,$3F,$FF,$01
        .BYTE $FF,$FF,$FF,$FF,$00,$58,$FF,$08
        .BYTE $FF,$FF,$FF,$08,$06,$00,$FF,$00
        .BYTE $1A,$06,$FF,$FF,$08,$08,$FF,$10
        .BYTE $FF,$FF,$FF,$BF,$FF,$FF,$FF,$00
        .BYTE $00,$00,$00,$FF,$00,$00,$A4,$00
        .BYTE $FF,$FF,$FF,$80,$08,$FF,$3F,$00
        .BYTE $66,$18,$FF,$FF,$90,$EF,$FF,$18
        .BYTE $18,$FF,$FF,$18,$FF,$1A,$FF,$00
        .BYTE $18,$FF,$FF,$18,$18,$FF,$10,$47
        .BYTE $FF,$18,$FF,$18,$00,$00,$00,$00
        .BYTE $FF,$40,$FF,$00,$18,$FF,$08,$00
        .BYTE $FF,$18,$FF,$00,$FF,$00,$00,$00
        .BYTE $18,$FF,$FF,$18,$00,$FF,$FD,$18
        .BYTE $B0,$B0,$10,$B0,$B0,$B0,$B0,$B0
        .BYTE $F0,$F0,$B0,$10,$B0,$B0,$B0,$B0
        .BYTE $B0,$B0,$FB,$1B,$FB,$0B,$0B,$0B
        .BYTE $0B,$0B,$0B,$FB,$1B,$FB,$0B,$0B
        .BYTE $B0,$F0,$F0,$B0,$60,$60,$60,$60
        .BYTE $B0,$10,$B0,$B0,$C0,$C0,$B0,$B0
        .BYTE $F0,$F0,$10,$10,$B0,$B0,$B0,$B0
        .BYTE $B0,$CB,$CB,$FB,$1B,$FB,$0B,$0B
        .BYTE $0B,$0B,$CB,$1B,$1B,$CB,$0B,$B0
        .BYTE $0B,$F0,$F0,$B0,$60,$60,$60,$60
        .BYTE $B0,$C0,$B0,$B0,$B0,$B0,$B0,$B0
        .BYTE $F0,$C0,$B0,$B0,$B0,$B0,$B0,$B0
        .BYTE $B0,$CB,$CB,$0B,$CB,$1B,$0B,$0B
        .BYTE $0B,$0B,$CB,$1B,$0B,$CB,$CB,$B0
        .BYTE $0B,$0B,$B0,$B0,$60,$60,$60,$60
        .BYTE $B0,$B0,$B0,$B0,$B0,$B0,$B0,$B0
        .BYTE $B0,$B0,$B0,$B0,$B0,$B0,$B0,$B0
        .BYTE $CB,$CB,$0B,$0B,$CB,$1B,$FB,$0B
        .BYTE $0B,$CB,$1B,$1B,$0B,$0B,$CB,$CB
        .BYTE $0B,$0B,$0B,$60,$60,$E0,$B0,$B0
        .BYTE $B9,$B9,$B8,$B8,$B8,$B8,$B8,$B8
        .BYTE $8B,$B8,$B8,$8B,$0B,$0B,$0B,$0B
        .BYTE $0B,$0B,$0B,$0B,$0B,$CB,$1B,$0B
        .BYTE $0B,$CB,$1B,$0B,$0B,$0B,$0B,$0B
        .BYTE $0B,$0B,$0B,$B0,$E0,$E0,$B0,$B0
        .BYTE $B9,$B8,$B8,$B8,$B8,$B8,$B8,$B8
        .BYTE $8B,$8B,$8B,$8B,$0B,$0B,$0B,$0B
        .BYTE $0B,$0B,$0B,$0B,$0B,$CB,$1B,$1B
        .BYTE $CB,$1B,$1B,$0B,$0B,$0B,$0B,$0B
        .BYTE $0B,$0B,$0B,$0B,$B0,$0B,$F0,$F0
        .BYTE $B9,$B9,$B9,$B8,$B8,$B8,$B8,$B8
        .BYTE $8B,$8B,$8B,$8B,$8B,$0B,$FB,$FB
        .BYTE $FB,$FB,$0B,$0B,$0B,$CB,$CB,$1B
        .BYTE $FB,$1B,$FB,$0B,$0B,$0B,$0B,$0B
        .BYTE $0B,$0B,$0B,$0B,$0B,$0B,$0B,$B0
        .BYTE $B9,$B9,$B8,$B8,$B8,$B8,$B8,$B8
        .BYTE $8B,$8B,$8B,$8B,$8B,$8B,$FB,$FB
        .BYTE $FB,$FB,$0B,$CB,$CB,$1B,$BF,$1C
        .BYTE $BF,$1C,$FB,$1B,$1B,$0B,$0B,$0B
        .BYTE $0B,$8B,$8B,$0B,$0B,$EB,$EB,$B0
        .BYTE $B9,$B8,$B8,$B8,$B9,$B9,$B9,$B9
        .BYTE $9B,$9B,$9B,$9B,$8B,$8B,$8B,$8B
        .BYTE $8B,$8B,$0B,$0B,$CB,$CB,$BF,$BF
        .BYTE $BF,$BF,$CB,$CB,$CB,$0B,$0B,$0B
        .BYTE $8B,$8B,$0B,$0B,$EB,$EB,$EB,$0B
        .BYTE $B9,$B9,$B9,$B9,$B1,$B1,$B1,$B9
        .BYTE $9B,$9B,$9B,$9B,$8B,$8B,$8B,$8B
        .BYTE $8B,$8B,$8B,$0B,$0B,$0B,$BC,$BF
        .BYTE $BF,$CF,$1B,$B0,$0B,$FB,$FB,$FB
        .BYTE $FB,$0B,$0B,$0B,$0B,$0B,$0B,$DB
        .BYTE $C9,$B1,$B1,$B1,$B1,$B1,$B1,$B1
        .BYTE $B1,$B1,$FB,$8B,$8B,$8B,$8B,$8B
        .BYTE $8B,$8B,$8B,$0B,$0B,$0B,$BC,$CF
        .BYTE $CF,$1F,$1F,$1B,$0B,$FB,$FB,$FB
        .BYTE $0B,$0B,$0B,$0B,$0B,$0B,$DB,$DB
        .BYTE $B1,$B1,$B1,$B1,$C1,$B1,$C1,$C1
        .BYTE $B1,$B1,$B1,$FC,$FB,$8B,$8B,$8B
        .BYTE $8B,$8B,$8B,$8B,$0B,$CB,$BC,$BF
        .BYTE $BF,$1F,$1F,$1B,$0B,$FB,$FB,$FB
        .BYTE $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B
        .BYTE $C1,$B1,$B1,$B1,$C1,$C1,$C1,$C1
        .BYTE $B1,$C1,$B1,$FC,$FC,$FB,$FB,$8B
        .BYTE $8B,$8B,$8B,$8B,$0B,$CB,$CB,$BF
        .BYTE $BF,$1F,$1F,$1B,$0B,$0B,$0B,$0B
        .BYTE $7B,$8B,$8B,$8B,$8B,$1B,$1B,$1B
        .BYTE $B1,$B1,$B1,$B1,$B1,$B1,$B1,$B1
        .BYTE $B1,$B1,$B1,$B1,$BC,$BC,$FB,$B1
        .BYTE $FB,$8B,$8B,$8B,$BC,$BC,$BC,$B1
        .BYTE $B1,$BF,$BF,$CB,$0B,$0B,$7B,$7B
        .BYTE $7B,$8B,$8B,$8B,$8B,$1B,$1B,$1B
        .BYTE $54,$14,$14,$14,$14,$14,$14,$14
        .BYTE $14,$14,$14,$14,$14,$14,$14,$14
        .BYTE $14,$54,$54,$B4,$BC,$BC,$BC,$B1
        .BYTE $BF,$BC,$BC,$BC,$CB,$0B,$7B,$7B
        .BYTE $7B,$0B,$8B,$8B,$8B,$0B,$1B,$1B
        .BYTE $16,$16,$16,$16,$16,$16,$16,$16
        .BYTE $16,$16,$16,$16,$16,$16,$16,$16
        .BYTE $16,$56,$56,$B6,$BC,$BC,$BC,$BC
        .BYTE $BC,$BC,$BC,$BC,$BC,$0B,$0B,$0B
        .BYTE $0B,$0B,$0B,$0B,$0B,$FB,$CB,$CB
        .BYTE $15,$15,$15,$15,$15,$15,$15,$15
        .BYTE $15,$15,$15,$15,$15,$15,$15,$15
        .BYTE $15,$05,$05,$51,$51,$51,$51,$5B
        .BYTE $BC,$BC,$BC,$BC,$BC,$CB,$FB,$FB
        .BYTE $FB,$FB,$CB,$FB,$FB,$FB,$FC,$FB
        .BYTE $57,$17,$17,$17,$17,$17,$17,$17
        .BYTE $17,$17,$17,$17,$17,$17,$17,$17
        .BYTE $17,$57,$B7,$BC,$BC,$BC,$C1,$51
        .BYTE $C1,$BC,$BF,$BF,$BC,$CB,$FB,$FB
        .BYTE $FC,$FC,$FB,$FB,$FB,$FC,$FC,$FC
        .BYTE $58,$18,$18,$18,$18,$18,$18,$18
        .BYTE $18,$18,$18,$18,$18,$18,$18,$18
        .BYTE $58,$58,$B8,$BC,$B1,$B1,$B1,$B1
        .BYTE $C1,$BC,$BF,$BC,$BC,$CB,$FB,$FB
        .BYTE $FC,$FC,$CB,$FB,$CB,$CB,$CB,$CB
        .BYTE $12,$12,$12,$12,$12,$12,$12,$12
        .BYTE $12,$12,$12,$12,$12,$12,$12,$12
        .BYTE $12,$52,$B2,$BC,$B1,$B1,$C1,$51
        .BYTE $C1,$BC,$BC,$BC,$BC,$B4,$04,$04
        .BYTE $04,$04,$04,$04,$04,$04,$04,$04
        .BYTE $50,$50,$E0,$20,$50,$50,$50,$50
        .BYTE $D0,$50,$50,$50,$50,$60,$40,$40
        .BYTE $50,$C0,$B0,$B0,$B1,$B1,$C1,$01
        .BYTE $B1,$B1,$01,$BC,$BC,$B6,$06,$06
        .BYTE $06,$06,$06,$06,$06,$06,$06,$06
        .BYTE $80,$80,$50,$50,$50,$50,$50,$50
        .BYTE $50,$50,$50,$50,$E0,$E0,$E0,$E0
        .BYTE $E0,$E0,$C0,$B0,$B1,$B1,$C1,$51
        .BYTE $C1,$B1,$B1,$BC,$B5,$B5,$05,$05
        .BYTE $05,$05,$05,$05,$05,$05,$05,$05
        .BYTE $80,$80,$D0,$D0,$D0,$D0,$D0,$D0
        .BYTE $D0,$D0,$D0,$D0,$30,$30,$30,$30
        .BYTE $30,$E0,$C0,$B0,$B1,$B1,$BC,$5C
        .BYTE $51,$51,$51,$51,$57,$57,$07,$07
        .BYTE $07,$07,$07,$07,$07,$07,$07,$07
        .BYTE $E0,$E0,$D0,$D0,$E0,$E0,$E0,$E0
        .BYTE $E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0
        .BYTE $30,$E0,$C0,$C0,$BC,$BC,$BC,$BC
        .BYTE $BC,$B1,$B1,$BC,$08,$08,$08,$08
        .BYTE $08,$08,$08,$08,$08,$08,$08,$08
        .BYTE $90,$90,$90,$90,$90,$90,$90,$90
        .BYTE $90,$10,$90,$90,$90,$90,$90,$C0
        .BYTE $C0,$C0,$C0,$C0,$CB,$BC,$BC,$BC
        .BYTE $BC,$BF,$B1,$CB,$02,$02,$02,$02
        .BYTE $02,$02,$02,$02,$02,$02,$02,$02
        .BYTE $B1,$B1,$B1,$B1,$B1,$B1,$B1,$B1
        .BYTE $B1,$B1,$B1,$B1,$B1,$B1,$B1,$B1
        .BYTE $4E,$63,$65,$66,$51,$53,$57,$58
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$01
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$01,$01
        .BYTE $03,$0C,$30,$74,$6E,$BB,$D5,$EA
        .BYTE $E0,$18,$E6,$7F,$09,$A2,$54,$2B
        .BYTE $00,$00,$00,$00,$80,$80,$C0,$C0
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$20,$50
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $03,$07,$0F,$0F,$1F,$1F,$1F,$0F
        .BYTE $EF,$EF,$F6,$39,$D7,$EF,$ED,$F7
        .BYTE $7B,$56,$B5,$EF,$7E,$BB,$F7,$7E
        .BYTE $FF,$FF,$FE,$FB,$F4,$F2,$EB,$CF
        .BYTE $E0,$1F,$6E,$73,$DE,$FB,$97,$DE
        .BYTE $00,$00,$00,$00,$00,$03,$05,$0F
        .BYTE $00,$00,$00,$00,$9E,$3F,$2F,$55
        .BYTE $00,$00,$00,$00,$00,$80,$E0,$F0
        .BYTE $04,$83,$60,$91,$4E,$10,$6C,$82
        .BYTE $7F,$3F,$DF,$0F,$0F,$1F,$7C,$D8
        .BYTE $11,$E4,$12,$0C,$89,$2A,$29,$D4
        .BYTE $00,$00,$00,$01,$06,$09,$14,$12
        .BYTE $54,$B3,$EF,$1A,$A1,$64,$D0,$C1
        .BYTE $E6,$D9,$26,$D2,$15,$22,$CA,$31
        .BYTE $00,$00,$00,$00,$00,$00,$03,$06
        .BYTE $00,$00,$00,$00,$3C,$AE,$5E,$AF
        .BYTE $00,$00,$00,$00,$80,$60,$70,$78
        .BYTE $9F,$3F,$4F,$27,$AB,$51,$45,$18
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$14,$20,$20,$1C,$0E,$01,$01
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$18,$1E
        .BYTE $00,$00,$00,$00,$00,$00,$01,$03
        .BYTE $00,$00,$00,$00,$62,$E0,$E0,$E0
        .BYTE $10,$01,$00,$00,$00,$20,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$04,$00,$00,$00,$00,$00,$01
        .BYTE $00,$00,$00,$00,$00,$00,$80,$80
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$08,$0C,$1A,$1B,$16
        .BYTE $00,$00,$00,$00,$00,$00,$00,$80
        .BYTE $01,$01,$01,$00,$00,$00,$00,$00
        .BYTE $DC,$F9,$D6,$E8,$75,$6E,$35,$0C
        .BYTE $5D,$A6,$32,$AD,$55,$39,$66,$28
        .BYTE $C0,$C0,$80,$80,$00,$00,$00,$00
        .BYTE $00,$02,$00,$00,$00,$00,$00,$00
        .BYTE $20,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$02,$07,$0B,$0D,$1E
        .BYTE $33,$6C,$DF,$EF,$73,$8F,$77,$AF
        .BYTE $FF,$7E,$BF,$CF,$F7,$B3,$DB,$77
        .BYTE $DF,$F7,$FF,$FF,$FF,$FE,$FD,$FC
        .BYTE $E3,$9A,$AF,$9B,$5F,$2E,$7F,$7B
        .BYTE $00,$00,$00,$00,$00,$01,$01,$00
        .BYTE $1C,$21,$0A,$57,$AE,$7C,$E8,$10
        .BYTE $2B,$1E,$40,$0A,$05,$02,$01,$00
        .BYTE $C4,$16,$AE,$5F,$7F,$AF,$56,$A1
        .BYTE $00,$00,$00,$00,$00,$80,$20,$70
        .BYTE $A9,$50,$20,$21,$52,$4A,$44,$9A
        .BYTE $12,$94,$89,$06,$09,$00,$12,$40
        .BYTE $28,$53,$4D,$B3,$4E,$94,$6F,$2C
        .BYTE $80,$88,$C1,$04,$40,$0B,$24,$14
        .BYTE $00,$00,$00,$00,$01,$00,$00,$03
        .BYTE $10,$2A,$55,$AF,$57,$AF,$17,$43
        .BYTE $5E,$2C,$82,$F8,$F0,$E0,$C0,$80
        .BYTE $1C,$42,$52,$AB,$55,$3F,$17,$00
        .BYTE $26,$09,$12,$15,$05,$0A,$01,$00
        .BYTE $80,$C0,$60,$A0,$D0,$68,$BE,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $0A,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$20,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $1B,$1D,$1A,$1D,$1A,$14,$18,$11
        .BYTE $87,$6F,$9C,$33,$4F,$3E,$FD,$FA
        .BYTE $C0,$04,$C0,$C0,$C0,$C0,$70,$AE
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$80,$C0,$E3
        .BYTE $03,$06,$0F,$1B,$2E,$7F,$DE,$D9
        .BYTE $C0,$E0,$F0,$F0,$78,$FC,$76,$F7
        .BYTE $00,$00,$00,$00,$00,$01,$01,$83
        .BYTE $3F,$2B,$5F,$6F,$B7,$6F,$5F,$FF
        .BYTE $C0,$F0,$F8,$FC,$FF,$FF,$FF,$FF
        .BYTE $00,$00,$00,$00,$80,$E0,$F8,$FF
        .BYTE $03,$00,$00,$00,$00,$00,$00,$80
        .BYTE $A0,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$04,$0E,$3D,$5F,$7D,$DB
        .BYTE $00,$00,$00,$00,$00,$00,$80,$80
        .BYTE $00,$00,$00,$00,$00,$00,$01,$06
        .BYTE $3D,$6D,$7B,$25,$1D,$76,$BF,$DF
        .BYTE $EF,$D6,$7B,$EB,$B7,$CF,$3D,$FE
        .BYTE $EF,$7F,$FF,$FF,$FF,$FF,$FE,$FC
        .BYTE $FA,$FB,$F4,$E7,$C3,$9D,$37,$9F
        .BYTE $BF,$7F,$FF,$FE,$EF,$FF,$FF,$77
        .BYTE $02,$07,$05,$0B,$0F,$01,$16,$2C
        .BYTE $E0,$40,$C0,$80,$00,$00,$00,$00
        .BYTE $24,$08,$10,$90,$64,$80,$20,$89
        .BYTE $0F,$3D,$1F,$37,$1E,$0B,$05,$03
        .BYTE $F0,$F8,$F8,$7C,$FC,$BE,$51,$87
        .BYTE $21,$12,$11,$29,$26,$11,$20,$01
        .BYTE $84,$F1,$AA,$D8,$E1,$E2,$D3,$0C
        .BYTE $3C,$19,$1C,$1A,$1B,$14,$14,$28
        .BYTE $48,$08,$67,$98,$04,$08,$08,$06
        .BYTE $06,$0F,$0D,$17,$1D,$3F,$47,$B0
        .BYTE $B8,$7E,$BC,$7E,$FC,$F8,$F0,$E0
        .BYTE $05,$02,$03,$04,$04,$49,$B2,$42
        .BYTE $07,$02,$03,$01,$00,$00,$00,$00
        .BYTE $40,$E0,$A0,$D0,$F0,$08,$68,$34
        .BYTE $7F,$3F,$8E,$C1,$E3,$DD,$F7,$FE
        .BYTE $FF,$FF,$FF,$7F,$BF,$1F,$4F,$33
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $03,$07,$0F,$1F,$3F,$7F,$7E,$F9
        .BYTE $F5,$EA,$D5,$AA,$57,$BC,$C0,$80
        .BYTE $55,$AA,$57,$BC,$C0,$00,$00,$00
        .BYTE $80,$E0,$80,$00,$00,$00,$00,$00
        .BYTE $E7,$F0,$FE,$FF,$FF,$FF,$E0,$0F
        .BYTE $BF,$DA,$37,$9D,$DB,$80,$3F,$FE
        .BYTE $DF,$FF,$7B,$F6,$FC,$01,$FF,$7F
        .BYTE $E6,$CB,$96,$3B,$D5,$BF,$FF,$FC
        .BYTE $F6,$FD,$F7,$EF,$FF,$FF,$FE,$3F
        .BYTE $FF,$FF,$FF,$EF,$FF,$FF,$7F,$FF
        .BYTE $FF,$7F,$DF,$FF,$FF,$FF,$0F,$F0
        .BYTE $C0,$E0,$F8,$FC,$FE,$FF,$FF,$3F
