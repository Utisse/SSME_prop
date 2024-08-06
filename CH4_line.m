clc;
close all;
clear all;

%0 -> 1 : LOW PRESSURE FUEL TURBOPUMP (PUMP)

cp_1= 3.4056e3; %[kJ/kgK] -> calore specifico a p costante
cv_1 = 2.1146e3;  %[kJ/kgK] -> calore specifico a v costante
gamma_1= cp_1/cv_1; %[-] -> coefficiente di compressione/espansione adiabatica-> rapproto tra calori specifici
% h = 0.028601 ; %[kJ/kg] -> entalpia specifica
% s = -0.07183 ; %[kJ/kgK] -> entropia specifica
% v = 0.01406 ; %[m^3/kg] -> volume specifico
p_vap = 101325 ; %[Pa] -> pressione di vapore

% adattato con Vs  = 4.46
T0 = 100 ; %[K] -> temperatura in ingresso nella prima pompa
p0 = 4e5 ; %[Pa] -> pressione in ingresso alla prima pompa
mdot = 123; %[kg/s] -> portata di fuel in ingresso al motore -> costante fino alla fuel main valve
p1 = 1.81e6 ; %[Pa] -> pressione in uscita dalla LPFTP (P)
rho_1 = 439.16;

eff = 0.71; %[-] -> efficienza della pompa presa da grafico dell'Humble

tp_design_LPFP = Turbopump_Desing (p0, p1, T0, mdot, rho_1, p_vap, eff, cp_1, 'LCH4' , 'no_booster');

disp(" --- LPFP ---");
disp("Numero di stadi = " + tp_design_LPFP.num_stadi);
disp("Temperatura in uscita = " + tp_design_LPFP.temp_out_K + " K");
disp("Potenza richiesta = " +tp_design_LPFP.Power_required_MW + " MW");
disp("Velocità di rotazione dell'albero = " + tp_design_LPFP.vel_rot_rpm + " rpm");
disp("Testa della pompa = " + tp_design_LPFP.head_m + " m");

%% HPFTP

cp_2 = 3.3091e3; %[kJ/kgK] -> calore specifico a p costante
cv_2 = 2.1502e3;  %[kJ/kgK] -> calore specifico a v costante
gamma_2 = cp_2/cv_2; %[-] -> coefficiente di compressione/espansione adiabatica-> rapproto tra calori specifici
% h = 0.028601 ; %[kJ/kg] -> entalpia specifica
% s = -0.07183 ; %[kJ/kgK] -> entropia specifica
% v = 0.01406 ; %[m^3/kg] -> volume specifico
p_vap = 101325 ; %[Pa] -> pressione di vapore

% adattato con Vs  = 4.46
T2 = 101.3278 ; %[K] -> temperatura in ingresso nella prima pompa
p2 = 1.78e6 ; %[Pa] -> pressione in ingresso alla prima pompa
mdot_2 = 123; %[kg/s] -> portata di fuel in ingresso al motore -> costante fino alla fuel main valve
p3 = 4.17e7 ; %[Pa] -> pressione in uscita dalla LPFTP (P)
rho_2 = 449.1;

eff = 0.75; %[-] -> efficienza della pompa presa da grafico dell'Humble

tp_design_HPFP = Turbopump_Desing (p2, p3,T2, mdot_2, rho_2, p_vap, eff, cp_2, 'LCH4','no_booster');

disp(" --- HPFP ---");
disp("Numero di stadi = " + tp_design_HPFP.num_stadi);
disp("Temperatura in uscita = " + tp_design_HPFP.temp_out_K + " K");
disp("Potenza richiesta = " +tp_design_HPFP.Power_required_MW + " MW");
disp("Velocità di rotazione dell'albero = " + tp_design_HPFP.vel_rot_rpm + " rpm");
disp("Testa della pompa = " + tp_design_HPFP.head_m + " m");

%% da cambiare dopo aver fatto il raffreddamento rigenerativo

p3 = 29.331e6 ;% [Pa]
p4 =  21.85e6 ; %[Pa]
T3 =  264 ; %[K]
mdot_3 = 13.15 ; % [kg/s]
rho_3 = 22.126; %[kg/m^3]
cp_3 = 14.786e3; %[J/gK]
cv_3 = 10.284e3 ;%[J/gK]
gamma_3 = cp_3 /cv_3 ;
eff_t = 0.58;
eta_mecc_tot = 0.9;
Vr_pump = tp_design_LPFP.vel_rot_rpm ;
Power_req = tp_design_LPFP.Power_required_MW;
T_design_LPFT = Turbine_Design (p3,p4,T3,cp_3,cv_3,Power_req,eff_t,eta_mecc_tot, Vr_pump, mdot_3);

disp(" --- LPFT ---");
disp("Numero di stadi = 2");
disp("Rapporto di espansione = " + T_design_LPFT.rapp_espansione );
disp("Velocità di rotazione dell'albero uguale a quella calcolata per la rispettiva pompa.");
disp("Temperatura all'uscita = " +T_design_LPFT.Outlet_temperature + " K");
disp("Potenza richiesta = " + T_design_LPFT.Power + " MW");
disp("Potenza calcolata dai dati termodinamici = " +T_design_LPFT.Power_effective + " MW");
disp("Velocità isoentropics allo scarico = " +T_design_LPFT.iso_spout_velocity + " m/s");

%% da cambiare dopo aver fatto il raffreddamento rigenerativo

p5= 29.331e6 ;% [Pa]
p6 =  21.85e6 ; %[Pa]
T5 =  264 ; %[K]
mdot_5 = 13.15 ; % [kg/s]
rho_5 = 22.126; %[kg/m^3]
cp_5 = 14.786e3; %[J/gK]
cv_5 = 10.284e3 ;%[J/gK]
gamma_5 = cp_5 /cv_5 ;
eff_t = 0.58;
eta_mecc_tot = 0.9;
Vr_pump = tp_design_HPFP.vel_rot_rpm ;
Power_req = tp_design_HPFP.Power_required_MW;
T_design_HPFT = Turbine_Design (p5,p6,T5,cp_5,cv_5,Power_req,eff_t,eta_mecc_tot, Vr_pump, mdot_5);

disp(" --- HPFT ---");
disp("Numero di stadi = 2");
disp("Rapporto di espansione = " + T_design_HPFT.rapp_espansione );
disp("Velocità di rotazione dell'albero uguale a quella calcolata per la rispettiva pompa.");
disp("Temperatura all'uscita = " +T_design_HPFT.Outlet_temperature + " K");
disp("Potenza richiesta = " + T_design_HPFT.Power + " MW");
disp("Potenza calcolata dai dati termodinamici = " +T_design_HPFT.Power_effective + " MW");
disp("Velocità isoentropics allo scarico = " +T_design_HPFT.iso_spout_velocity + " m/s");


