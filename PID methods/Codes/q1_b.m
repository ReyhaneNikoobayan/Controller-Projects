clc;clear;close all
s=tf('s');
G_main=(-s+3)/((s+1)*(s+2)*(s^2+2*s+4));

[K,L,T]=get_fod(G_main,0);  % frequency 
G_model=K*exp(-L*s)/(T*s+1);
[Kc,~,wc,~]=margin(G_main);  %margin
Tc=2*pi/wc;
N=10;
rb=0.6;
pb=10;

[G_Ziegler_fopdt,H_Sys,Kp,Ti,Td]=ziegler_nic(3,[K,L,T,N]); %FOPDT
GC_Ziegler_fopdt=feedback(G_main*G_Ziegler_fopdt,1);
step(GC_Ziegler_fopdt);
legend 'show'
figure

[G_Ziegler_frequency,H_Sys,Kp,Ti,Td]=ziegler_nic(3,[Kc,Tc,N]); %Frequency
GC_Ziegler_frequency=feedback(G_main*G_Ziegler_frequency,1);
step(GC_Ziegler_frequency);
legend 'show'
figure


[G_Ziegler_refined,H_Sys,Kp,Ti,Td,beta]=rziegler_nic([K,L,T,N,Kc,Tc]); %Refined
GC_Ziegler_refined=feedback(G_main*G_Ziegler_refined,H_Sys);
step(GC_Ziegler_refined);
legend 'show'
figure


[G_Ziegler_modified,H_Sys,Kp,Ti,Td]=ziegler_nic(3,[Kc,Tc,rb,pb,N]); %modified
GC_Ziegler_modified=feedback(G_main*G_Ziegler_modified,1);
step(GC_Ziegler_modified);
legend 'show'
figure


[G_Cohen,H_Sys,Kp,Ti,Td]=cohen_pid(3,1,[K,L,T,N]); %cohen
GC_Cohen=feedback(G_main*G_Cohen,1);
step(GC_Cohen);
legend 'show'
figure

[G_Cohen_rev,H_Sys,Kp,Ti,Td]=cohen_pid(3,2,[K,L,T,N]); %revisited cohen
GC_Cohen_rev=feedback(G_main*G_Cohen_rev,1);
step(GC_Cohen_rev);
legend 'show'
figure


[G_Astrom,H_Sys,Kp,Ti,Td]=astrom_hagglund(2,1,[K,L,T,N]) ; %astrom_haglund
GC_Astrom=feedback(G_main*G_Astrom,1);
step(GC_Astrom);
legend 'show'
figure



[G_Astrom_frequency,H_Sys,Kp,Ti,Td]=astrom_hagglund(2,2,[K,Kc,Tc,N]) ; %astrom_haglund_frequency
GC_Astrom_frequency=feedback(G_main*G_Astrom_frequency,1);
step(GC_Astrom_frequency);
legend 'show'
figure


[Gc_chr,H_Sys,Kp,Ti,Td]=chr_pid(3,1,[K,L,T,N,0]); %chr_without_overshoot
GC_chr=feedback(G_main*Gc_chr,1);
step(GC_chr);
legend 'show'
figure



[Gc_chr_overshoot,H_Sys,Kp,Ti,Td]=chr_pid(3,1,[K,L,T,N,1]); %chr_with_overshoot
GC_chr_overshoot=feedback(G_main*Gc_chr_overshoot,1);
step(GC_chr_overshoot);
legend 'show'
figure


[G_wjc,Kp,Ti,Td]=wjcpid([K,L,T,N]); %wjcpid
GC_wjc=feedback(G_main*G_wjc,1);
step(GC_wjc);
legend 'show'
figure


[G_optimum, Kp, Ti, Td, H] = Optimum(3, 1, [K,L,T,N,2]) ; % optimum PID
GC_optimum=feedback(G_main*G_optimum,1);
step(GC_optimum);
legend 'show'
figure


[G_optimum_Dfeedback, Kp, Ti, Td, H] = Optimum(4, 1, [K,L,T,N,2]) ; % optimum PI_D
GC_optimum_Dfeedback=feedback(G_main*G_optimum_Dfeedback,H);
step(GC_optimum_Dfeedback);
legend 'show'
figure

[G_optimum_frequency, Kp, Ti, Td, H] = Optimum(3, 1, [K,L,T,N,Kc,Tc,K*Kc]) ; % optimum PID frequency
GC_optimum_frequency=feedback(G_main*G_optimum_frequency,1);
step(GC_optimum_frequency);
legend 'show'
figure

[G_optimum_Dfeedback_frequency, Kp, Ti, Td, H] = Optimum(4, 1, [K,L,T,N,Kc,Tc,K*Kc]) ; % optimum PI_D frequency
GC_optimum_Dfeedback_frequency=feedback(G_main*G_optimum_Dfeedback_frequency,1);
step(GC_optimum_Dfeedback_frequency);
legend 'show'
figure


step(GC_Ziegler_fopdt,GC_Ziegler_frequency,GC_Ziegler_modified,GC_Ziegler_refined,GC_Cohen,GC_Cohen_rev, ...
    GC_Astrom,GC_Astrom_frequency,GC_chr,GC_chr_overshoot,GC_wjc,GC_optimum,GC_optimum_Dfeedback, ...
    GC_optimum_Dfeedback_frequency,GC_optimum_frequency);
legend 'show'