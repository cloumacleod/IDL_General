	PRO QMPLOT,FILENAME,DELETE=DELETE,QUEUE=QUEUE,COMMAND=COMMAND
;+
; Project     : SOHO - CDS
;
; Name        : 
;	QMPLOT
; Purpose     : 
;	Print a QMS plot file and reset the graphics device.
; Explanation : 
;	Sends a QMS plot file generated by IDL to the QMS laser printer.  The
;	default queue is defined by the logical name/environment variable
;	LASER.  The graphics device is reset to what was used previously.
; Use         : 
;	QMPLOT  [, FILE ]  [, /DELETE ]
;
;	QMS				;Open QMS plot file
;	   ... plotting commands ...	;Create plot
;	QMPLOT				;Close & plot file, reset to prev. dev.
;	   or
;	QMCLOSE				;Close w/o printing,  "    "   "    "
;
; Inputs      : 
;	None required.
; Opt. Inputs : 
;	The default filename is either taken from the last call to the QMS
;	routine, or is "idl.bit".
;
;	A filename other than the default can be passed in one of three ways:
;
;		Explicitly:		e.g. QMPLOT,'graph.bit'
;		By number (VMS)		e.g. QMPLOT,3   for "idl.bit;3"
;		All versions (VMS)	e.g. QMPLOT,'*' for "idl.bit;*"
;		All ".bit" files (UNIX)	e.g. QMPLOT,'*' for "*.bit"
; Outputs     : 
;	A message is printed to the screen.
; Opt. Outputs: 
;	None.
; Keywords    : 
;	DELETE	= If set, then file is deleted after printing.
;	QUEUE	= Name of printer queue to be used in printing the file.
;	COMMAND	= (Unix only.)  Command to be used to send the plot file to the
;		  printer.  If not passed, then the environment variable
;		  PRINTCOM is checked.  If neither of these is set, then the
;		  standard command "lpr" is used.
; Calls       : 
;	SETPLOT
; Common      : 
;	QMS_FILE which contains QMS_FILENAME, the name of the plotting file,
;	and LAST_DEVICE, which is the name of the previous graphics device.
; Restrictions: 
;	The requested plot file must exist.
;
;	In general, the SERTS graphics devices routines use the special system
;	variables !BCOLOR and !ASPECT.  These system variables are defined in
;	the procedure DEVICELIB.  It is suggested that the command DEVICELIB be
;	placed in the user's IDL_STARTUP file.
;
; Side effects: 
;	The plot file is queued on the printer LASER.  Also, any files
;	"idl.bit" that may be open will be closed.  The previous plotting
;	device is reset.
; Category    : 
;	Utilities, Devices.
; Prev. Hist. : 
;	W.T.T., February, 1991, from PSPLOT.
;	W.T.T., May 1991, extended environment variable LASER to UNIX.
;	W.T.T., Jul 1992, added check for QMS_FILENAME in common block.
; Written     : 
;	William Thompson, GSFC, February 1991.
; Modified    : 
;	Version 1, William Thompson, GSFC, 27 April 1993.
;		Incorporated into CDS library.
;	Version 2, William Thompson, GSFC, 3 June 1993.
;		Fixed bug with ENDIF/ENDELSE statements.
;	Version 3, William Thompson, GSFC, 8 June 1994
;		Added keyword COMMAND
; Version     : 
;	Version 3, 8 June 1994
;-
;
	COMMON QMS_FILE, QMS_FILENAME, LAST_DEVICE
	STRING_TYPE = 7
;
;  No parameters passed:  assume either the name from the last time QMS was
;  called, or "idl.bit".
;
	IF N_PARAMS(0) EQ 0 THEN BEGIN
		IF N_ELEMENTS(QMS_FILENAME) EQ 1 THEN BEGIN
			IF QMS_FILENAME EQ "" THEN FILENAME = "idl.bit"	$
				ELSE FILENAME = QMS_FILENAME
		END ELSE FILENAME = "idl.bit"
	ENDIF
;
;  Test and interpret FILENAME.
;
	S = SIZE(FILENAME)
	IF S(0) NE 0 THEN BEGIN
		PRINT,'*** Variable must not be an array, ' +	$
			'name= FILE, routine QMPLOT.'
		RETURN
