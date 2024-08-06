clc;
close all;
clear;

%LPOTP
% aggiustare Vs = 6.1, con questi dati l'efficienza dovrebbe essere 0.84
T1 = 90.37; %[K]
p1 = 6.9e5;
p2 = 2.875e6 ;
mdot = 424.109;
rho_1 = 1141.6;
cp_1 = 1.69e3;
cv_1 = 0.926e3;
eff = 0.677;
gamma = cp_1/cv_1 ;
pvap = 8e4;

tp_design_LPOP = Turbopump_Desing (p1, p2,T1, mdot, rho_1, pvap, eff, cp_1, 'LOX', 'no_booster');

disp(" --- LPOP ---");
disp("Numero di stadi = " + tp_design_LPOP.num_stadi);
disp("Temperatura in uscita = " + tp_design_LPOP.temp_out_K + " K");
disp("Potenza richiesta = " +tp_design_LPOP.Power_required_MW + " MW");
disp("Velocità di rotazione dell'albero = " + tp_design_LPOP.vel_rot_rpm + " rpm");
disp("Testa della pompa = " + tp_design_LPOP.head_m + " m");

%% HPOTP main duct
%pompa semplificata come se avesse un solo ingresso e non 2
% adattata con Vs = 4.7
T2 = 93; %[K]
p2 = 2.62e6;
p3 = 27.88e6 ;
mdot = 508; % da capire perchè aumenta
rho_2= 1132.9;
cp_2 = 1.6939e3;
cv_2= 0.92361e3;
eff = 0.718;  %efficienza presa da tabella
gamma_2 = cp_2/cv_2 ;

tp_design_HPOP = Turbopump_Desing (p2, p3,T2, mdot, rho_2, pvap, eff, cp_2, 'LOX', 'booster');

disp(" --- HPOP ---");
disp("Numero di stadi = " + tp_design_HPOP.num_stadi);
disp("Temperatura in uscita = " + tp_design_HPOP.temp_out_K + " K");
disp("Potenza richiesta = " +tp_design_HPOP.Power_required_MW + " MW");
disp("Velocità di rotazione dell'albero = " + tp_design_HPOP.vel_rot_rpm + " rpm");
disp("Testa della pompa = " + tp_design_HPOP.head_m + " m");


%% HPOP secondary duct booster impeller to raise pressure for the preburners
% T2_boost= 95; %[K]
% p2_boost = 26.59e6;
% p3_boost = 48.056e6 ;
% mdot_boost = 50.3; % da capire perchè aumenta
% rho_2_boost= 1171.69;
% cp_2_boost = 1.6098e3;
% cv_2_boost= 0.95794e3;
% eff_boost = 0.758;  %efficienza presa da tabella
% gamma_boost = cp_2_boost/cv_2_boost ;
%
% tp_design_HPOP_boost = Turbopump_Desing (p2_boost, p3_boost,T2_boost, mdot_boost, rho_2_boost, pvap, eff_boost, cp_2_boost, 'LOX', 'booster')


%% PROSEGUO

% dopo la seconda pompa ho 380 kg/s che vanno nell'iniettore principale e
% per le perdite di carico arrivano a 2.4 Mpa.
% la parte che passa nel booster 50.3 m/s è a 48 Mpa e 115 K

%% Turbine
% LPOT
p3 = 26.331e6 ;% [Pa]
p4 =  2.9e6 ; %[Pa] -> il flusso si ricongiunge a quello in uscita dall LPOP-> ipotizzo pressione matchata
T3 =  104.261 ; %[K]
mdot_3 = 84.36 ; % [kg/s]
rho_3 = 1074.9; %[kg/m^3]
cp_3 = 1.7401e3; %[J/gK]
cv_3 = 0.88615e3 ;%[J/gK]
gamma_3 = cp_3 /cv_3 ;
eff_t = 0.677;
eta_mecc_tot = 0.9;
Vr_pump = tp_design_LPOP.vel_rot_rpm ;
Power_req = tp_design_LPOP.Power_required_MW;
T_design_LPOT = Turbine_Design (p3,p4,T3,cp_3,cv_3,Power_req,eff_t,eta_mecc_tot, Vr_pump, mdot_3);

disp(" --- LPOT ---");
disp("Numero di stadi = 6")
disp("Rapporto di espansione = " + T_design_LPOT.rapp_espansione );
disp("Velocità di rotazione dell'albero uguale a quella calcolata per la rispettiva pompa.");
disp("Temperatura all'uscita = " +T_design_LPOT.Outlet_temperature + " K");
disp("Potenza richiesta = " +T_design_LPOT.Power + " MW");
disp("Potenza calcolata dai dati termodinamici = " +T_design_LPOT.Power_effective + " MW");
disp("Velocità isoentropics allo scarico = " +T_design_LPOT.iso_spout_velocity + " m/s");

%% hpot
p6 = 33.17e6 ;% [Pa]
p7 = 21.3e6 ; %[Pa] -> il flusso si ricongiunge a quello in uscita dall LPOP-> ipotizzo pressione matchata
T6 = 739.261 ; %[K]
mdot_6 = 30.844 ; % [kg/s]
rho_6 = 12.786; %[kg/m^3]
cp_6 = 9.6330e3; %[J/gK]
cv_6 = 7.054e3 ;%[J/gK]
gamma_6 = cp_6 /cv_6 ;
eff_t = 0.677;
eta_mecc_tot = 0.9;
Vr_pump = tp_design_HPOP.vel_rot_rpm ;
Power_req = tp_design_HPOP.Power_required_MW;
T_design_HPOT = Turbine_Design (p6,p7,T6,cp_6,cv_6,Power_req,eff_t,eta_mecc_tot, Vr_pump, mdot_6);

disp(" --- HPOT ---");
disp("Numero di stadi = 3");
disp("Rapporto di espansione = " + T_design_HPOT.rapp_espansione );
disp("Velocità di rotazione dell'albero uguale a quella calcolata per la rispettiva pompa.");
disp("Temperatura all'uscita = " +T_design_HPOT.Outlet_temperature + " K");
disp("Potenza richiesta = " +T_design_HPOT.Power + " MW");
disp("Potenza calcolata dai dati termodinamici = " +T_design_HPOT.Power_effective + " MW");
disp("Velocità isoentropics allo scarico = " +T_design_HPOT.iso_spout_velocity + " m/s");

%TUTTO CORRETTO

%% INIETTORI