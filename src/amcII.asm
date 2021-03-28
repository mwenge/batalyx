;---------------------------------------------------------------------------------
;  Game 2. AMC II 
; 
; I'm sure this will need no introduction. Attack the dromedroids with your
; ship's bullets. Repeated hits on the camels weaken and eventually destroy them
; (strength being shown by the colour of each camel on the scanner). Hits on your
; ship by camel's bullets, or by flying into the camels, reduce your shields. You
; can get by a camel's legs if you fly low. The camels march towards the right
; hand side of the scanner. If they reach it they are 'taken up' and an extra
; beast is added to the number remaining. 
; 
; Your objective is to destroy all the dromedroids within the level, then warp to
; the next level. You get one quarter of the completion icon following a
; successful warp, but only if you cleared all the camels. (You can warp at any
; time, even with loads of camels left). Thus, you must clear 4 different levels
; to get the whole Icon. (To warp, just keep accelerating). If you run out of
; shields, you are chucked down one level. The camel's bullets can be pretty
; devious. Watch out for those ones which stop and start. The higher the level
; you're on the more points you'll get for each camel. 
;
; Design Notes: Well, I'd often wanted to update AMC on the 64 but couldn't
; really justify it on its own. Putting it in as a subgame seemed like the
; perfect solution. Still a good blast after all these years... 
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
;

a6003   .BYTE $00
;---------------------------------------------------------------------------------
; ResetSomeDataAndClearMiddleScreen
;---------------------------------------------------------------------------------
ResetSomeDataAndClearMiddleScreen   
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

;---------------------------------------------------------------------------------
; LaunchAMCII
;---------------------------------------------------------------------------------
LaunchAMCII
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
        JSR ResetSomeDataAndClearMiddleScreen
        JSR s60E0
        JSR s616C
        JSR s6F4E
        JSR s70E4
        CLI 
j6081   JSR s6F20
        JSR JumpToCheckSubGameSelection
        JSR s6E5E
        JSR s71C4
        JMP j6081

;---------------------------------------------------------------------------------
; s6090
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s60E0
;---------------------------------------------------------------------------------
s60E0   
        JSR s6090
        LDA #$0A
        STA currentCharYPos
        LDA #$63
        STA currentChar
        LDA a74D2
        STA a06

b60F0   LDA #$00
        STA currentCharXPos
b60F4   JSR WriteCurrentCharToScreen
        INC currentCharXPos
        LDA currentCharXPos
        CMP #$28
        BNE b60F4
        INC currentChar
        INC currentCharYPos
        LDA currentCharYPos
        CMP #$12
        BNE b60F0

        LDX #$00
b610B   LDA a74D1
        STA COLOR_RAM + $0028,X
        STA COLOR_RAM + $0090,X
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

;---------------------------------------------------------------------------------
; s616C
;---------------------------------------------------------------------------------
s616C   
        LDX #$00
b616E   LDA f6186,X
        STA rasterPositionArray,X
        LDA f618C,X
        STA rasterJumpTableLoPtrArray,X
        LDA f6191,X
        STA rasterJumpTableHiPtrArray,X
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
        JMP JumpToIncrementAndUpdateRaster

        LDA a7231
        STA $D021    ;Background Color 0
        JSR JumpToPlaySomeSounds
        JSR s4135
        JMP JumpToIncrementAndUpdateRaster

        LDA a7232
        STA $D021    ;Background Color 0
        JSR s62B2
        JSR s6B87
        JMP JumpToIncrementAndUpdateRaster

        LDA a689E
        STA $D021    ;Background Color 0
        LDA $D016    ;VIC Control Register 2
        AND #$E0
        STA $D016    ;VIC Control Register 2
        JSR s64FB
        JSR $FF9F ;$FF9F - scan keyboard                    
        JMP JumpToIncrementAndUpdateRaster

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
        JMP JumpToIncrementAndUpdateRaster

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
;---------------------------------------------------------------------------------
; s62A4
;---------------------------------------------------------------------------------
s62A4   
        LDA a6251
        AND #$80
        BNE b62AE
        JMP j6218

b62AE   JMP j6252

a62B1   .BYTE $06
;---------------------------------------------------------------------------------
; s62B2
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s6328
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s638B
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; s63B7
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; s63D1
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; s63EA
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s647F
;---------------------------------------------------------------------------------
s647F   
        INC a689D
        LDX #$00
b6484   JSR s6490
        JSR s6540
        INX 
        CPX #$03
        BNE b6484
b648F   RTS 

