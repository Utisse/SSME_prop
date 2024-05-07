function tp_mass = Tp_mass_extimation (A, B, P_req, Vr)
% mass is extimated empirically, A and B are two coefficient that vary
% between their range of values, we will use A = 1.5 and B = 0.6 for
% conceptual design

tau = P_req/Vr ; % pump shaft torque
tp_mass = A * tau^B;

end
