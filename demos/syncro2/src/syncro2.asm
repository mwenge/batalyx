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
aC5 = $C5
;
; **** ZP POINTERS **** 
;
p02 = $02
p04 = $04
p06 = $06
p08 = $08
;
; **** FIELDS **** 
;
f0340 = $0340
f0360 = $0360
f0500 = $0500
f0600 = $0600
f0700 = $0700
f071F = $071F
f076F = $076F
f07BF = $07BF
f07DD = $07DD
f07F8 = $07F8
f2000 = $2000
f2100 = $2100
f2200 = $2200
f3000 = $3000
f3100 = $3100
f3200 = $3200
fD100 = $D100
fD800 = $D800
fD900 = $D900
fDA00 = $DA00
fDB00 = $DB00
fDB1F = $DB1F
fDB6F = $DB6F
fDBBF = $DBBF
;
; **** ABSOLUTE ADRESSES **** 
;
a0314 = $0314
a0315 = $0315
a0746 = $0746
a07C9 = $07C9
a07D3 = $07D3
aEF0C = $EF0C
;
; **** POINTERS **** 
;
p0220 = $0220
p0303 = $0303
p0400 = $0400
p06FA = $06FA

        * = $0801

        .BYTE $0B,$08,$0A,$00,$9E,$32,$30,$36
        .BYTE $31,$00,$00,$00
;-------------------------------------------------------------------------
; s080D
;-------------------------------------------------------------------------
s080D
        LDX #$00
b080F   LDA f1400,X
        STA f2200,X
        LDA f1460,X
        STA f3000,X
        LDA f1560,X
        STA f3100,X
        LDA f1660,X
        STA f3200,X
        DEX 
        BNE b080F
        LDA #$00
        STA $D404    ;Voice 1: Control Register
        STA $D40B    ;Voice 2: Control Register
        STA $D412    ;Voice 3: Control Register
        STA $D405    ;Voice 1: Attack / Decay Cycle Control
        STA $D40C    ;Voice 2: Attack / Decay Cycle Control
        STA $D413    ;Voice 3: Attack / Decay Cycle Control
        LDA #$01
        STA a10F8
        STA a10F7
        STA a1093
        LDA #$03
        STA a10F6
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
        JMP j0959

a086C   .BYTE $07
a086D   .BYTE $00
a086E   .BYTE $0B
a086F   .BYTE $3C
;-------------------------------------------------------------------------
; s0870
;-------------------------------------------------------------------------
s0870
        LDA #>p0400
        STA a03
        LDA #<p0400
        STA a02
        LDX #$18
        LDY #$00
b087C   LDA a02
        STA f0340,Y
        LDA a03
        STA f0360,Y
        LDA a02
        CLC 
        ADC #$28
        STA a02
        LDA a03
        ADC #$00
        STA a03
        INY 
        DEX 
        BNE b087C
        RTS 

;-------------------------------------------------------------------------
; s0898
;-------------------------------------------------------------------------
s0898
        LDY a086C
        LDX a086D
        LDA f0340,X
        STA a02
        LDA f0360,X
        STA a03
        LDA a086F
        STA (p02),Y
        LDA a03
        CLC 
        ADC #$D4
        STA a03
        LDA a086E
        STA (p02),Y
        RTS 

a08BA   .BYTE $00
a08BB   .BYTE $00
;-------------------------------------------------------------------------
; s08BC
;-------------------------------------------------------------------------
s08BC
        LDA #<p0303
        STA a08BA
b08C1   LDA #>p0303
        STA a08BB
b08C6   JSR s0898
        INC a086C
        DEC a08BB
        BNE b08C6
        DEC a086C
        DEC a086C
        DEC a086C
        INC a086D
        DEC a08BA
        BNE b08C1
        RTS 

f08E3   .BYTE $02,$08,$07,$05,$0E,$04,$06,$00
;-------------------------------------------------------------------------
; s08EB
;-------------------------------------------------------------------------
s08EB
        LDY #$00
b08ED   LDA (p04),Y
        CLC 
        ADC #$40
        STA a086F
        LDA (p04),Y
        TAX 
        LDA f08E3,X
        STA a086E
        TYA 
        AND #$07
        ASL 
        ASL 
        CLC 
        ADC #$04
        STA a086C
        TYA 
        ROR 
        AND #$3C
        STA a086D
        TYA 
        PHA 
        JSR s08BC
        PLA 
        TAY 
        INY 
        CPY #$28
        BNE b08ED
        RTS 

;-------------------------------------------------------------------------
; s091D
;-------------------------------------------------------------------------
s091D
        LDX #$00
b091F   LDA #$20
        STA p0400,X
        STA f0500,X
        STA f0600,X
        STA f0700,X
        LDA #$01
        STA fD800,X
        STA fD900,X
        STA fDA00,X
        STA fDB00,X
        DEX 
        BNE b091F
        LDA #$FF
        STA $D01C    ;Sprites Multi-Color Mode Select
        LDA #$00
        STA $D01D    ;Sprites Expand 2x Horizontal (X)
        STA $D017    ;Sprites Expand 2x Vertical (Y)
        STA a1095
        LDA #$06
        STA $D025    ;Sprite Multi-Color Register 0
        LDA #$0E
        STA $D026    ;Sprite Multi-Color Register 1
        RTS 

