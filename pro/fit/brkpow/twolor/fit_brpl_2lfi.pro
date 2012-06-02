pro fit_brpl_2lfi,p,p_err,f_b,a1,a2,a3,fi,fit

window, 0
xl = 0.01
xu = 100
yl = 1.e-5
yu = 2.

;set_plot,'ps'
;!p.font=0
;device,/times

; Program for reading in and fitting an rms^2/Hz normalized power spectra

modelname = 'brk_pow_2lfi' ; the model name should also go here

a = [a1,a2,a3] ; guess for curvefit

; This is just so the error bars on the plot look right
fix1 = p-p_err ; where
fix2 = p
g = where(fix2 gt 0)
b = where(fix1 lt 0)

!x.style = 1
!y.style = 1

read, 'Type 1 to save to ps: ', kk
if (kk eq 1) then set_plot, 'ps'
if (kk eq 1) then device, filename = 'idl.ps'
if (kk eq 1) then device, yoffset = 5.0
if (kk eq 1) then device, ysize = 17.0

plot_oo, f_b(g), p(g), psym = 10, $
  xrange = [xl,xu], $
  yrange = [yl,yu], $
  xtitle = 'Frequency (Hz)', $
  ytitle = '(rms/mean)!E2!N Hz!E-1!N', $
  charsize = 2.0, charthick = 2.0,/xstyle,/ystyle,$
  xtickname=['0.01','0.1','1','10','100']

oploterr, f_b(g), p(g), p_err(g), 3
fixup, b, f_b, p, p_err

w = 1.0/(p_err^2)
yfit = curvefit_i(f_b, p, w, a, fi, chisqr, sigmaa, function_name = modelname)

array = [transpose(a), transpose(sigmaa)]
print, array

; calculating the chi^2 for the fit
chi = (p-yfit)^2/(p_err^2)
g = where(yfit gt p)
chi(g) = -chi(g)
dof = n_elements(f_b)-n_elements(a)
print, 'chi2 = ', chisqr*dof
print, 'dof = ', dof

; plotting the fit on the data

n = 100000
x = 0.001+0.01*findgen(n)

g1 = where(x le a(1)) 
g2 = where(x gt a(1)) 

den1 = (x - a(4))^2 + (0.5*a(3))^2
den2 = (x - a(7))^2 + (0.5*a(6))^2

f=fltarr(n_elements(x))

f(g1) = a(0) + (a(2)*a(3))/(2.0*!pi*den1(g1)) + (a(5)*a(6))/(2.0*!pi*den2(g1)) 
f(g2) = a(0)*(a(1)^(-fi))*(x(g2)^fi) + (a(2)*a(3))/(2.0*!pi*den1(g2)) + $
(a(5)*a(6))/(2.0*!pi*den2(g2))

oplot, x, f, thick = 2

; plotting individual components

c1_1 = a(0) 
oplot, [0.01,max(x(g1))], [c1_1,c1_1],linestyle = 2, thick = 1
c1_2 = a(0)*(a(1)^(-fi))*(x(g2)^fi)
oplot, x(g2), c1_2, linestyle = 2, thick = 1

c2_1 = (a(2)*a(3))/(2.0*!pi*den1(g1))
oplot, x(g1), c2_1, linestyle = 2, thick = 1
c2_2 = (a(2)*a(3))/(2.0*!pi*den1(g2))
oplot, x(g2), c2_2, linestyle = 2, thick = 1

c3_1 = (a(5)*a(6))/(2.0*!pi*den2(g1))
oplot, x(g1), c3_1, linestyle = 2, thick = 1
c3_2 = (a(5)*a(6))/(2.0*!pi*den2(g2))
oplot, x(g2), c3_2, linestyle = 2, thick = 1

; calculating fractional rms amplitudes
print, 'broken power law'
print, 'f_break = ', a(1), sigmaa(1)
print, 'index = ', fi , 'fixed'
print, 'frac_rms = ', sqrt(a(0)*a(1)+(a(0)*a(1)^(-fi)*(100^(fi+1)-a(1)^(fi+1))/(fi+1))), sigmaa(0)/(2.0*sqrt(a(0)))
print, 'fundamental'
print, 'f_buency = ', a(4), sigmaa(4)
print, 'frac_rms = ', sqrt(a(2)), sigmaa(2)/(2.0*sqrt(a(2)))
print, 'firs harmonic'
print, 'f_buency = ', a(7), sigmaa(7)
print, 'frac_rms = ', sqrt(a(5)), sigmaa(5)/(2.0*sqrt(a(5)))
print, 'chi^2, dof = ',chisqr, dof

read, 'Type 1 to show residuals: ', jj
if (jj eq 1) then window, 1
if (jj eq 1) then plot_oi, f_b, chi, psym = 10, xtitle = 'Frequency (Hz)', ytitle = 'Chi!U2!N', charsize = 2, charthick = 2, xrange = [xl,xu]
if (jj eq 1) then oplot, [1.e-5,1.e5],[0,0],linestyle = 1, thick = 2

if (kk eq 1) then device, /close
if (kk eq 1) then set_plot, 'x'
!p.multi = 0

fit=a

end
