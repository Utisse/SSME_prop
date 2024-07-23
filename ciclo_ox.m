clear;clc;close all;

% LO2 prevalve
prevalve_LO2 = stato(90.3722,imp_to_met('p',100),432.65);


% Turbopompa a bassa pressione
eta_LPOTP = 0.677;
beta_LPOTP = .417;
LPOTP = stato(93.70556,29.0958,508.023); 
turbopump_design(prevalve_LO2.P,LPOTP_stato.P,prevalve_LO2.T,prevalve_LO2.Q,rho,P_vaport,eta,cp,"ox",
% DP_LPOTP = LPOTP.T - imp_to_met('p',417);
%%
% Turbopompa ad alta pressione
% qui ho due entrate e due uscite:
% il primo input è il LOX che viene dalla LPOTP
% il secondo input viene spillato da il LOX che sta andando alla mcc
% il primo output è verso la mcc
% il secondo output invece va ai precombustori
eta_HPOTP = .746;
beta_HPOTP = 0; 
HPOTP = stato(104.2511,277.514,LPOTP.Q);

% Qui la portata si divide
% Parte va ad alimentare la pompa a bassa pressione
LPOTP_alimentazione = stato(imp_to_met('t',-272),imp_to_met('p',3801),imp_to_met('q',186));

% Parte si riscalda tramite l'oxidizer heat exchanger
% e diventa gassoso. Da questo punto in poi parte va 
% a pressurizzare l'ET e parte nel POGO suppression

pressurizzazione_ET_ox = stato(448.7056,262.06972,0.8618248);
POGO_suppression = stato(pressurizzazione_ET_ox.T,246.418625,0.09979);

% Parte va direttamente alla main combustion chamber
mcc_ox = stato(104.2611,240.2822,380.5637);

% infine parte passa dai due precombustori
in_precomb_f = stato(115.3722,366.11161,34.92658);
in_precomb_ox = stato(115.3722,366.11161,11.3398);
% preburner fuel
precomb_f = stato(983.15,330.4657,67.5852);
HPFTP_alimentazione = stato(859.2611,213.1169,67.585208);
% preburner ox
precomb_ox = stato(739.2611,331.77572,30.844256);
HPOTP_alimentazione = stato(659.8167,213.6685,30.844256);

% I gas combusti arrivano al hot gas manifold e poi finiscono nella mcc


%% 1 -> 2   INLET -> LPOTP
gamma =1.4;
[p2,t2] = TurboPumpOperation(eta_LPOTP,beta_LPOTP,prevalve_LO2.P,prevalve_LO2.T,gamma,LPOTP.T);
punto2 = stato(t2,p2,prevalve_LO2.Q);