;-------------------------------------------------------------------------
; j0959
;-------------------------------------------------------------------------
j0959
        SEI 
        JSR s091D
        JSR s0F71
        JSR s1306
        JSR s0870
        JSR s0A1F
        JSR s0F19
        JSR s0ABE
;-------------------------------------------------------------------------
; j096F
;-------------------------------------------------------------------------
j096F
        JSR s117F
        JSR s10F9
        JSR s08EB
        CLI 
;-------------------------------------------------------------------------
; j0979
;-------------------------------------------------------------------------
j0979
        JSR s1096
        JMP j0979

p097F   .BYTE $00,$00,$00,$00,$00,$01,$01,$01
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
;-------------------------------------------------------------------------
; s0A1F
;-------------------------------------------------------------------------
s0A1F
        LDA #$00
        STA $D020    ;Border Color
        STA $D021    ;Background Color 0
        LDA #$18
        STA $D018    ;VIC Memory Control Register
        RTS 

;-------------------------------------------------------------------------
; s0A2D
;-------------------------------------------------------------------------
s0A2D
        TXA 
        PHA 
        LDA f0B19,X
        BEQ b0A4E
        TAX 
b0A35   LDY #$00
        LDA (p06),Y
        PHA 
b0A3A   INY 
        LDA (p06),Y
        DEY 
        STA (p06),Y
        INY 
        CPY #$07
        BNE b0A3A
        PLA 
        STA (p06),Y
        DEX 
        BNE b0A35
        PLA 
        TAX 
        PHA 
b0A4E   LDA f0B21,X
        BEQ b0A6B
        TAX 
b0A54   LDY #$07
        LDA (p06),Y
        PHA 
b0A59   DEY 
        LDA (p06),Y
        INY 
        STA (p06),Y
        DEY 
        BNE b0A59
        PLA 
        STA (p06),Y
        DEX 
        BNE b0A54
        PLA 
        TAX 
        PHA 
b0A6B   LDA f0B11,X
        BEQ b0A85
        TAX 
b0A71   LDY #$00
b0A73   LDA (p06),Y
        ASL 
        ADC #$00
        STA (p06),Y
        INY 
        CPY #$08
        BNE b0A73
        DEX 
        BNE b0A71
        PLA 
        TAX 
        PHA 
b0A85   LDA f0B09,X
        BEQ b0A9F
        TAX 
b0A8B   LDY #$00
b0A8D   LDA (p06),Y
        CLC 
        ROR 
        BCC b0A95
        ORA #$80
b0A95   STA (p06),Y
        INY 
        CPY #$08
        BNE b0A8D
        DEX 
        BNE b0A8B
b0A9F   PLA 
        TAX 
        RTS 

;-------------------------------------------------------------------------
; s0AA2
;-------------------------------------------------------------------------
s0AA2
        LDX #$00
b0AA4   LDA #$22
        STA a07
        LDA f0AB6,X
        STA a06
        JSR s0A2D
        INX 
        CPX #$08
        BNE b0AA4
        RTS 

f0AB6   .BYTE $00,$08,$10,$18,$20,$28,$30,$38
;-------------------------------------------------------------------------
; s0ABE
;-------------------------------------------------------------------------
s0ABE
        SEI 
        LDA $D011    ;VIC Control Register 1
        AND #$7F
        STA $D011    ;VIC Control Register 1
        LDA #$C0
        STA $D012    ;Raster Position
        LDA #$01
        STA $D019    ;VIC Interrupt Request Register (IRR)
        STA $D01A    ;VIC Interrupt Mask Register (IMR)
        LDA #<p0AE4
        STA a0314    ;IRQ
        LDA #>p0AE4
        STA a0315    ;IRQ
        LDA #$7F
        STA $DC0D    ;CIA1: CIA Interrupt Control Register
        RTS 

p0AE4   JSR s103A
        JSR s11CD
        JSR s0BB6
        JSR s0D56
        JSR s1285
        JSR s0AA2
        JSR s1341
        LDA #$FF
        STA $D012    ;Raster Position
        LDA #$01
        STA $D019    ;VIC Interrupt Request Register (IRR)
        STA $D01A    ;VIC Interrupt Mask Register (IMR)
        JMP $EA31

f0B09   .BYTE $00,$00,$00,$00,$00,$00,$00,$00
f0B11   .BYTE $00,$00,$00,$00,$00,$00,$00,$00
f0B19   .BYTE $00,$00,$00,$00,$00,$00,$00,$00
f0B21   .BYTE $00,$00,$00,$00,$00,$00,$00,$00
;-------------------------------------------------------------------------
; j0B29
;-------------------------------------------------------------------------
j0B29
        LDA a0BBE
        ASL 
        ASL 
        CLC 
        ADC #$03
        STA a086C
        LDA a0BBF
        ASL 
        ASL 
        STA a086D
        LDA #$3E
        STA a086F
        LDX a0BC0
        LDA f0C38,X
        STA a086E
        JSR s0898
        INC a086D
        JSR s0898
        INC a086D
        JSR s0898
        LDA a086C
        CLC 
        ADC #$04
        STA a086C
        LDA #$3C
        STA a086F
        JSR s0898
        DEC a086D
        JSR s0898
        DEC a086D
        JSR s0898
        RTS 

