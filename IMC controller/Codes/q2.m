clc
clear 
close all
s=tf('s');
G=1/(s+0.5)/(s-1);
G2=1/(s+0.5)/(s+1);
[Ns, Xs, Ms, Ys] = Euclid(G, 1);
K=Xs/Ys;
Q1=((21*s+11)*(s+0.5)*(s+1))/((4*s+14)*(s+0.5)*(s+1)+21*s+11);
zpk(Q1);
cltf=feedback(K*G,1);
cltf2=feedback(K*G2,1);
step(cltf)
hold on
legend show
step(cltf2)