function [H, Pp, Ns, Vr, Vs, Dh, Dt] = Turbopump_Desing (P_in, P_out, mdot, rho, eff, cp )

Dp = P_out - P_in; % salto di pressione richiesto a cavallo della pompa [MPa]
g = 9.81; % costante [m/s^2]
Dp_ps = 47 ; %[MPa] -> masssimo Dp (teorico) per singolo stadio
H = Dp/(g * rho) ; % head of the pump -> parametro
Pp = (H*g*mdot)/eff  ; % potenza richiesta dalla pompa -> va eguagliata a quella prodotta dalla turbina
Ns = ceil(Dp/Dp_ps) ; % numero di stadi necessari alla pompa -> se <1 Ns = 1
Dh = Pp/mdot ; % salto entalpico
Dt= abs(Dh)/cp ;%variazione di temperatura-> molto meno importante dell'aumento della pressione
T_out = Dt + T_in ;
Q = mdot/rho ;
Vs = 3;
% rivaluta
Vr = (Vs*(H/Ns)^0.75)/sqrt(Q) ;
beta = P_out/P_in ;

% Pump mass 
% t = Pp_req/Vr -> torque
% M = A *t^B ;
% A,B coefficienti da valutare tra A:(1,3-1,6) B:(0.600-0.667)

tp_design.head = H;
tp_design.power_required= Pp;
tp_design.temp_out = T_out ;
tp_design.rapp_compressione = beta ;
tp_design.num_stadi = Ns ;
tp_design.vel_rotazione = Vr ;
tp_design.salto_entalpico = Dh ;
