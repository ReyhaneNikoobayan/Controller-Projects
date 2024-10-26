clc;clear;close all
s=tf('s');
G_main=(-s+3)/((s+1)*(s+2)*(s^2+2*s+4));
step(G_main);
hold on
legend 'show'

[K,L,T]=get_fod(G_main,0);  % frequency 
G_frequency=K*exp(-L*s)/(T*s+1);
step(G_frequency);
hold on

[K,L,T]=get_fod(G_main,1);  % Transfer function 
G_trasfer=K*exp(-L*s)/(T*s+1);
step(G_trasfer);
hold on

G_optapp=opt_app(G_main,0,1,1);   % opt_app
step(G_optapp);

figure 
error_fre=G_frequency-G_main;
error_tra=G_trasfer-G_main;
error_opt=G_optapp-G_main;
step(error_fre,error_tra,error_opt);
legend 'show'