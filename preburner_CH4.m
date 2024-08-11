clc;
close all;
clear;

% %mdot_LOX ->  portata oxidizer [kg/s]
% mdot_f -> portata fuel [kg/s}
% rho_LOX -> % densità ox [kg/m^3]
% rho_f -> densità fuel [kg/m^3]
% deltaP_LOX -> salto di pressione a cavallo dell'iniettore ox [Pa]
% deltaP_f -> salto di pressione  a cavallo dell'iniettore f [Pa]

%fuel preburner
mdot_LOX = 30.39 ;
mdot_f = 60.78;
rho_LOX =1114.7; 
rho_f = 400 ;
deltaP_LOX = 5.8e6; 
deltaP_f = 3.565e6; 

injectors_CH4preburner = inj_design(mdot_LOX, mdot_f, rho_LOX, rho_f, deltaP_LOX, deltaP_f) % chiamata funzione

%%

mdot_LOX = 15.84 ;
mdot_f = 33.625;
rho_LOX = 1114.7;
rho_f = 400 ;
deltaP_LOX = 6.36e6;
deltaP_f = 3.43e6;

injectors_LOXpreburner = inj_design (mdot_LOX, mdot_f, rho_LOX, rho_f, deltaP_LOX, deltaP_f)


%% combustion chamber


mdot_LOX = 380;
mdot_f = 158;
rho_LOX = 1128.5;
rho_f = 34.590 ;
deltaP_LOX = 2.5e6;
deltaP_f = 2.3e6;

injectors_comb_chamber = inj_design (mdot_LOX, mdot_f, rho_LOX, rho_f, deltaP_LOX, deltaP_f)
