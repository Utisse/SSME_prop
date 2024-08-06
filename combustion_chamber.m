function [A_t, epsilon, L, F, eps, I_sp] = combustion_chamber_design(P_c, P_e, gamma_gc, rho_gc, T_gc, mdot, eff, R, M, L_star, A_c)
    % Costanti
    c_star = 4.440; % m/s velocità caratteristica -> da calcolare
    % Calcoli intermedi
    n_c = c_c * eff; % velocità caratteristica efficiente
    gamma_gs = gamma_gc; %gamma gc

    % Calcolo area di gola (A_t)
    A_t = (mdot*sqrt(gamma_gc * R * T_gc))/(n_c * P_c * gamma_gc * ( 2 /(gamma_gs + 1))^((gamma_gc + 1)/(2*gamma_gc - 2)));
    % Oppure
    % A_t = mdot * c_star;
    
    % Calcolo diametro di gola
    D_t = 2 * sqrt(A_t/pi);
    
    % Calcolo area totale del combustore (A_c)
    epsilon = ((1./M) * (( 2 ./(gamma_gs + 1).*(1+ ((gamma_gs - 1)./2) * M^2))^((gamma_gs + 1)/(2*(gamma_gs-1))))) ;
    
    % Calcolo temperatura all'efflusso (T_e)
    T_e = (1+ (((gamma_gc - 1)/2)*(M^2)));
    
    % Calcolo velocità all'efflusso (V_e)
    V_e = M * sqrt(gamma_gc * R * T_e);
    
    % Calcolo lunghezza del combustore (L)
    
    L = (1/epsilon).*L_star;
    
    % Calcolo spinta (F)
    F = m_flow .* V_e + (P_e - P_c)*A_c;

    % Calcolo Impulso Specifico (I_sp)


end
