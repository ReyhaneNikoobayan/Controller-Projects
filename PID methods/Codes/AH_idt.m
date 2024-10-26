
function [Gc_Sys,H_Sys,Kp,Ti,Td] = AH_idt(keys,vars)
    Td=0;
    Kv=vars(1); L=vars(2); N=vars(3); a=Kv*L;
    switch keys
        case 1, Kp=0.35/a; Ti=13.4*L;
        case 2, Kp=0.45/a; Ti=8*L; Td=0.5*L;
    end
    dd=Ti*[Td/N,1,0]; nn=[Kp*Ti*Td*(N+1)/N, Kp*(Ti+Td/N), Kp]; Gc_Sys=tf(nn,dd); H_Sys=1;
end

