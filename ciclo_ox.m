clear;clc;close all;

% LO2 prevalve
P = zeros(10,3)
Q = P;
T = P;
P(1) = imp_to_met('p',100);
T(1) = 90.3722;
Q(1) = 423.65;

% Turbopompa a bassa pressione
E_LP_pompa = 0.677;
E_LP_turbina = 0.677;
P(2) = 29.0958;
T(2) = 93.70556;
Q(2) = 508.023;

% Turbopompa ad alta pressione
P(3) = 277.514;
T(3) = 104.2511;
Q(3) = Q(2);
