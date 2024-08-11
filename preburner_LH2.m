clc ;
close all;
clear ;

% mdot_LOX ->  portata oxidizer [kg/s]
% mdot_f -> portata fuel []g/s}
% rho_LOX -> % densità ox [kg/m^3]
% rho_f -> densità fuel [kg/m^3]
% deltaP_LOX -> salto di pressione a cavallo dell'iniettore ox [Pa]
% deltaP_f -> salto di pressione  a cavallo dell'iniettore f [Pa]

% fuel preburner

mdot_LOX = 30.39 ;
mdot_f = 34.9;
rho_LOX =1114.7;
rho_f = 42.374 ;
deltaP_LOX = 5.8e6;
deltaP_f = 3.565e6;

injectors_LH2preburner = inj_design(mdot_LOX, mdot_f, rho_LOX, rho_f, deltaP_LOX, deltaP_f)


%% oxidizer preburner


mdot_LOX = 11.34 ;
mdot_f = 19;
rho_LOX =1114.7;
rho_f = 42.374 ;
deltaP_LOX = 6.36e6;
deltaP_f = 3.43e6;

injectors_LOXpreburner = inj_design(mdot_LOX, mdot_f, rho_LOX, rho_f, deltaP_LOX, deltaP_f)

%% comb chamber

mdot_LOX = 380.564;
mdot_f = 108.4;
rho_LOX = 1128.8;
rho_f = 11.590 ;
deltaP_LOX = 4.36e6;
deltaP_f = 1.6e6;

injectors_comb_chamber = inj_design(mdot_LOX, mdot_f, rho_LOX, rho_f, deltaP_LOX, deltaP_f)


