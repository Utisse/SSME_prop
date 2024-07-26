function performance = Performance_calculations (mdot, gamma, rho, Cp, Cv, pc, tc, pe, g, Ve)

% completamente da rifare

mdot_ex = mdot ; % portat dei gas combusti ;
R = Cp-Cv ; %costante dei gas
% Impulso specifico ponderale (Isp)
T = mdot_ex * Ve; % Calcolo della spinta [N]
I_sp = T / (mdot_ex * g0); % Calcolo dell'impulso specifico ponderale [s] , occhio che sul cea da n m/s

% Velocità specifica (c_star)
C_star = sqrt((2 * gamma / (gamma - 1)) * R * T_c); % Calcolo della velocità specifica [m/s]

% Velocità di efflusso dall'ugello (Ve)
v_e = C_star * sqrt(1-(pe/pc)^((gamma-1)/gamma)); % Calcolo della velocità di efflusso dall'ugello [m/s]

%struct per raccogliere i dati
performance.thrust = T ;
performance.vel_specifica = C_satr;
performance.Mach_uscita = Ma_e ;
performance.vel_uscita = v_e ;
performance.coeff_spinta = C_T ;
performance.t_uscita = t_ex ;
performance.imp_specifico_grav = I_sp ;
performance.imp_specifico_vacuum = I_vac ;
performance.fun_di_Vanderchkove = GAMMA ;

end