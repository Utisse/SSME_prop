 %%
clear;clc;close all;

    g0 = 9.81;
    % Prendo come riferimento l'impulso totale dell'SSME
    % Spinta di un solo motore
    Thrust_sl = 1860e3; %[N]
    % burn time di tutti e tre i motori 
    burn_time = 480;
    I_tot =  Thrust_sl * burn_time; %[N s]
    I_sp = 366; %[s] sea level
    % moltiplico per 3 poichè ho tre RS-25 e o il burntime è triplicato
    % oppure lo è la spinta
    m_prop = 3 * I_tot/(I_sp * g0);
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
    LH.gammaPress = 1.4427; 
    LH.massa_molare =  1.00784*2;
    LH.tank = Tank(0,0,0,0,0);


    ox.name = "Ossigeno";
    ox.m = LH.m * of;
    ox.rho = 1142.4497675514076; %[kg/m3]
    ox.temp = 90.19;
    ox.Tpress = 448.7056;
    ox.Ppress = 2.4607e+07;
    ox.gammaPress = 1.5102; 
    ox.pressure = .68e6;
    ox.volume = ox.m/ox.rho;
    ox.cp = 1698.1015309831562;
    ox.cv = 929.8734290792967;
    ox.gamma = ox.cp/ox.cv;
    ox.massa_molare = 32; %[kg/kmol]
    ox.tank = Tank(0,0,0,0,0);



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
    

    
    % uso il metodo pV/W 
    % phi_tank = 2500; % [m], tipicamente per serbatoi metallici
    % g_0 = 9.81;
    R = 8314; %[m^3 Pa /(K kmol)]

    for i = 1:length(prop) % Eseguo il calcolo per ogni propellente
    p = prop(i);
    disp(" --- " + p.name + " ---");
    disp("Volume propulsivo = " + p.volume);
    % In teoria il volume del propellente =/= volume serbatoio
    % ma somma di V_prop + V_ullage (espansione) + V_boil + V_trapped (feed lines).
    % Come lo calcolo? per ora metto V_tot = V_prop + .02 * V_prop (vedi pagina 288)
    % considerando dunque solo i primi due termini
    %V_tot = V_prop + 0.02 *V_prop;
    p.volume= 1.02* p.volume;
    disp("Volume totale escluso pressurizzante = " + p.volume);
    maxiter = 1000;
    press_volume = zeros(maxiter,1);
    iter = 2;
    Ru = R / p.massa_molare;
    % Calcolo pressurizzante, questo passaggio in teoria mi avvicinerà ai
    % valori reali.
    % Considero un lungo burn time e dunque una trasformazione isoentropica
    T_f = p.Tpress * (p.pressure / p.Ppress)^((p.gammaPress - 1) / p.gammaPress);
        while 1            
            press_volume(iter) = press_volume(iter-1) + p.volume;

            % Calcoliamo la massa del gas pressurizzante
            press_mass = press_volume(iter) * p.pressure / (Ru * T_f);
            
            % Calcoliamo il nuovo volume del gas pressurizzante
            press_volume(iter) = press_mass /p.rho;
            % Verifichiamo la condizione di convergenza
            check = abs(press_volume(iter) - press_volume(iter-1));
            if check < 1e-10|| iter > maxiter
                disp("Convergiamo a iterazione = " + iter);
                disp("Volume pressurizzante = " + press_volume(iter));
                %disp("Temperatura finale = " + T_f)
                %disp("Differenza finale = "+ check)
                break;
            end
        
        % Aggiorniamo il volume e la vecchia iterazione
            iter = iter + 1;
        end
     p.volume = p.volume + press_volume(iter);
     disp("Volume finale = "+ p.volume)

     % calotte sferiche 
     V_sfera = 4/3 * pi* r^3;
     A_sfera = 4*pi * r^2;
     spessore_sfera = p_b *r /(2*F_all);
     m_sfera = A_sfera *spessore_sfera *rho; 
     % Cilindro 
     % lunghezza della sezione cilindrica
     V_cilindro = p.volume - V_sfera;
     l_c = V_cilindro/(pi*r^2);
     A_cilindro = 2 * pi * r * l_c;
     spessore_cilindro = p_b * r /(F_all);
     m_cilindro = A_cilindro * spessore_cilindro * rho;
     tot_mass = m_cilindro + m_sfera;
     tank_height = l_c + r*2
     p.tank = Tank(p.volume,press_volume(iter),p.temp,p.pressure,tot_mass);
    end

    
   
%     