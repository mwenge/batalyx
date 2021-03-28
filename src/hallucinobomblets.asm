;---------------------------------------------------------------------------------
; Game 1: Hallucin-O-Bomblets 
; 
; You control a little robot droid attacking the Hallu... ok let's call 'em aliens then.
; You fire by leaning the stick in the direction you want to fire. Thanks to Newton, your 
; ship is thrust in the opposite direction to bullets you fire. Thus you steer your ship 
; by carefully firing in the direction you don't want to go whilst simultaneously trying 
; to blap the aliens with your bullets. 
;
; Design Notes: I'd had the idea of the ship and bullets-as-reaction-mass for
; ages and this seemed like a good opportunity to try it. The control seems weird
; at first but you soon get the hang. Sort of like a weird Asteroids I suppose. I
; thought I could do some nice trad-Minter multi-wave-wacky sprites here too, and
; the bits flying off are simple but effective. Unlimited lives here - as indeed
; throughout the game. I wanted to take some of the frustration out of learning.
; I do like the sonics though, the 'doomff' when you shoot one and the jangling
; crash when you get hit. 
;---------------------------------------------------------------------------------
; This is the reverse-engineered source code for the game 'Batalyx'
; written by Jeff Minter in 1985.
;
; The code in this file was created by disassembling a binary of the game released into
; the public domain by Jeff Minter in 2019.
;
; The original code from which this source is derived is the copyright of Jeff Minter.
;
; The original home of this file is at: https://github.com/mwenge/batalyx
;
; To the extent to which any copyright may apply to the act of disassembling and reconstructing
; the code from its binary, the author disclaims copyright to this source code.  In place of
; a legal notice, here is a blessing:
;
;    May you do good and not evil.
;    May you find forgiveness for yourself and forgive others.
;    May you share freely, never taking more than you give.
;
; (Note: I ripped this part from the SQLite licence! :) )

aAB03   .BYTE $00
;---------------------------------------------------------------------------------
; LaunchHallucinOBomblets
;---------------------------------------------------------------------------------
LaunchHallucinOBomblets
        JSR sB9E9

        LDA $D011    ;VIC Control Register 1
        ORA #$0B
        AND #$7B
        STA $D011    ;VIC Control Register 1

        JSR SwapInOutHallucinoBombletSprites
        LDA aAB03
        BNE bAB23
        LDA #$FF
        JSR sBBA5
        LDA #$00
        STA aBBA4
bAB23   SEI 
        JSR ResetSomeData
        JSR ClearScreenAndInitializeSprites
        JSR InitializeRasterJumpTableForHB
        JSR sB5B0
        CLI 
        LDA #$01
        STA aAB03
jAB36   JSR sB954
        JSR sBB99
        JMP jAB36

;---------------------------------------------------------------------------------
; ClearScreenAndInitializeSprites
;---------------------------------------------------------------------------------
ClearScreenAndInitializeSprites   
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
        JSR ResetSomeDataAndClearMiddleScreen
        RTS 

;---------------------------------------------------------------------------------
; InitializeRasterJumpTableForHB
;---------------------------------------------------------------------------------
InitializeRasterJumpTableForHB   
        LDX #$00
bAB63   LDA hbRasterPosArray,X
        STA rasterPositionArray,X
        LDA hbRasterJumpTableLoPtrs,X
        STA rasterJumpTableLoPtrArray,X
        LDA hbRasterJumpTableHiPtrs,X
        STA rasterJumpTableHiPtrArray,X
        INX 
        CPX #$02
        BNE bAB63
        RTS 

hbRasterPosArray   .BYTE $E0,$FF,$FF

; Raster jump table pointing to sAB82 ($AB82) initially.
hbRasterJumpTableLoPtrs   .BYTE $82,$82
hbRasterJumpTableHiPtrs   .BYTE $AB,$AB

;---------------------------------------------------------------------------------
; sAB82
;---------------------------------------------------------------------------------
sAB82
        JSR sABBA
        JSR s412C
        JSR stroboscopeOnOff
        JSR $FF9F ;$FF9F - scan keyboard                    
        JSR JumpToPlaySomeSounds
        JSR sAC1B
        JSR sADEA
        JSR sB0B1
        JSR sB118
        JSR sB348
        LDA $D01E    ;Sprite to Sprite Collision Detect
        STA aB347
        JSR sB49D
        JSR JumpToPlaySomeSounds
        JSR s4135
        JSR ProcessInputOrScrollText
        JMP JumpToIncrementAndUpdateRaster

