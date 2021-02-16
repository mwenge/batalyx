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
screenLinesLoPtr = $02
screenLinesHiPtr = $03
currentCharXPos = $04
currentCharYPos = $05
a06 = $06
currentChar = $07
a08 = $08
a09 = $09
currentRasterArrayIndex = $0A
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
tempLoPtr1 = $FB
tempHiPtr1 = $FC
tempLoPtr2 = $FD
tempHiPtr2 = $FE
;
; **** ZP POINTERS **** 
;
p00 = $00
p01 = $01
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
COLOR_RAM = $D800
screenLinesLoPtrArray = $0340
screenLinesHiPtrArray = $0360

* = $0801
;------------------------------------------------------------------
; SYS 16816 ($41B0)
; This launches the program from address $41B0, i.e. LaunchBatalyx.
;------------------------------------------------------------------
; $9E = SYS
; $31,$36,$38,$31,$36,$00 = 16816 ($41B0 in hex)
        .BYTE $0C,$08,$0A,$00,$9E,$31,$36,$38,$31,$36,$00

* = $0810

.include "cippyontherun.asm"

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
        .BYTE $00,$00,$00,$00,$00,$00,$00

.include "charset.asm"

.include "sprites.asm"

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

rasterJumpTableLoPtr2=*+$01
rasterJumpTableLoPtr3=*+$02
rasterJumpTableLoPtrArray .BYTE $55,$55
                          .BYTE $22,$22,$22,$22,$46,$46,$46,$46
                          .BYTE $46,$46
rasterJumpTableHiPtr2=*+$01
rasterJumpTableHiPtr3=*+$02
rasterJumpTableHiPtrArray .BYTE $C0,$C0
                          .BYTE $C3,$C3,$C3,$C3,$42,$42,$42,$42
                          .BYTE $42,$42
rasterPositionArray       .BYTE $E0,$FF,$C0,$FF,$A0,$C0,$FF

;----------------------------------------------------------------
; s4129
;----------------------------------------------------------------
s4129   
        JMP j47BB

;----------------------------------------------------------------
; s412C
;----------------------------------------------------------------
s412C   
        JMP j4677

;----------------------------------------------------------------
; stroboscopeOnOff
;----------------------------------------------------------------
stroboscopeOnOff   
        JMP j542B

;----------------------------------------------------------------
; JumpToIncrementAndUpdateRaster   
;----------------------------------------------------------------
JumpToIncrementAndUpdateRaster   
        JMP IncrementAndUpdateRaster

;----------------------------------------------------------------
; s4135
;----------------------------------------------------------------
s4135   
        JMP j4C40

;----------------------------------------------------------------
; s4138
;----------------------------------------------------------------
s4138   
        JMP j59ED

;----------------------------------------------------------------
; JumpToCheckSubGameSelection
;----------------------------------------------------------------
JumpToCheckSubGameSelection   
        JMP CheckSubGameSelection

j413E   JMP j578A

a4141   .BYTE $00
a4142   .BYTE $01
;----------------------------------------------------------------
; InitializeScreenLinePtrArray
;----------------------------------------------------------------
InitializeScreenLinePtrArray   
        LDA #>SCREEN_RAM + $0000
        STA screenLinesHiPtr
        LDA #<SCREEN_RAM + $0000
        STA screenLinesLoPtr

        LDX #$00
b414D   LDA screenLinesLoPtr
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
        CPX #$1A
        BNE b414D
        RTS 

;----------------------------------------------------------------
; ClearScreen
;----------------------------------------------------------------
ClearScreen   
        LDX #$00
b416C   LDA #$20
        STA SCREEN_RAM + $0000,X
        STA SCREEN_RAM + $0100,X
        STA SCREEN_RAM + $0200,X
        STA SCREEN_RAM + $0300,X
        LDA #$01
        STA COLOR_RAM + $02F0,X
        DEX 
        BNE b416C
        RTS 

;----------------------------------------------------------------
; GetCurrentCharAddress
;----------------------------------------------------------------
GetCurrentCharAddress   
        LDX currentCharYPos
        LDY currentCharXPos
        LDA screenLinesLoPtrArray,X
        STA screenLinesLoPtr
        LDA screenLinesHiPtrArray,X
        STA screenLinesHiPtr
        RTS 

