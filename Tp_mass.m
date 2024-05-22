function [mass, min_mass, tau] = Tp_mass (P_req, Vr)% mass is extimated empirically, A and B are two coefficient that vary
% between their range of values, we will use A = 1.5 and B = 0.6 for
% conceptual design

tau = P_req/Vr ; % pump shaft torque
A = linspace(1.3, 2.6, 20)
B = linspace(0.600, 0.667, 10) ;
tau_int  = tau.^B ;
tp_mass = tau_int.*A ;

% da rivedere
% vale la pena considerare tutto l'intervallo o i valori 1.5 e 0.6 sono
% attendibili?

% quanto è importante?

end