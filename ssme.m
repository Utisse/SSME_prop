clc;
close all; 
clear all;

%% DATI

% INLET
t_in_f = 20.27 ;  % [K]
p_in_f = 2.068 ; % [bar]
mdot_in_f = 70.307 ; %[kg/s]
k = 0.01 ;  % fattore perdite di carico nei condotti (pressione)
  
% LOW PRESSURE FUEL TURBOPUMP
beta_lpftp = 9.933 ;
eta_lptftp = 0.713 ;  
mdot_lpftp = mdot_in_f ;

% LOW PRESSURE FUEL TURBOPUMP TURBINE
beta_lpftpt = 1.38 ;
eta_lpftpt = 0.58 ;
mdot_lpftpt = 7.834 ;  %[kg/s]
lpftpt_speed = 15400 ; % [rpm] ~ 256.66 Hz
lpftpt_P = 2.48 ; % [MW]

% HIGH PRESSURE FUEL TURBOPUMP
beta_hpftp = 23.8 ; 
eta_hpftp = 0.750 ;
mdot_hpftp = mdot_lpftp ;

% HIGH PRESSURE FUEL TURBOPUMP TURBINE
beta_hpftpt = 1.50 ;
eta_hpftpt  = 0.811 ;
% mdot_hpftpt = 34.927 + mdot_ox_fpb ;
hpftpt_P = 47.04; % [MW]
hpftpt_speed = 34360 ; %[rpm] ~ 572.66 Hz

%% FUEL PREBURNER 
d = 0.265  ;%[m]
l = 0.11 ; %[m] 
O_F = 0.86 ;
mdot_ox = 66.9 ;
mdot_f = 77.7 ;



%% 1 -> 2   INLET -> LPFTP
% input
mdot = mdot_in_f;
eff = eta_lpftp ;
PR = beta_lpftp ;
P_inlet = p_in_f;
T_inlet = t_in_f ;
gamma = 1.4 ;

[p_1, t_1, p_2, t_2, mdot_2_f] = TurboPumpOperation(mdot, eff, PR, P_inlet, T_inlet, gamma)

%% 2 -> 3   LPFTP -> HPFTP
% input
mdot = mdot_2_f;
eff = eta_hpftp ;
PR = beta_hpftp ;
P_inlet = p_2;
T_inlet = t_2;
gamma = 1.4 ;

[p_2, t_2, p_3, t_3] = TurboPumpOperation (mdot, eff, PR, P_inlet, T_inlet, gamma)


%% 3 -> 4   HPFTP -> FMV
mdot_f_mcc_cool =  ;
mdot_f_noz_cool =  ;

%% 4 -> 5   FMV -> MCC. COOLING
%% 5 -> 6   MCC. COOLING -> LPFTP. T
%% 6 -> 7   LPFTP. T -> HGM. COOLING
%% 4 -> 8   FMV -> NOZZLE COOLING  (CHAMBER COOLANT VALVE)
%% 8 -> 9.1 NOZZLE COOLING (/CCV) -> FUEL PREBURNER
%% 9.2   -> OXIDIZER PREBURNER
%% 9.1 -> 10 FUEL PREBURNER -> HPFTP. T
%% 10 -> 11  HPFTP. T -> HOT GAS MANIFOLD
%% 11 -> 12  HGM -> MCC
%% 13   FUEL TANK PRESSURIZATION
%% 7 -> 14  HGM. COOLING -> MCC

%% 12 -> 14
%% 7 -> 14

