function tp_design = Turbopump_Desing (P_in, P_out,T_in, mdot, rho, P_vapor, eff, cp, type)

Dp = P_out - P_in; % salto di pressione richiesto a cavallo della pompa [MPa]
g = 9.81; % costante [m/s^2]
if type == "f" 
    Dp_ps = 16 ; %[MPa] -> masssimo Dp (teorico) per singolo stadio per LH2 da libro "space prop. analysis and design (Humble)
    disp('fuel')
    Vs = 2.0; %stage specific speed per LH2
    u_ss = 130 ;% suction specific speed per LH2
    psi = 0.60 ;%pump head coefficient for LH2
end
if  type == "o" 
    Dp_ps = 47 ;%[MPa] -> masssimo Dp (teorico) per singolo stadio per altri fluidi da libro "space prop. analysis and design (Humble)
    disp('Oxidizer')
    Vs = 3.0 ; % stage specific speed per altre specie;
    u_ss = 90; % suction specific speed for cryogenic liquids
    psi = 0.55 ;% pump head coefficient for others 
end

H = Dp/(g * rho) ; % head of the pump -> parametro
Ns = ceil(Dp/Dp_ps) ; % numero di stadi necessari alla pompa -> se <1 Ns = 1
Dh = Pp/mdot ; % salto entalpico
Dt = abs(Dh)/cp ;%variazione di temperatura-> molto meno importante dell'aumento della pressione
%nei due passaggi precedenti c'è qualche errore
T_out = Dt + T_in ;
Q = mdot/rho ;
NPSH = (P_in - P_vapor)/(g*rho); % [m] Net Positive Suction Head-> misura per evitare cavitazione
Vr = (u_ss * NPSH^0.75)/sqrt(Q); 
V = 30*Vr / pi; %[rpm]
Vs = Vr*sqrt(Q)/((H/Ns)^0.75) ;  % stage specific speed rivalutata -> serve a valutare efficienza -> usa grafico
beta = P_out/P_in ; %rapporto di compressione della pompa

% pump impeller speed
u_t = sqrt((g * H)/(Ns * psi)) ;

% pump impeller diameters
phi = 0.10 ;% inducer-inlet flow coefficient
L = 0.3 ; % inducer inlet hub-to-tip diameter ratio
D2t = 2*Ut/Vr ; %[m] exit tip diameter
D1t = (((4/pi)*Q)/(phi*Vr)/(1-L^2))^(1/3);% [m] inlet tip diameter
P_req = g*mdot*H / eff; %power required from the turbine to drive the pump
% Pump mass 
% t = Pp_req/Vr -> torque
% M = A *t^B ;
% A,B coefficienti da valutare tra A:(1,3-1,6) B:(0.600-0.667)

%classe per raccogliere i dati

tp_design.head = H;
tp_design.temp_out = T_out ;
tp_design.rapp_compressione = beta ;
tp_design.num_stadi = Ns ;
tp_design.vel_rotazione_radpersecond = Vr ;
tp_design.vel_rot_rpm = V ; 
tp_design.salto_entalpico = Dh ;
tp_design.exit_tip_diameter = D2t ;
tp_design.inlet_tip_diameter = D1t;
tp_design.Power_required = P_req ;
tp_design.pump_impeller_speed = u_t ;

end
