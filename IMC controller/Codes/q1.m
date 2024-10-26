clc
clear 
close all
s=tf('s');
G=(s+0.3)/(s+0.1)/(s+1);
K=(3*s^2+3.3*s+0.3)/(s^2+0.3*s);
G_cl=feedback(G*K,1);
G_ur=feedback(K,G);
step(G_cl);
hold on
step(3/(s+3));
legend('G_cl', '3/(s+3)')
figure
step(G_ur);
legend show