aABB5   .BYTE $60
aABB6   .BYTE $80
aABB7   .BYTE $B7
aABB8   .BYTE $00
aABB9   .BYTE $05
;---------------------------------------------------------------------------------
; sABBA
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; sAC1B
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; sACB6
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; sAD78
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; sAD96
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; sADEA
;---------------------------------------------------------------------------------
sADEA   
        JSR sACB6
        JSR sAD78
        RTS 

aADF1   .BYTE $00
aADF2   .BYTE $00
aADF3   .BYTE $00
aADF4   .BYTE $00
;---------------------------------------------------------------------------------
; sADF5
;---------------------------------------------------------------------------------
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
        STA (tempLoPtr1),Y
        INY 
        CPY #$08
        BNE bAEBC
        LDX #$00
bAEC8   LDA SCREEN_RAM + $037D,X
        STA (tempLoPtr1),Y
        INY 
        INX 
        CPX #$0A
        BNE bAEC8
        LDX #$00
bAED5   LDA SCREEN_RAM + $03A5,X
        STA (tempLoPtr1),Y
        INX 
        INY 
        CPX #$0A
        BNE bAED5
        LDX #$00
bAEE2   LDA COLOR_RAM + $037D,X
        STA (tempLoPtr1),Y
        INX 
        INY 
        CPX #$0A
        BNE bAEE2
        LDX #$00
bAEEF   LDA COLOR_RAM + $03A5,X
        STA (tempLoPtr1),Y
        INX 
        INY 
        CPX #$0A
        BNE bAEEF
        RTS 

        .BYTE $C0,$C0,$20,$2A
;---------------------------------------------------------------------------------
; ResetSomeData
;---------------------------------------------------------------------------------
ResetSomeData   
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
;---------------------------------------------------------------------------------
; sB0B1
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; sB118
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; sB14B
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; sB192
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; sB1DC
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; sB2C9
;---------------------------------------------------------------------------------
sB2C9   
        LDA fAEAA,X
        BNE bB2CF
bB2CE   RTS 

bB2CF   DEC fAEAA,X
        BNE bB2CE
;---------------------------------------------------------------------------------
; sB2D4
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; sB2E9
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; sB348
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; sB373
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; sB414
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; sB44B
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; sB49D
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; sB4B6
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; sB4CE
;---------------------------------------------------------------------------------
sB4CE   
        LDA #$20
        STA currentChar
jB4D2   LDA fB4AD,X
        STA currentCharXPos
        LDA fB4B1,X
        SEC 
        SBC aB4B5
        STA currentCharYPos
        JSR sB52D
        LDA currentCharXPos
        CLC 
        ADC aB4B5
        STA currentCharXPos
        JSR sB52D
        LDA currentCharYPos
        CLC 
        ADC aB4B5
        STA currentCharYPos
        JSR sB52D
        LDA currentCharYPos
        CLC 
        ADC aB4B5
        STA currentCharYPos
        JSR sB52D
        LDA currentCharXPos
        SEC 
        SBC aB4B5
        STA currentCharXPos
        JSR sB52D
        LDA currentCharXPos
        SEC 
        SBC aB4B5
        STA currentCharXPos
        JSR sB52D
        LDA currentCharYPos
        SEC 
        SBC aB4B5
        STA currentCharYPos
        JSR sB52D
        LDA currentCharYPos
        SEC 
        SBC aB4B5
        STA currentCharYPos
;---------------------------------------------------------------------------------
; sB52D
;---------------------------------------------------------------------------------
sB52D   
        LDA currentCharXPos
        BMI bB53D
        CMP #$28
        BPL bB53D
        LDA currentCharYPos
        BMI bB53D
        CMP #$14
        BMI bB53E
bB53D   RTS 

bB53E   TXA 
        PHA 
        JSR WriteCurrentCharToScreen
        PLA 
        TAX 
        RTS 

jB546   LDA #<p2A01
        STA a06
        LDA #>p2A01
        STA currentChar
        JMP jB4D2

;---------------------------------------------------------------------------------
; sB551
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; sB56E
;---------------------------------------------------------------------------------
sB56E   
        INC aB56D
        TXA 
        PHA 
        LDX aB56D
        LDA #$3D
        STA SCREEN_RAM + $0321,X
        LDA #$04
        STA COLOR_RAM + $0321,X
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

