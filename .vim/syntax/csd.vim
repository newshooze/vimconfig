" Vim syntax file
" Language:	csound document	

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn keyword csdOpcode ATSadd ATSaddnz ATSbufread ATScross ATSinfo ATSinterpread
syn keyword csdOpcode ATSpartialtap ATSread ATSreadnz ATSsinnoi FLbox FLbutBank
syn keyword csdOpcode FLbutton FLcloseButton FLcolor FLcolor2 FLcount
syn keyword csdOpcode FLexecButton FLgetsnap FLgroup FLgroupEnd FLgroup_end
syn keyword csdOpcode FLhide FLhvsBox FLhvsBoxSetValue FLjoy FLkeyIn FLknob
syn keyword csdOpcode FLlabel FLloadsnap FLmouse FLpack FLpackEnd FLpack_end
syn keyword csdOpcode FLpanel FLpanelEnd FLpanel_end FLprintk FLprintk2 FLroller
syn keyword csdOpcode FLrun FLsavesnap FLscroll FLscrollEnd FLscroll_end
syn keyword csdOpcode FLsetAlign FLsetBox FLsetColor FLsetColor2 FLsetFont
syn keyword csdOpcode FLsetPosition FLsetSize FLsetSnapGroup FLsetText
syn keyword csdOpcode FLsetTextColor FLsetTextSize FLsetTextType FLsetVal
syn keyword csdOpcode FLsetVal_i FLsetVali FLsetsnap FLshow FLslidBnk FLslidBnk2
syn keyword csdOpcode FLslidBnk2Set FLslidBnk2Setk FLslidBnkGetHandle
syn keyword csdOpcode FLslidBnkSet FLslidBnkSetk FLslider FLtabs FLtabsEnd
syn keyword csdOpcode FLtabs_end FLtext FLupdate FLvalue FLvkeybd FLvslidBnk
syn keyword csdOpcode FLvslidBnk2 FLxyin MixerClear MixerGetLevel MixerReceive
syn keyword csdOpcode MixerSend MixerSetLevel OSCinit OSClisten OSCrecv OSCsend a
syn keyword csdOpcode abs active add adsr adsyn adsynt adsynt2 aftouch alpass
syn keyword csdOpcode ampdb ampdbfs ampmidi and areson aresonk atone atonek
syn keyword csdOpcode atonex babo balance bamboo barmodel bbcutm bbcuts betarand
syn keyword csdOpcode bexprnd bformdec bformdec1 bformenc bformenc1 binit biquad
syn keyword csdOpcode biquada birnd bqrez butbp butbr buthp butlp butterbp
syn keyword csdOpcode butterbr butterhp butterlp button buzz cabasa cauchy ceil
syn keyword csdOpcode cent cggoto chanctrl changed chani chano chebyshevpoly
syn keyword csdOpcode checkbox chn_S chn_a chn_k chnclear chnexport chnget chnmix
syn keyword csdOpcode chnparams chnrecv chnsend chnset chuap cigoto ckgoto clear
syn keyword csdOpcode clfilt clip clockoff clockon cngoto cogoto comb compress
syn keyword csdOpcode control convle convolve cos cosh cosinv cps2pch cpsmidi
syn keyword csdOpcode cpsmidib cpsmidinn cpsoct cpspch cpstmid cpstun cpstuni
syn keyword csdOpcode cpsxpch cpuprc cross2 crunch ctlchn ctrl14 ctrl21 ctrl7
syn keyword csdOpcode ctrlinit cuserrnd dam date dates db dbamp dbfsamp dcblock
syn keyword csdOpcode dcblock2 dconv delay delay1 delayk delayr delayw deltap
syn keyword csdOpcode deltap3 deltapi deltapn deltapx deltapxw denorm diff
syn keyword csdOpcode diskgrain diskin diskin2 dispfft display distort distort1
syn keyword csdOpcode div divz downsamp dripwater dssiactivate dssiaudio dssictls
syn keyword csdOpcode dssiinit dssilist dumpk dumpk2 dumpk3 dumpk4 duserrnd endin
syn keyword csdOpcode endop envlpx envlpxr ephasor eqfil event event_i exitnow
syn keyword csdOpcode exp expcurve expon exprand expseg expsega expsegr ficlose
syn keyword csdOpcode filelen filenchnls filepeak filesr filter2 fin fini fink
syn keyword csdOpcode fiopen flanger flashtxt flooper flooper2 flooper3 floor
syn keyword csdOpcode fluidAllOut fluidCCi fluidCCk fluidControl fluidEngine
syn keyword csdOpcode fluidLoad fluidNote fluidOut fluidProgramSelect
syn keyword csdOpcode fluidSetInterpMethod fmb3 fmbell fmmetal fmpercfl fmrhode
syn keyword csdOpcode fmvoice fmwurlie fof fof2 fofilter fog fold follow follow2
syn keyword csdOpcode foscil foscili fout fouti foutir foutk fprintks fprints
syn keyword csdOpcode frac freeverb ftchnls ftconv ftfree ftgen ftgentmp ftlen
syn keyword csdOpcode ftload ftloadk ftlptim ftmorf ftsave ftsavek ftsr gain
syn keyword csdOpcode gainslider gauss gbuzz getcfg gogobel goto grain grain2
syn keyword csdOpcode grain3 granule guiro harmon harmon2 harmon3 harmon4 hilbert
syn keyword csdOpcode hrtfer hrtfmove hrtfmove2 hrtfstat hsboscil hvs1 hvs2 hvs3
syn keyword csdOpcode i iampmidid igoto ihold imagecreate imagefree imagegetpixel
syn keyword csdOpcode imageload imagesave imagesetpixel imagesize in in32 inch
syn keyword csdOpcode inh init initc14 initc21 initc7 ino inq inrg ins insglobal
syn keyword csdOpcode insremot instr int integ interp invalue inx inz
syn keyword csdOpcode jacktransport jitter jitter2 jspline k kampmidid kgoto
syn keyword csdOpcode ktableseg la_i_add_mc la_i_add_mr la_i_add_vc la_i_add_vr
syn keyword csdOpcode la_i_assign_mc la_i_assign_mr la_i_assign_t la_i_assign_vc
syn keyword csdOpcode la_i_assign_vr la_i_conjugate_mc la_i_conjugate_mr
syn keyword csdOpcode la_i_conjugate_vc la_i_conjugate_vr la_i_distance_vc
syn keyword csdOpcode la_i_distance_vr la_i_divide_mc la_i_divide_mr
syn keyword csdOpcode la_i_divide_vc la_i_divide_vr la_i_dot_mc la_i_dot_mc_vc
syn keyword csdOpcode la_i_dot_mr la_i_dot_mr_vr la_i_dot_vc la_i_dot_vr
syn keyword csdOpcode la_i_get_mc la_i_get_mr la_i_get_vc la_i_get_vr
syn keyword csdOpcode la_i_invert_mc la_i_invert_mr la_i_lower_solve_mc
syn keyword csdOpcode la_i_lower_solve_mr la_i_lu_det_mc la_i_lu_det_mr
syn keyword csdOpcode la_i_lu_factor_mc la_i_lu_factor_mr la_i_lu_solve_mc
syn keyword csdOpcode la_i_lu_solve_mr la_i_mc_create la_i_mc_set la_i_mr_create
syn keyword csdOpcode la_i_mr_set la_i_multiply_mc la_i_multiply_mr
syn keyword csdOpcode la_i_multiply_vc la_i_multiply_vr la_i_norm1_mc
syn keyword csdOpcode la_i_norm1_mr la_i_norm1_vc la_i_norm1_vr
syn keyword csdOpcode la_i_norm_euclid_mc la_i_norm_euclid_mr la_i_norm_euclid_vc
syn keyword csdOpcode la_i_norm_euclid_vr la_i_norm_inf_mc la_i_norm_inf_mr
syn keyword csdOpcode la_i_norm_inf_vc la_i_norm_inf_vr la_i_norm_max_mc
syn keyword csdOpcode la_i_norm_max_mr la_i_print_mc la_i_print_mr la_i_print_vc
syn keyword csdOpcode la_i_print_vr la_i_qr_eigen_mc la_i_qr_eigen_mr
syn keyword csdOpcode la_i_qr_factor_mc la_i_qr_factor_mr la_i_qr_sym_eigen_mc
syn keyword csdOpcode la_i_qr_sym_eigen_mr la_i_random_mc la_i_random_mr
syn keyword csdOpcode la_i_random_vc la_i_random_vr la_i_size_mc la_i_size_mr
syn keyword csdOpcode la_i_size_vc la_i_size_vr la_i_subtract_mc la_i_subtract_mr
syn keyword csdOpcode la_i_subtract_vc la_i_subtract_vr la_i_t_assign
syn keyword csdOpcode la_i_trace_mc la_i_trace_mr la_i_transpose_mc
syn keyword csdOpcode la_i_transpose_mr la_i_upper_solve_mc la_i_upper_solve_mr
syn keyword csdOpcode la_i_vc_create la_i_vc_set la_i_vr_create la_i_vr_set
syn keyword csdOpcode la_k_a_assign la_k_add_mc la_k_add_mr la_k_add_vc
syn keyword csdOpcode la_k_add_vr la_k_assign_a la_k_assign_f la_k_assign_mc
syn keyword csdOpcode la_k_assign_mr la_k_assign_t la_k_assign_vc la_k_assign_vr
syn keyword csdOpcode la_k_conjugate_mc la_k_conjugate_mr la_k_conjugate_vc
syn keyword csdOpcode la_k_conjugate_vr la_k_current_f la_k_current_vr
syn keyword csdOpcode la_k_distance_vc la_k_distance_vr la_k_divide_mc
syn keyword csdOpcode la_k_divide_mr la_k_divide_vc la_k_divide_vr la_k_dot_mc
syn keyword csdOpcode la_k_dot_mc_vc la_k_dot_mr la_k_dot_mr_vr la_k_dot_vc
syn keyword csdOpcode la_k_dot_vr la_k_f_assign la_k_get_mc la_k_get_mr
syn keyword csdOpcode la_k_get_vc la_k_get_vr la_k_invert_mc la_k_invert_mr
syn keyword csdOpcode la_k_lower_solve_mc la_k_lower_solve_mr la_k_lu_det_mc
syn keyword csdOpcode la_k_lu_det_mr la_k_lu_factor_mc la_k_lu_factor_mr
syn keyword csdOpcode la_k_lu_solve_mc la_k_lu_solve_mr la_k_mc_set la_k_mr_set
syn keyword csdOpcode la_k_multiply_mc la_k_multiply_mr la_k_multiply_vc
syn keyword csdOpcode la_k_multiply_vr la_k_norm1_mc la_k_norm1_mr la_k_norm1_vc
syn keyword csdOpcode la_k_norm1_vr la_k_norm_euclid_mc la_k_norm_euclid_mr
syn keyword csdOpcode la_k_norm_euclid_vc la_k_norm_euclid_vr la_k_norm_inf_mc
syn keyword csdOpcode la_k_norm_inf_mr la_k_norm_inf_vc la_k_norm_inf_vr
syn keyword csdOpcode la_k_norm_max_mc la_k_norm_max_mr la_k_qr_eigen_mc
syn keyword csdOpcode la_k_qr_eigen_mr la_k_qr_factor_mc la_k_qr_factor_mr
syn keyword csdOpcode la_k_qr_sym_eigen_mc la_k_qr_sym_eigen_mr la_k_random_mc
syn keyword csdOpcode la_k_random_mr la_k_random_vc la_k_random_vr
syn keyword csdOpcode la_k_subtract_mc la_k_subtract_mr la_k_subtract_vc
syn keyword csdOpcode la_k_subtract_vr la_k_t_assign la_k_trace_mc la_k_trace_mr
syn keyword csdOpcode la_k_upper_solve_mc la_k_upper_solve_mr la_k_vc_set
syn keyword csdOpcode la_k_vr_set lfo limit line linen linenr lineto linrand
syn keyword csdOpcode linseg linsegr locsend locsig log log10 logbtwo logcurve
syn keyword csdOpcode loop_ge loop_gt loop_le loop_lt loopseg loopsegp lorenz
syn keyword csdOpcode loscil loscil3 loscilx lowpass2 lowres lowresx lpf18
syn keyword csdOpcode lpfreson lphasor lpinterp lposcil lposcil3 lposcila
syn keyword csdOpcode lposcilsa lposcilsa2 lpread lpreson lpshold lpsholdp lpslot
syn keyword csdOpcode mac maca madsr mandel mandol marimba massign max max_k
syn keyword csdOpcode maxabs maxabsaccum maxaccum maxalloc maxk mclock mdelay
syn keyword csdOpcode metro midglobal midic14 midic21 midic7
syn keyword csdOpcode midichannelaftertouch midichn midicontrolchange midictrl
syn keyword csdOpcode mididefault midiin midinoteoff midinoteoncps midinoteonkey
syn keyword csdOpcode midinoteonoct midinoteonpch midion midion2 midiout midipgm
syn keyword csdOpcode midipitchbend midipolyaftertouch midiprogramchange
syn keyword csdOpcode miditempo midremot min minabs minabsaccum minaccum mirror
syn keyword csdOpcode mod mode monitor moog moogladder moogvcf moogvcf2 moscil
syn keyword csdOpcode mpulse mrtmsg mul multitap mute mutex_lock mutex_locki
syn keyword csdOpcode mutex_unlock mutex_unlocki mxadsr nestedap nlalp nlfilt
syn keyword csdOpcode noise not noteoff noteon noteondur noteondur2 notnum
syn keyword csdOpcode nreverb nrpn nsamp nstrnum ntrpol octave octcps octmidi
syn keyword csdOpcode octmidib octmidinn octpch opcode or oscbnk oscil oscil1
syn keyword csdOpcode oscil1i oscil3 oscili oscilikt osciliktp oscilikts osciln
syn keyword csdOpcode oscils oscilx out out32 outc outch outh outiat outic
syn keyword csdOpcode outic14 outipat outipb outipc outkat outkc outkc14 outkpat
syn keyword csdOpcode outkpb outkpc outo outq outq1 outq2 outq3 outq4 outrg outs
syn keyword csdOpcode outs1 outs2 outvalue outx outz p pan pan2 pareq partials
syn keyword csdOpcode partikkel partikkelsync pcauchy pchbend pchmidi pchmidib
syn keyword csdOpcode pchmidinn pchoct pconvolve pcount pdclip pdhalf pdhalfy
syn keyword csdOpcode peak pgmassign pgmchn phaser1 phaser2 phasor phasorbnk
syn keyword csdOpcode pindex pinkish pitch pitchamdf planet pluck poisson polyaft
syn keyword csdOpcode polynomial pop pop_f port portk poscil poscil3 pow
syn keyword csdOpcode powershape powoftwo prealloc prepiano print printf printf_i
syn keyword csdOpcode printk printk2 printks prints product pset ptrack push
syn keyword csdOpcode push_f puts pvadd pvbufread pvcross pvinterp pvoc pvread
syn keyword csdOpcode pvsadsyn pvsanal pvsarp pvsbandp pvsbandr pvsbin pvsblur
syn keyword csdOpcode pvsbuffer pvsbufread pvscale pvscent pvscross pvsdemix
syn keyword csdOpcode pvsdiskin pvsdisp pvsfilter pvsfread pvsfreeze pvsftr
syn keyword csdOpcode pvsftw pvsfwrite pvshift pvsifd pvsin pvsinfo pvsinit
syn keyword csdOpcode pvsmaska pvsmix pvsmooth pvsmorph pvsosc pvsout pvspitch
syn keyword csdOpcode pvstencil pvsvoc pvsynth pyassign pyassigni pyassignt
syn keyword csdOpcode pycall pycall1 pycall1i pycall1t pycall2 pycall2i pycall2t
syn keyword csdOpcode pycall3 pycall3i pycall3t pycall4 pycall4i pycall4t pycall5
syn keyword csdOpcode pycall5i pycall5t pycall6 pycall6i pycall6t pycall7
syn keyword csdOpcode pycall7i pycall7t pycall8 pycall8i pycall8t pycalli pycalln
syn keyword csdOpcode pycallni pycallt pyeval pyevali pyevalt pyexec pyexeci
syn keyword csdOpcode pyexect pyinit pylassign pylassigni pylassignt pylcall
syn keyword csdOpcode pylcall1 pylcall1i pylcall1t pylcall2 pylcall2i pylcall2t
syn keyword csdOpcode pylcall3 pylcall3i pylcall3t pylcall4 pylcall4i pylcall4t
syn keyword csdOpcode pylcall5 pylcall5i pylcall5t pylcall6 pylcall6i pylcall6t
syn keyword csdOpcode pylcall7 pylcall7i pylcall7t pylcall8 pylcall8i pylcall8t
syn keyword csdOpcode pylcalli pylcalln pylcallni pylcallt pyleval pylevali
syn keyword csdOpcode pylevalt pylexec pylexeci pylexect pylrun pylruni pylrunt
syn keyword csdOpcode pyrun pyruni pyrunt rand randh randi random randomh randomi
syn keyword csdOpcode rbjeq readclock readk readk2 readk3 readk4 reinit release
syn keyword csdOpcode remoteport remove repluck reson resonk resonr resonx
syn keyword csdOpcode resonxk resony resonz resyn reverb reverb2 reverbsc
syn keyword csdOpcode rewindscore rezzy rigoto rireturn rms rnd rnd31 round
syn keyword csdOpcode rspline rtclock s16b14 s32b14 samphold sandpaper scale
syn keyword csdOpcode scanhammer scantable schedkwhen schedkwhennamed schedule
syn keyword csdOpcode schedwhen scoreline scoreline_i seed sekere semitone sense
syn keyword csdOpcode sensekey seqtime seqtime2 setctrl setksmps setscorepos
syn keyword csdOpcode sfilist sfinstr sfinstr3 sfinstr3m sfinstrm sfload sflooper
syn keyword csdOpcode sfpassign sfplay sfplay3 sfplay3m sfplaym sfplist sfpreset
syn keyword csdOpcode shaker shl shr sin sinh sininv sinsyn sleighbells slider16
syn keyword csdOpcode slider16f slider16table slider16tablef slider32 slider32f
syn keyword csdOpcode slider32table slider32tablef slider64 slider64f
syn keyword csdOpcode slider64table slider64tablef slider8 slider8f slider8table
syn keyword csdOpcode slider8tablef sliderKawai sndload sndloop sndwarp sndwarpst
syn keyword csdOpcode sockrecv sockrecvs socksend socksends soundin soundout
syn keyword csdOpcode soundouts space spat3d spat3di spat3dt spdist specaddm
syn keyword csdOpcode specdiff specdisp specfilt spechist specptrk specscal
syn keyword csdOpcode specsum spectrum splitrig sprintf sprintfk spsend sqrt
syn keyword csdOpcode stack statevar stix strcat strcatk strchar strchark strcmp
syn keyword csdOpcode strcmpk strcpy strcpyk strecv streson strget strindex
syn keyword csdOpcode strindexk strlen strlenk strlower strlowerk strrindex
syn keyword csdOpcode strrindexk strset strsub strsubk strtod strtodk strtol
syn keyword csdOpcode strtolk strupper strupperk stsend sub subinstr subinstrinit
syn keyword csdOpcode sum svfilter syncgrain syncloop syncphasor system system_i
syn keyword csdOpcode tab tab_i table table3 tablecopy tablegpw tablei tableicopy
syn keyword csdOpcode tableigpw tableikt tableimix tableiw tablekt tablemix
syn keyword csdOpcode tableng tablera tableseg tablew tablewa tablewkt tablexkt
syn keyword csdOpcode tablexseg tabmorph tabmorpha tabmorphak tabmorphi tabplay
syn keyword csdOpcode tabrec tabw tabw_i tambourine tan tanh taninv taninv2 tb0
syn keyword csdOpcode tb0_init tb1 tb10 tb10_init tb11 tb11_init tb12 tb12_init
syn keyword csdOpcode tb13 tb13_init tb14 tb14_init tb15 tb15_init tb1_init tb2
syn keyword csdOpcode tb2_init tb3 tb3_init tb4 tb4_init tb5 tb5_init tb6
syn keyword csdOpcode tb6_init tb7 tb7_init tb8 tb8_init tb9 tb9_init tbvcf
syn keyword csdOpcode tempest tempo tempoval tigoto timedseq timeinstk timeinsts
syn keyword csdOpcode timek times timout tival tlineto tone tonek tonex tradsyn
syn keyword csdOpcode trandom transeg trcross trfilter trhighest trigger trigseq
syn keyword csdOpcode trirand trlowest trmix trscale trshift trsplit turnoff
syn keyword csdOpcode turnoff2 turnon unirand upsamp urd vadd vadd_i vaddv
syn keyword csdOpcode vaddv_i vaget valpass vaset vbap16 vbap16move vbap4
syn keyword csdOpcode vbap4move vbap8 vbap8move vbaplsinit vbapz vbapzmove vcella
syn keyword csdOpcode vco vco2 vco2ft vco2ift vco2init vcomb vcopy vcopy_i vdel_k
syn keyword csdOpcode vdelay vdelay3 vdelayk vdelayx vdelayxq vdelayxs vdelayxw
syn keyword csdOpcode vdelayxwq vdelayxws vdivv vdivv_i vecdelay veloc vexp
syn keyword csdOpcode vexp_i vexpseg vexpv vexpv_i vibes vibr vibrato vincr
syn keyword csdOpcode vlimit vlinseg vlowres vmap vmirror vmult vmult_i vmultv
syn keyword csdOpcode vmultv_i voice vosim vphaseseg vport vpow vpow_i vpowv
syn keyword csdOpcode vpowv_i vpvoc vrandh vrandi vsubv vsubv_i vtaba vtabi vtabk
syn keyword csdOpcode vtable1k vtablea vtablei vtablek vtablewa vtablewi vtablewk
syn keyword csdOpcode vtabwa vtabwi vtabwk vwrap waveset weibull wgbow wgbowedbar
syn keyword csdOpcode wgbrass wgclar wgflute wgpluck wgpluck2 wguide1 wguide2
syn keyword csdOpcode wrap wterrain xadsr xin xor xout xtratim xyin zacl zakinit
syn keyword csdOpcode zamod zar zarg zaw zawm zfilter2 zir ziw ziwm zkcl zkmod
syn keyword csdOpcode zkr zkw zkwm 