;----------------------------------------------------------------
; GetCurrentChar
;----------------------------------------------------------------
GetCurrentChar   
        JSR GetCurrentCharAddress
        LDA (screenLinesLoPtr),Y
        RTS 

;----------------------------------------------------------------
; WriteCurrentCharToScreen
;----------------------------------------------------------------
WriteCurrentCharToScreen   
        JSR GetCurrentCharAddress
        LDA currentChar
        STA (screenLinesLoPtr),Y
        LDA screenLinesHiPtr
        PHA 

        ; Update color of character
        CLC 
        ADC #$D4
        STA screenLinesHiPtr
        LDA a06
        STA (screenLinesLoPtr),Y

        PLA 
        STA screenLinesHiPtr
        RTS 

a41AF   .BYTE $27
;----------------------------------------------------------------
; LaunchBatalyx $41B0
;----------------------------------------------------------------
LaunchBatalyx
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
        STA selectedSubGame
        JSR UpdateGameIconsPanel
        JMP TitleScreenLoop

;----------------------------------------------------------------
; SetUpInterrupts
;----------------------------------------------------------------
SetUpInterrupts   
        SEI 
        LDA #$7F
        STA $DC0D    ;CIA1: CIA Interrupt Control Register
        LDA #<TitleScreenInterruptHandler
        STA $0314    ;IRQ
        LDA #>TitleScreenInterruptHandler
        STA $0315    ;IRQ
        LDA #$00
        STA currentRasterArrayIndex
        JSR UpdateRasterPosition
        JSR InitializeRasterJumpTablePtrArray

        LDA #$01
        STA $D01A    ;VIC Interrupt Mask Register (IMR)
        RTS 

;----------------------------------------------------------------
; UpdateRasterPosition
;----------------------------------------------------------------
UpdateRasterPosition   
        LDA $D011    ;VIC Control Register 1
        AND #$7F
        STA $D011    ;VIC Control Register 1
        LDX currentRasterArrayIndex
        LDA rasterPositionArray,X
        CMP #$FF
        BNE b4224

        LDA #$00
        STA currentRasterArrayIndex
        LDA rasterPositionArray
b4224   STA $D012    ;Raster Position
        LDA #$01
        STA $D019    ;VIC Interrupt Request Register (IRR)
        RTS 

;----------------------------------------------------------------
; TitleScreenInterruptHandler
;----------------------------------------------------------------
TitleScreenInterruptHandler
        LDA $D019    ;VIC Interrupt Request Register (IRR)
        AND #$01
        BNE b4237
        JMP $EA31

        ;Check for keyboard input
b4237   LDX currentRasterArrayIndex
        LDA rasterJumpTableLoPtrArray,X
        STA a08
        LDA rasterJumpTableHiPtrArray,X
        STA a09
        JMP ($0008)

;----------------------------------------------------------------
; IncrementAndUpdateRaster
;----------------------------------------------------------------
IncrementAndUpdateRaster
        INC currentRasterArrayIndex
        JSR UpdateRasterPosition
        PLA 
        TAY 
        PLA 
        TAX 
        PLA 
        RTI 

        LDX currentRasterArrayIndex
        LDA f40DA,X
        STA $D020    ;Border Color
        STA $D021    ;Background Color 0
        JMP IncrementAndUpdateRaster
        ; Returns

;----------------------------------------------------------------
; LaunchSubGame
;----------------------------------------------------------------
LaunchSubGame
        SEI 
        LDA #$00
        STA currentRasterArrayIndex
        JSR UpdateRasterPosition
        LDX selectedSubGame
        LDA subGameJumpMapLoPtr,X
        STA a449E
        LDA subGameJumpMapHiPtr,X
        STA a449F
        JSR UpdateGameIconsPanel
        JMP (a449E)

