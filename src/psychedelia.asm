
;---------------------------------------------------------------------------------
; LaunchPsychedelia
;---------------------------------------------------------------------------------
LaunchPsychedelia
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

;---------------------------------------------------------------------------------
; s781A
;---------------------------------------------------------------------------------
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
        STA currentCharYPos
        LDA #$63
        STA currentChar
        LDA a78DF
        STA a06
b783B   LDA #$00
        STA currentCharXPos
b783F   JSR WriteCurrentCharToScreen
        LDA currentCharYPos
        PHA 
        SEC 
        SBC #$0A
        STA currentCharYPos
        LDA currentChar
        PHA 
        CLC 
        CLC 
        ADC #$5D
        STA currentChar
        JSR WriteCurrentCharToScreen
        PLA 
        STA currentChar
        PLA 
        STA currentCharYPos
        INC currentCharXPos
        LDA currentCharXPos
        CMP #$28
        BNE b783F
        INC currentChar
        INC currentCharYPos
        LDA currentCharYPos
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
        STA COLOR_RAM + $0140,X
        INX 
        CPX #$50
        BNE b7891
        RTS 

;---------------------------------------------------------------------------------
; s78A2
;---------------------------------------------------------------------------------
s78A2   
        LDX #$00
b78A4   LDA f78BC,X
        STA rasterPositionArray,X
        LDA f78BF,X
        STA rasterJumpTableLoPtrArray,X
        LDA f78C2,X
        STA rasterJumpTableHiPtrArray,X
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
        JMP JumpToIncrementAndUpdateRaster

a78DF   .BYTE $0B
a78E0   .BYTE $15
a78E1   .BYTE $0B
a78E2   .BYTE $01
;---------------------------------------------------------------------------------
; s78E3
;---------------------------------------------------------------------------------
s78E3   
        LDY a78E0
        LDX a78E1
        LDA screenLinesLoPtrArray,X
        STA a23
        LDA screenLinesHiPtrArray,X
        CLC 
        ADC #$D4
        STA a24
        LDA a78E2
        STA (p23),Y
        RTS 

;---------------------------------------------------------------------------------
; s78FC
;---------------------------------------------------------------------------------
s78FC   
        LDA a78DF
        STA a78E2
        JSR s78E3
        JSR s7911
        LDA #$01
        STA a78E2
        JSR s78E3
        RTS 

;---------------------------------------------------------------------------------
; s7911
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s797E
;---------------------------------------------------------------------------------
s797E   
        LDX a79BF
        LDY a79C0
        LDA screenLinesLoPtrArray,X
        STA a25
        LDA screenLinesHiPtrArray,X
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
;---------------------------------------------------------------------------------
; s79C1
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s7A4A
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s7C45
;---------------------------------------------------------------------------------
s7C45   
        LDX #$00
b7C47   LDA #$08
        STA f7C05,X
        INX 
        CPX #$40
        BNE b7C47
b7C51   RTS 

;---------------------------------------------------------------------------------
; s7C52
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s7C8F
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s7CD6
;---------------------------------------------------------------------------------
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
        JMP JumpToCheckSubGameSelection

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
b7D4E   LDA COLOR_RAM + $0000,X
        JSR s7D73
        STA COLOR_RAM + $0000,X
        LDA COLOR_RAM + $0100,X
        JSR s7D73
        STA COLOR_RAM + $0100,X
        LDA COLOR_RAM + $01D0,X
        JSR s7D73
        STA COLOR_RAM + $01D0,X
        DEX 
        BNE b7D4E
        LDA #$01
        STA a7D26
        CLI 
b7D72   RTS 

;---------------------------------------------------------------------------------
; s7D73
;---------------------------------------------------------------------------------
s7D73   
        AND #$0F
        CMP a7D7E
        BNE b7D72
        LDA a78DF
        RTS 

a7D7E   .BYTE $00
;---------------------------------------------------------------------------------
; s7D7F
;---------------------------------------------------------------------------------
s7D7F   
        LDX #$00
b7D81   LDA f7D94,X
        AND #$3F
        STA SCREEN_RAM + $0320,X
        LDA #$0B
        STA COLOR_RAM + $0320,X
        INX 
        CPX #$28
        BNE b7D81
        RTS 