;-------------------------------------------------------------------------
; s0B77
;-------------------------------------------------------------------------
s0B77
        LDA a0BBE
        ASL 
        ASL 
        CLC 
        ADC #$03
        STA a086C
        LDA a0BBF
        ASL 
        ASL 
        STA a086D
        LDA #$20
        STA a086F
        JSR s0898
        INC a086D
        JSR s0898
        INC a086D
        JSR s0898
        LDA a086C
        CLC 
        ADC #$04
        STA a086C
        JSR s0898
        DEC a086D
        JSR s0898
        DEC a086D
        JMP s0898

;-------------------------------------------------------------------------
; s0BB6
;-------------------------------------------------------------------------
s0BB6
        DEC a0BBC
        BEQ b0BC2
        RTS 

a0BBC   .BYTE $03
a0BBD   .BYTE $7F
a0BBE   .BYTE $00
a0BBF   .BYTE $00
a0BC0   .BYTE $01
a0BC1   .BYTE $04
b0BC2   LDA #$03
        STA a0BBC
        JSR s0B77
        LDA $DC00    ;CIA1: Data Port Register A
        STA a0BBD
        INC a0BC0
        LDA a0BC0
        AND #$07
        STA a0BC0
        LDA a0BBD
        AND #$10
        BEQ b0C32
        LDA a0BBD
        AND #$01
        BNE b0BF8
        DEC a0BBF
        LDA a0BBF
        CMP #$FF
        BNE b0BF8
        LDA #$04
        STA a0BBF
b0BF8   LDA a0BBD
        AND #$02
        BNE b0C0E
        INC a0BBF
        LDA a0BBF
        CMP #$05
        BNE b0C0E
        LDA #$00
        STA a0BBF
b0C0E   LDA a0BBD
        AND #$04
        BNE b0C20
        DEC a0BBE
        LDA a0BBE
        AND #$07
        STA a0BBE
b0C20   LDA a0BBD
        AND #$08
        BNE b0C32
        INC a0BBE
        LDA a0BBE
        AND #$07
        STA a0BBE
b0C32   JSR s0C40
        JMP j0B29

f0C38   BRK #$0B
        .BYTE $0C,$0F,$01 ;NOP $010F
        .BYTE $0F,$0C,$0B ;SLO $0B0C
;-------------------------------------------------------------------------
; s0C40
;-------------------------------------------------------------------------
s0C40
        DEC a0C46
        BEQ b0C47
        RTS 

a0C46   .BYTE $03
b0C47   LDA #$03
        STA a0C46
        LDA a0BBD
        AND #$10
        BEQ b0C54
        RTS 

b0C54   LDA a0BBF
        ASL 
        ASL 
        ASL 
        ORA a0BBE
        TAY 
        LDA (p04),Y
        TAX 
        LDA a0BBD
        AND #$01
        BNE b0C84
        JSR s12D9
        LDA f0B21,X
        BEQ b0C76
        DEC f0B21,X
        JMP b0C84

b0C76   INC f0B19,X
        LDA f0B19,X
        CMP a0BC1
        BNE b0C84
        DEC f0B19,X
b0C84   LDA a0BBD
        AND #$02
        BNE b0CA7
        JSR s12EA
        LDA f0B19,X
        BEQ b0C99
        DEC f0B19,X
        JMP b0CA7

b0C99   INC f0B21,X
        LDA f0B21,X
        CMP a0BC1
        BNE b0CA7
        DEC f0B21,X
b0CA7   LDA a0BBD
        AND #$04
        BNE b0CC7
        LDA f0B09,X
        BEQ b0CB9
        DEC f0B09,X
        JMP b0CC7

b0CB9   INC f0B11,X
        LDA f0B11,X
        CMP a0BC1
        BNE b0CC7
        DEC f0B11,X
b0CC7   LDA a0BBD
        AND #$08
        BNE b0CE5
        LDA f0B11,X
        BEQ b0CD7
        DEC f0B11,X
        RTS 

b0CD7   INC f0B09,X
        LDA f0B09,X
        CMP a0BC1
        BNE b0CE5
        DEC f0B09,X
b0CE5   RTS 

f0CE6   .BYTE $01,$02,$04,$08,$10,$20,$40,$80
b0CEE   LDA f0CE6,X
        EOR #$FF
        AND $D015    ;Sprite display Enable
        STA $D015    ;Sprite display Enable
        RTS 

;-------------------------------------------------------------------------
; s0CFA
;-------------------------------------------------------------------------
s0CFA
        TXA 
        ASL 
        TAY 
        LDA f0D3E,X
        BEQ b0CEE
        ASL 
        STA $D000,Y  ;Sprite 0 X Pos
        BCC b0D14
        LDA f0CE6,X
        ORA $D010    ;Sprites 0-7 MSB of X coordinate
        STA $D010    ;Sprites 0-7 MSB of X coordinate
        JMP j0D1F