; $AB00 - LaunchHallucinOBomblets
; $6000 - LaunchAMCII
; $4288 - LaunchIridisBase
; $0810 - LaunchCippyOnTheRun
; $A000 - LaunchSyncro
; $7800 - LaunchPsychedelia
subGameJumpMapLoPtr   .BYTE $00,$00,$88,$10,$00,$00
subGameJumpMapHiPtr   .BYTE $AB,$60,$42,$08,$A0,$78


.include "iridisbase.asm"

.include "somedata1.asm"

.include "amcII.asm"

.include "psychedelia.asm"

.include "somedata2.asm"

.include "moresprites.asm"

fA001   =*+$01
JumpToLaunchSyncro
        JMP LaunchSyncro

.include "syncroII.asm"

JumpToLaunchHallucinOBomblets
        JMP LaunchHallucinOBomblets

.include "hallucinobomblets.asm"

;----------------------------------------------------------------
; TitleScreenLoop
;----------------------------------------------------------------
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
        JSR InitializeRasterJumpTableForTitleScreen
        JSR ClearTopOfScreen
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

;----------------------------------------------------------------
; InitializeRasterJumpTableForTitleScreen
;----------------------------------------------------------------
InitializeRasterJumpTableForTitleScreen   
        LDX #$00
bC036   LDA titleScreenRasterPosArray,X
        STA rasterPositionArray,X
        LDA titleScreenRasterJumpTableLoPtrs,X
        STA rasterJumpTableLoPtrArray,X
        LDA titleScreenRasterJumpTableHiPtrs,X
        STA rasterJumpTableHiPtrArray,X
        INX 
        CPX #$02
        BNE bC036
        JMP UpdateHighestScoreForCurrentLevelIfRequired

titleScreenRasterPosArray   .BYTE $E0,$FF,$FF
titleScreenRasterJumpTableLoPtrs   .BYTE $55,$55,$20
        .BYTE $9F,$FF,$20,$EB,$C2,$4C,$32,$41
;----------------------------------------------------------------
; AnimateScreenDissolve
;----------------------------------------------------------------
AnimateScreenDissolve   
        SEI 
        LDA #>SCREEN_RAM + $0000
        STA tempHiPtr1
        LDA #<SCREEN_RAM + $0000
        STA tempLoPtr1
        JSR ResetRasterJumpTable
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
bC097   JSR PutRandomByteInAccumulator
        AND #$07
        TAX 
        LDA #$42
        STA (tempLoPtr1),Y
        LDA tempHiPtr1
        PHA 
        CLC 
        ADC #$D4
        STA tempHiPtr1
        LDA f40FB,X
        STA (tempLoPtr1),Y
        PLA 
        STA tempHiPtr1
        INC tempLoPtr1
        BNE bC0B7
        INC tempHiPtr1
bC0B7   LDA tempHiPtr1
        CMP #$06
        BNE bC097
        LDA tempLoPtr1
        CMP #$F8
        BNE bC097
        JMP DrawColorsForAnimatedScreenDissolve

;----------------------------------------------------------------
; PutRandomByteInAccumulator
;----------------------------------------------------------------
PutRandomByteInAccumulator   
aC0C7   =*+$01
        LDA $EEF8
        INC aC0C7
        RTS 

;----------------------------------------------------------------
; DrawColorsForAnimatedScreenDissolve
;----------------------------------------------------------------
DrawColorsForAnimatedScreenDissolve
        LDA #$07
        STA aC118
bC0D2   LDA #>COLOR_RAM + $0000
        STA tempHiPtr1
        LDA #<COLOR_RAM + $0000
        STA tempLoPtr1
        LDY #$00
bC0DC   LDA (tempLoPtr1),Y
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
        STA (tempLoPtr1),Y
bC0F6   INC tempLoPtr1
        BNE bC0FC
        INC tempHiPtr1
bC0FC   LDA tempHiPtr1
        CMP #$DA
        BNE bC0DC
        LDA tempLoPtr1
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
;----------------------------------------------------------------
; ClearTopOfScreen
;----------------------------------------------------------------
ClearTopOfScreen   
        LDX #$00
