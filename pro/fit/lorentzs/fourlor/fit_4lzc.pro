pro fit_4lzc,p,p_err,f_b,a1,a2,a3,a4,fit,guess


window, 0
;xl = 0.01
;xu = 2048
yl = 1.e-5
yu = 0.5

; Program for reading in and fitting an rms^2/Hz normalized power spectra

modelname = 'lor_4lzc' ; the model name should also go here

; This is just so the error bars on the plot look right
fix1 = p-p_err ; where
fix2 = p
g = where(fix2 gt 0)
b = where(fix1 lt 0)

!x.style = 1
!y.style = 1

a=[a1,a2,a3,a4]

cont=0
while cont eq 0 do begin

ploterror, f_b(g), p(g), p_err(g),psym = 10, $
  ;xrange = [xl,xu], /xlog,$
  yrange = [yl,yu], /ylog,$
  xtitle = 'Frequency (Hz)', /nohat, $
  ytitle = '(rms/mean)!E2!N Hz!E-1!N', /xlog,$
  charsize = 2.0, charthick = 2.0,/xstyle,/ystyle
  ;xtickname=['0.01','0.1','1','10','100']


fixup, b, f_b, p, p_err

n = 100000
x = 0.001+0.01*findgen(n)

den_1 = x^2 + (0.5*a(1))^2
den_2 = (x - a(4))^2 + (0.5*a(3))^2
den_3 = (x - a(7))^2 + (0.5*a(6))^2
den_4 = (x - a(10))^2 + (0.5*a(9))^2

f=fltarr(n_elements(x))

f= (a(0)*a(1))/(2.0*!pi*den_1) + $
   (a(2)*a(3))/(2.0*!pi*den_2) + $
   (a(5)*a(6))/(2.0*!pi*den_3) + $
   (a(8)*a(9))/(2.0*!pi*den_4)


oplot, x, f, thick = 2

; plotting individual components

c_1 = (a(0)*a(1))/(2.0*!pi*den_1)
oplot, x, c_1, linestyle = 2, thick = 1

c_2 = (a(2)*a(3))/(2.0*!pi*den_2)
oplot, x, c_2, linestyle = 2, thick = 1

c_3 = (a(5)*a(6))/(2.0*!pi*den_3)
oplot, x, c_3, linestyle = 2, thick = 1

c_4 = (a(8)*a(9))/(2.0*!pi*den_4)
oplot, x, c_4, linestyle = 2, thick = 1

 print,'which parameter you want to change, or 11 to exit'
 read,ind
 case ind of
  0: begin
     print,a(0)
     read,var
     a(0)=var
  end
  
  1: begin
     print,a(1)
     read,var
     a(1)=var
  end
  
  2: begin 
     print,a(2)
     read,var
     a(2)=var
  end 
  
  3: begin
     print,a(3)
     read,var
     a(3)=var
  end
  
  4: begin
     print,a(4)
     read,var
     a(4)=var
  end

  5: begin 
     print,a(5)
     read,var
     a(5)=var
  end 
  
  6: begin
     print,a(6)
     read,var
     a(6)=var
  end
  
  7: begin
     print,a(7)
     read,var
     a(7)=var
  end

  8: begin 
     print,a(8)
     read,var
     a(8)=var
  end 
  
  9: begin
     print,a(9)
     read,var
     a(6)=var
  end
  
  10: begin
     print,a(10)
     read,var
     a(10)=var
  end

  11: cont=1
endcase

endwhile

read, 'Type 1 to save to ps: ', kk
if (kk eq 1) then begin
   set_plot, 'ps'
   device, filename = 'idl.ps'
   device, yoffset = 6.0
   device, ysize = 14.5
   !p.font=0
   device,/times
endif

ploterror, f_b(g), p(g), p_err(g),psym = 10, $
  ;xrange = [xl,xu], /xlog,$
  yrange = [yl,yu], /ylog,$
  xtitle = 'Frequency (Hz)', /nohat, $
  ytitle = '(rms/mean)!E2!N Hz!E-1!N', /xlog,$
  charsize = 1.5, charthick = 1.5,/xstyle,/ystyle,$
  xtickname=['0.01','0.1','1','10','100']

fixup, b, f_b, p, p_err

guess=a
w = 1.0/(p_err^2)
yfit = curvefit(f_b, p, w, a, sigmaa, function_name = modelname)

array = [transpose(a), transpose(sigmaa)]
print, array

; calculating the chi^2 for the fit
chi = (p-yfit)^2/(p_err^2)
dof = n_elements(f_b)-n_elements(a)
print, 'chi2 = ', total(chi)
print, 'dof = ', dof

; plotting the fit on the data
n = 100000
x = 0.001+0.01*findgen(n)

den_1 = x^2 + (0.5*a(1))^2
den_2 = (x - a(4))^2 + (0.5*a(3))^2
den_3 = (x - a(7))^2 + (0.5*a(6))^2
den_4 = (x - a(10))^2 + (0.5*a(9))^2

f=fltarr(n_elements(x))
f = (a(0)*a(1))/(2.0*!pi*den_1) + $
    (a(2)*a(3))/(2.0*!pi*den_2) + $
    (a(5)*a(6))/(2.0*!pi*den_3) + $
    (a(8)*a(9))/(2.0*!pi*den_4)



oplot, x, f, thick = 2

; plotting individual components

c_1 = (a(0)*a(1))/(2.0*!pi*den_1)
oplot, x, c_1, linestyle = 2, thick = 1

c_2 = (a(2)*a(3))/(2.0*!pi*den_2)
oplot, x, c_2, linestyle = 2, thick = 1

c_3 = (a(5)*a(6))/(2.0*!pi*den_3)
oplot, x, c_3, linestyle = 2, thick = 1

c_4 = (a(8)*a(9))/(2.0*!pi*den_4)
oplot, x, c_4, linestyle = 2, thick = 1

; calculating fractional rms amplitudes
print, 'broken pow law'

print, 'f_buency (1) = ZERO CENTERED'
print, 'frac_rms (1) = ', sqrt(a(0)), sigmaa(0)/(2.0*sqrt(a(0)))
print, 'fwhm (1) =', a(1), sigmaa(1)

print, 'f_buency (2) = ', a(4), sigmaa(4)
print, 'frac_rms (2) = ', sqrt(a(2)), sigmaa(2)/(2.0*sqrt(a(2)))
print, 'fwhm (2) =', a(3), sigmaa(3)

print, 'f_buency (3) = ', a(7), sigmaa(7)
print, 'frac_rms (3) = ', sqrt(a(5)), sigmaa(5)/(2.0*sqrt(a(5)))
print, 'fwhm (3) =', a(6), sigmaa(6)
 
print, 'f_buency (4) = ', a(10), sigmaa(10)
print, 'frac_rms (4) = ', sqrt(a(8)), sigmaa(8)/(2.0*sqrt(a(8)))
print, 'fwhm (4) =', a(9), sigmaa(9)

print, 'reduced chi^2 = ', total(chi), dof, total(chi)/dof

read, 'Type 1 to show residuals: ', jj
if (jj eq 1) then window, 1
if (jj eq 1) then plot_oi, f_b, chi, psym = 10, xtitle = 'Frequency (Hz)', ytitle = 'Chi!U2!N', charsize = 2, charthick = 2
if (jj eq 1) then oplot, [1.e-5,1.e5],[0,0],linestyle = 1, thick = 2

if (kk eq 1) then device, /close
if (kk eq 1) then set_plot, 'x'
!p.multi = 0

fit=a

end
