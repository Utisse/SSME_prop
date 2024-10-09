 %%
clear;clc;close all;

    g0 = 9.81;
    % Prendo come riferimento l'impulso totale dell'SSME
    % Spinta di un solo motore
    Thrust_sl = 1860e3; %[N]
    % burn time di tutti e tre i motori 
    burn_time = 480;
    I_tot =  Thrust_sl * burn_time; %[N s]
    I_sp_1= 366; %[s] sea level
    I_sp_2  = 311 ;
    % moltiplico per 3 poichè ho tre RS-25 e o il burntime è triplicato
    % oppure lo è la spinta
    m_prop_1= 3 * I_tot/(I_sp_1 * g0);
    m_prop_2= 3 * I_tot/(I_sp_2 * g0);
    of_1 = 6.03;
    of_2 = 3.1;

    LH.name = "Idrogeno";
    LH.m = m_prop_1/(1 + of_1);
    LH.temp = 20.3;
    LH.Tpress =   255.3722;
    LH.Ppress =    2.1849e+07; %un po' altino ma probabilmente ok
    LH.rho = 71.09070627519642;
    LH.rhopress = 18.00585015821076;
    LH.pressure = 225e3;
    LH.volume = LH.m/LH.rho;
    LH.cp = 9673.283384191343;
    LH.cv = 5657.830299878916;
    LH.gamma = LH.cp/LH.cv;
    LH.gammaPress = 1.4427; 
    LH.massa_molare =  1.00784*2;
    LH.tankMass=0;
    LH.tankHeight=0;


    ox1.name = "Ossigeno (caso LOX/LH2)";
    ox1.m = LH.m * of_1;
    ox1.rho = 1142.4497675514076; %[kg/m3]
    ox1.rhopress = 199.34724639100787;
    ox1.temp = 90.19;
    ox1.Tpress = 448.7056;
    ox1.Ppress = 2.4607e+07;
    ox1.gammaPress = 1.5102; 
    ox1.pressure = .68e6;
    ox1.volume = ox1.m/ox1.rho;
    ox1.cp = 1698.1015309831562;
    ox1.cv = 929.8734290792967;
    ox1.gamma = ox1.cp/ox1.cv;
    ox1.massa_molare = 32; %[kg/kmol]
    ox1.tankMass=0;
    ox1.tankHeight=0;


    %per il metano sono da valutare pressione e temperatura del
    %pressurizzante
    ch4.name = "Metano";
    ch4.m = m_prop_2/(1 + of_2);
    ch4.rho = 439.01; %[kg/m3]
    ch4.rhopress = 102.82178788656677;
    ch4.temp = 100;
    ch4.Tpress = 448.7056;
    ch4.Ppress = 2.4607e+07;
    ch4.gammaPress = 1.4001; 
    ch4.pressure = .68e6;
    ch4.volume = ch4.m/ch4.rho;
    ch4.cp = 3.4071e3;
    ch4.cv = 2.1140e3;
    ch4.gamma = ch4.cp/ch4.cv;
    ch4.massa_molare = 16.04; %[kg/kmol]
    ch4.tankMass=0;
    ch4.tankHeight=0;



    ox2.name = "Ossigeno (caso LOX/CH4)";
    ox2.m = ch4.m * of_2;
    ox2.rho = 1142.4497675514076; %[kg/m3]
    ox2.rhopress = 199.34724639100787;
    ox2.temp = 90.19;
    ox2.Tpress = 448.7056;
    ox2.Ppress = 2.4607e+07;
    ox2.gammaPress = 1.5102; 
    ox2.pressure = .68e6;
    ox2.volume = ox2.m/ox2.rho;
    ox2.cp = 1698.1015309831562;
    ox2.cv = 929.8734290792967;
    ox2.gamma = ox2.cp/ox2.cv;
    ox2.massa_molare = 32; %[kg/kmol]
    ox2.tankMass=0;
    ox2.tankHeight=0;


    % In realtà questi due serbatoi sono più grandi poichè 
    % non tutto il propellente viene usato a fini propulsivi (i.e. va in
    % camera di combustione).
    tanks = [[ox1 LH];[ox2 ch4]];
    % Mantengo costante il raggio che suppongo essere tale
    % per questioni strutturali
    r = 8.4/2; %[m] 
    f_s_cryo = 2; % se il serbatioio contiene un fluido criogenico ho un 
                 % fattore di sicurezza pari a due
    %% VALORI strutturali del serbatoio

    F_all =170e6; %Pa ATTENZIONE VALORE PER Al 2219
    rho =2600; % ATTENZIONE VALORE PER Al 2219
    

    
    % uso il metodo pV/W 
    % phi_tank = 2500; % [m], tipicamente per serbatoi metallici
    % g_0 = 9.81;
    R = 8314; %[m^3 Pa /(K kmol)]
    for t = 1:size(tanks,1)
        disp("---- Tank "+ t+ " -----");
        for i = 1:size(tanks,2) % Eseguo il calcolo per ogni propellente
        p = tanks(t,i);
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
                    %disp("Convergiamo a iterazione = " + iter);
                    disp("Volume pressurizzante = " + press_volume(iter));
                    %disp("Temperatura finale = " + T_f)
                    %disp("Differenza finale = "+ check)
                    break;
                end
            
            % Aggiorniamo il volume e la vecchia iterazione
                iter = iter + 1;
            end
         p.volume = p.volume + press_volume(iter);
         %disp("Volume finale = "+ p.volume)
    
         p_b = p.pressure * f_s_cryo; %tank burst pressure
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
         tank_height = l_c + r*2;
         p.tankMass = tot_mass;
         p.tankHeight = tank_height;
         %disp("Altezza del tank di " +p.name+ " = " + tank_height+ " m "  );
         %disp("Peso del tank di " +p.name+ " = " + tot_mass+ " kg "  );
         tanks(t,i) = p;
        end
        serb = tanks(t,:);
        tankmass = arrayfun(@(x) x.tankMass, serb);
        cont =  arrayfun(@(x) x.name, serb);
        volume =  arrayfun(@(x) x.volume, serb);
        height = arrayfun(@(x) x.tankHeight, serb);
        disp("continene: " + cont(1) + " | " + cont(2)+ "| SOMMMA")
        disp ("massa: " +tankmass(1)+" kg" +" | "+ tankmass(2)+" kg | "+sum(tankmass)+" kg")
        disp("volume: "+volume(1) +" m^3 | "+ volume(2)+" m^3 | "+ sum(volume)+ " m3");
        disp("altezza: "+height(1) +" m | "+ height(2)+" m | "+sum(height) + " m")
        
    end

    
   
%     