;---------------------------------------------------------------------------------
; s6490
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s64FB
;---------------------------------------------------------------------------------
s64FB   
        LDX #$00
b64FD   JSR s6506
        INX 
        CPX #$03
        BNE b64FD
        RTS 

;---------------------------------------------------------------------------------
; s6506
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s6539
;---------------------------------------------------------------------------------
s6539   
        LDA $EEEC
        INC a653A
b653F   RTS 

;---------------------------------------------------------------------------------
; s6540
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; s6590
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; s66D1
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s6732
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; s6743
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s67BB
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s689F
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; s690F
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s692F
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s6A49
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s6AB0
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s6AE8
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; s6AFD
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; s6B87
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; s6BAB
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s6C45
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s6D30
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; s6E5E
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; s6E85
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s6F0B
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; s6F20
;---------------------------------------------------------------------------------
s6F20   
        LDA a40D8
        BNE b6F26
        RTS 

b6F26   JMP j413E

a6F29   .BYTE $00
f6F2A   .BYTE $16,$26,$46,$86,$25,$45,$85,$24
        .BYTE $44,$84
;---------------------------------------------------------------------------------
; s6F34
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s6F4E
;---------------------------------------------------------------------------------
s6F4E   
        LDX #$00
b6F50   LDA f6F46,X
        BEQ b6F66
        TAY 
        LDA selectedSubGame,Y
        STA COLOR_RAM + $02F0,X
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
        STA COLOR_RAM + $02EF,Y
        DEC a6F4D
        BNE b6F66
        JSR s6FB7
        RTS 

b6F85   STY a6C28
        TAY 
        LDA selectedSubGame,Y
        LDY a6C28
        STA COLOR_RAM + $02EF,Y
        RTS 

a6F93   .BYTE $00
f6F94   .BYTE $00,$00,$00,$00,$00
f6F99   .BYTE $00,$00,$00,$00,$00
f6F9E   .BYTE $00,$00,$00,$00,$00
f6FA3   .BYTE $00,$00,$00,$00,$00
f6FA8   .BYTE $04,$04,$04,$04,$04
f6FAD   .BYTE $00,$00,$00,$00,$00
f6FB2   .BYTE $00,$40,$50,$60,$70
;---------------------------------------------------------------------------------
; s6FB7
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; s7006
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; s702C
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s7051
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s70E4
;---------------------------------------------------------------------------------
s70E4   
        LDX #$00
b70E6   LDA f7154,X
        AND #$3F
        STA SCREEN_RAM + $0311,X
        LDA #$01
        STA COLOR_RAM + $0311,X
        LDA f7162,X
        AND #$3F
        STA SCREEN_RAM + $0339,X
        LDA #$01
        STA COLOR_RAM + $0339,X
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
;---------------------------------------------------------------------------------
; s711F
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s7170
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s71C4
;---------------------------------------------------------------------------------
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
        STA tempHiPtr1
        LDA #<SCREEN_RAM + $0028
        STA tempLoPtr1
        LDX #$00
b71E0   LDA f7211,X
        LDY #$00
b71E5   STA (tempLoPtr1),Y
        PHA 
        LDA tempHiPtr1
        PHA 
        CLC 
        ADC #$D4
        STA tempHiPtr1
        LDA COLOR_RAM + $02B0
        STA (tempLoPtr1),Y
        PLA 
        STA tempHiPtr1
        PLA 
        INY 
        CPY #$28
        BNE b71E5
        LDA tempLoPtr1
        CLC 
        ADC #$28
        STA tempLoPtr1
        LDA tempHiPtr1
        ADC #$00
        STA tempHiPtr1
        INX 
        CPX #$09
        BNE b71E0
b7210   RTS 

f7211   .BYTE $C0,$C1,$C2,$C3,$C4,$C5,$C6,$C7
        .BYTE $20
;---------------------------------------------------------------------------------
; s721A
;---------------------------------------------------------------------------------
s721A   
        LDA a71C3
        BEQ b7210
;---------------------------------------------------------------------------------
; s721F
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s7253
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; s72B4
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s7329
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s7470
;---------------------------------------------------------------------------------
s7470   
        LDX a6F29
        LDA f740C,X
        STA a7153

;---------------------------------------------------------------------------------
; s7479
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s74D4
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; s750B
;---------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------
; s7561
;---------------------------------------------------------------------------------
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
        STA COLOR_RAM + $037F,Y
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
        .BYTE $00,$FF,$40,$BF,$42,$9D ;LAX $9D42,Y
