pro cov_g100,lo,la,an
map_set,lo,la,an,/ortho,/isotropic,/grid,/label

;top detector

lont=findgen(45)
lant=atan(tan(65*!pi/180)*cos(lont*!pi/180))*180/!pi
lant2=reverse(lant)
lont2=lont+45
lant3=lant
lant5=lant
lant7=lant
lant4=lant2
lant6=lant2
lant8=lant2
lont3=lont2+45
lont4=lont3+45
lont5=lont4+45
lont6=lont5+45
lont7=lont6+45
lont8=lont7+45

print,lant,lont

plots,lont,lant
plots,lont2,lant2
plots,lont3,lant3
;plots,lont4,lant4
plots,lont5,lant5
;plots,lont6,lant6
plots,lont7,lant7
plots,lont8,lant8


a=fltarr(2,45)
a(0,*)=lont
a(1,*)=lant
b=rot(a,90)
print,a,b

x=cos(lant*!pi/180)*cos(lont*!pi/180)
y=cos(lant*!pi/180)*sin(lont*!pi/180)
z=sin(lant*!pi/180)



xp=x
yp=z
zp=-y
;print,x(0),y(0),z(0)
;print,x(44),y(44),z(44)
;print,lant(0),lant(44)
lantp=acos(sqrt(xp^2+yp^2))*180/!pi
;lantp=asin(zp)
lontp=atan(yp/xp)*180/!pi
print,lantp,lontp
;lantp=lantp*180/!pi
plots,lontp,-lantp
;plots,65,lant-90

x=cos(lant8*!pi/180)*cos(lont8*!pi/180)
y=cos(lant8*!pi/180)*sin(lont8*!pi/180)
z=sin(lant8*!pi/180)

xp=x
yp=z
zp=-y
;print,x(0),y(0),z(0)
;print,x(44),y(44),z(44)
;print,lant(0),lant(44)
lantp=acos(sqrt(xp^2+yp^2))*180/!pi
;lantp=asin(zp)
;print,lantp(0),lantp(44)
lontp=atan(yp/xp)*180/!pi
;print,lontp(0),lontp(44)
;lantp=lantp*180/!pi
plots,lontp,lantp
;plots,65,lant-90

x=cos(lant3*!pi/180)*cos(lont3*!pi/180)
y=cos(lant3*!pi/180)*sin(lont3*!pi/180)
z=sin(lant3*!pi/180)

xp=x
yp=z
zp=-y
;print,x(0),y(0),z(0)
;print,x(44),y(44),z(44)
;print,lant(0),lant(44)
lantp=acos(sqrt(xp^2+yp^2))*180/!pi
;lantp=asin(zp)
;print,lantp(0),lantp(44)
lontp=atan(yp/xp)*180/!pi
;print,lontp(0),lontp(44)
;lantp=lantp*180/!pi
plots,-lontp,lantp
;plots,65,lant-90

x=cos(lant2*!pi/180)*cos(lont2*!pi/180)
y=cos(lant2*!pi/180)*sin(lont2*!pi/180)
z=sin(lant2*!pi/180)

xp=x
yp=z
zp=-y
;print,x(0),y(0),z(0)
;print,x(44),y(44),z(44)
;print,lant(0),lant(44)
lantp=acos(sqrt(xp^2+yp^2))*180/!pi
;lantp=asin(zp)
;print,lantp(0),lantp(44)
lontp=atan(yp/xp)*180/!pi
;print,lontp(0),lontp(44)
;lantp=lantp*180/!pi
plots,lontp,-lantp
;plots,65,lant-90

x=cos(lant5*!pi/180)*cos(lont5*!pi/180)
y=cos(lant5*!pi/180)*sin(lont5*!pi/180)
z=sin(lant5*!pi/180)

xp=x
yp=z
zp=-y
;print,x(0),y(0),z(0)
;print,x(44),y(44),z(44)
;print,lant(0),lant(44)
lantp=acos(sqrt(xp^2+yp^2))*180/!pi
;lantp=asin(zp)
;print,lantp(0),lantp(44)
lontp=atan(yp/xp)*180/!pi
;print,lontp(0),lontp(44)
;lantp=lantp*180/!pi
plots,lontp+180,lantp
;plots,65,lant-90

x=cos(lant3*!pi/180)*cos(lont3*!pi/180)
y=cos(lant3*!pi/180)*sin(lont3*!pi/180)
z=sin(lant3*!pi/180)

xp=x
yp=z
zp=-y
;print,x(0),y(0),z(0)
;print,x(44),y(44),z(44)
;print,lant(0),lant(44)
lantp=acos(sqrt(xp^2+yp^2))*180/!pi
;lantp=asin(zp)
;print,lantp(0),lantp(44)
lontp=atan(yp/xp)*180/!pi
;print,lontp(0),lontp(44)
;lantp=lantp*180/!pi
plots,lontp+180,lantp
;plots,65,lant-90

x=cos(lant6*!pi/180)*cos(lont6*!pi/180)
y=cos(lant6*!pi/180)*sin(lont6*!pi/180)
z=sin(lant6*!pi/180)

xp=x
yp=z
zp=-y
;print,x(0),y(0),z(0)
;print,x(44),y(44),z(44)
;print,lant(0),lant(44)
lantp=acos(sqrt(xp^2+yp^2))*180/!pi
;lantp=asin(zp)
;print,lantp(0),lantp(44)
lontp=atan(yp/xp)*180/!pi
;print,lontp(0),lontp(44)
;lantp=lantp*180/!pi
plots,lontp+180,-lantp
;plots,65,lant-90

x=cos(lant4*!pi/180)*cos(lont4*!pi/180)
y=cos(lant4*!pi/180)*sin(lont4*!pi/180)
z=sin(lant4*!pi/180)

xp=x
yp=z
zp=-y
;print,x(0),y(0),z(0)
;print,x(44),y(44),z(44)
;print,lant(0),lant(44)
lantp=acos(sqrt(xp^2+yp^2))*180/!pi
;lantp=asin(zp)
;print,lantp(0),lantp(44)
lontp=atan(yp/xp)*180/!pi
;print,lontp(0),lontp(44)
;lantp=lantp*180/!pi
plots,lontp+180,-lantp
;plots,65,lant-90


end
