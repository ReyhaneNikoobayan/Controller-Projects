clc;clear;close all
s=tf('s');
G_main=(-s+3)/((s)*(s+2)*(s^2+2*s+4));

[Kv,L] = get_ipd(G_main);
G_ipdt=Kv*exp(-L*s)/s;
N=10;

[G_ipdt_pd_ISE,Kp,Ti,Td]=ipdtctrl(1,1,Kv,L,N); %ipdt pd ISE
GC_ipdt_pd_ISE=feedback(G_main*G_ipdt_pd_ISE,1);

[G_ipdt_pd_ISTE,Kp,Ti,Td]=ipdtctrl(1,2,Kv,L,N); %ipdt pd ISTE
GC_ipdt_pd_ISTE=feedback(G_main*G_ipdt_pd_ISTE,1);

[G_ipdt_pd_ISTSE,Kp,Ti,Td]=ipdtctrl(1,3,Kv,L,N); %ipdt pd ISTSE
GC_ipdt_pd_ISTSE=feedback(G_main*G_ipdt_pd_ISTSE,1);

step(GC_ipdt_pd_ISE,GC_ipdt_pd_ISTE,GC_ipdt_pd_ISTSE);
legend 'show'
figure

[G_ipdt_pid_ISE,Kp,Ti,Td]=ipdtctrl(2,1,Kv,L,N); %ipdt pid ISE
GC_ipdt_pid_ISE=feedback(G_main*G_ipdt_pid_ISE,1);

[G_ipdt_pid_ISTE,Kp,Ti,Td]=ipdtctrl(2,2,Kv,L,N); %ipdt pid ISTE
GC_ipdt_pid_ISTE=feedback(G_main*G_ipdt_pid_ISTE,1);

[G_ipdt_pid_ISTSE,Kp,Ti,Td]=ipdtctrl(2,3,Kv,L,N); %ipdt pid ISTSE
GC_ipdt_pid_ISTSE=feedback(G_main*G_ipdt_pid_ISTSE,1);

step(GC_ipdt_pid_ISE,GC_ipdt_pid_ISTE,GC_ipdt_pid_ISTSE);
legend 'show'
figure


[G_AH_pid,H_Sys,Kp,Ti,Td] = AH_idt(2,[Kv,L,N]);  %pid AH
GC_AH_pid=feedback(G_AH_pid*G_main,1);

step(GC_AH_pid);
legend 'show'
figure

[Gc_Zeigler,H_Sys,Kp,Ti,Td] = ziegler_itd(3,[Kv,L,N]); %pid ZN
GC_zn_pid=feedback(Gc_Zeigler*G_main,1);

step(GC_zn_pid);
legend 'show'

