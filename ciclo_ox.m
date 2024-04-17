clear;clc;close all;

% LO2 prevalve
prevalve = stato_termodinamico(imp_to_met('p',100), 90.3722,432.65);

% Turbopompa a bassa pressione
E_LP_pompa = 0.677;
E_LP_turbina = 0.677;
LP_turbopump_ox = stato_termodinamico(93.70556,29.0958,508.023); 

% Turbopompa ad alta pressione
HP_turbopump_ox = stato_termodinamico(104.2511,277.514,LP_turbopump_ox.Q);

% Qui la portata si divide
% Parte va ad alimentare la pompa a bassa pressione
LP_turbopump_ox_alimentazione = stato_termodinamico(imp_to_met('t',-272),imp_to_met('p',3801),imp_to_met('q',186));

% Parte si riscalda tramite l'oxidizer heat exchanger
% e diventa gassoso. Da questo punto in poi parte va 
% a pressurizzare l'ET e parte nel POGO suppression



