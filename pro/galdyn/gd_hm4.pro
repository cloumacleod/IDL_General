pro gd_hm4

a1=[0.0,0.2,0.4,0.6,0.8,1.0,1.2,1.4,1.6,.18,2.0]
br=[23.5,23.6,23.8,24.2,24.5,24.9,25.2,25.6,26.1,26.7,27.2]

a2=[0.0,0.75,1.5,2.25,3.0,3.75,4.5,5.25,6.0,6.75,7.5]
mg=[0.75,0.74,0.72,0.62,0.52,0.36,0.2,-0.05,-0.27,-0.45,-0.62]

a3=[0.1,0.75,1.5,2.25,3.0,3.75,4.5,5.25,6.0,6.75,7.5]
vrot=[2.0,14.0,28.0,34.,40.,44.0,46.0,47.5,50.0,48.0,45.0]

I_pr=35.*10^(-(0.4*(br-23.3)))*3.83*0.001/(3.1^2.)
print,I_pr





;mgreal=exp(mg)
;a1real=a1*3.1e18
w=1.0/vrot
a=[3.45,3.44]



;yfit= curvefit(a3,vrot,w,a,function_name='vc_4')
print,a
vf_arr,a3,vrot,'vc_4',a,weights=w

end
