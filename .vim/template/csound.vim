:insert
;vim:ts=2
<CsoundSynthesizer>
<CsOptions>
-odac
</CsOptions>
<CsInstruments>
sr = 96000            ; Samplerate
kr = 9600             ; Control rate
ksmps = 10            ; ...
nchnls = 2            ; Number of audio channels
0dbfs = 1             ; Maximum amplitude is 1.0 ,minimum is 0.0
gitablesize = 65536
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Bipolar
gisine         ftgen  1,0,gitablesize,10,1
gisawup        ftgen  2,0,gitablesize,7,0,gitablesize*.5,1,0,-1,gitablesize*.5,0
gisawdown      ftgen  3,0,gitablesize,7,0,gitablesize*.5,-1,0,1,gitablesize*.5,0
gisquare       ftgen  4,0,gitablesize,7,1,gitablesize*.5,1,0,-1,gitablesize*.5,-1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Unipolar
gipulse        ftgen  5,0,gitablesize,7,1,gitablesize*.5,1,0,0,gitablesize*.5,0
gitriangle     ftgen  6,0,gitablesize,7,0,gitablesize*.5,1,gitablesize*.5,0
girampup       ftgen  7,0,gitablesize,7,0,gitablesize,1
girampdown     ftgen  8,0,gitablesize,7,1,gitablesize,0
giexprampup    ftgen  9,0,gitablesize,5,.001,gitablesize,1
giexprampdown  ftgen  10,0,gitablesize,5,1,gitablesize,.001
giexptriangle  ftgen  11,0,gitablesize,5,.001,gitablesize*.5,1,gitablesize*.5,.001

gareverbleft init 0
gareverbright init 0

instr 1
	idur = p3
	iamp = p4
	ifrq = cpsmidinn(p5)
	aenv linseg .001,.001,1,p3-.002,.001
	a1 poscil aenv,ifrq,2
	;outs a1,a1
	gareverbleft += a1
	gareverbright += a1
endin

instr 99
	iroom = .4	
	idamp = .35	
	al,ar freeverb gareverbleft,gareverbright,iroom,idamp,sr,0	
	outs al,ar
	gareverbleft = 0
	gareverbright = 0
endin 

</CsInstruments>
<CsScore>

t 0 120

; Instrument 1 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;     p1   p2    p3     p4     p5       p6       p7       p8
;  Instr  Start   Dur   Amp    

i     1     0     3      1     53
i     1     3     1      1     58
i     1     4     1      1     61
i     1     6     1      1     54
i     1     7     3      1     56
i     97    0     360
i     98    0     360
i     99    0     360
</CsScore>
</CsoundSynthesizer>

