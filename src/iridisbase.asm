
;---------------------------------------------------------------------------------
; LaunchIridisBase ($4288)
;---------------------------------------------------------------------------------
LaunchIridisBase
        LDA $D011    ;VIC Control Register 1
        AND #$6F
        STA $D011    ;VIC Control Register 1
        JSR ResetSomeDataAndClearMiddleScreen
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
        STA rasterPositionArray,X
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
        STA rasterJumpTableLoPtrArray
        LDA #$44
        STA rasterJumpTableHiPtrArray
        LDA #$4A
        STA rasterJumpTableLoPtr3
        LDA #$45
        STA rasterJumpTableHiPtr3
        LDA #$7E
        STA rasterJumpTableLoPtr2
        LDA #$4F
        STA rasterJumpTableHiPtr2
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
        JMP IncrementAndUpdateRaster

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
b4486   JMP IncrementAndUpdateRaster

a4489   .BYTE $0D
a448A   .BYTE $AD
a448B   .BYTE $F4
f448C   .BYTE $FD,$FE,$00,$02,$00,$FE
f4492   .BYTE $FE,$FF,$00,$01,$00,$FF
f4498   .BYTE $C0,$C1,$C2,$C3,$C2,$C1
a449E   .BYTE $18
a449F   .BYTE $6D
;---------------------------------------------------------------------------------
; s44A0
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s44ED
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s451E
;---------------------------------------------------------------------------------
s451E   
        JSR s4584
        LDA #<SCREEN_RAM + $0209
        STA currentCharYPos
        LDA #>SCREEN_RAM + $0209
        STA a06
b4529   LDY currentCharYPos
        LDA f5A54,Y
        STA currentChar
        LDA #$00
        STA currentCharXPos
b4534   JSR WriteCurrentCharToScreen
        INC currentCharXPos
        LDA currentCharXPos
        CMP #$28
        BNE b4534
        INC currentCharYPos
        LDA currentCharYPos
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
        JMP IncrementAndUpdateRaster

;---------------------------------------------------------------------------------
; InitializeRasterJumpTablePtrArray
;---------------------------------------------------------------------------------
InitializeRasterJumpTablePtrArray   
        LDX #$00
b4574   LDA #$46
        STA rasterJumpTableLoPtrArray,X
        LDA #$42
        STA rasterJumpTableHiPtrArray,X
        INX 
        CPX #$0C
        BNE b4574
        RTS 

;---------------------------------------------------------------------------------
; s4584
;---------------------------------------------------------------------------------
s4584   
        LDA #>p00
        STA currentCharYPos
b4588   LDA #<p00
        STA currentCharXPos
        LDY currentCharYPos
        LDA f44E4,Y
        STA a06
b4593   JSR GetCurrentChar
        STA currentChar
        JSR WriteCurrentCharToScreen
        INC currentCharXPos
        LDA currentCharXPos
        CMP #$28
        BNE b4593
        INC currentCharYPos
        LDA currentCharYPos
        CMP #$09
        BNE b4588
        RTS 

;---------------------------------------------------------------------------------
; s45AC
;---------------------------------------------------------------------------------
s45AC   
        LDA #$1E
        SEC 
        SBC a0D
        TAY 
        LDA #$01
        STA COLOR_RAM + $0000,Y
        STA COLOR_RAM + $0001,Y
        STA COLOR_RAM + $0028,Y
        STA COLOR_RAM + $0029,Y
        STA COLOR_RAM + $0027,Y
        STA COLOR_RAM + $002A,Y
        RTS 

;---------------------------------------------------------------------------------
; s45C7
;---------------------------------------------------------------------------------
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
        STA COLOR_RAM + $0000,Y
        STA COLOR_RAM + $0001,Y
        STA COLOR_RAM + $0028,Y
        STA COLOR_RAM + $0029,Y
        STA COLOR_RAM + $0027,Y
        STA COLOR_RAM + $002A,Y
        RTS 

a45F1   .BYTE $01
f45F2   .BYTE $01,$0F,$0C,$0B
        .BYTE $0B,$0C ;ANC #$0C
        .BYTE $0F,$01
b45FA   PLA 
        PLA 
        RTS 

;---------------------------------------------------------------------------------
; s45FD
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; s4653
;---------------------------------------------------------------------------------
s4653   
        LDA $DC00    ;CIA1: Data Port Register A
        STA a10
        RTS 

;---------------------------------------------------------------------------------
; s4659
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; s46BA
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; s4733
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; PlaySomeSounds   
;---------------------------------------------------------------------------------
PlaySomeSounds   
        LDY #$00
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
;---------------------------------------------------------------------------------
; s48F8
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s497D
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s49FD
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s4AFC
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; InitializeVariablesInterruptsDrawRainbow
;---------------------------------------------------------------------------------
InitializeVariablesInterruptsDrawRainbow   
        LDA #$36
        STA RAM_ACCESS_MODE
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
        LDA #<StubInterruptHandler
        STA $0318    ;NMI
        LDA #>StubInterruptHandler
        STA $0319    ;NMI
        LDA #$80
        STA $0291
        CLI 

        JSR DrawRainbowDivider
        RTS 

