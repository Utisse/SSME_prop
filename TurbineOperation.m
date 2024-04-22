function [P_in, T_in, P_out, T_out] = TurbineOperation(mdot, eff, PR, P_inlet, T_inlet, power, rpm)
    % Dati di design
    R = 287; % Costante specifica del gas [J/(kg*K)]
    
    % Efficienza della turbina
    eta_turbine = eff;
    
    % Rapporto di espansione della turbina
    PR_turbine = PR;
    
    % Condizioni in ingresso
    P_in = P_inlet; % Pressione in ingresso [Pa]
    T_in = T_inlet; % Temperatura in ingresso [K]
    
    % Calcolo della pressione in uscita
    P_out = P_in / PR_turbine; % Pressione in uscita [Pa]
    
    % Calcolo della temperatura in uscita considerando l'efficienza
    T_out = T_in * (1 - ((1 - PR_turbine^(1/gamma)) / eta_turbine)); % Temperatura in uscita [K]
end