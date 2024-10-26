clc
clear
close all
s=tf('s');
G=(1-s)/((s-2)/(s+10));
rlocus(G)
figure
bode(G)
