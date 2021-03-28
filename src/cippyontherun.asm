
;---------------------------------------------------------------------------------
; LaunchCippyOnTheRun
;---------------------------------------------------------------------------------
LaunchCippyOnTheRun
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
j084E   JSR JumpToCheckSubGameSelection
        JSR s1994
        JMP j084E

;---------------------------------------------------------------------------------
; s0857
;---------------------------------------------------------------------------------
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
        STA COLOR_RAM + $0000,X
        STA COLOR_RAM + $02A8,X
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
        JSR ResetSomeDataAndClearMiddleScreen
        RTS 

;---------------------------------------------------------------------------------
; s08A2
;---------------------------------------------------------------------------------
s08A2   
        LDX #$00
b08A4   LDA f08BC,X
        STA rasterPositionArray,X
        LDA f08BF,X
        STA rasterJumpTableLoPtrArray,X
        LDA f08C2,X
        STA rasterJumpTableHiPtrArray,X
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
;---------------------------------------------------------------------------------
; s08C9
;---------------------------------------------------------------------------------
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
        JSR JumpToPlaySomeSounds
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
        JMP JumpToIncrementAndUpdateRaster

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
        JSR JumpToPlaySomeSounds
        JMP JumpToIncrementAndUpdateRaster

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
;---------------------------------------------------------------------------------
; s09FE
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; s0A58
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s0A6F
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s0B26
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s0C56
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s0C7B
;---------------------------------------------------------------------------------
s0C7B   
        ASL f0C,X
        RTS 

a0C7F   =*+$01
;---------------------------------------------------------------------------------
; s0C7E
;---------------------------------------------------------------------------------
s0C7E   
        LDA $FFFF    ;IRQ
        INC a0C7F
        RTS 

;---------------------------------------------------------------------------------
; s0C85
;---------------------------------------------------------------------------------
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
        STA COLOR_RAM + $0000,X
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
        STA COLOR_RAM + $02A8,X
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
;---------------------------------------------------------------------------------
; s0D7C
;---------------------------------------------------------------------------------
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
        .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
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
;---------------------------------------------------------------------------------
; s0E34
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s0ECC
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s0F6A
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s0F84
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; s0FBD
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; s102A
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; s103F
;---------------------------------------------------------------------------------
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
        STA COLOR_RAM + $02D4,X
        LDY a1072
        LDA f0C16,Y
        TAY 
        LDA f1073,Y
        STA COLOR_RAM + $0324,X
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
;---------------------------------------------------------------------------------
; s1097
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; s10F9
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s1113
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; s120F
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; s128A
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s12C3
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s12E1
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s1336
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; s136C
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; s1490
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; s14D6
;---------------------------------------------------------------------------------
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
b1519   STA COLOR_RAM + $0177,X
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

;---------------------------------------------------------------------------------
; s15EB
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s16E9
;---------------------------------------------------------------------------------
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
b16FE   STA COLOR_RAM + $0175,X
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
;---------------------------------------------------------------------------------
; s1803
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; s1821
;---------------------------------------------------------------------------------
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
        STA COLOR_RAM + $0170,X
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
;---------------------------------------------------------------------------------
; s18A2
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s1981
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s1994
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s19D7
;---------------------------------------------------------------------------------
s19D7   
        LDX a19F1
        CPX #$04
        BNE b19DF
        RTS 

b19DF   LDY f19F2,X
        LDA f19F6,X
        STA SCREEN_RAM + $0381,Y
        LDA #$07
        STA COLOR_RAM + $0381,Y
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
