clc;clear;close all
s=tf('s');
G_main=(-s+3)/((s+1)*(s+2)*(s^2+2*s+4));

[K,L,T]=get_fod(G_main,0);  % frequency 
G_model=K*exp(-L*s)/(T*s+1);
[Kc,~,wc,~]=margin(G_main);
Tc=2*pi/wc;
pb=45;
N=10;
legend 'show'
name={'GC1', 'GC2', 'GC3', 'GC4', 'GC5', 'GC6', 'GC7', 'GC8', 'GC9', 'GC10'};
i=1;
for rb=0.1:0.1:1
  
  [Gc_Sys,H_Sys,Kp,Ti,Td]=ziegler_nic(3,[Kc,Tc,rb,pb,N]);
  Gc=feedback(Gc_Sys*G_main,1);
  step(Gc,20);
  legend (name)
  hold on
  i=i+1;
end 
figure
rb=0.6;
for pb=10:10:70

  [Gc_Sys,H_Sys,Kp,Ti,Td]=ziegler_nic(3,[Kc,Tc,rb,pb,N]);
  Gc=feedback(Gc_Sys*G_main,1);
  step(Gc,20);
  legend (name)
  hold on
  i=i+1;
end 

% rb=0.6
%pb=10