a4B68   .BYTE $00
;---------------------------------------------------------------------------------
; CheckSubGameSelection
;---------------------------------------------------------------------------------
CheckSubGameSelection
        LDA a4CE8
        BEQ b4B74
        LDX #$F8
        TXS 
        JMP HB_ResetRasterJumpTable

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

;---------------------------------------------------------------------------------
; DrawGameIconPanel
;---------------------------------------------------------------------------------
DrawGameIconPanel   
        JSR WriteCurrentCharToScreen
        INC currentCharYPos
        INC currentChar
        JSR WriteCurrentCharToScreen
        INC currentChar
        DEC currentCharYPos
        INC currentCharXPos
        JSR WriteCurrentCharToScreen
        INC currentChar
        INC currentCharYPos
        JMP WriteCurrentCharToScreen

f4BBD   .BYTE $01,$03,$05,$07,$09,$0B
f4BC3   .BYTE $B9,$82,$7A,$B5,$7E,$76
;---------------------------------------------------------------------------------
; UpdateGameIconsPanel
;---------------------------------------------------------------------------------
UpdateGameIconsPanel   
        LDX #$00
b4BCB   LDA #$0B
        STA a06
        CPX selectedSubGame
        BNE b4BD8

        LDA #$01
        STA a06
b4BD8   LDA f4BBD,X
        STA currentCharXPos
        LDA f4BC3,X
        STA currentChar
        LDA #$16
        STA currentCharYPos
        TXA 
        PHA 
        JSR DrawGameIconPanel
        PLA 
        TAX 
        INX 
        CPX #$06
        BNE b4BCB
        RTS 

keyPressToSubGameMap   .BYTE $38,$3B,$08,$0B,$10,$13
;---------------------------------------------------------------------------------
; DrawRainbowDivider
;---------------------------------------------------------------------------------
DrawRainbowDivider   
        LDA #$27
        STA a41AF
        TAX 
b4BFF   LDA #$3F
        STA SCREEN_RAM + $0348,X
        LDA RainbowDividerColors,X
        STA COLOR_RAM + $0348,X
        DEX 
        BNE b4BFF
        LDX #$08
b4C0F   LDA #$30
        STA SCREEN_RAM + $03B6,X
        DEX 
        BNE b4C0F
        RTS 

RainbowDividerColors=*-$01
        .BYTE $02,$02,$02,$02,$02,$02,$08,$08
        .BYTE $08,$08,$08,$07,$07,$07,$07,$07
        .BYTE $05,$05,$05,$05,$05,$05,$0E,$0E
        .BYTE $0E,$0E,$0E,$04,$04,$04,$04,$04
        .BYTE $06,$06,$06,$06,$06,$06

a4C3E   .BYTE $40
a4C3F   .BYTE $04
;---------------------------------------------------------------------------------
; j4C40
;---------------------------------------------------------------------------------
j4C40
        DEC a4C3E
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
;---------------------------------------------------------------------------------
; s4C88
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; s4CA1
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; s4CBA
;---------------------------------------------------------------------------------
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

StubInterruptHandler
        RTI

f4CEA   .BYTE $A9
a4CEB   .BYTE $0F
a4CEC   .BYTE $8D
a4CED   .BYTE $00
;---------------------------------------------------------------------------------
; s4CEE
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s4D78
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s4DAF
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s4DF9
;---------------------------------------------------------------------------------
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
b4E37   LDA screenLinesLoPtr
        STA screenLinesLoPtrArray,X
        LDA screenLinesHiPtr
        STA screenLinesHiPtrArray,X
        LDA screenLinesLoPtr
        CLC 
        ADC #$28
        STA screenLinesLoPtr
        LDA screenLinesHiPtr
        ADC #$00
        STA screenLinesHiPtr
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
        STA COLOR_RAM + $02F0,X
        DEX 
        BNE b4E56
        RTS 

        LDX currentCharYPos
        LDY currentCharXPos
        LDA screenLinesLoPtrArray,X
        STA screenLinesLoPtr
        LDA screenLinesHiPtrArray,X
        STA screenLinesHiPtr
        RTS 

        JSR GetCurrentCharAddress
        LDA (screenLinesLoPtr),Y
        RTS 

        JSR GetCurrentCharAddress
        LDA currentChar
        STA (screenLinesLoPtr),Y
        LDA screenLinesHiPtr
        PHA 
        CLC 
        ADC #$D4