b0D14   LDA f0CE6,X
        EOR #$FF
        AND $D010    ;Sprites 0-7 MSB of X coordinate
        STA $D010    ;Sprites 0-7 MSB of X coordinate
;-------------------------------------------------------------------------
; j0D1F
;-------------------------------------------------------------------------
j0D1F
        LDA f0D46,X
        STA $D001,Y  ;Sprite 0 Y Pos
        LDA f0D4E,X
        STA f07F8,X
        LDY a0BC0
        LDA f0C38,Y
        STA $D027,X  ;Sprite 0 Color
        LDA f0CE6,X
        ORA $D015    ;Sprite display Enable
        STA $D015    ;Sprite display Enable
        RTS 

f0D3E   .BYTE $1A,$5B,$83,$00,$00,$00,$00,$00
f0D46   .BYTE $C8,$AE,$AD,$50,$60,$70,$80,$90
f0D4E   .BYTE $C0,$C1,$C2,$C3,$C4,$C5,$C6,$C7
;-------------------------------------------------------------------------
; s0D56
;-------------------------------------------------------------------------
s0D56
        LDX #$00
        LDA #$00
        ORA a1095
        STA a1094
b0D60   JSR s0CFA
        LDA f0D3E,X
        BEQ b0D71
        JSR s0D96
        JSR s0E95
        JSR s0E1A
b0D71   INX 
        CPX #$08
        BNE b0D60
        LDA a1094
        BNE b0D85
        LDA a1093
        BNE b0D85
        LDA #$01
        STA a1095
b0D85   RTS 

f0D86   .BYTE $01,$FD,$03,$00,$00,$00,$00,$00
f0D8E   .BYTE $FF,$01,$01,$01,$00,$00,$00,$00
;-------------------------------------------------------------------------
; s0D96
;-------------------------------------------------------------------------
s0D96
        DEC f0DFF,X
        BNE b0DD0
        LDA #$02
        STA f0DFF,X
        JSR s0E07
;-------------------------------------------------------------------------
; j0DA3
;-------------------------------------------------------------------------
j0DA3
        LDA f0D3E,X
        CLC 
        ADC f0D86,X
        STA f0D3E,X
        AND #$F8
        CMP #$08
        BEQ b0DB7
        CMP #$98
        BNE b0DD0
b0DB7   LDA f0D86,X
        EOR #$FF
        CLC 
        ADC #$01
        STA f0D86,X
        LDA f0E85,X
        EOR #$FF
        CLC 
        ADC #$01
        STA f0E85,X
        JMP j0DA3

b0DD0   LDA f0D46,X
        CLC 
        ADC f0D8E,X
        STA f0D46,X
        AND #$F0
        CMP #$10
        BEQ b0DE5
        CMP #$D0
        BEQ b0DE5
        RTS 

b0DE5   LDA f0D8E,X
        EOR #$FF
        CLC 
        ADC #$01
        STA f0D8E,X
        LDA f0E8D,X
        EOR #$FF
        CLC 
        ADC #$01
        STA f0E8D,X
        JMP b0DD0

        RTS 

f0DFF   .BYTE $02,$02,$02,$01,$01,$01,$01,$01
;-------------------------------------------------------------------------
; s0E07
;-------------------------------------------------------------------------
s0E07
        INC f0D4E,X
        LDA f0D4E,X
        CMP #$CA
        BEQ b0E12
        RTS 

b0E12   LDA #$C0
        STA f0D4E,X
        RTS 

a0E18   .BYTE $02
a0E19   .BYTE $10
;-------------------------------------------------------------------------
; s0E1A
;-------------------------------------------------------------------------
s0E1A
        TXA 
        PHA 
        LDA f0D3E,X
        BNE b0E24
        PLA 
        TAX 
        RTS 

b0E24   SEC 
        SBC #$08
        ROR 
        ROR 
        AND #$3F
        STA a0E18
        LDA f0D46,X
        SEC 
        SBC #$2C
        ROR 
        ROR 
        ROR 
        AND #$1F
        CLC 
        ADC #$00
        STA a0E19
        LDY a0E18
        LDX a0E19
        LDA f0340,X
        STA a02
        LDA f0360,X
        STA a03
        LDA (p02),Y
        CMP #$20
        BEQ b0E82
        SEC 
        SBC #$40
        STA a0E18
        AND #$F8
        BNE b0E82
        LDA a0E18
        TAY 
        PLA 
        TAX 
        PHA 
        LDA f0B09,Y
        CLC 
        ADC f0E85,X
        SEC 
        SBC f0B11,Y
        STA f0D86,X
        LDA f0B21,Y
        CLC 
        ADC f0E8D,X
        SEC 
        SBC f0B19,Y
        STA f0D8E,X
b0E82   PLA 
        TAX 
        RTS 

f0E85   .BYTE $01,$FD,$03,$00,$00,$00,$00,$00
f0E8D   .BYTE $FF,$01,$01,$01,$00,$00,$00,$00
;-------------------------------------------------------------------------
; s0E95
;-------------------------------------------------------------------------
s0E95
        LDA f0D86,X
        BEQ b0EA0