;---------------------------------------------------------------------------------
; sB5B0
;---------------------------------------------------------------------------------
sB5B0   
        LDX #$00
        LDA aB56D
        CMP #$FF
        BEQ bB5CB
bB5B9   LDA #$3D
        STA SCREEN_RAM + $0321,X
        LDA #$04
        STA COLOR_RAM + $0321,X
        CPX aB56D
        BEQ bB5CB
        INX 
        BNE bB5B9
bB5CB   RTS 

;---------------------------------------------------------------------------------
; sB5CC
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; sB623
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; SwapInOutHallucinoBombletSprites
;---------------------------------------------------------------------------------
SwapInOutHallucinoBombletSprites   
        LDA #>hbSprites
        STA tempHiPtr1
        LDA #<hbSprites
        STA tempLoPtr1
        LDA #>mainSprites
        STA tempHiPtr2
        LDA #<mainSprites
        STA tempLoPtr2

        LDY #$00
bB6DC   LDA (tempLoPtr1),Y
        PHA 
        LDA (tempLoPtr2),Y
        STA (tempLoPtr1),Y
        PLA 
        STA (tempLoPtr2),Y
        INC tempLoPtr1
        BNE bB6EC
        INC tempHiPtr1
bB6EC   INC tempLoPtr2
        BNE bB6F2
        INC tempHiPtr2
bB6F2   LDA tempHiPtr1
        CMP #$A0
        BNE bB6DC

        RTS 

aB6F9   .BYTE $00
aB6FA   .BYTE $00
;---------------------------------------------------------------------------------
; ProcessInputOrScrollText
;---------------------------------------------------------------------------------
ProcessInputOrScrollText   
        LDA #<scrollingText
        STA tempLoPtr1
        LDA #>scrollingText
        STA tempHiPtr1
        LDA currentPressedKey
        CMP #$40
        BEQ bB70C
        JMP jB95D

bB70C   LDY aB6F9
        BEQ bB721
bB711   LDA tempLoPtr1
        CLC 
        ADC #$20
        STA tempLoPtr1
        LDA tempHiPtr1
        ADC #$00
        STA tempHiPtr1
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
        LDA (tempLoPtr1),Y
        AND #$3F
        STA SCREEN_RAM + $03C0,X
        TYA 
        PHA 
        LDY aB953
        LDA f40DA,Y
        STA COLOR_RAM + $03C0,X
        PLA 
        TAY 
        INY 
        INX 
        CPX #$28
        BNE bB734
        RTS 

scrollingText .TEXT " THE BONEHEADS                   THE I I"
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
;---------------------------------------------------------------------------------
; sB954
;---------------------------------------------------------------------------------
sB954   
        LDA a40D8
        BNE bB95A
        RTS 

bB95A   JMP j413E

;---------------------------------------------------------------------------------
; jB95D   
;---------------------------------------------------------------------------------
jB95D   
        LDX #$28
        LDA #$20
bB961   STA SCREEN_RAM + $03BF,X
        DEX 
        BNE bB961
        RTS 

fB968   .BYTE $3B,$08,$0B,$10,$13,$03
;---------------------------------------------------------------------------------
; jB96E   
;---------------------------------------------------------------------------------
jB96E   
        LDA currentPressedKey
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
        JSR SwapInOutHallucinoBombletSprites
        JSR jB95D
        PLA 
        JMP JumpToCheckSubGameSelection

fB990   .BYTE $AD,$AF,$AE,$B0
fB994   .BYTE $00,$01,$28,$29
;---------------------------------------------------------------------------------
; sB998
;---------------------------------------------------------------------------------
sB998   
        LDA fB990,Y
        BNE bB99E
        RTS 

bB99E   LDA fB994,Y
        TAX 
        LDA fB990,Y
        STA SCREEN_RAM + $0385,X
        LDA #$0E
        STA COLOR_RAM + $0385,X
        RTS 

aB9AE   .BYTE $00
;---------------------------------------------------------------------------------
; sB9AF
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; sB9E9
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; HB_ResetRasterJumpTable   
;---------------------------------------------------------------------------------
HB_ResetRasterJumpTable   
        SEI 
        LDA #<pB9CB
        STA a1B
        LDA #>pB9CB
        STA a1C
        LDA #$01
        STA a4141
        JSR ClearScreenAndInitializeSprites
        LDA $D016    ;VIC Control Register 2
        AND #$E8
        STA $D016    ;VIC Control Register 2

        ; Jump address gets reset to HB_DefaultRasterJump ($BA3C)
        LDX #$00
