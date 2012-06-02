pro coldat_1859,ind,eb,fpeak,qpo,rmsiz,rmstz,trmsi,trmst


base1='/raid1/ekalemci/DATA239/1859/

base2=['P57.01/an/','P57.02/an/','P58.00/an/',$
'P58.01/an/','P58.03/an/','P59.00/an/','P60.00/an/','P61.01/an/']


base3_1=['onelor_e1n.dat','onelor_e1n.dat','onelor_e1n.dat',$
'twolor_e1n.dat','twolor_e1n.dat','onelor_e1n.dat','onelor_e1n.dat',$
'onelor_e1n.dat']

base3_2=['twolor_e2n.dat','twolor_e2n.dat','onelor_e2n.dat',$
'twolor_e2n.dat','twolor_e2n.dat','onelor_e2n.dat','onelor_e2n.dat',$
'onelor_e2n.dat']

if eb eq 1 then files=base1+base2+base3_1
if eb eq 2 then files=base1+base2+base3_2

restore,files[ind]

num=n_elements(res)
ele=num/3

rmstoti=0.
rmstott=0.
errix=0.
errtx=0.


q=1
l=1

fpeak=fltarr(2,3)
rmsiz=fltarr(2,3)
rmstz=fltarr(2,3)
qpo=fltarr(2,6)

for j=0,ele-1 do begin
  a=res(j*3:j*3+2)
  er=sig(j*3:j*3+2)
  rmsix=rmsi(j*2)
  rmsix_er=rmsi(j*2+1)
  rmstx=rmst(j*2)
  rmstx_er=rmst(j*2+1)
  rmstoti=rmstoti+rmsix^2
  rmstott=rmstott+rmstx^2
  errix=errix+(rmsix+rmsix_er)^2
  errtx=errtx+(rmstx+rmstx_er)^2
  if a(2)/a(1) ge 2. then begin
;     print,'QPO #',q
;     print,'Freq. :',a(2),er(2)
;     print,'FWHM :',a(1),er(1) 
;     print,'RMS 0 inf :',rmsix*100.,rmsix_er*100.
     qpo[0,(q-1)*3]=a[2]
     qpo[1,(q-1)*3]=er[2]
     qpo[0,((q-1)*3)+1]=a[1]
     qpo[1,((q-1)*3)+1]=er[1]
     qpo[0,((q-1)*3)+2]=rmsix*100.
     qpo[1,((q-1)*3)+2]=rmsix_er*100.
     q=q+1
  endif else begin
     peak,a(2),er(2),a(1),er(1),fp,fper
     fpeak[0,l-1]=fp
     fpeak[1,l-1]=fper
     rmsiz[0,l-1]=rmsix
     rmsiz[1,l-1]=rmsix_er
     rmstz[0,l-1]=rmstx
     rmstz[1,l-1]=rmstx_er  
;     print,'lor #:',l
;     print,'Peak f :',fp,fper
;     print,'rms 0 inf :',rmsix*100.,rmsix_er*100.
;     print,'rms 0 20 :',rmstx*100.,rmstx_er*100.
     l=l+1
  endelse
endfor

trmsi=[sqrt(rmstoti),sqrt(errix)-sqrt(rmstoti)]
trmst=[sqrt(rmstott),sqrt(errtx)-sqrt(rmstott)] 
  
;print,'Total rms, 0 inf :',trmsi[0],trmsi[1]
;print,'Total rms, 0 20 :',trmst[0],trmst[1]

trmsi=[sqrt(rmstoti),sqrt(errix)-sqrt(rmstoti)]
trmst=[sqrt(rmstott),sqrt(errtx)-sqrt(rmstott)]
end