b0E9A   LDA #$01
        STA a1094
        RTS 

b0EA0   LDA f0D8E,X
        BNE b0E9A
        LDA f0ED4,X
        BNE b0EB3
        JSR s0EE5
        LDA #$FF
        STA f0ED4,X
        RTS 

b0EB3   CMP #$FF
        BNE b0EC6
        LDA a0EE4
        STA f0ED4,X
        LDA #$00
        STA f0EDC,X
        JSR s11FD
        RTS 

b0EC6   INC f0EDC,X
        BNE b0ECE
        DEC f0ED4,X
b0ECE   LDA #$0B
        STA $D027,X  ;Sprite 0 Color
        RTS 

f0ED4   .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
f0EDC   .BYTE $69,$0D,$20,$F5,$0E,$29,$07,$38
a0EE4   .BYTE $07
;-------------------------------------------------------------------------
; s0EE5
;-------------------------------------------------------------------------
s0EE5
        JSR s0F12
        AND #$07
        SEC 
        SBC #$03
        CMP #$04
        BNE b0EF3
        AND #$03
b0EF3   ORA #$01
        STA f0E85,X
        STA f0D86,X
        JSR s0F12
        AND #$07
        SEC 
        SBC #$03
        CMP #$04
        BNE b0F09
        AND #$03
b0F09   ORA #$01
        STA f0E8D,X
        STA f0D8E,X
        RTS 

a0F13   =*+$01
;-------------------------------------------------------------------------
; s0F12
;-------------------------------------------------------------------------
s0F12
        LDA aEF0C
        INC a0F13
        RTS 

;-------------------------------------------------------------------------
; s0F19
;-------------------------------------------------------------------------
s0F19
        LDA #>p06FA
        STA a09
        LDA #<p06FA
        STA a08
        LDY #$00
        LDX #$13
b0F25   LDA a08
        SEC 
        SBC #$28
        STA a08
        LDA a09
        SBC #$00
        STA a09
        LDA #$48
        STA (p08),Y
        DEX 
        BNE b0F25
        STA a0F3D
        RTS 

a0F3D   .TEXT "H"
;-------------------------------------------------------------------------
; s0F3E
;-------------------------------------------------------------------------
s0F3E
        SEI 
        LDA a01
        AND #$FB
        STA a01
        LDX #$00
        LDY #$03
b0F49   LDA $D000,X  ;Sprite 0 X Pos
        CPY #$02
        BNE b0F52
        AND #$0F
b0F52   STA f2000,X
        LDA fD100,X
        CPY #$02
        BNE b0F5E
        AND #$0F
b0F5E   STA f2100,X
        INY 
        TYA 
        AND #$07
        TAY 
        DEX 
        BNE b0F49
        LDA a01
        ORA #$04
        STA a01
        CLI 
        RTS 

;-------------------------------------------------------------------------
; s0F71
;-------------------------------------------------------------------------
s0F71
        JSR s0F3E
        LDX #$28
b0F76   LDA f0F99,X
        AND #$3F
        STA f076F,X
        LDA f0FC1,X
        AND #$0F
        STA fDB6F,X
        LDA f0FE9,X
        AND #$3F
        STA f07BF,X
        LDA f1011,X
        AND #$0F
        STA fDBBF,X
        DEX 
        BNE b0F76
f0F99   RTS 

        .TEXT " SYNCRO ][ *2D!*  BY YAK THE HAIRY....."
f0FC1   .TEXT "  DDDDDD GG CCCCC  AA DDD AAA AAAAAAAAAA"
f0FE9   .TEXT "   ROUND: 0  LEVEL: 0   SCORE: 00000000 "
f1011   .TEXT "   CCCCCC G  CCCCCC G   DDDDDD GGGGGGGG "
        .TEXT " "
;-------------------------------------------------------------------------
; s103A
;-------------------------------------------------------------------------
s103A
        LDA a1093
        BNE b1049
        LDA a1095
        BNE b1049
        DEC a104A
        BEQ b104B
b1049   RTS 

a104A   .TEXT $10
b104B   LDA #$40
        STA a104A
        INC a0F3D
        LDA a0F3D
        LDY #$00
        STA (p08),Y
        CMP #$4C
        BEQ b105F
b105E   RTS 

b105F   LDA #$20
        STA (p08),Y
        LDA #$48
        STA a0F3D
        LDA a08
        CLC 
        ADC #$28
        STA a08
        LDA a09
        ADC #$00
        STA a09
        LDA a08
        CMP #$FA
        BNE b105E
        LDA #$01
        STA a1093
        LDA #<p0220
        STA a11F9
        LDA #>p0220
        STA a11FA
        STA a11FB
        LDA #$01
        STA a11FC
        RTS 

a1093   .BYTE $01
a1094   .BYTE $01
a1095   .BYTE $00
;-------------------------------------------------------------------------
; s1096
;-------------------------------------------------------------------------
s1096
        LDA a1095
        BNE b109C
        RTS 

b109C   LDA #$08
        SEC 
        SBC a10F8
        STA a117E
        LDA a10F7
        CLC 
        ADC a10F6
        ASL 
        ASL 
        ASL 
        ASL 
        ORA a117E
        STA a117E