bC11B   LDA #$20
        STA SCREEN_RAM + $0000,X
        STA SCREEN_RAM + $0100,X
        STA SCREEN_RAM + $01F8,X
        LDA #$0C
        STA COLOR_RAM + $0000,X
        STA COLOR_RAM + $0100,X
        STA COLOR_RAM + $01F8,X
        DEX 
        BNE bC11B

        JSR UpdateStroboscopeSpriteColors
        LDA #$08
        STA aC2E8
        RTS 

;----------------------------------------------------------------
; DrawTitleScreen
;----------------------------------------------------------------
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

        JSR UpdateDisplayedLevel
        JSR UpdateStroboscopeDisplay
        JMP DrawCredits

fC165   .TEXT " PRESS KEYS 1-6 TO ACTIVATE SUBGAMES..  "
fC18D   .TEXT " PRESS F1 FOR LEVEL: CURRENT LEVEL 1    "
fC1B5   .TEXT " PRESS F3 FOR STROBOSCOPICS: NOW ON     "
;----------------------------------------------------------------
; CheckTitleScreenInput
;----------------------------------------------------------------
CheckTitleScreenInput   
        LDA currentPressedKey
        CMP #$40
        BNE bC1E9
        LDA #$00
        STA displayedSelectedLevel
bC1E8   RTS 

bC1E9   LDY displayedSelectedLevel
        BNE bC1E8
        STA lastPressedKey
        LDA aC2EA
        BEQ bC201
        LDA #$01
        STA aC2E8
        LDA #$01
        STA aC2E9
        RTS 

bC201   LDA #$08
        STA aC2E8
        LDA lastPressedKey
        CMP #$04 ;F1
        BNE bC22C

        ;F1 pressed - cycle selected level.
        INC selectedLevel
        LDA selectedLevel
        CMP #$05 ; Cycle levels through 1 to 5
        BNE UpdateDisplayedLevel
        LDA #$00
        STA selectedLevel
        ;Fall through

;----------------------------------------------------------------
; UpdateDisplayedLevel
;----------------------------------------------------------------
UpdateDisplayedLevel   
        ; Convert the level counter to ascii, e.g. 00 to 31, 01 to 32.
        LDA #$31
        CLC 
        ADC selectedLevel
        STA SCREEN_RAM + $01B3
        STA displayedSelectedLevel
        JSR UpdateDisplayedScoreAndOtherInfoForCurrentLevel
        RTS 

bC22C   CMP #$05 ;F3 pressed?
        BNE bC260

        ; F3 pressed - update stroboscope setting.
        LDA stroboscopeOnOff
        CMP #$4C
        BEQ bC24F

        ;Stroboscope turned on
        LDA #$4C
        STA stroboscopeOnOff
        ; Update displayed stroboscope setting
DisplayStroboscopeOn
        LDA #$0F
        STA SCREEN_RAM + $0201
        LDA #$0E
        STA SCREEN_RAM + $0202
        LDA #$20
        STA SCREEN_RAM + $0203
        STA displayedSelectedLevel
        RTS 

        ;Stroboscope turned off
bC24F   LDA #$60
        STA stroboscopeOnOff

DisplayStroboScopeOff
        LDA #$06
        STA SCREEN_RAM + $0202
        STA SCREEN_RAM + $0203
        STA displayedSelectedLevel
        RTS 

bC260   LDA #$07
        STA selectedSubGame
        JSR InitializeVariablesInterruptsDrawRainbow
        JMP JumpToCheckSubGameSelection

displayedSelectedLevel   .BYTE $00
;----------------------------------------------------------------
; UpdateStroboscopeDisplay
;----------------------------------------------------------------
UpdateStroboscopeDisplay   
        JSR UpdateDisplayedScoreAndOtherInfoForCurrentLevel
        LDA stroboscopeOnOff
        CMP #$4C
        BEQ DisplayStroboscopeOn
        BNE DisplayStroboScopeOff
        ;Never reached

;----------------------------------------------------------------
; SwapData
;----------------------------------------------------------------
SwapData   
        SEI 

        ; Swap data between C800-CC00 to 0400-0800
        LDA #$C8
        STA tempHiPtr1
        LDA #$04
        STA tempHiPtr2

        LDA #$00
        STA tempLoPtr1
        STA tempLoPtr2

        LDY #$00
