function [P_in, T_in, P_out, T_out, mdot_out] = TurboPumpOperation(mdot, eff, PR, P_inlet, T_inlet, gamma)
    % Dati di design
    R = 287; % Costante specifica del gas [J/(kg*K)]
    
    % Efficienza delle turbopompe
    eta_pump = eff;
    
    % Rapporto di compressione delle turbopompe
    PR_pump = PR;
    
    % Condizioni in ingresso
    P_in = P_inlet; % Pressione in ingresso [Pa]
    T_in = T_inlet; % Temperatura in ingresso [K]
    
    % Calcolo della pressione in uscita
    P_out = P_in * PR_pump; % Pressione in uscita [Pa]
    
    % Calcolo della temperatura in uscita considerando l'efficienza
    T_out_id= T_in*PR_pump^((gamma-1)/(gamma)); % Temperatura in uscita ideale [K]
    T_out = (T_out_id - T_in) / eta_pump ; % considero l'efficienza della turbopompa
    mdot_out = mdot ; % portata in uscita dalla turbopompa
end