b10B6   JSR s1154
        JSR b104B
        JSR s11BA
        LDA a1093
        BEQ b10B6
        SEI 
        LDA #$00
        STA a1093
        JSR s0F19
        LDA #$00
        STA a1095
        INC a10F7
        LDA a10F7
        CMP #$03
        BNE b10F1
        LDA #$01
        STA a10F7
        INC a10F8
        LDY a10F8
        DEY 
        TYA 
        AND #$03
        STA a10F8
        INC a10F8
b10F1   PLA 
        PLA 
        JMP j096F

a10F6   .BYTE $03
a10F7   .BYTE $01
a10F8   .BYTE $01
;-------------------------------------------------------------------------
; s10F9
;-------------------------------------------------------------------------
s10F9
        LDX #$00
        TXA 
b10FC   STA f0B09,X
        STA f0B11,X
        STA f0B19,X
        STA f0B21,X
        INX 
        CPX #$08
        BNE b10FC
        LDA a10F7
        CLC 
        ADC #$30
        STA a07C9
        LDA a10F8
        CLC 
        ADC #$30
        STA a07D3
        LDA a10F6
        CLC 
        ADC #$30
        STA a0746
        LDY a10F7
        LDA f11B5,Y
        STA a0EE4
        LDA #<p097F
        STA a04
        LDA #>p097F
        STA a05
        LDY a10F8
        DEY 
        TYA 
        AND #$03
        TAY 
        BEQ b1153
b1143   LDA a04
        CLC 
        ADC #$28
        STA a04
        LDA a05
        ADC #$00
        STA a05
        DEY 
        BNE b1143
b1153   RTS 

;-------------------------------------------------------------------------
; s1154
;-------------------------------------------------------------------------
s1154
        LDA a117E
        AND #$0F
        TAX 
        LDA a117E
        ROR 
        ROR 
        ROR 
        ROR 
        AND #$0F
        TAY 
b1164   TXA 
        PHA 
b1166   INC f07DD,X
        LDA f07DD,X
        CMP #$3A
        BNE b1178
        LDA #$30
        STA f07DD,X
        DEX 
        BNE b1166
b1178   PLA 
        TAX 
        DEY 
        BNE b1164
        RTS 

a117E   .BYTE $00
;-------------------------------------------------------------------------
; s117F
;-------------------------------------------------------------------------
s117F
        LDX #$00
b1181   LDA #$00
        STA f0D3E,X
        STA f0D86,X
        STA f0E85,X
        LDA #$FF
        STA f0ED4,X
        INX 
        CPX #$08
        BNE b1181
        LDX #$00
b1198   JSR s0F12
        AND #$1F
        ADC #$30
        STA f0D3E,X
        JSR s0F12
        AND #$3F
        ADC #$40
        STA f0D46,X
        JSR s0EE5
        INX 
        CPX a10F6
        BNE b1198
f11B5   RTS 

        .BYTE $07,$05,$04,$03
;-------------------------------------------------------------------------
; s11BA
;-------------------------------------------------------------------------
s11BA
        TXA 
        PHA 
        TYA 
        PHA 
        LDX #$10
b11C0   LDY #$40
b11C2   DEY 
        BNE b11C2
        DEX 
        BNE b11C0
        PLA 
        TAY 
        PLA 
        TAX 
        RTS 

;-------------------------------------------------------------------------
; s11CD
;-------------------------------------------------------------------------
s11CD
        LDA a11F9
        BNE b11DB
;-------------------------------------------------------------------------
; j11D2
;-------------------------------------------------------------------------
j11D2
        LDA #$00
        STA $D020    ;Border Color
        STA $D021    ;Background Color 0
        RTS 

b11DB   LDA a11FB
        BNE b11F3
        LDA a11FA
        STA a11FB
        LDA a11FC
        STA $D020    ;Border Color
        STA $D021    ;Background Color 0
        DEC a11F9
        RTS 

b11F3   DEC a11FB
        JMP j11D2

a11F9   .BYTE $00
a11FA   .BYTE $00
a11FB   .BYTE $00
a11FC   .BYTE $00
;-------------------------------------------------------------------------
; s11FD
;-------------------------------------------------------------------------
s11FD
        JSR s0F12
        AND #$0F
        BNE b1206
        ORA #$01
b1206   STA a11FC
        JSR s0F12
        AND #$1F
        ADC #$08
        STA a11F9
        JSR s0F12
        AND #$07
        CLC 
        ADC #$02
        STA a11FA
        STA a11FB
        RTS 

f1222   .BYTE $04,$04,$04,$04,$05,$05,$05,$06
        .BYTE $06,$07,$07,$07,$08,$08,$09,$09
        .BYTE $0A,$0B,$0B,$0C,$0D,$0E,$0E,$0F
        .BYTE $10,$11,$12,$13,$15,$16,$17,$19
        .BYTE $1A,$1C,$1D,$1F,$21,$23,$25,$27
        .BYTE $2A,$2C,$2F,$32,$35,$38,$3B,$3F
