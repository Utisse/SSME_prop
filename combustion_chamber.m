function [A_t, A_c, L, F, eps, I_sp,] = combustion_chamber_design(P_c, P_e, gamma_gc, d_gc, T_gc, m_flow, eff, R, M, L_car)
    % Costanti
    c_c = 4.440; % m/s velocità caratteristica
    
    % Calcoli intermedi
    n_c = c_c * eff; % velocità caratteristica efficiente
    gamma_gs = gamma_gc; % gamma gc
    
    % Calcolo area di gola (A_t)
    A_t = (m_flow*sqrt(gamma_gc * R * T_gc))/(n_c * P_c * gamma_gc * ( 2 /(gamma_gs + 1))^((gamma_gc + 1)/(2*gamma_gc - 2)));
    % Oppure
    % A_t = m_flow * c_c;
    
    % Calcolo diametro
    D = 2 * sqrt(A_t/pi);
    
    % Calcolo area totale del combustore (A_c)
    A_c = ((1./M) * (( 2 ./(gamma_gs + 1).*(1+ ((gamma_gs - 1)./2) * M^2))^((gamma_gs + 1)/(2*(gamma_gs-1)))) * A_t;
    
    % Calcolo temperatura all'efflusso (T_e)
    T_e = (1+ (((gamma_gc - 1) /2) * (M^2)));
    
    % Calcolo velocità all'efflusso (V_e)
    V_e = M .* sqrt(gamma_gc * R * T_e);
    
    % Calcolo lunghezza del combustore (L)
    L = L_car * (A_t ./ A_c);
    
    % Calcolo forza (F)
    F = m_flow .* V_e + (P_e - P_c)*A_c;
    
    % Calcolo epsilon
    

    % Calcolo Impulso Specifico (I_sp)


    %

end
