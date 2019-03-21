" Vim syntax file
" Language: csound document
" Last modified: Wed Mar 20 13:49:58 2019


if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn keyword csoundOpcode ATSadd ATSaddnz ATSbufread ATScross ATSinfo
syn keyword csoundOpcode ATSinterpread ATSpartialtap ATSread ATSreadnz ATSsinnoi
syn keyword csoundOpcode FLbox FLbutBank FLbutton FLcloseButton FLcolor FLcolor2
syn keyword csoundOpcode FLcount FLexecButton FLgetsnap FLgroup FLgroupEnd
syn keyword csoundOpcode FLgroup_end FLhide FLhvsBox FLhvsBoxSetValue FLjoy
syn keyword csoundOpcode FLkeyIn FLknob FLlabel FLloadsnap FLmouse FLpack
syn keyword csoundOpcode FLpackEnd FLpack_end FLpanel FLpanelEnd FLpanel_end
syn keyword csoundOpcode FLprintk FLprintk2 FLroller FLrun FLsavesnap FLscroll
syn keyword csoundOpcode FLscrollEnd FLscroll_end FLsetAlign FLsetBox FLsetColor
syn keyword csoundOpcode FLsetColor2 FLsetFont FLsetPosition FLsetSize
syn keyword csoundOpcode FLsetSnapGroup FLsetText FLsetTextColor FLsetTextSize
syn keyword csoundOpcode FLsetTextType FLsetVal FLsetVal_i FLsetVali FLsetsnap
syn keyword csoundOpcode FLshow FLslidBnk FLslidBnk2 FLslidBnk2Set FLslidBnk2Setk
syn keyword csoundOpcode FLslidBnkGetHandle FLslidBnkSet FLslidBnkSetk FLslider
syn keyword csoundOpcode FLtabs FLtabsEnd FLtabs_end FLtext FLupdate FLvalue
syn keyword csoundOpcode FLvkeybd FLvslidBnk FLvslidBnk2 FLxyin JackoAudioIn
syn keyword csoundOpcode JackoAudioInConnect JackoAudioOut JackoAudioOutConnect
syn keyword csoundOpcode JackoFreewheel JackoInfo JackoInit JackoMidiInConnect
syn keyword csoundOpcode JackoMidiOut JackoMidiOutConnect JackoNoteOut JackoOn
syn keyword csoundOpcode JackoTransport MixerClear MixerGetLevel MixerReceive
syn keyword csoundOpcode MixerSend MixerSetLevel MixerSetLevel_i OSCinit
syn keyword csoundOpcode OSClisten OSCsend STKBandedWG STKBeeThree STKBlowBotl
syn keyword csoundOpcode STKBlowHole STKBowed STKBrass STKClarinet STKDrummer
syn keyword csoundOpcode STKFMVoices STKFlute STKHevyMetl STKMandolin STKModalBar
syn keyword csoundOpcode STKMoog STKPercFlut STKPlucked STKResonate STKRhodey
syn keyword csoundOpcode STKSaxofony STKShakers STKSimple STKSitar STKStifKarp
syn keyword csoundOpcode STKTubeBell STKVoicForm STKWhistle STKWurley a abs
syn keyword csoundOpcode active adsr adsyn adsynt adsynt2 aftouch alpass alwayson
syn keyword csoundOpcode ampdb ampdbfs ampmidi ampmidid areson aresonk array
syn keyword csoundOpcode atone atonek atonex babo balance bamboo barmodel bbcutm
syn keyword csoundOpcode bbcuts betarand bexprnd bformdec bformdec1 bformenc
syn keyword csoundOpcode bformenc1 binit biquad biquada birnd bqrez buchla butbp
syn keyword csoundOpcode butbr buthp butlp butterbp butterbr butterhp butterlp
syn keyword csoundOpcode button buzz c2r cabasa cauchy cauchyi ceil cell cent
syn keyword csoundOpcode centroid ceps cggoto chanctrl changed chani chano
syn keyword csoundOpcode chebyshevpoly checkbox chn_S chn_a chn_k chnclear
syn keyword csoundOpcode chnexport chnget chnmix chnparams chnset chuap cigoto
syn keyword csoundOpcode cingoto ckgoto clear clfilt clip clockoff clockon
syn keyword csoundOpcode cmplxprod cngoto comb combinv compilecsd compileorc
syn keyword csoundOpcode compilestr compress connect control convle convolve
syn keyword csoundOpcode copy2ftab copy2ttab copya2ftab copyf2array cos cosh
syn keyword csoundOpcode cosinv cosseg cossegb cossegr cps2pch cpsmidi cpsmidib
syn keyword csoundOpcode cpsmidinn cpsoct cpspch cpstmid cpstun cpstuni cpsxpch
syn keyword csoundOpcode cpumeter cpuprc cross2 crossfm crossfmi crossfmpm
syn keyword csoundOpcode crossfmpmi crosspm crosspmi crunch ctlchn ctrl14 ctrl21
syn keyword csoundOpcode ctrl7 ctrlinit cuserrnd dam date dates db dbamp dbfsamp
syn keyword csoundOpcode dcblock dcblock2 dconv delay delay1 delayk delayr delayw
syn keyword csoundOpcode deltap deltap3 deltapi deltapn deltapx deltapxw denorm
syn keyword csoundOpcode diff diskgrain diskin diskin2 dispfft display distort
syn keyword csoundOpcode distort1 divz doppler downsamp dripwater dssiactivate
syn keyword csoundOpcode dssiaudio dssictls dssiinit dssilist dumpk dumpk2 dumpk3
syn keyword csoundOpcode dumpk4 duserrnd dust dust2 endin endop envlpx envlpxr
syn keyword csoundOpcode ephasor eqfil evalstr event event_i exciter exitnow exp
syn keyword csoundOpcode expcurve expon exprand exprandi expseg expsega expsegb
syn keyword csoundOpcode expsegba expsegr fareylen fareyleni fft fftinv ficlose
syn keyword csoundOpcode filebit filelen filenchnls filepeak filesr filevalid
syn keyword csoundOpcode fillarray filter2 fin fini fink fiopen flanger flashtxt
syn keyword csoundOpcode flooper flooper2 floor fluidAllOut fluidCCi fluidCCk
syn keyword csoundOpcode fluidControl fluidEngine fluidLoad fluidNote fluidOut
syn keyword csoundOpcode fluidProgramSelect fluidSetInterpMethod fmb3 fmbell
syn keyword csoundOpcode fmmetal fmpercfl fmrhode fmvoice fmwurlie fof fof2
syn keyword csoundOpcode fofilter fog fold follow follow2 foscil foscili fout
syn keyword csoundOpcode fouti foutir foutk fprintks fprints frac fractalnoise
syn keyword csoundOpcode freeverb ftchnls ftconv ftcps ftfree ftgen ftgenonce
syn keyword csoundOpcode ftgentmp ftlen ftload ftloadk ftlptim ftmorf ftresize
syn keyword csoundOpcode ftresizei ftsave ftsavek ftsr gain gainslider gauss
syn keyword csoundOpcode gaussi gausstrig gbuzz genarray genarray_i gendy gendyc
syn keyword csoundOpcode gendyx getcfg getcol getrow gogobel goto grain grain2
syn keyword csoundOpcode grain3 granule guiro harmon harmon2 harmon3 harmon4
syn keyword csoundOpcode hilbert hrtfearly hrtfer hrtfmove hrtfmove2 hrtfreverb
syn keyword csoundOpcode hrtfstat hsboscil hvs1 hvs2 hvs3 i iceps igoto ihold
syn keyword csoundOpcode imagecreate imagefree imagegetpixel imageload imagesave
syn keyword csoundOpcode imagesetpixel imagesize in in32 inch inh init initc14
syn keyword csoundOpcode initc21 initc7 inleta inletf inletk inletkid inletv ino
syn keyword csoundOpcode inq inrg ins insglobal insremot instr int integ interp
syn keyword csoundOpcode invalue inx inz jacktransport jitter jitter2 joystick
syn keyword csoundOpcode jspline k kgoto ktableseg la_i_add_mc la_i_add_mr
syn keyword csoundOpcode la_i_add_vc la_i_add_vr la_i_assign_mc la_i_assign_mr
syn keyword csoundOpcode la_i_assign_t la_i_assign_vc la_i_assign_vr
syn keyword csoundOpcode la_i_conjugate_mc la_i_conjugate_mr la_i_conjugate_vc
syn keyword csoundOpcode la_i_conjugate_vr la_i_distance_vc la_i_distance_vr
syn keyword csoundOpcode la_i_divide_mc la_i_divide_mr la_i_divide_vc
syn keyword csoundOpcode la_i_divide_vr la_i_dot_mc la_i_dot_mc_vc la_i_dot_mr
syn keyword csoundOpcode la_i_dot_mr_vr la_i_dot_vc la_i_dot_vr la_i_get_mc
syn keyword csoundOpcode la_i_get_mr la_i_get_vc la_i_get_vr la_i_invert_mc
syn keyword csoundOpcode la_i_invert_mr la_i_lower_solve_mc la_i_lower_solve_mr
syn keyword csoundOpcode la_i_lu_det_mc la_i_lu_det_mr la_i_lu_factor_mc
syn keyword csoundOpcode la_i_lu_factor_mr la_i_lu_solve_mc la_i_lu_solve_mr
syn keyword csoundOpcode la_i_mc_create la_i_mc_set la_i_mr_create la_i_mr_set
syn keyword csoundOpcode la_i_multiply_mc la_i_multiply_mr la_i_multiply_vc
syn keyword csoundOpcode la_i_multiply_vr la_i_norm1_mc la_i_norm1_mr
syn keyword csoundOpcode la_i_norm1_vc la_i_norm1_vr la_i_norm_euclid_mc
syn keyword csoundOpcode la_i_norm_euclid_mr la_i_norm_euclid_vc
syn keyword csoundOpcode la_i_norm_euclid_vr la_i_norm_inf_mc la_i_norm_inf_mr
syn keyword csoundOpcode la_i_norm_inf_vc la_i_norm_inf_vr la_i_norm_max_mc
syn keyword csoundOpcode la_i_norm_max_mr la_i_print_mc la_i_print_mr
syn keyword csoundOpcode la_i_print_vc la_i_print_vr la_i_qr_eigen_mc
syn keyword csoundOpcode la_i_qr_eigen_mr la_i_qr_factor_mc la_i_qr_factor_mr
syn keyword csoundOpcode la_i_qr_sym_eigen_mc la_i_qr_sym_eigen_mr la_i_random_mc
syn keyword csoundOpcode la_i_random_mr la_i_random_vc la_i_random_vr
syn keyword csoundOpcode la_i_size_mc la_i_size_mr la_i_size_vc la_i_size_vr
syn keyword csoundOpcode la_i_subtract_mc la_i_subtract_mr la_i_subtract_vc
syn keyword csoundOpcode la_i_subtract_vr la_i_t_assign la_i_trace_mc
syn keyword csoundOpcode la_i_trace_mr la_i_transpose_mc la_i_transpose_mr
syn keyword csoundOpcode la_i_upper_solve_mc la_i_upper_solve_mr la_i_vc_create
syn keyword csoundOpcode la_i_vc_set la_i_vr_create la_i_vr_set la_k_a_assign
syn keyword csoundOpcode la_k_add_mc la_k_add_mr la_k_add_vc la_k_add_vr
syn keyword csoundOpcode la_k_assign_a la_k_assign_f la_k_assign_mc
syn keyword csoundOpcode la_k_assign_mr la_k_assign_t la_k_assign_vc
syn keyword csoundOpcode la_k_assign_vr la_k_conjugate_mc la_k_conjugate_mr
syn keyword csoundOpcode la_k_conjugate_vc la_k_conjugate_vr la_k_current_f
syn keyword csoundOpcode la_k_current_vr la_k_distance_vc la_k_distance_vr
syn keyword csoundOpcode la_k_divide_mc la_k_divide_mr la_k_divide_vc
syn keyword csoundOpcode la_k_divide_vr la_k_dot_mc la_k_dot_mc_vc la_k_dot_mr
syn keyword csoundOpcode la_k_dot_mr_vr la_k_dot_vc la_k_dot_vr la_k_f_assign
syn keyword csoundOpcode la_k_get_mc la_k_get_mr la_k_get_vc la_k_get_vr
syn keyword csoundOpcode la_k_invert_mc la_k_invert_mr la_k_lower_solve_mc
syn keyword csoundOpcode la_k_lower_solve_mr la_k_lu_det_mc la_k_lu_det_mr
syn keyword csoundOpcode la_k_lu_factor_mc la_k_lu_factor_mr la_k_lu_solve_mc
syn keyword csoundOpcode la_k_lu_solve_mr la_k_mc_set la_k_mr_set
syn keyword csoundOpcode la_k_multiply_mc la_k_multiply_mr la_k_multiply_vc
syn keyword csoundOpcode la_k_multiply_vr la_k_norm1_mc la_k_norm1_mr
syn keyword csoundOpcode la_k_norm1_vc la_k_norm1_vr la_k_norm_euclid_mc
syn keyword csoundOpcode la_k_norm_euclid_mr la_k_norm_euclid_vc
syn keyword csoundOpcode la_k_norm_euclid_vr la_k_norm_inf_mc la_k_norm_inf_mr
syn keyword csoundOpcode la_k_norm_inf_vc la_k_norm_inf_vr la_k_norm_max_mc
syn keyword csoundOpcode la_k_norm_max_mr la_k_qr_eigen_mc la_k_qr_eigen_mr
syn keyword csoundOpcode la_k_qr_factor_mc la_k_qr_factor_mr la_k_qr_sym_eigen_mc
syn keyword csoundOpcode la_k_qr_sym_eigen_mr la_k_random_mc la_k_random_mr
syn keyword csoundOpcode la_k_random_vc la_k_random_vr la_k_subtract_mc
syn keyword csoundOpcode la_k_subtract_mr la_k_subtract_vc la_k_subtract_vr
syn keyword csoundOpcode la_k_t_assign la_k_trace_mc la_k_trace_mr
syn keyword csoundOpcode la_k_upper_solve_mc la_k_upper_solve_mr la_k_vc_set
syn keyword csoundOpcode la_k_vr_set lenarray lentab lfo limit line linen linenr
syn keyword csoundOpcode lineto linrand linseg linsegb linsegr locsend locsig log
syn keyword csoundOpcode log10 log2 logbtwo logcurve loop_ge loop_gt loop_le
syn keyword csoundOpcode loop_lt loopseg loopsegp looptseg loopxseg lorenz loscil
syn keyword csoundOpcode loscil3 loscilx lowpass2 lowres lowresx lpf18 lpform
syn keyword csoundOpcode lpfreson lphasor lpinterp lposcil lposcil3 lposcila
syn keyword csoundOpcode lposcilsa lposcilsa2 lpread lpreson lpshold lpsholdp
syn keyword csoundOpcode lpslot lua_exec lua_iaopcall lua_iaopcall_off
syn keyword csoundOpcode lua_ikopcall lua_ikopcall_off lua_iopcall
syn keyword csoundOpcode lua_iopcall_off lua_opdef mac maca madsr mags mandel
syn keyword csoundOpcode mandol maparray maparray_i marimba massign max max_k
syn keyword csoundOpcode maxabs maxabsaccum maxaccum maxalloc maxarray maxtab
syn keyword csoundOpcode mclock mdelay median mediank metro midglobal midic14
syn keyword csoundOpcode midic21 midic7 midichannelaftertouch midichn
syn keyword csoundOpcode midicontrolchange midictrl mididefault midifilestatus
syn keyword csoundOpcode midiin midinoteoff midinoteoncps midinoteonkey
syn keyword csoundOpcode midinoteonoct midinoteonpch midion midion2 midiout
syn keyword csoundOpcode midipgm midipitchbend midipolyaftertouch
syn keyword csoundOpcode midiprogramchange miditempo midremot min minabs
syn keyword csoundOpcode minabsaccum minaccum minarray mincer mintab mirror mode
syn keyword csoundOpcode modmatrix monitor moog moogladder moogvcf moogvcf2
syn keyword csoundOpcode moscil mp3bitrate mp3in mp3len mp3nchnls mp3sr mpulse
syn keyword csoundOpcode mrtmsg multitap mute mxadsr nestedap nlalp nlfilt
syn keyword csoundOpcode nlfilt2 noise noteoff noteon noteondur noteondur2 notnum
syn keyword csoundOpcode nreverb nrpn nsamp nstance nstrnum ntrpol octave octcps
syn keyword csoundOpcode octmidi octmidib octmidinn octpch opcode oscbnk oscil
syn keyword csoundOpcode oscil1 oscil1i oscil3 oscili oscilikt osciliktp
syn keyword csoundOpcode oscilikts osciln oscils oscilx out out32 outc outch outh
syn keyword csoundOpcode outiat outic outic14 outipat outipb outipc outkat outkc
syn keyword csoundOpcode outkc14 outkpat outkpb outkpc outleta outletf outletk
syn keyword csoundOpcode outletkid outletv outo outq outq1 outq2 outq3 outq4
syn keyword csoundOpcode outrg outs outs1 outs2 outvalue outx outz p pan pan2
syn keyword csoundOpcode pareq partials partikkel partikkelget partikkelset
syn keyword csoundOpcode partikkelsync passign pcauchy pchbend pchmidi pchmidib
syn keyword csoundOpcode pchmidinn pchoct pconvolve pcount pdclip pdhalf pdhalfy
syn keyword csoundOpcode peak pgmassign pgmchn phaser1 phaser2 phasor phasorbnk
syn keyword csoundOpcode phs pindex pinker pinkish pitch pitchac pitchamdf planet
syn keyword csoundOpcode platerev plltrack pluck poisson pol2rect polyaft
syn keyword csoundOpcode polynomial pop pop_f port portk poscil poscil3 pow
syn keyword csoundOpcode powershape powoftwo prealloc prepiano print print_type
syn keyword csoundOpcode printf printf_i printk printk2 printks printks2 prints
syn keyword csoundOpcode product pset ptable ptable3 ptablei ptableiw ptablew
syn keyword csoundOpcode ptrack push push_f puts pvadd pvbufread pvcross pvinterp
syn keyword csoundOpcode pvoc pvread pvs2array pvs2tab pvsadsyn pvsanal pvsarp
syn keyword csoundOpcode pvsbandp pvsbandr pvsbin pvsblur pvsbuffer pvsbufread
syn keyword csoundOpcode pvsbufread2 pvscale pvscent pvsceps pvscross pvsdemix
syn keyword csoundOpcode pvsdiskin pvsdisp pvsenvftw pvsfilter pvsfread pvsfreeze
syn keyword csoundOpcode pvsfromarray pvsftr pvsftw pvsfwrite pvsgain pvsgendy
syn keyword csoundOpcode pvshift pvsifd pvsin pvsinfo pvsinit pvslock pvsmaska
syn keyword csoundOpcode pvsmix pvsmooth pvsmorph pvsosc pvsout pvspitch pvstanal
syn keyword csoundOpcode pvstencil pvsvoc pvswarp pvsynth pwd pyassign pyassigni
syn keyword csoundOpcode pyassignt pycall pycall1 pycall1i pycall1t pycall2
syn keyword csoundOpcode pycall2i pycall2t pycall3 pycall3i pycall3t pycall4
syn keyword csoundOpcode pycall4i pycall4t pycall5 pycall5i pycall5t pycall6
syn keyword csoundOpcode pycall6i pycall6t pycall7 pycall7i pycall7t pycall8
syn keyword csoundOpcode pycall8i pycall8t pycalli pycalln pycallni pycallt
syn keyword csoundOpcode pyeval pyevali pyevalt pyexec pyexeci pyexect pyinit
syn keyword csoundOpcode pylassign pylassigni pylassignt pylcall pylcall1
syn keyword csoundOpcode pylcall1i pylcall1t pylcall2 pylcall2i pylcall2t
syn keyword csoundOpcode pylcall3 pylcall3i pylcall3t pylcall4 pylcall4i
syn keyword csoundOpcode pylcall4t pylcall5 pylcall5i pylcall5t pylcall6
syn keyword csoundOpcode pylcall6i pylcall6t pylcall7 pylcall7i pylcall7t
syn keyword csoundOpcode pylcall8 pylcall8i pylcall8t pylcalli pylcalln pylcallni
syn keyword csoundOpcode pylcallt pyleval pylevali pylevalt pylexec pylexeci
syn keyword csoundOpcode pylexect pylrun pylruni pylrunt pyrun pyruni pyrunt qinf
syn keyword csoundOpcode qnan r2c rand randh randi random randomh randomi rbjeq
syn keyword csoundOpcode readclock readf readfi readk readk2 readk3 readk4 readks
syn keyword csoundOpcode readscore readscratch rect2pol reinit release remoteport
syn keyword csoundOpcode remove repluck reson resonk resonr resonx resonxk resony
syn keyword csoundOpcode resonz resyn return reverb reverb2 reverbsc rewindscore
syn keyword csoundOpcode rezzy rfft rifft rigoto rireturn rms rnd rnd31 round
syn keyword csoundOpcode rspline rtclock s16b14 s32b14 samphold sandpaper scale
syn keyword csoundOpcode scalearray scalet scanhammer scantable schedkwhen
syn keyword csoundOpcode schedkwhennamed schedule schedwhen scoreline scoreline_i
syn keyword csoundOpcode seed sekere semitone sense sensekey seqtime seqtime2
syn keyword csoundOpcode serialBegin serialEnd serialFlush serialPrint serialRead
syn keyword csoundOpcode serialWrite serialWrite_i setcol setctrl setksmps setrow
syn keyword csoundOpcode setscorepos sfilist sfinstr sfinstr3 sfinstr3m sfinstrm
syn keyword csoundOpcode sfload sflooper sfpassign sfplay sfplay3 sfplay3m
syn keyword csoundOpcode sfplaym sfplist sfpreset shaker shiftin shiftout
syn keyword csoundOpcode signalflowgraph signum sin sinh sininv sinsyn
syn keyword csoundOpcode sleighbells slicearray slider16 slider16f slider16table
syn keyword csoundOpcode slider16tablef slider32 slider32f slider32table
syn keyword csoundOpcode slider32tablef slider64 slider64f slider64table
syn keyword csoundOpcode slider64tablef slider8 slider8f slider8table
syn keyword csoundOpcode slider8tablef sliderKawai sndload sndloop sndwarp
syn keyword csoundOpcode sndwarpst sockrecv sockrecvs socksend socksends soundin
syn keyword csoundOpcode soundout soundouts space spat3d spat3di spat3dt spdist
syn keyword csoundOpcode specaddm specdiff specdisp specfilt spechist specptrk
syn keyword csoundOpcode specscal specsum spectrum splitrig sprintf sprintfk
syn keyword csoundOpcode spsend sqrt stack statevar stix strcat strcatk strchar
syn keyword csoundOpcode strchark strcmp strcmpk strcpy strcpyk strecv streson
syn keyword csoundOpcode strget strindex strindexk strlen strlenk strlower
syn keyword csoundOpcode strlowerk strrindex strrindexk strset strsub strsubk
syn keyword csoundOpcode strtod strtodk strtol strtolk strupper strupperk stsend
syn keyword csoundOpcode subinstr subinstrinit sum sumarray sumtab svfilter
syn keyword csoundOpcode syncgrain syncloop syncphasor system system_i tab
syn keyword csoundOpcode tab2pvs tab_i tabgen table table3 table3kt tablecopy
syn keyword csoundOpcode tablefilter tablefilteri tablegpw tablei tableicopy
syn keyword csoundOpcode tableigpw tableikt tableimix tableiw tablekt tablemix
syn keyword csoundOpcode tableng tablera tableseg tableshuffle tableshufflei
syn keyword csoundOpcode tablew tablewa tablewkt tablexkt tablexseg tabmap
syn keyword csoundOpcode tabmap_i tabmorph tabmorpha tabmorphak tabmorphi tabplay
syn keyword csoundOpcode tabrec tabslice tabsum tabw tabw_i tambourine tan tanh
syn keyword csoundOpcode taninv taninv2 tb0 tb0_init tb1 tb10 tb10_init tb11
syn keyword csoundOpcode tb11_init tb12 tb12_init tb13 tb13_init tb14 tb14_init
syn keyword csoundOpcode tb15 tb15_init tb1_init tb2 tb2_init tb3 tb3_init tb4
syn keyword csoundOpcode tb4_init tb5 tb5_init tb6 tb6_init tb7 tb7_init tb8
syn keyword csoundOpcode tb8_init tb9 tb9_init tbvcf tempest tempo temposcal
syn keyword csoundOpcode tempoval tigoto timedseq timeinstk timeinsts timek times
syn keyword csoundOpcode timout tival tlineto tone tonek tonex tradsyn trandom
syn keyword csoundOpcode transeg transegb transegr trcross trfilter trhighest
syn keyword csoundOpcode trigger trigseq trirand trlowest trmix trscale trshift
syn keyword csoundOpcode trsplit turnoff turnoff2 turnon unirand unwrap upsamp
syn keyword csoundOpcode urandom urd vactrol vadd vadd_i vaddv vaddv_i vaget
syn keyword csoundOpcode valpass vaset vbap vbap16 vbap4 vbap4move vbap8
syn keyword csoundOpcode vbap8move vbapg vbapgmove vbaplsinit vbapmove vbapz
syn keyword csoundOpcode vbapzmove vcella vco vco2 vco2ft vco2ift vco2init vcomb
syn keyword csoundOpcode vcopy vcopy_i vdel_k vdelay vdelay3 vdelayk vdelayx
syn keyword csoundOpcode vdelayxq vdelayxs vdelayxw vdelayxwq vdelayxws vdivv
syn keyword csoundOpcode vdivv_i vecdelay veloc vexp vexp_i vexpseg vexpv vexpv_i
syn keyword csoundOpcode vibes vibr vibrato vincr vlimit vlinseg vlowres vmap
syn keyword csoundOpcode vmirror vmult vmult_i vmultv vmultv_i voice vosim
syn keyword csoundOpcode vphaseseg vport vpow vpow_i vpowv vpowv_i vpvoc vrandh
syn keyword csoundOpcode vrandi vsubv vsubv_i vtaba vtabi vtabk vtable1k vtablea
syn keyword csoundOpcode vtablei vtablek vtablewa vtablewi vtablewk vtabwa vtabwi
syn keyword csoundOpcode vtabwk vwrap waveset weibull wgbow wgbowedbar wgbrass
syn keyword csoundOpcode wgclar wgflute wgpluck wgpluck2 wguide1 wguide2 window
syn keyword csoundOpcode wrap writescratch wterrain xadsr xin xout xtratim xyin
syn keyword csoundOpcode zacl zakinit zamod zar zarg zaw zawm zfilter2 zir ziw
syn keyword csoundOpcode ziwm zkcl zkmod zkr zkw zkwm

syn match csoundNumber "\<\d\+\>"
syn match csoundNumber "\<\d\+\.\d*\>"
syn match csoundNumber "\.\d\+\>"
syn region csoundString start=+"+ skip=+\\\\\|\\"+ end=+"+
syn match csoundMathsOperator "-\|=\|[:<>+\*^/\\]\|AND\|OR"
syn region csoundComment start="\/\*" end="\*\/"
syn region csoundComment start=";" end="$"
syn region csoundDefine start="^\s*#\s*define" skip="\\$" end="$"
syn region csoundInclude start="^\s*#\s*include" skip="\\$" end="$"

if version >= 508 || !exists("did_csound_syntax_inits")
  if version < 508
    let did_csound_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink csoundDefine PreProc
  HiLink csoundInclude	PreProc
  HiLink csoundConditional	Conditional
  HiLink csoundNumber Number
  HiLink csoundError	Error
  HiLink csoundOpcode Statement
  HiLink csoundString String
  HiLink csoundComment Comment
  HiLink csoundTodo Todo
  HiLink csoundMathsOperator Operator
  delcommand HiLink
endif
let b:current_syntax = "csound"
