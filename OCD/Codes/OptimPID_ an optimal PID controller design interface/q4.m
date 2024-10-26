clc
clear 
close all
s=tf('s');
kp=1;
G=kp/(s+2)*exp(-2*s);
nyquist(G);
figure
kp=-1;
G=kp/(s+2)*exp(-2*s);
nyquist(G);

figure
kp=2.37;
G=kp/(s+2)*exp(-2*s);
nyquist(G);

figure
kp=-2;
G=kp/(s+2)*exp(-2*s);
nyquist(G);