clc
clear
s=tf('s');
G_model=1/(s^2+0.2*s+1)/s^2/(s^2+4);
[Ns, Xs, Ms, Ys] = Euclid(G_model, 1);
K=Xs/Ys;
K=K/(s*(s^2+4));
G=1/(s^2+0.2*s+1);
zpk(K)