f7D94   .TEXT "*** KLINGE MODE *** HAVE FUN- USE S,C,F1"
f7DBC   .TEXT "      SYMMETRY .... CURSOR SPEED 0      "
;---------------------------------------------------------------------------------
; s7DE4
;---------------------------------------------------------------------------------
s7DE4   
        LDX #$00
b7DE6   LDA f7DBC,X
        AND #$3F
        STA SCREEN_RAM + $02D0,X
        LDA #$0B
        STA COLOR_RAM + $02D0,X
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

;---------------------------------------------------------------------------------
; s8113
;---------------------------------------------------------------------------------
s8113   
        JSR s8116
;---------------------------------------------------------------------------------
; s8116
;---------------------------------------------------------------------------------
s8116   
        JSR s813C
        BEQ b8137
b811B   PLA 
        PLA 
j811D   INC a3B
        BEQ b8124
        JMP j807E

b8124   JMP j85C0

;---------------------------------------------------------------------------------
; s8127
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; s813C
;---------------------------------------------------------------------------------
s813C   
        STX a3C
        LDX a3A
        CMP $0210,X
        RTS 

;---------------------------------------------------------------------------------
; s8144
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; s8157
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; s8167
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s81A1
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; s82AB
;---------------------------------------------------------------------------------
s82AB   
        LDA aC1
        STA $0120
        LDA aC2
        STA $0121
        RTS 

;---------------------------------------------------------------------------------
; s82B6
;---------------------------------------------------------------------------------
s82B6   
        LDA $0129
        LDY $012A
        JMP j82C3

;---------------------------------------------------------------------------------
; s82BF
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; s82DC
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; s82F0
;---------------------------------------------------------------------------------
s82F0   
        JSR s8309
        STA aC3
        STX aC4
;---------------------------------------------------------------------------------
; s82F7
;---------------------------------------------------------------------------------
s82F7   
        JSR s853F
        BCC b8300
        STA aC3
        STX aC4
b8300   RTS 

;---------------------------------------------------------------------------------
; s8301
;---------------------------------------------------------------------------------
s8301   
        JSR s853F
b8304   STA aC1
        STX aC2
        RTS 

;---------------------------------------------------------------------------------
; s8309
;---------------------------------------------------------------------------------
s8309   
        JSR s853F
        BCS b8304
b830E   JMP j85C0

;---------------------------------------------------------------------------------
; s8311
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; s832D
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; s8349
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s8389
;---------------------------------------------------------------------------------
s8389   
        LDA #$3A
        JSR s84E3
b838E   LDA #$08
        JSR s82DC
        LDA #$07
        BNE b83CC
;---------------------------------------------------------------------------------
; s8397
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s83C2
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; s83DE
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; s8442
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; s84E3
;---------------------------------------------------------------------------------
s84E3   
        STA a39
;---------------------------------------------------------------------------------
; s84E5
;---------------------------------------------------------------------------------
s84E5   
        LDA a39
        JSR s8522
;---------------------------------------------------------------------------------
; s84EA
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s8502
;---------------------------------------------------------------------------------
s8502   
        PHA 
        LSR 
        LSR 
        LSR 
        LSR 
        JSR s850D
        PLA 
        AND #$0F
;---------------------------------------------------------------------------------
; s850D
;---------------------------------------------------------------------------------
s850D   
        CLC 
        ADC #$F6
        BCC b8514
        ADC #$06
b8514   ADC #$3A
        JMP $FFD2 ;$FFD2 - output character                 

;---------------------------------------------------------------------------------
; s8519
;---------------------------------------------------------------------------------
s8519   
        PHA 
        TXA 
        JSR $FFD2 ;$FFD2 - output character                 
b851E   PLA 
        JMP $FFD2 ;$FFD2 - output character                 

;---------------------------------------------------------------------------------
; s8522
;---------------------------------------------------------------------------------
s8522   
        PHA 
        JSR s86E0
        BNE b851E
;---------------------------------------------------------------------------------
; s8528
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; s853F
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s855F
;---------------------------------------------------------------------------------
s855F   
        JSR s85A9
b8562   JSR s8568
        BCC b8580
b8567   TAX 
;---------------------------------------------------------------------------------
; s8568
;---------------------------------------------------------------------------------
s8568   
        LDA #$00
        STA $0100
        JSR s85A9
