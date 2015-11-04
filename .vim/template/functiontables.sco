
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
			 f        11       0     4096    5     1   4096 .001