;
;  If of type string, then must be the filename.  If the string "*", then the
;  meaning depends on which operating system is being used.
;
	END ELSE IF S(1) EQ STRING_TYPE THEN BEGIN
		IF FILENAME EQ "*" THEN BEGIN
			IF !VERSION.OS EQ "vms" THEN BEGIN
				FILENAME = "idl.bit;*"
			END ELSE BEGIN
				FILENAME = "*.bit"
			ENDELSE
		ENDIF
;
;  If numerical, then either it is the file version number (VMS) or it is
;  simply incorrect (UNIX).
;
	END ELSE IF !VERSION.OS EQ "vms" THEN BEGIN
		FILENAME = "idl.bit;" + TRIM(FILENAME)
	END ELSE BEGIN
		PRINT,'*** Variable must be of type string, ' +		$
			'name= FILENAME, routine QMPLOT.'
		RETURN
	ENDELSE
;
;  If passed, then check the value of QUEUE.
;
	IF N_ELEMENTS(QUEUE) NE 0 THEN BEGIN
		SQ = SIZE(QUEUE)
		IF S(0) NE 0 THEN BEGIN
			PRINT,'*** Variable must not be an array, ' +	$
				'name= QUEUE, routine QMPLOT.'
			RETURN
		END ELSE IF S(1) NE STRING_TYPE THEN BEGIN
			PRINT,'*** Variable must be of type string, ' +	$
				'name= QUEUE, routine QMPLOT.'
			RETURN
		ENDIF
;
;  Otherwise check the logical name/environment variable LASER to get the name
;  of the queue.  A queue name is required.
;
	END ELSE BEGIN
		LASER = GETENV("LASER")
		IF LASER NE "" THEN BEGIN
			QUEUE = LASER
		END ELSE BEGIN
			PRINT,'*** Logical name LASER or keyword QUEUE ' + $
				'must be defined, routine QMPLOT.'
			RETURN
		ENDELSE
	ENDELSE
;
;  Close any QMS files.
;
	DEVICE = !D.NAME
	IF N_ELEMENTS(LAST_DEVICE) EQ 0 THEN LAST_DEVICE = !D.NAME
	IF !D.NAME NE 'QMS' THEN SETPLOT,'QMS'
	DEVICE,/CLOSE_FILE
	QMS_FILENAME = ""
;
;  Form the print command according to the operating system.
;
	IF !VERSION.OS EQ "vms" THEN BEGIN
		LASER = TRIM(STRUPCASE(QUEUE))
		COM_LINE = "PRINT /NOTIFY /QUEUE=" + LASER + " "
		IF LASER EQ "SOLAR$TALARIS" THEN	$
			COM_LINE = COM_LINE + "/SETUP=QC "
	END ELSE BEGIN
;
;  In UNIX, use the switch "-P" to control which queue is used.  Otherwise, the
;  default print queue is used.  The printing command can be set by the keyword
;  COMMAND, by the environment variable PRINTCOM, or the standard command "lpr"
;  can be used.
;
		IF N_ELEMENTS(COMMAND) EQ 1 THEN PRINTCOM = COMMAND ELSE $
			PRINTCOM = GETENV("PRINTCOM")
		IF PRINTCOM EQ "" THEN PRINTCOM = "lpr"
		COM_LINE = PRINTCOM + " "
		IF N_ELEMENTS(QUEUE) NE 0 THEN	$
			COM_LINE = COM_LINE + "-P" + QUEUE + " "
	ENDELSE
;
;  Test to see if the DELETE keyword was set.
;
	IF KEYWORD_SET(DELETE) THEN IF !VERSION.OS EQ "vms" THEN	$
		COM_LINE = COM_LINE + "/DELETE "	    ELSE	$
		COM_LINE = COM_LINE + "-r "
	COM_LINE = COM_LINE + FILENAME
	PRINT,"$ " + COM_LINE
	SPAWN,COM_LINE
;
;  Reset the plotting device.
;
	IF DEVICE NE 'QMS' THEN SETPLOT,DEVICE ELSE SETPLOT,LAST_DEVICE
	PRINT,'The plotting device is now set to '+TRIM(LAST_DEVICE)+'.'
;
	RETURN
	END
