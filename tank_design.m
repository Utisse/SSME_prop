function [tank] = tank_design()
    % [tank] = tank_design(vol_prop,isCryo,MEPP,mm_prop,gamma,T_i,P_f,P_i)
    % Chiede volume del propellente, se è criogenico (TRUE o FALSE)
    % Maximum Operating Pressure,massa molare del propellente, 
    % del materiale e restituisce V, il volume

    g0 = 9.81;
    % Prendo come riferimento l'impulso totale dell'SSME
    % Spinta di un solo motore
    Thrust_sl = 1860e3; %[N]
    % burn time di tutti e tre i motori 
    burn_time = 480;
    % moltiplico per 3 poichè ho tre RS-25 e o il burntime è triplicato
    % oppure lo è la spinta
    I_tot = 3* Thrust_sl * burn_time; %[N s]
    I_sp = 366; %[s] sea level
    m_prop = I_tot/(I_sp * g0);
    of = 6.03;
    LH.m = m_prop/(1 + of);
    LH.temp = 20.3;
    LH.rho = 71.09070627519642;
    LH.pressure = 225e3;
    LH.volume = LH.m/LH.rho;
    ox.m = LH.m * of;
    ox.rho = 1141.4844624986936;
    ox.temp = 90.19;
    ox.pressure = 246e3;
    ox.volume = ox.m/ox.rho;
    % In realtà questi due serbatoi sono più grandi poichè 
    % non tutto il propellente viene usato a fini propulsivi (i.e. va in
    % camera di combustione).

    % Mantengo costante il raggio che suppongo essere tale
    % per questioni strutturali
    r = 8.4/2; %[m] 
    f_s_cryo = 2; % se il serbatioio contiene un fluido criogenico ho un 
                 % fattore di sicurezza pari a due
    %% VALORI strutturali del serbatoio
    p_b = MEOP * f_s_cryo; %tank burst pressure
    F_all = 0.413; % ATTENZIONE VALORE PER Al 2219
    rho =2800; % ATTENZIONE VALORE PER Al 2219
    

    % In teoria il volume del propellente =/= volume serbatoio
    % ma somma di V_prop + V_ullage (espansione) + V_boil + V_trapped (feed lines).
    % Come lo calcolo? per ora metto V_tot = V_prop + .02 * V_prop (vedi pagina 288)
    % considerando dunque solo i primi due termini
    %V_tot = V_prop + 0.02 *V_prop;
    ox.m = ox.m *1.02;
    LH.m = LH.m *1.02;
    V_tot = ox.m + LH.m;
    % uso il metodo pV/W 
    phi_tank = 2500; % [m], tipicamente per serbatoi metallici
    g_0 = 9.81;

    m_tank = p_b * V_tot /(g_0 * phi_tank); 

    % Calcolo pressurizzante, questo passaggio in teoria mi avvicinerà ai
    % valori reali 
    T_f = T_i *(P_f/P_i)^((gamma - 1)/gamma);
    mm_pressurizzante = mm_prop; % Credo che in particolare nel STS sia corretto
    R = 8314;
    Ru = R / mm_pressurizzante;
    V_press = [];
    i = 1;
    V_press(1) = V_tot;
    while 1
        i = i + 1;
        m_press = V_press(i-1) *P_f /(Ru * T_f);
        V_press(i) = m_press * Ru * T_f /P_f;
        if or(abs(V_press(i) - V_press(i-1))  == 0, i > 100000)
            disp("Convergiamo a iterazione = "+ i);
            break;
        end
    end
    V = V_press;
    
    
    l_c = 15;

    Volume_finale = V(end);

    %% calotte sferiche 
    V_sfera = 4/3 * pi* r^3;
    A_sfera = 4*pi * r^2;
    spessore_sfera = p_b *r /(2*F_all);
    m_sfera = A_sfera *spessore_sfera *rho; 
    %% Cilindro 
    % lunghezza della sezione cilindrica
    V_cilindro = pi*r* l_c;
    A_cilindro = 2 * pi * r * l_c;
    spessore_cilindro = p_b * r /(F_all);
    m_cilindro = A_cilindro * spessore_cilindro * rho;
    V_press = abs(V(end)- V_tot);
    tank = Tank(V(end),V_press,T_f,P_f);
%% PER TEST
% Tank(1514.6,true,900,1.00784,1.4,20.37222,206842.7184,21849485.82032)