bC289   LDA (tempLoPtr2),Y
        PHA 
        LDA (tempLoPtr1),Y
        STA (tempLoPtr2),Y
        PLA 
        STA (tempLoPtr1),Y
        DEY 
        BNE bC289

        INC tempHiPtr1
        INC tempHiPtr2
        LDA tempHiPtr2
        CMP #$08
        BNE bC289

        ; Copy data from CC00 to 2000
        LDA #$CC
        STA tempHiPtr1
        LDA #$20
        STA tempHiPtr2
        LDA #$00
        STA tempLoPtr1
        STA tempLoPtr2

        LDY #$00
        LDA a01
        AND #$FD
        STA a01

bC2B6   LDA (tempLoPtr2),Y
        PHA 
        LDA (tempLoPtr1),Y
        STA (tempLoPtr2),Y
        PLA 
        STA (tempLoPtr1),Y
        DEY 
        BNE bC2B6

        INC tempHiPtr1
        INC tempHiPtr2
        LDA tempHiPtr1
        CMP #$D0
        BNE bC2CF
        LDA #$E0
bC2CF   STA tempHiPtr1
        CMP #$FC
        BNE bC2B6

        LDA a01
        ORA #$02
        STA a01

        CLI 
        RTS 

;----------------------------------------------------------------
; UpdateControlRegister
;----------------------------------------------------------------
UpdateControlRegister   
        LDA $D011    ;VIC Control Register 1
        ORA #$20
        AND #$7F
        STA $D011    ;VIC Control Register 1
        RTS 

aC2E8   .BYTE $07
aC2E9   .BYTE $0E
aC2EA   .BYTE $00

;----------------------------------------------------------------
;----------------------------------------------------------------
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

        JSR SwapData
        JSR UpdateControlRegister
        INC aC2EA
        RTS 

bC30D   JSR SwapData
        LDA $D011    ;VIC Control Register 1
        AND #$5F
        STA $D011    ;VIC Control Register 1
        LDA #$02
        STA aC2EA
        STA displayedSelectedLevel
        RTS 

lastPressedKey   .BYTE $00

;----------------------------------------------------------------
; JumpToJumpToIncrementAndUpdateRaster
;----------------------------------------------------------------
JumpToJumpToIncrementAndUpdateRaster
        JMP JumpToIncrementAndUpdateRaster
;----------------------------------------------------------------
; ResetRasterJumpTable
;----------------------------------------------------------------
ResetRasterJumpTable   
        LDX #$00
        ; Jump address gets reset to JumpToJumpToIncrementAndUpdateRaster ($C322)
bC327   LDA #$22
        STA rasterJumpTableLoPtrArray,X
        LDA #$C3
        STA rasterJumpTableHiPtrArray,X
        INX 
        CPX #$06
        BNE bC327

        LDA $D016    ;VIC Control Register 2
        AND #$EF
        STA $D016    ;VIC Control Register 2
        JMP s6004

;----------------------------------------------------------------
; GetHighestScoreForCurrentSelectedLevel
;----------------------------------------------------------------
GetHighestScoreForCurrentSelectedLevel   
        LDA #<highestScoreForLevelArray
        STA tempLoPtr1
        LDA #>highestScoreForLevelArray
        STA tempHiPtr1
        LDY selectedLevel
        BEQ bC35E

bC34E   LDA tempLoPtr1
        CLC 
        ADC #$30
        STA tempLoPtr1
        LDA tempHiPtr1
        ADC #$00
        STA tempHiPtr1
        DEY 
        BNE bC34E

bC35E   RTS 

;----------------------------------------------------------------
; UpdateDisplayedScoreAndOtherInfoForCurrentLevel
;----------------------------------------------------------------
UpdateDisplayedScoreAndOtherInfoForCurrentLevel   
        JSR GetHighestScoreForCurrentSelectedLevel
bC362   LDA (tempLoPtr1),Y
        STA SCREEN_RAM + $028A,Y
        LDA #$01
        STA COLOR_RAM + $028A,Y
        INY 
        CPY #$08
        BNE bC362

        LDX #$00
