function  T_design= Turbine_Design (p_in,p_out,T_in,cp,cv,P_req,eff_turb,eta_mecc, Vr_pump, mdot)

% k perdite di pressione
% Ns numero 
% beta rapporto di espansione

% formule 
gamma = cp/cv;
beta = p_in/p_out ;
Power = P_req/(eta_mecc); % la potena qui è prodotta
% da capire quali sono questi eta_mecc
% verifica che sia maggiore di quella della turbopompa P_tp ;
 
% valutare la temperatura all'uscita
T_out_id = T_in*((1/beta)^((gamma-1)/gamma));
T_out = T_in - (eff_turb*(T_in - T_out_id));

% isoentropic spouting velocity:
% velocity that the turbine gas flow would have if they were expanded isoentropically 
% from the turbine inlet conditions to the turbine exit static pressure
% è importante?
 C_0 = sqrt(2*cp*T_in*(1-(1/beta)^((gamma-1)/gamma))) ;

% Pitch diameter
% if single rotor U_m = 0.4 * C_0
% if thre rotors U_m = 0.21 * C_0 ;
U_m = 0.25 * C_0 ; % dal grafico su humble -> considero turbina a 2 rotori 50% reaction
Vr = Vr_pump; % non considero la presenza di riduttori di velocità radiale -> singola v_shaft per pompa e turbina
Dm = 2*U_m/Vr;
% Vr -> rotational speed
% Um -> pitch velocity -> da grafici

Power_effective = mdot * cp * (T_in - T_out) ;

% serve altro per la turbina
% il numero di stadi

T_design.iso_spout_velocity = C_0 ;
T_design.pitch_velocity = U_m;
T_design.rotational_speed = Vr; 
T_design.pitch_diameter = Dm;
T_design.rapp_espansione = beta;
T_design.Outlet_temperature = T_out ;
T_design.Power = Power;
T_design.Power_effective = Power_effective * 10^(-6) ;

end