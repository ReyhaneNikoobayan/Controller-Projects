clc
clear
close all
s=tf('s');
G=(s)/(10*s+1)/(s-1);
[Ns, Xs, Ms, Ys] = Euclid(G, 1);
K=Xs/Ys;
ClTf=feedback(K*G,1);
zpk(ClTf)