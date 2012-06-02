pro calrms,res,sig,intzt,intzi,frange=frange,calclf=calclf

if NOT keyword_set(calclf) then begin
    calclf=0
    print, 'to speed up things rms in limited frequency range will not be calculated'
endif

if NOT keyword_set(frange) then frange=[0D, 20D]

a=res
;spawn,'pwd',pwd
save,a,filename='~/temp_lor.dat'

if calclf then begin

 int=sqrt(qromb('lorentz',frange[0],frange[1],/DOUBLE))

a=res
a(0)=res(0)+sig(0)
save,a,filename='~/temp_lor.dat'
intx=sqrt(qromb('lorentz',frange[0],frange[1]))
err=intx-int
intzt=[int,err]

endif else intzt=[0,0]

a=res
Q=double(2.*a(2)/a(1))
int=sqrt(a(0)*(0.5-(atan(-Q)/!PI)))

d0=(0.5-(atan(-Q)/!PI))/(2*int)
d1=((a(0)/!PI) * (2*a(2)/(a(1)^2.)) * (1./(1.+((2.*a(2)/a(1))^2.))))/(2*int)
d2=((a(0)/!PI) * (2/a(1)) * (1./(1.+((2.*a(2)/a(1))^2.))))/(2*int)

err_old=sig(0)/(4.*int)
err_new=sqrt(((d0*sig(0))^2.)+((d1*sig(1))^2.)+((d2*sig(2))^2.))
intzi=[int,err_new]

print,err_old, err_new

end
