clc
clear
close all
s=tf('s');
G=(10*exp(-11*s))/(s+10+10*(exp(-11*s)-exp(-10*s)));
step(G)
