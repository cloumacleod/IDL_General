pro fit_pl_2l,p,p_err,f_b,a1,a2,a3,fit,guess


window, 0
xl = min(f_b)
xu = max(f_b)
yl = min(p)/5.
yu = max(p)*5.

; Program for reading in and fitting an rms^2/Hz normalized power spectra

modelname = 'pow_2l' ; the model name should also go here

a=[a1,a2,a3]

; This is just so the error bars on the plot look right
fix1 = p-p_err ; where
fix2 = p
g = where(fix2 gt 0)
b = where(fix1 lt 0)

!x.style = 1
!y.style = 1

cont=0
while cont eq 0 do begin

plot_oo, f_b(g), p(g), psym = 10, $
  xrange = [xl,xu], $
  ;yrange = [yl,yu], $
  xtitle = 'Frequency (Hz)', $
  ytitle = '(rms/mean)!E2!N Hz!E-1!N', $
  charsize = 2.0, charthick = 2.0,/xstyle,ystyle=1
 ; xtickname=['0.01','0.1','1','10','100']

oploterr, f_b(g), p(g), p_err(g)
;fixup, b, f_b, p, p_err

n = 100000
x = 0.001+0.01*findgen(n)

den1 = (x - a(4))^2 + (0.5*a(3))^2
den2 = (x - a(7))^2 + (0.5*a(6))^2

f=fltarr(n_elements(x))

f = a(0)*(x^a(1)) + (a(2)*a(3))/(2.0*!pi*den1)+ (a(5)*a(6))/(2.0*!pi*den2)


oplot, x, f, thick = 2

; plotting individual components

c1 = a(0)*x^a(1)
oplot, x, c1, linestyle = 2, thick = 1
c2 = (a(2)*a(3))/(2.0*!pi*den1)
oplot, x, c2, linestyle = 2, thick = 1
c2 = (a(5)*a(6))/(2.0*!pi*den2)
oplot, x, c2, linestyle = 2, thick = 1

 print,'which parameter you want to change, or 8 to exit'
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

  8: cont=1
endcase

endwhile

read, 'Type 1 to save to ps: ', kk
if (kk eq 1) then set_plot, 'ps'
if (kk eq 1) then device, filename = 'idl.ps'
if (kk eq 1) then device, yoffset = 5.0
if (kk eq 1) then device, ysize = 17.0

plot_oo, f_b(g), p(g), psym = 10, $
  xrange = [xl,xu], $
  ;yrange = [yl,yu], $
  xtitle = 'Frequency (Hz)', $
  ytitle = '(rms/mean)!E2!N Hz!E-1!N', $
  charsize = 2.0, charthick = 2.0,/xstyle,ystyle=1
  $xtickname=['0.01','0.1','1','10','100']

oploterr, f_b(g), p(g), p_err(g), 3
;fixup, b, f_b, p, p_err

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

den1 = (x - a(4))^2 + (0.5*a(3))^2
den2 = (x - a(7))^2 + (0.5*a(6))^2

f=fltarr(n_elements(x))
f = a(0)*(x^a(1)) + (a(2)*a(3))/(2.0*!pi*den1) + (a(5)*a(6))/(2.0*!pi*den2)


oplot, x, f, thick = 2

; plotting individual components

c1 = a(0)*x^a(1)
oplot, x, c1, linestyle = 2, thick = 1
c2 = (a(2)*a(3))/(2.0*!pi*den1)
oplot, x, c2, linestyle = 2, thick = 1
c2 = (a(5)*a(6))/(2.0*!pi*den2)
oplot, x, c2, linestyle = 2, thick = 1
; calculating fractional rms amplitudes
print, 'level = ', a(0), sigmaa(0)
print, 'index = ', a(1), sigmaa(1)
print, 'f_buency = ', a(4), sigmaa(4)
print, 'frac_rms = ', sqrt(a(2))
print, 'frac_rms_err = ', sigmaa(2)/(2.0*sqrt(a(2)))
print, 'f_buency = ', a(7), sigmaa(7)
print, 'frac_rms = ', sqrt(a(5))
print, 'frac_rms_err = ', sigmaa(5)/(2.0*sqrt(a(5)))
print, 'reduced chi^2 = ', total(chi), dof, total(chi)/dof

read, 'Type 1 to show residuals: ', jj
if (jj eq 1) then window, 1
if (jj eq 1) then plot_oi, f_b, chi, psym = 10, xtitle = 'Frequency (Hz)', ytitle = 'Chi!U2!N', charsize = 2, charthick = 2, xrange = [xl,xu]
if (jj eq 1) then oplot, [1.e-5,1.e5],[0,0],linestyle = 1, thick = 2

if (kk eq 1) then device, /close
if (kk eq 1) then set_plot, 'x'
!p.multi = 0

fit=a

end