"integer number, or floating point number without a dot.
syn match  csdNumber		"\<\d\+\>"
"floating point number, with dot
syn match  csdNumber		"\<\d\+\.\d*\>"
"floating point number, starting with a dot
syn match  csdNumber		"\.\d\+\>"

" String and Character contstants
syn region  csdString		  start=+"+  skip=+\\\\\|\\"+  end=+"+  

syn match   csdMathsOperator   "-\|=\|[:<>+\*^/\\]\|AND\|OR"

" This allows for embedding python inside csd files
"syntax include @Python syntax/python.vim
"syntax region Python start="{{" end="}}" contains=@Python

syn region csdComment start="\/\*" end="\*\/"
syn region csdComment	start=";" end="$"
syn region csdDefine	start="^\s*#\s*define" skip="\\$" end="$" 
syn region csdInclude	start="^\s*#\s*include" skip="\\$" end="$" 
"syn region csdOptions start="<CsOptions>" end="</CsOptions>" contains=csdMathsOperator,csdComment,csdNumber
"syn region csdInstruments start="<CsInstruments>" end="</CsInstruments>" contains=csdOpcode,csdComment,csdNumber,csdString,csdMathsOperator,Python
"syn region csdScore start="<CsScore>" end="</CsScore>" contains=csdComment,csdNumber,csdMathsOperator,csdDefine,csdInclude


" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_csd_syntax_inits")
  if version < 508
    let did_csd_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif


  HiLink csdDefine		PreProc
  HiLink csdInclude		PreProc
  HiLink csdConditional		Conditional
  HiLink csdNumber		Number
  HiLink csdError		Error
  HiLink csdOpcode		Statement
  HiLink csdString		String
  HiLink csdComment		Comment
  HiLink csdTodo		Todo
  HiLink csdMathsOperator	Operator

  delcommand HiLink
endif

let b:current_syntax = "csd"

" vim: ts=8
