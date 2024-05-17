function [V] = ExternalTank(V_prop,isCryo,MEOP,mm_prop,gamma,T_i,P_f,P_i)
    % [V] = TANK(vol_prop,isCryo,MEPP,mm_prop,gamma,T_i,P_f,P_i)
    % Chiede volume del propellente, se è criogenico (TRUE o FALSE)
    % Maximum Operating Pressure,massa molare del propellente, 
    %  
    % del materiale e restituisce V, il volume

    if isCryo
        f_s = 2; 
    end
    %% VALORI 
    p_b = MEOP * f_s; %tank burst pressure
    F_all = 0.413; % ATTENZIONE VALORE PER Al 2219
    rho =2800; % ATTENZIONE VALORE PER Al 2219
    r = 4.2; % Raggio del tank !!! DA CONTROLLARE, FORSE é ESTERNO E NON INTERNO.
    
    %% calotte sferiche 
    V_s = 4/3 * pi* r^3;
    A_s = 4*pi * r^2;
    s_s = p_b *r /(2*F_all);
    m_s = A_s *s_s *rho;

    %% Cilindro 
    % lunghezza della sezione cilindrica
    l_c = 15;
    V_c = pi*r* l_c;
    A_c = 2 * pi * r * l_c;
    t_c = p_b * r /(F_all);
    m_c = A_c * t_c * rho;

    % In teoria il volume del propellente =/= volume serbatoio
    % ma somma di V_prop + V_ullage (espansione) + V_boil + V_trapped (feed lines).
    % Come lo calcolo? per ora metto V_tot = V_prop + .02 * V_prop (vedi pagina 288)
    % considerando dunque solo i primi due termini
    V_tot = V_prop + 0.02 *V_prop;

    % uso il metodo pV/W 
    phi_tank = 2500; % [m], tipicamente per serbatoi metallici
    g_0 = 9.81;

    m_tank = p_b * V_tot /(g_0 * phi_tank); 

    %% Calcolo pressurizzante
    T_f = T_i *(P_f/P_i)^((gamma - 1)/gamma);
    mm_pressurizzante = mm_prop; % Credo che in particolare nel STS sia corretto
    R = 8314;
    Ru = R / mm_pressurizzante;
    V_press = [];
    i = 1;
    V_press(i) = V_tot;
    while 1
        i = i + 1;
        V_press(i) = V_press(i-1) + V_tot;
        m_press = V_press(i) *P_f /(Ru * T_f);
        V_press(i) = m_press * Ru * T_f /P_f;
        if or(abs(V_press(i) - V_press(i-1)) < 10^-5, i > 100000)
            disp("Convergiamo");
            break;
        end
    end
    V = V_press(:) + V_tot;
    
%% PER TEST
% ExternalTank(1514.6,true,900,1.00784,1.4,20.37222,206842.7184,21849485.82032)