f1252   .BYTE $30,$70,$B4,$FB,$47,$98,$ED,$47
        .BYTE $A7,$0C,$77,$E9,$61,$E1,$68,$F7
        .BYTE $8F,$30,$DA,$8F,$4E,$18,$EF,$D2
        .BYTE $C3,$C3,$D1,$E7,$1F,$60,$B5,$1E
        .BYTE $9C,$31,$DF,$A5,$87,$86,$A2,$DF
        .BYTE $3E,$C1,$6B,$3C,$39,$63,$BE,$4B
a1282   .BYTE $00,$00,$00
;-------------------------------------------------------------------------
; s1285
;-------------------------------------------------------------------------
s1285
        LDX a1282
        LDA f1222,X
        STA $D401    ;Voice 1: Frequency Control - High-Byte
        LDA f1252,X
        STA $D400    ;Voice 1: Frequency Control - Low-Byte
        LDA a0BBE
        AND #$07
        TAY 
        LDA f12FA,Y
        CLC 
        ADC a1282
        TAX 
        LDA f1252,X
        STA $D407    ;Voice 2: Frequency Control - Low-Byte
        LDA f1222,X
        STA $D408    ;Voice 2: Frequency Control - High-Byte
        LDA a0BBE
        CMP #$05
        BNE b12BE
        LDA f1252,X
        CLC 
        ADC #$03
        STA $D407    ;Voice 2: Frequency Control - Low-Byte
b12BE   LDA a0BBF
        AND #$03
        TAY 
        LDA f1302,Y
        CLC 
        ADC a1282
        TAX 
        LDA f1252,X
        STA $D40E    ;Voice 3: Frequency Control - Low-Byte
        LDA f1222,X
        STA $D40F    ;Voice 3: Frequency Control - High-Byte
        RTS 

;-------------------------------------------------------------------------
; s12D9
;-------------------------------------------------------------------------
s12D9
        INC a1282
        LDA a1282
        CMP #$18
        BEQ b12E4
b12E3   RTS 

b12E4   LDA #$00
        STA a1282
        RTS 

;-------------------------------------------------------------------------
; s12EA
;-------------------------------------------------------------------------
s12EA
        DEC a1282
        LDA a1282
        CMP #$FF
        BNE b12E3
        LDA #$17
        STA a1282
        RTS 

f12FA   .BYTE $03,$04,$0F,$10,$18,$00,$03,$04
f1302   .BYTE $07,$08,$13,$14
;-------------------------------------------------------------------------
; s1306
;-------------------------------------------------------------------------
s1306
        LDX #$28
b1308   LDA f1318,X
        AND #$3F
        STA f071F,X
        LDA #$01
        STA fDB1F,X
        DEX 
        BNE b1308
f1318   RTS 

        .TEXT "  F1: START   F7: SKILL   SKILL LEVEL 0 "
;-------------------------------------------------------------------------
; s1341
;-------------------------------------------------------------------------
s1341
        LDA a1093
        BNE b1347
        RTS 

b1347   LDA aC5
        CMP #$04
        BNE b1375
        LDX #$28
        LDA #$01
b1351   STA fDB1F,X
        DEX 
        BNE b1351
        LDA #$00
        STA a1093
        STA a1095
        LDA #$01
        STA a10F7
        STA a10F8
        LDX #$08
        LDA #$30
b136B   STA f07DD,X
        DEX 
        BNE b136B
        JSR s0F19
b1374   RTS 

b1375   CMP #$03
        BNE b1396
        LDA a13AF
        BNE b1374
        INC a10F6
        LDA a10F6
        STA a13AF
        CMP #$08
        BNE b1390
        LDA #$01
        STA a10F6
b1390   JSR s10F9
        JMP s117F

b1396   CMP #$40
        BEQ b139B
        RTS 

b139B   LDA #$00
        STA a13AF
        LDY a0BC0
        LDA f0C38,Y
        LDX #$28
b13A8   STA fDB1F,X
        DEX 
        BNE b13A8
        RTS 

a13AF   .BYTE $00,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .BYTE $FF

