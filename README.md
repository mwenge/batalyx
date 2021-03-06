# Batalyx by Jeff Minter
<img src="http://www.computinghistory.org.uk/userdata/images/large/54/11/product-85411.jpg" height=300><img src="https://i.ytimg.com/vi/4KmcFkCIKCc/hqdefault.jpg" height=300>


This is the disassembled and [commented source code] for the 1986 Commodore 64 game Batalyx by Jeff Minter. 

You can play Batalyx in your browser at https://batalyx.xyz. (Ctrl key is 'Fire', Arrow Keys to move.)

## Current Status
The game compiles and plays. Character set and sprite data has been separated out and commented. Because there is so much character and sprite data, and because Batalyx contains two sub games, it was necessary to use a compressor ([Exomizser]) to produce the final binary. 

Labelling the game logic is still in progress.


## Requirements
* [64tass][64tass], tested with v1.54, r1900
* [VICE][vice]
* [Exomizer][Exomizer]

[64tass]: http://tass64.sourceforge.net/
[vice]: http://vice-emu.sourceforge.net/
[https://gridrunner.xyz]: https://mwenge.github.io/gridrunner.xyz
[commented source code]:https://github.com/mwenge/batalyx/blob/master/src/
[Syncro]:https://github.com/mwenge/batalyx/blob/master/demos/syncro
[Syncro II]:https://github.com/mwenge/batalyx/blob/master/demos/syncro2
[Exomizer]:https://bitbucket.org/magli143/exomizer/wiki/Home

To compile and run it do:

```sh
$ make
```
The compiled game is written to the `bin` folder. 

To just compile the game and get a binary (`batalyx.prg`) do:

```sh
$ make batalyx.prg
```

## Batalyx's Side Projects
During the development of Batalyx Jeff Minter released a number of demos to friends on Compunet. These are collected in the [demos folder](https://github.com/mwenge/batalyx/tree/master/demos). They are:

* [Syncro], a demo by Jeff Minter demonstrating an early concept for the Syncro subgame.
* [Syncro II], another demo by Jeff Minter containing the final Syncro II mini game.