bC373   LDA (tempLoPtr1),Y
        STA SCREEN_RAM + $026B,X
        TYA 
        PHA 
        CLC 
        ADC #$14
        TAY 
        LDA (tempLoPtr1),Y
        STA COLOR_RAM + $026B,X
        PLA 
        TAY 
        INY 
        INX 
        CPY #$12
        BNE bC373

        LDX #$00
bC38D   LDA (tempLoPtr1),Y
        STA SCREEN_RAM + $0293,X
        TYA 
        PHA 
        CLC 
        ADC #$14
        TAY 
        LDA (tempLoPtr1),Y
        STA COLOR_RAM + $0293,X
        PLA 
        TAY 
        INY 
        INX 
        CPY #$1C
        BNE bC38D

        RTS 

;-------------------------------------------------------------------
; UpdateHighestScoreForCurrentLevelIfRequired
;-------------------------------------------------------------------
UpdateHighestScoreForCurrentLevelIfRequired
        JSR GetHighestScoreForCurrentSelectedLevel

        ; Compare the highest score for the level to the current score
        ; and update if required.
bC3A9   LDA SCREEN_RAM + $03B7,Y
        CMP (tempLoPtr1),Y
        BMI bC3B9 ; If it's less return early.
        BEQ bC3B4 ; Compare the next digit in the score
        BPL bC3BA ; It's a new high score so store it.
bC3B4   INY 
        CPY #$08
        BNE bC3A9

bC3B9   RTS 

bC3BA   LDY #$00
bC3BC   LDA SCREEN_RAM + $03B7,Y
        STA (tempLoPtr1),Y
        INY 
        CPY #$08
        BNE bC3BC

        LDX #$00
bC3C8   LDA SCREEN_RAM + $037D,X
        STA (tempLoPtr1),Y
        INY 
        INX 
        CPX #$0A
        BNE bC3C8

        LDX #$00
bC3D5   LDA SCREEN_RAM + $03A5,X
        STA (tempLoPtr1),Y
        INX 
        INY 
        CPX #$0A
        BNE bC3D5

        LDX #$00
bC3E2   LDA COLOR_RAM + $037D,X
        STA (tempLoPtr1),Y
        INX 
        INY 
        CPX #$0A
        BNE bC3E2

        LDX #$00
bC3EF   LDA COLOR_RAM + $03A5,X
        STA (tempLoPtr1),Y
        INX 
        INY 
        CPX #$0A
        BNE bC3EF
        RTS 

titleScreenRasterJumpTableHiPtrs   .BYTE $C0,$C0

fC3FD   .TEXT " *** B A T A L Y X ***  A GAME SYSTEM   "
fC425   .TEXT "      CREATED BY  Y A K  THE HAIRY      "
fC44D   .TEXT "     SYNERGY BY JEFF MINTER AGAIN!!     "
fC475   .TEXT "   HIGHEST SCORE FOR THE CURRENT LEVEL  "
;----------------------------------------------------------------
; DrawCredits
;----------------------------------------------------------------
DrawCredits
        LDX #$00
bC49F   LDA fC3FD,X
        AND #$3F
        STA SCREEN_RAM + $0028,X
        LDA #$07
        STA COLOR_RAM + $0028,X
        LDA fC425,X
        AND #$3F
        STA SCREEN_RAM + $0078,X
        LDA #$04
        STA COLOR_RAM + $0078,X
        LDA fC44D,X
        AND #$3F
pC4C0   =*+$02
        STA SCREEN_RAM + $00C8,X
        LDA #$03
        STA COLOR_RAM + $00C8,X
        LDA fC475,X
        AND #$3F
        STA SCREEN_RAM + $02F8,X
        LDA #$0E
        STA COLOR_RAM + $02F8,X
        INX 
        CPX #$28
        BNE bC49F
        RTS 

;----------------------------------------------------------------
; UpdateStroboscopeSpriteColors
;----------------------------------------------------------------
UpdateStroboscopeSpriteColors   
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
;----------------------------------------------------------------
; sC503
;----------------------------------------------------------------
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
        STA tempLoPtr1
        LDA aC502
        STA tempHiPtr1
        LDY #$00
        LDA (tempLoPtr1),Y
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

.include "padding.asm"

