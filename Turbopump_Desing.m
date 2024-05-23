function tp_design = Turbopump_Desing (P_in, P_out,T_in, mdot, rho, P_vapor, eff, cp, type)

g = 9.81; % costante (accelerazione gravitazionale) [m/s^2]

Dp = P_out - P_in;% salto di pressione richiesto a cavallo della pompa [Pa]

if type == 0 
    Dp_ps = 16e6 ; % [Pa] -> masssimo Dp (teorico) per singolo stadio per LH2 da libro "space prop. analysis and design " (Humble)
    disp('FUEL LH2')
    Ns = 2.0; % stage specific speed per LH2
    u_ss = 130 ;% suction specific speed per LH2
    psi = 0.60 ;% pump head coefficient for LH2
end
if  type == 1 
    Dp_ps = 47e6 ; % [Pa] -> masssimo Dp (teorico) per singolo stadio per altri fluidi da libro "space prop. analysis and design" (Humble)
    disp('OXIDIZER LOX')
    Ns = 3.0 ; % [ - ] è adimensionale -> stage specific speed per altre specie;
    u_ss = 90; % suction specific speed for cryogenic liquids
    psi = 0.55 ; % pump head coefficient for others 
end

H = Dp/(g*rho); % head of the pump
n = ceil(Dp/Dp_ps) ; % numero di stadi necessari alla pompa -> se <1 Ns = 1 effettuato da funzione ceil



Q = mdot/rho; % [m^3/s] -> portata volumetrica
NPSH = (P_in - P_vapor)/(g*rho); % [m] Net Positive Suction Head-> misura per evitare cavitazione
Vr_npsh = (u_ss*(NPSH^0.75))/sqrt(Q); % da usare se pompa preceduta da booster
% -> per le seconde pompe è da usare questo? considero le prime dei
% booster?
Vr = (Ns*(H/n)^0.75)/sqrt(Q); % [rad/s]
% Se invece non è preceduto da booster va usato il valore minore
if Vr > Vr_npsh
    disp('Uso valore alternativo di Vr');
    Vr = Vr_npsh;
end
%Ns = 5018 * sqrt(Q)/(H/n)^(.75);


V = 30*Vr/pi; % [rpm] -> trasformo da [rad/s] in [rpm] -> da verificare formula
% Vs = Vr*sqrt(Q)/((H/Ns)^0.75) ;  % [rad/s]? -> stage specific speed rivalutata -> serve a valutare efficienza -> usa grafico
beta = P_out/P_in ; %rapporto di compressione della pompa

% pump impeller speed
u_t = sqrt((g*H)/(n * psi)) ; %a cosa serve?

% pump impeller diameters
phi = 0.10 ;% inducer-inlet flow coefficient
L = 0.3 ; % inducer inlet hub-to-tip diameter ratio
D2t = 2*u_t/Vr ; %[m] exit tip diameter
D1t = (((4/pi)*Q)/(phi*Vr)/(1-L^2))^(1/3);% [m] inlet tip diameter

%per i diametri non abbiamo un riferimento attendibile

P_req = (g*mdot*H*10^(-6))/eff; %power required from the turbine to drive the pump
Dh = P_req/mdot; % salto entalpico
Dt = Dh/cp; %variazione di temperatura-> molto meno importante dell'aumento della pressione
%nei due passaggi precedenti c'è qualche errore
T_out = Dt + T_in ;
%T_out troppo bassa

%struct per raccogliere i dati

tp_design.head_m = H;
tp_design.temp_out_K= T_out ;
tp_design.rapp_compressione = beta ;
tp_design.NPSH = NPSH ;
tp_design.num_stadi = n ;
tp_design.vel_rotazione_radpersecond = Vr ;
tp_design.vel_rot_rpm = V ; 
tp_design.salto_entalpico = Dh ;
tp_design.exit_tip_diameter_m = D2t ;
tp_design.inlet_tip_diameter_m = D1t;
tp_design.Power_required_MW = P_req ;
tp_design.pump_impeller_speed_mpersec = u_t ;

end