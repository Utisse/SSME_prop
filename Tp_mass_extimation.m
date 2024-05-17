function tp_mass = Tp_mass_extimation (A, B, P_req, Vr)
% mass is extimated empirically, A and B are two coefficient that vary
% between their range of values, we will use A = 1.5 and B = 0.6 for
% conceptual design

tau = P_req/Vr ; % pump shaft torque
A = linspace(1.2, 2.3, 10);
B = linspace(0.600, 0.667, 10) ;
tau_int  = tau.^B ;
tp_mass = tau_int'.*A ;

end
