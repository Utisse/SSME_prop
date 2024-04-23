function [D_inj_preburner, D_inj_combustor] = InjectorSizing(mdot_f, mdot_o, Pc, Tc, gamma_f, gamma_o, P_inj_factor, T_inj_factor)
    % Fattori di scala per le dimensioni degli iniettori
    D_inj_factor = sqrt(mdot_f / mdot_o); % Fattore di scala basato sulla portata massica del carburante e dell'ossidante
    D_inj_combustor = D_inj_factor * P_inj_factor; % Diametro dell'iniettore della camera di combustione
    D_inj_preburner = D_inj_factor * T_inj_factor; % Diametro dell'iniettore dei preburner
    
    % Correzione dei diametri degli iniettori basata sulla pressione e temperatura di combustione
    Pc_ref = 100 * 10^5; % Pressione di riferimento per il dimensionamento [Pa]
    Tc_ref = 3000; % Temperatura di riferimento per il dimensionamento [K]
    D_inj_combustor = D_inj_combustor * sqrt(Pc / Pc_ref) * (Tc / Tc_ref); % Correzione per la pressione e la temperatura
    D_inj_preburner = D_inj_preburner * sqrt(Pc / Pc_ref) * (Tc / Tc_ref); % Correzione per la pressione e la temperatura
end