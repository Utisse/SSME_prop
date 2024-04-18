clear;clc;close all;

% LO2 prevalve
prevalve = stato_termodinamico(imp_to_met('p',100), 90.3722,432.65);
k_prevalve = 0.01;

% Turbopompa a bassa pressione
eta_lpotp = 0.677;
beta_lfotp = 00000;
LP_turbopump_ox = stato_termodinamico(93.70556,29.0958,508.023); 

% Turbopompa ad alta pressione
HP_turbopump_ox = stato_termodinamico(104.2511,277.514,LP_turbopump_ox.Q);

% Qui la portata si divide
% Parte va ad alimentare la pompa a bassa pressione
LP_turbopump_ox_alimentazione = stato_termodinamico(imp_to_met('t',-272),imp_to_met('p',3801),imp_to_met('q',186));

% Parte si riscalda tramite l'oxidizer heat exchanger
% e diventa gassoso. Da questo punto in poi parte va 
% a pressurizzare l'ET e parte nel POGO suppression

pressurizzazione_ET_ox = stato_termodinamico(448.7056,262.06972,0.8618248);
POGO_suppression = stato_termodinamico(pressurizzazione_ET_ox.T,246.418625,0.09979);

% Parte va direttamente alla main combustion chamber
mcc_ox = stato_termodinamico(104.2611,240.2822,380.5637);

% infine parte passa dai due precombustori
%fuel_preburner_ox = stato_termodinamico(115.3722)

