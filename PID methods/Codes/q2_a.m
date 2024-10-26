clc;clear;close all
s=tf('s');
G_main=(-s+3)/((s)*(s+2)*(s^2+2*s+4));
step(G_main)
legend 'show'
hold on
[Kv,L] = get_ipd(G_main);
G_ipdt=Kv*exp(-L*s)/s;
G1=G_main*s;
R=opt_app(G1,0,1,1);
k=R.num{1}(2)/R.den{1}(2);
l=R.ioDelay;
T=1/R.den{1}(2);
G_foipdt=k*exp(-l*s)/(s*(T*s+1));

step(G_foipdt,G_ipdt);

figure;

err_foipdt=G_foipdt-G_main;
err_ipdt=G_ipdt-G_main;
step(err_ipdt,err_foipdt)
legend 'show'