; Project     : The ULTIMATE IDL Object
;
; Name        : ULTIMON_INFO__DEFINE
;
; Purpose     : Used by ULTIMON__DEFINE for dynamic data handling.
;
; Category    : Ancillary Synoptic Objects
;
; Syntax      : N/A
;
; Example     : 
;
; Notes       :
;
; History     : Written 18-AUG-2007 (My birthday!), Paul Higgins, (ARG/TCD)
;
; Tutorial    : Not yet. For now take a look at the configuration section of 
;               [http://solarmonitor.org/solmon_tutorial.html]
;
; Contact     : P.A. Higgins: era {at} msn {dot} com
;               P. Gallagher: peter.gallagher {at} tcd {dot} ie
;-->
;----------------------------------------------------------------------------->

;-------------------------------------------------------->

PRO ultimon_info__define

  struct = { ultimon_info, $
	data: fltarr(1024,1024), $

	;--<< Map header variables. >>

	ut: '', $
	obs: '', $
	instrument: '', $
	filter: '', $
	timerange: ['',''], $
	header: strarr(2,13) $

	}
	 
END

;-------------------------------------------------------->