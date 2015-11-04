:insert
; vim:ts=2
<CsoundSynthesizer>
  <CsOptions>
    ;-o test.wav           ; Output to wav file
    -odac -+rtaudio=jack   ; Output to jack
    -odac:system:playback_ ; Output to system
    -b 256                 ; Sample frames (or -kprds) per software sound I/O buffer
     ;-8                    ;  8 bit
    -3                     ; 24 bit
    ;-f                    ; 32 bit
    -B 1024                ; Samples per hardware sound I/O buffer
    -d                     ; Supress all graphical displays
    ;-g                    ; Use ascii graphical function plotters
    ;-G                    ; Use postscript graphical function plotters
    ;-Z                    ; Dither output
  </CsOptions>
  <CsInstruments>
    sr = 44100            ; Samplerate
    kr = 4410             ; Control rate
    ksmps = 10            ; ...
    nchnls = 2            ; Number of audio channels
    0dbfs=1               ; Maximum amplitude is 1.0 ,minimum is 0.0
    
    instr 1,Sine
      itable=1            ; sine,sawup,sawdown,square,pulse
      iamp=p4
      ifreq=cpsmidinn(p5)
      aenv madsr .001,p3,0,0
      asig poscil iamp,ifreq,itable
      asig=asig*aenv;
      outs asig,asig
    endin
  </CsInstruments>
  <CsScore>

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; Instruments use midi note numbers for frequency (0-128)  
    ; Command | Instrument | Start |  Duration | Amp | Freq | p6 | p7 | p8 | p9 |
         i          1          0          1       .8    60  
         i          1          1          1       .8    60  
         i          1          2          1       .8    60  
         i          1          3          .5      .8    60  
         i          1          3.5        .5      .8    61  
         i          1          4          1       .8    60  


    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; Tempo
    ; Command | Zero | BPM
         t       0      60

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; Function Table 1 Sine
    ; str1,str2... Relative strength of fixed harmonic partials 1,2,3, etc.
    ; Command | Table# | Start | Size | GEN# | str1 | str2 | str3 | str4 | str5
         f        1        0     32768   10     2

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; Function Table 2 Saw (up)
    ;           .
    ;         . .
    ;      .    .
    ;   .       .
    ;.          .         .
    ;           .       .
    ;           .     .
    ;           .  .
    ;           .  
    ; a,b,c Ordinate values. n1,n2,n3,etc. Length of segment
    ; Command | Table# | Start | Size | GEN# | a | n1 | b | n2 | c | n3 | d 
         f        2        0      256     7    0   128  1   0   -1   128  0

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; Function Table 3 Saw (Down)
    ;           .
    ;           .  .
    ;           .     .
    ;           .        .
    ;.          .           .
    ;   .       .       
    ;      .    .    
    ;         . .
    ;           .
    ; a,b,c Ordinate values. n1,n2,n3,etc. Length of segment
    ; Command | Table# | Start | Size | GEN# | a | n1 | b | n2 | c | n3 | d 
         f        3        0      256     7    0   128  -1  0    1   128  0

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; Function Table 4 Square
    ; _______
    ;|       |
    ;|       |
    ;|       |      
    ; - - - -|- - - -| 
    ;        |       |
    ;        |       |
    ;        |_______|
    ;         
    ; a,b,c Ordinate values. n1,n2,n3,etc. Length of segment
    ; Command | Table# | Start | Size | GEN# | a | n1 | b | n2 | c | n3 | d 
         f        4        0      256     7    1   128  1   0   -1   128 -1

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
    ; Function Table 5 Pulse
    ; _______  
    ;|       |
    ;|       |
    ;|       |
    ;|       |_________
    ;
    ; Command | Table# | Start | Size | GEN# | a | n1 | b | n2 | c | n3 | d | n4 | e |
         f        5        0      256     7    0   0    1   128  1   0    0   128  0

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;  Function Table 6 Triangle
    ;
    ;           .
    ;         .   .
    ;       .       .
    ;     .           .
    ;   .               .
    ; .                   .
    ; Command | Table# | Start | Size | GEN# | a | n1 | b | n2  | c
        f         6        0      256    7     0   128  1   128   0
    
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;  Function Table 7 Ramp Up
    ;
    ;                   .
    ;                .  .
    ;             .     .
    ;          .        .
    ;       .           .
    ;    .              .
    ; .                 .
    ; Command | Table# | Start | Size | GEN# | a | n1 | b 
         f        7        0     4096    7     0  4096  1 

     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;  Function Table 8 Ramp Down
    ;
    ; .
    ; .  .
    ; .     .   
    ; .        .
    ; .           .
    ; .              .
    ; .                 .
    ; Command | Table# | Start | Size | GEN# | a | n1 | b 
         f        8        0     4096    7     1   4096 0 
     
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; Function Table 9 Exponential Ramp Up
    ;
    ;                  .
    ;                  .
    ;                 ..
    ;               .  .
    ;           .      .
    ;      .           .
    ; .                .
    ; Command | Table# | Start | Size | GEN# | a | n1 | b    
         f        9        0     4096     5  .0001 4096  1 
  
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;  Function Table 10 Exponential Ramp Down
    ;
    ; .
    ; .
    ; . .   
    ; .   .
    ; .     .
    ; .        .
    ; .            .
    ; Command | Table# | Start | Size | GEN# | a  | n1 | b 
         f        10       0     4096    5     1   4096 .001

     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;  Function Table 11 Exponential Exponential Triangle
    ;
    ;                  .
    ;                  .
    ;                 . .
    ;               .      .
    ;           .              .
    ;      .                       .
    ; .                                 .
    ; Command | Table# | Start | Size | GEN# | a  | n1 | b 
         f        10       0     4096    5     1   4096 .001

  </CsScore>
</CsoundSynthesizer>
