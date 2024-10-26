
function [Gc_Sys,H_Sys,Kp,Ti,Td] = ziegler_itd(keys,vars)
    Ti=0; Td=0;
    Kv=vars(1); L=vars(2); N=vars(3); a=Kv*L;
    switch keys
        case 1, Kp=1/a;
        case 2, Kp=0.9/a; Ti=3*L;
        case {3,4}, Kp=1.2/a; Ti=2*L; Td=L/2;
    end
    switch keys
    case 1, Gc_Sys=tf(Kp,1); H_Sys=1;
    case 2, Gc_Sys=tf(Kp*[Ti,1],[Ti,0]); H_Sys=1;
    case 3
       dd=Ti*[Td/N,1,0]; nn=[Kp*Ti*Td*(N+1)/N, Kp*(Ti+Td/N), Kp];
       Gc_Sys=tf(nn,dd); H_Sys=1;
    case 4
       d0=sqrt(Ti*(Ti-4*Td)); Ti0=Ti; 
       Kp=0.5*(Ti+d0)*Kp/Ti; Ti=0.5*(Ti+d0); Td=Ti0-Ti; nn=Kp*[Ti,1]; dd=[Ti,0]; 
       nH=[(1+Kp/N)*Ti*Td, Kp*(Ti+Td/N), Kp]; dH=Kp*conv([Ti,1],[Td/N,1]);
       Gc_Sys=tf(nn,dd); H_Sys=tf(nH,dH);
    end
end