bBA1D   LDA fBA35,X
        STA rasterPositionArray,X
        LDA #$3C
        STA rasterJumpTableLoPtrArray,X
        LDA #$BA
        STA rasterJumpTableHiPtrArray,X
        INX 
        CPX #$06
        BNE bBA1D
        JMP jBA48

fBA35   .BYTE $F0,$FF,$FF,$FF,$FF,$FF,$FF
;----------------------------------------------------------------
; HB_DefaultRasterJump
;----------------------------------------------------------------
HB_DefaultRasterJump
        JSR JumpToPlaySomeSounds
        JSR sB49D
        JSR stroboscopeOnOff
        JMP JumpToIncrementAndUpdateRaster

;---------------------------------------------------------------------------------
; jBA48   
;---------------------------------------------------------------------------------
jBA48   
        LDX #$00
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
;---------------------------------------------------------------------------------
; sBAA0
;---------------------------------------------------------------------------------
sBAA0   
        JSR ClearScreenAndInitializeSprites
        LDA #$00
        STA aBA9F
bBAA8   LDA #$00
        STA aBB16
bBAAD   LDA aBB16
        STA currentCharXPos
        LDA aBA9F
        STA currentCharYPos
        LDA aBA9F
        ROR 
        AND #$0F
        TAX 
        LDA f40DD,X
        BNE bBAC5
        LDA #<pA108
bBAC5   STA a06
        LDA #>pA108
        STA currentChar
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
        JMP DrawGameOverScreen

;---------------------------------------------------------------------------------
; sBAEB
;---------------------------------------------------------------------------------
sBAEB   
        JSR sBB02
        INC currentCharYPos
        INC currentChar
        JSR sBB02
        INC currentCharXPos
        DEC currentCharYPos
        INC currentChar
        JSR sBB02
        INC currentChar
        INC currentCharYPos
;---------------------------------------------------------------------------------
; sBB02
;---------------------------------------------------------------------------------
sBB02   
        LDA currentCharXPos
        BMI bBB15
        CMP #$28
        BPL bBB15
        LDA currentCharYPos
        BMI bBB15
        CMP #$15
        BPL bBB15
        JSR WriteCurrentCharToScreen
bBB15   RTS 

aBB16   .BYTE $00
;---------------------------------------------------------------------------------
; DrawGameOverScreen
;---------------------------------------------------------------------------------
DrawGameOverScreen
        LDA #$20
        STA currentChar
        LDA #>p090A
        STA currentCharYPos
bBB1F   LDA #<p090A
        STA currentCharXPos
bBB23   JSR WriteCurrentCharToScreen
        INC currentCharXPos
        LDA currentCharXPos
        CMP #$1C
        BNE bBB23
        INC currentCharYPos
        LDA currentCharYPos
        CMP #$0C
        BNE bBB1F
        LDA #<$010A
        STA currentCharYPos
        LDA #>$010A
        STA a06
        LDA #$0B
        STA currentCharXPos
        LDX #$00
bBB44   LDA fBB5C,X
        AND #$3F
        STA currentChar
        TXA 
        PHA 
        JSR WriteCurrentCharToScreen
        PLA 
        TAX 
        INX 
        INC currentCharXPos
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

;---------------------------------------------------------------------------------
; sBB99
;---------------------------------------------------------------------------------
sBB99   
        LDA a4CE8
        BEQ bBBA1
        JMP jBBAE

bBBA1   JMP jB96E

aBBA4   .BYTE $00
;---------------------------------------------------------------------------------
; sBBA5
;---------------------------------------------------------------------------------
sBBA5   
        STA aB56D
        LDA #$00
        STA aB9AE
        RTS 

;---------------------------------------------------------------------------------
; jBBAE   
;---------------------------------------------------------------------------------
jBBAE   
        SEI 
        JSR jB95D
        JSR SwapInOutHallucinoBombletSprites
        LDX #$F8
        TXS 
        JMP HB_ResetRasterJumpTable

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
;---------------------------------------------------------------------------------
; sBDCD
;---------------------------------------------------------------------------------
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
