
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
;-------------------------------
; LaunchSyncro
;-------------------------------
LaunchSyncro
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
        STA COLOR_RAM + $0000,X
        STA COLOR_RAM + $0100,X
        STA COLOR_RAM + $0200,X
        STA COLOR_RAM + $0248,X
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
        STA COLOR_RAM + $031F,X
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
bAA0D   STA COLOR_RAM + $031F,X
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
bAA5E   STA COLOR_RAM + $031F,X
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
        STA COLOR_RAM + $0383,X
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
        .BYTE $29
