clear;clc;close all;

% LO2 prevalve
prevalve_LO2 = stato(90.3722,imp_to_met('p',100), 432.65);
k_prevalve = 0.01;

% Turbopompa a bassa pressione
eta_LPOTP = 0.677;
beta_LPOTP = 417/100;
LPOTP = stato(93.70556,29.0958,508.023); 
DP_LPOTP = LPOTP.T - imp_to_met('p',417);

% Turbopompa ad alta pressione
HPOTP = stato(104.2511,277.514,LPOTP.Q);

% Qui la portata si divide
% Parte va ad alimentare la pompa a bassa pressione
LP_turbopump_ox_alimentazione = stato(imp_to_met('t',-272),imp_to_met('p',3801),imp_to_met('q',186));

% Parte si riscalda tramite l'oxidizer heat exchanger
% e diventa gassoso. Da questo punto in poi parte va 
% a pressurizzare l'ET e parte nel POGO suppression

pressurizzazione_ET_ox = stato(448.7056,262.06972,0.8618248);
POGO_suppression = stato(pressurizzazione_ET_ox.T,246.418625,0.09979);

% Parte va direttamente alla main combustion chamber
mcc_ox = stato(104.2611,240.2822,380.5637);

% infine parte passa dai due precombustori
%fuel_preburner_ox = stato(115.3722)

