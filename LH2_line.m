clc;
close all ;
clear all ;


% 0 -> 1 : LOW PRESSURE FUEL TURBOPUMP (PUMP)
% DATI INIZIALI
% presi da NIST chemical
% dati termodinamici idrogeno a 20.27 K e 0.2 Mpa -> fase liquida

rho_1 = 71.997 ; %[kg/m^3] -> densità
cp_1 = 9.3707e3; %[kJ/kgK] -> calore specifico a p costante
cv_1 = 5.6602e3;  %[kJ/kgK] -> calore specifico a v costante
gamma_1= cp_1/cv_1; %[-] -> coefficiente di compressione/espansione adiabatica-> rapproto tra calori specifici
% h = 0.028601 ; %[kJ/kg] -> entalpia specifica
% s = -0.07183 ; %[kJ/kgK] -> entropia specifica
% v = 0.01406 ; %[m^3/kg] -> volume specifico
p_vap = 101325 ; %[Pa] -> pressione di vapore

% adattato con Vs  = 4.46
T0 = 20.27 ; %[K] -> temperatura in ingresso nella prima pompa
p0 = 2e5 ; %[Pa] -> pressione in ingresso alla prima pompa
mdot = 70.4; %[kg/s] -> portata di fuel in ingresso al motore -> costante fino alla fuel main valve
p1 = 1.98e6 ; %[Pa] -> pressione in uscita dalla LPFTP (P)

eff = 0.71; %[-] -> efficienza della pompa presa da grafico dell'Humble

tp_design_LPFP = Turbopump_Desing (p0, p1, T0, mdot, rho_1, p_vap, eff, cp_1, 'LH2' , 'no_booster');

disp(" --- LPFP ---");
disp("Numero di stadi = " + tp_design_LPFP.num_stadi);
disp("Temperatura in uscita = " + tp_design_LPFP.temp_out_K + " K");
disp("Potenza richiesta = " +tp_design_LPFP.Power_required_MW + " MW");
disp("Velocità di rotazione dell'albero = " + tp_design_LPFP.vel_rot_rpm + " rpm");
disp("Testa della pompa = " + tp_design_LPFP.head_m + " m");
%% 1 -> 2 : HPFTP (P)
% primo stadio
% dati termodinamici di LH2 a 23.19 K e 1.72 MPa -> durante il pompaggio il
% fluido diventa supercritico, da vedere come gestire i dati.
% ANALIZZATA STADIO PER STADIO IN MANIERA TALE DA VALUTARE OGNI VOLTA LA
% DENSITA' DEL FLUIDO (DIVENTA SUPERCRITICO). RISULTATI LEGGERMENTE DIVERSI
% DALLA REALTA', IN PARTICOLARE TEMPERATURA E POTENZA RICHIESTA(SOMMA DEI 3
% STADI)
% PER LA VELOCITA' DI ROTAZIONE DELLE POMPE HO FISSATO QUELLA REALE A
% 34360RPM E IN QUESTO CASO VALUTIAMO LA VELOCITA' SPECIFICA PER OGNI
% STADIO. SEMPRE PER PROBLEMI RELATIVI AL FATTO DEL FLUIDO SUPERCRITICO
T1 = 23.19 ;
p1 =1.723690e6 ;
p_s2 = 4.96e6;
mdot = 70.4;
rho_s1 = 68.9;
cp_s1 = 10.587e3;
cv_s1 = 5.8592e3;
gamma_s1= cp_s1/cv_s1;
eff = 0.75 ;
pvap = 9e4; % da ricontrollare
HPFP_s1 = pompa_idrogeno(p1, p_s2,T1, mdot, rho_s1, pvap, eff, cp_s1);

%% secondo stadio

T_s2 = 28.106 ;
p_s2 = 4.96e6 ;
p_s3 = 14.28e6  ;
mdot = 70.4 ;
rho_s2 = 67.591 ;
cp_s2 = 23.916e3 ;
cv_s2 = 12.563e3 ;
gamma_s2  = cp_s2/cv_s2 ;
eff = 0.75 ;
pvap = 9e4 ;
HPFP_s2 = pompa_idrogeno(p_s2,p_s3,T_s2, mdot, rho_s2, pvap, eff, cp_s2);


%% 3 stadio
T_s3 = 35.7934;
p_s3 = 14.28e6;
p_2 = 41.7e6  ;
mdot = 70.4 ;
rho_s3 = 71.117 ;
cp_s3 = 22.848e3 ;
cv_s3= 13.353e3 ;
gamma_s3  = cp_s3/cv_s3 ;
eff = 0.75 ;
pvap = 9e4 ;
HPFP_s3 = pompa_idrogeno(p_s3, p_2,T_s3, mdot, rho_s3, pvap, eff, cp_s3);
Power_req = HPFP_s3.power_required + HPFP_s2.power_required + HPFP_s1.power_required;
Vr_pump = 34360;
Total_head = HPFP_s3.head_perstage + HPFP_s2.head_perstage + HPFP_s1.head_perstage;
disp(" --- HPFP ---");
disp("Numero di stadi = 3");
disp("Temperatura in uscita = " + HPFP_s3.T_exit + " K");
disp("Potenza richiesta = " + Power_req + " MW");
disp("Velocità di rotazione dell'albero = " + Vr_pump + " rpm");
disp("Testa della pompa = " + Total_head + " m");

%% RAFFREDDAMENTO RIGENERATIVO


%% Turbine
% riceve il fluido dal raffreddamento della camera di combustione ->
% conv-divergente
% LPFT
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
disp("Potenza richiesta = " +T_design_LPFT.Power + " MW");
disp("Potenza calcolata dai dati termodinamici = " +T_design_LPFT.Power_effective + " MW");
disp("Velocità isoentropics allo scarico = " +T_design_LPFT.iso_spout_velocity + " m/s");
%% HPFT
% solo divergente
p5 = 33.047e6 ;% [Pa]
p6 =  21.305e6 ; %[Pa]
T5 =  883.15 ; %[K]
mdot_5 = 65.77; % [kg/s]
rho_5= 11.714; %[kg/m^3]
cp_5= 8.7355e3; %[J/gK]
cv_5= 6.518e3 ;%[J/gK]
gamma_5 = cp_5/cv_5 ;
eff_t = 0.811;
eta_mecc_tot = 0.9;
Vr_pump = 34360;
Power_req = HPFP_s3.power_required + HPFP_s2.power_required + HPFP_s1.power_required;
T_design_HPFT = Turbine_Design (p5,p6,T5,cp_5,cv_5,Power_req,eff_t,eta_mecc_tot, Vr_pump, mdot_5);

disp(" --- HPFT ---");
disp("Numero di stadi = 2");
disp("Rapporto di espansione = " + T_design_HPFT.rapp_espansione );
disp("Velocità di rotazione dell'albero uguale a quella calcolata per la rispettiva pompa.");
disp("Temperatura all'uscita = " +T_design_HPFT.Outlet_temperature + " K");
disp("Potenza richiesta = " +T_design_HPFT.Power + " MW");
disp("Potenza calcolata dai dati termodinamici = " +T_design_HPFT.Power_effective + " MW");
disp("Velocità isoentropics allo scarico = " +T_design_HPFT.iso_spout_velocity + " m/s");

% ovviamente l'errore nel calcolo della potenza per la pompa dovuta al
% fatto che il liquido è supercritico si amplifica con la turbina.
% la potenza calcolata dalla T_out è realistica -> errore inferiore