f1400
        .BYTE $F0,$F0,$F0,$F0,$0F,$0F,$0F,$0F   ;.BYTE $F0,$F0,$F0,$F0,$0F,$0F,$0F,$0F
                                                ; CHARACTER $00
                                                ; 11110000   ****    
                                                ; 11110000   ****    
                                                ; 11110000   ****    
                                                ; 11110000   ****    
                                                ; 00001111       ****
                                                ; 00001111       ****
                                                ; 00001111       ****
                                                ; 00001111       ****
        .BYTE $FF,$E7,$C3,$00,$00,$C3,$E7,$FF   ;.BYTE $FF,$E7,$C3,$00,$00,$C3,$E7,$FF
                                                ; CHARACTER $01
                                                ; 11111111   ********
                                                ; 11100111   ***  ***
                                                ; 11000011   **    **
                                                ; 00000000           
                                                ; 00000000           
                                                ; 11000011   **    **
                                                ; 11100111   ***  ***
                                                ; 11111111   ********
        .BYTE $BF,$3B,$B1,$B1,$C1,$ED,$ED,$C9   ;.BYTE $BF,$3B,$B1,$B1,$C1,$ED,$ED,$C9
                                                ; CHARACTER $02
                                                ; 10111111   * ******
                                                ; 00111011     *** **
                                                ; 10110001   * **   *
                                                ; 10110001   * **   *
                                                ; 11000001   **     *
                                                ; 11101101   *** ** *
                                                ; 11101101   *** ** *
                                                ; 11001001   **  *  *
        .BYTE $E7,$CF,$9F,$3E,$7C,$F9,$F3,$E7   ;.BYTE $E7,$CF,$9F,$3E,$7C,$F9,$F3,$E7
                                                ; CHARACTER $03
                                                ; 11100111   ***  ***
                                                ; 11001111   **  ****
                                                ; 10011111   *  *****
                                                ; 00111110     ***** 
                                                ; 01111100    *****  
                                                ; 11111001   *****  *
                                                ; 11110011   ****  **
                                                ; 11100111   ***  ***
        .BYTE $FF,$E7,$E7,$C3,$C3,$81,$81,$FF   ;.BYTE $FF,$E7,$E7,$C3,$C3,$81,$81,$FF
                                                ; CHARACTER $04
                                                ; 11111111   ********
                                                ; 11100111   ***  ***
                                                ; 11100111   ***  ***
                                                ; 11000011   **    **
                                                ; 11000011   **    **
                                                ; 10000001   *      *
                                                ; 10000001   *      *
                                                ; 11111111   ********
        .BYTE $18,$3C,$7E,$FF,$FF,$7E,$3C,$18   ;.BYTE $18,$3C,$7E,$FF,$FF,$7E,$3C,$18
                                                ; CHARACTER $05
                                                ; 00011000      **   
                                                ; 00111100     ****  
                                                ; 01111110    ****** 
                                                ; 11111111   ********
                                                ; 11111111   ********
                                                ; 01111110    ****** 
                                                ; 00111100     ****  
                                                ; 00011000      **   
        .BYTE $FF,$FF,$C3,$C3,$C3,$C3,$FF,$FF   ;.BYTE $FF,$FF,$C3,$C3,$C3,$C3,$FF,$FF
                                                ; CHARACTER $06
                                                ; 11111111   ********
                                                ; 11111111   ********
                                                ; 11000011   **    **
                                                ; 11000011   **    **
                                                ; 11000011   **    **
                                                ; 11000011   **    **
                                                ; 11111111   ********
                                                ; 11111111   ********
        .BYTE $FF,$FF,$03,$03,$F3,$F3,$33,$33   ;.BYTE $FF,$FF,$03,$03,$F3,$F3,$33,$33
                                                ; CHARACTER $07
                                                ; 11111111   ********
                                                ; 11111111   ********
                                                ; 00000011         **
                                                ; 00000011         **
                                                ; 11110011   ****  **
                                                ; 11110011   ****  **
                                                ; 00110011     **  **
                                                ; 00110011     **  **
        .BYTE $FF,$DB,$BD,$81,$DB,$C3,$E7,$FF   ;.BYTE $FF,$DB,$BD,$81,$DB,$C3,$E7,$FF
                                                ; CHARACTER $08
                                                ; 11111111   ********
                                                ; 11011011   ** ** **
                                                ; 10111101   * **** *
                                                ; 10000001   *      *
                                                ; 11011011   ** ** **
                                                ; 11000011   **    **
                                                ; 11100111   ***  ***
                                                ; 11111111   ********
        .BYTE $00,$00,$FF,$DB,$BD,$81,$DB,$C3   ;.BYTE $00,$00,$FF,$DB,$BD,$81,$DB,$C3
                                                ; CHARACTER $09
                                                ; 00000000           
                                                ; 00000000           
                                                ; 11111111   ********
                                                ; 11011011   ** ** **
                                                ; 10111101   * **** *
                                                ; 10000001   *      *
                                                ; 11011011   ** ** **
                                                ; 11000011   **    **
        .BYTE $00,$00,$00,$00,$FF,$DB,$BD,$81   ;.BYTE $00,$00,$00,$00,$FF,$DB,$BD,$81
                                                ; CHARACTER $0a
                                                ; 00000000           
                                                ; 00000000           
                                                ; 00000000           
                                                ; 00000000           
                                                ; 11111111   ********
                                                ; 11011011   ** ** **
                                                ; 10111101   * **** *
                                                ; 10000001   *      *
        .BYTE $00,$00,$00,$00,$00,$00,$FF,$DB   ;.BYTE $00,$00,$00,$00,$00,$00,$FF,$DB
                                                ; CHARACTER $0b
                                                ; 00000000           
                                                ; 00000000           
                                                ; 00000000           
                                                ; 00000000           
                                                ; 00000000           
                                                ; 00000000           
                                                ; 11111111   ********
                                                ; 11011011   ** ** **

.include "sprites.asm"

        .BYTE $08,$4C,$48,$4C,$04,$FF,$EA,$FF
        .BYTE $00,$FF,$00,$FF,$40,$FF,$00,$DF
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00
        .BYTE $00,$00,$00,$00,$00,$00,$00,$00

