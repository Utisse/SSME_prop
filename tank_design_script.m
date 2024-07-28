%%
clear;clc;close all;

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
    LH.name = "Idrogeno";
    LH.m = m_prop/(1 + of);
    LH.temp = 20.3;
    LH.Tpress =   255.3722;
    LH.Ppress =    2.1849e+07; %un po' altino ma probabilmente ok
    LH.rho = 71.09070627519642;
    LH.pressure = 225e3;
    LH.volume = LH.m/LH.rho;
    LH.cp = 9673.283384191343;
    LH.cv = 5657.830299878916;
    LH.gamma = LH.cp/LH.cv;
    LH.massa_molare =  1.00784*2;


    ox.name = "Ossigeno";
    ox.m = LH.m * of;
    ox.rho = 1141.4844624986936;
    ox.temp = 90.19;
    ox.Tpress = 448.7056;
    ox.Ppress = 2.4607e+07;
    ox.pressure = 246e3;
    ox.volume = ox.m/ox.rho;
    ox.cp = 1698.1015309831562;
    ox.cv = 929.8734290792967;
    ox.gamma = ox.cp/ox.cv;
    ox.massa_molare = 32;
    % In realtà questi due serbatoi sono più grandi poichè 
    % non tutto il propellente viene usato a fini propulsivi (i.e. va in
    % camera di combustione).
    prop = [ox, LH];
    % Mantengo costante il raggio che suppongo essere tale
    % per questioni strutturali
    r = 8.4/2; %[m] 
    f_s_cryo = 2; % se il serbatioio contiene un fluido criogenico ho un 
                 % fattore di sicurezza pari a due
    %% VALORI strutturali del serbatoio
    MEOP = 900;
    p_b = MEOP * f_s_cryo; %tank burst pressure
    F_all = 0.413; % ATTENZIONE VALORE PER Al 2219
    rho =2800; % ATTENZIONE VALORE PER Al 2219
    

    % In teoria il volume del propellente =/= volume serbatoio
    % ma somma di V_prop + V_ullage (espansione) + V_boil + V_trapped (feed lines).
    % Come lo calcolo? per ora metto V_tot = V_prop + .02 * V_prop (vedi pagina 288)
    % considerando dunque solo i primi due termini
    %V_tot = V_prop + 0.02 *V_prop;
    for i=1: length(prop)
        p = prop(i);
        p.m= 1.02* p.m;
    end
    ox.m = ox.m *1.02;
    LH.m = LH.m *1.02;
    V_tot = ox.m + LH.m;
    % uso il metodo pV/W 
    phi_tank = 2500; % [m], tipicamente per serbatoi metallici
    g_0 = 9.81;
    R = 8314;
    m_tank = p_b * V_tot /(g_0 * phi_tank); 
    %%
    % Calcolo pressurizzante, questo passaggio in teoria mi avvicinerà ai
    % valori reali.
    for i=1: length(prop) % Eseguo il calcolo per ogni propellente
        p = prop(i);
        disp(" --- "+ p.name+ " ---");
        press_volume = 0;
        press_volume_old = -1000;
        iter = 1;
        Ru = R/p.massa_molare;  
        % Considero un lungo burn time e dunque una trasformazione
        % isoentropica
        T_f = p.temp * (p.Ppress/p.pressure)^(1-p.gamma)/p.gamma
        while 1
            iter = iter + 1;
            p.volume = press_volume + p.volume;
            press_mass =  p.volume* p.pressure /(Ru * T_f);
            press_volume = press_mass * (Ru * p.temp)/p.pressure;
            if or(abs(press_volume - press_volume_old) < 1e-5, i > 1000)
            disp("Convergiamo a iterazione = "+ i);
            disp("Volume pressurizzante = " + press_volume);
            break;
            end
            press_volume_old = press_volume;
        end
    end
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
    