;---------------------------------------------------------------------------------
; s8570
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; s8581
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; s8596
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; s85A9
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s85D1
;---------------------------------------------------------------------------------
s85D1   
        LDA #$2C
;---------------------------------------------------------------------------------
; s85D3
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s8620
;---------------------------------------------------------------------------------
s8620   
        LDA a3E
        BNE s8626
;---------------------------------------------------------------------------------
; s8624
;---------------------------------------------------------------------------------
s8624   
        LDA #$00
;---------------------------------------------------------------------------------
; s8626
;---------------------------------------------------------------------------------
s8626   
        JSR s8632
        STA aC1
        STY aC2
        BNE b8631
        INC a3B
b8631   RTS 

;---------------------------------------------------------------------------------
; s8632
;---------------------------------------------------------------------------------
s8632   
        SEC 
;---------------------------------------------------------------------------------
; s8633
;---------------------------------------------------------------------------------
s8633   
        LDY aC2
        TAX 
        BPL b8639
        DEY 
b8639   ADC aC1
        BCC b863E
        INY 
b863E   RTS 

;---------------------------------------------------------------------------------
; s863F
;---------------------------------------------------------------------------------
s863F   
        LDX #$00
        LDA (pC1,X)
;---------------------------------------------------------------------------------
; s8643
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; s8689
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; s86A4
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; s86E0
;---------------------------------------------------------------------------------
s86E0   
        LDA #$0D
        JSR s86F9
        BIT a13
        BPL b86EE
        LDA #$0A
        JSR s86F9
b86EE   EOR #$FF
        RTS 

;---------------------------------------------------------------------------------
; s86F1
;---------------------------------------------------------------------------------
s86F1   
        LDA #$20
        BIT a1DA9
;---------------------------------------------------------------------------------
; s86F7
;---------------------------------------------------------------------------------
s86F7   =*+$01
        BIT a3FA9
;---------------------------------------------------------------------------------
; s86F9
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s8879
;---------------------------------------------------------------------------------
s8879   
        LDX #$57
        .BYTE $2C
;---------------------------------------------------------------------------------
; s887C
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; s89C9
;---------------------------------------------------------------------------------
s89C9   
        LDY #$02
b89CB   LDA (pC1),Y
        JSR s8502
        DEY 
        BNE b89CB
        JMP s86F1

;---------------------------------------------------------------------------------
; s89D6
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s8A4F
;---------------------------------------------------------------------------------
s8A4F   
        LDX #$00
        LDA (pC1,X)
        LDY $0128
        BEQ b8A5A
        STA (pC3,X)
b8A5A   CMP (pC3,X)
        BEQ b8A69
;---------------------------------------------------------------------------------
; s8A5E
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; s8B92
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s8C20
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s8CB2
;---------------------------------------------------------------------------------
s8CB2   
        PHA 
        TXA 
        PHA 
        JSR s8A5E
        PLA 
        TAX 
        PLA 
        RTS 

;---------------------------------------------------------------------------------
; s8CBC
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; s8CE4
;---------------------------------------------------------------------------------
s8CE4   
        LDA $0129
        STA aC1
        LDA $012A
        STA aC2
        LDX a3A
        RTS 

;---------------------------------------------------------------------------------
; s8CF1
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; s8D27
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; s8D37
;---------------------------------------------------------------------------------
s8D37   
        LDX #$02
;---------------------------------------------------------------------------------
; s8D3A
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; s8D4B
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; s8D5D
;---------------------------------------------------------------------------------
s8D5D   
        JSR s8D63
        .BYTE $02    ;JAM 
        ASL fE7,X
;---------------------------------------------------------------------------------
; s8D63
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; s8D96
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s8DAB
;---------------------------------------------------------------------------------
s8DAB   =*+$01
        BIT a13A9
;---------------------------------------------------------------------------------
; s8DAE
;---------------------------------------------------------------------------------
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
b8F21   LDA JumpToLaunchSyncro,X
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

;---------------------------------------------------------------------------------
; s8FBD
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; s8FD4
;---------------------------------------------------------------------------------
s8FD4   
        JSR $FD15 ;$FD15 (jmp) - restore default I/O vectors      
        LDA #<p8DB3
        STA $0316
        LDA #>p8DB3
        STA $0317
        RTS 