f4E8F   STA screenLinesHiPtr
        LDA a06
        STA (screenLinesLoPtr),Y
        PLA 
        STA screenLinesHiPtr
        RTS 

        .BYTE $00
        JSR InitializeScreenLinePtrArray
        JSR ClearScreen
        JSR DrawSomethingOnSecondLastLine
        LDA $D016    ;VIC Control Register 2
        AND #$F0
        STA $D016    ;VIC Control Register 2
        JSR InitializeVariablesInterruptsDrawRainbow
        JSR SetUpInterrupts
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
;---------------------------------------------------------------------------------
; s4ED0
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s4EF0
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s4F77
;---------------------------------------------------------------------------------
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
        JSR PlaySomeSounds
        JSR $FF9F ;$FF9F - scan keyboard                    
        JSR s49FD
        JMP IncrementAndUpdateRaster

a4FAF   .BYTE $01
a4FB0   .BYTE $00
;---------------------------------------------------------------------------------
; s4FB1
;---------------------------------------------------------------------------------
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
        STA COLOR_RAM + $01F7,Y
        STA COLOR_RAM + $0297,Y
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
b5015   STA COLOR_RAM + $0247,X
        STA COLOR_RAM + $026F,X
        STA COLOR_RAM + $021F,X
        INX 
        CPX #$0F
        BNE b5015
        RTS 

a5024   .TEXT $00
a5025   .TEXT $02
a5026   .TEXT $10
a5027   .TEXT $00
a5028   .BYTE $01
;---------------------------------------------------------------------------------
; s5029
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s5042
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; s5055
;---------------------------------------------------------------------------------
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
        LDA #<COLOR_RAM + $0213
        STA a17
        LDA #>COLOR_RAM + $0213
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
;---------------------------------------------------------------------------------
; s50FF
;---------------------------------------------------------------------------------
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
b5170   JMP IncrementAndUpdateRaster

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
;---------------------------------------------------------------------------------
; s520C
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s5254
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s52BF
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; s5362
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s53C2
;---------------------------------------------------------------------------------
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
;----------------------------------------------------------------
; j542B
;----------------------------------------------------------------
j542B
        LDY a4141
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
;---------------------------------------------------------------------------------
; s5460
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s54B5
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s550D
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s5586
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; s55A0
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s55E4
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; s55FC
;---------------------------------------------------------------------------------
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
        STA COLOR_RAM + $00C8,X
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
j56C3   LDA #<COLOR_RAM + $0000
        STA a1F
        LDA #>COLOR_RAM + $0000
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

;---------------------------------------------------------------------------------
; s5721
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; DrawSomethingOnSecondLastLine
;---------------------------------------------------------------------------------
DrawSomethingOnSecondLastLine   
        LDX #$00
b574F   LDA f5762,X
        AND #$3F
        STA SCREEN_RAM + $0398,X
        LDA #$01
        STA COLOR_RAM + $0398,X
        INX 
        CPX #$28
        BNE b574F
        RTS 

f5762   .BYTE $A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0
        .BYTE $A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0
        .BYTE $A0,$A0,$A0,$A0,$A0,$A0,$A0,$A7
        .BYTE $D3,$C3,$CF,$D2,$C5,$A7,$A0,$B0
        .BYTE $B0,$B0,$B0,$B0,$B0,$B0,$B0,$A0
;---------------------------------------------------------------------------------
; j578A   
;---------------------------------------------------------------------------------
j578A   
        TXA 
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
;---------------------------------------------------------------------------------
; s57DE
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s5827
;---------------------------------------------------------------------------------
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
p5877   .TEXT "BONUS FOR ANY  PHOSPHENES LEFT"
f5895   .BYTE $88,$0F,$99,$01,$40,$21,$F8,$08
        .BYTE $00,$01,$10,$30,$FE,$0C,$00,$01
        .BYTE $00,$01
f58A7   .BYTE $8F,$0F,$BB,$03,$03,$21,$00,$40
        .BYTE $00,$01,$20,$80,$0C,$05,$04,$04
        .BYTE $00,$01,$A2,$00,$CA,$D0,$FD,$60
a58BF   .BYTE $00
;---------------------------------------------------------------------------------
; s58C0
;---------------------------------------------------------------------------------
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
p593D   .TEXT "!!! PERFECT !!!BONUS OF 106000"
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
;---------------------------------------------------------------------------------
; j59ED
;---------------------------------------------------------------------------------
j59ED
        DEC a5A5C
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

;---------------------------------------------------------------------------------
; s5A29
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s5A7B
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s5AEB
;---------------------------------------------------------------------------------
s5AEB   
        LDX #$00
b5AED   LDY f5B01,X
        LDA f5B05,X
        STA SCREEN_RAM + $037D,Y
        LDA #$03
        STA COLOR_RAM + $037D,Y
        INX 
        CPX #$04
        BNE b5AED
        RTS 

f5B01   .BYTE $00,$28,$01,$29
f5B05   .BYTE $99,$9A,$9B,$9C
