function [beta, Dh, Dt, speed, Ns, Power] = Turbine_Design (p_in, p_out, T_in, mdot, cp, cv,  rho, P_tp, eff_turb, eff_tp, k)

% k perdite di pressione
% Ns numero 
% beta rapporto di espansione

% formule 
% gamma = cp/cv ;
% beta = p_out/p_in ;
% Power = eff_turb * mdot* cp * T_in*  (1-(1/beta)^((gamma-1)/gamma)) ;
% verifica che sia maggiore di quella della turbopompa P_tp ;
 
% valutare la temperatura all'uscita
% T_out_id = T_in * (beta ^ ((gamma-1)/gamma));
% T_out = (eff * (T_out_id - T_in)) + T_in ;


% isoentropic spouting velocity:
% velocity that the turbine gas flow would have if they were expanded isoentropically 
%from the turbine inlet conditions to the turbine exit static pressure
% c_0 = sqrt (2 * cp * T_in * (1-(1/beta)^((gamma-1)/gamma))) ;


% Pitch diameter
% Dm = 2*Um / Nr
% Nr -> rotational speed
% Um da capire cos' [kg]

