function nozzle = nozzle_design (mdot,M ,pc, Tc, cp, cv, eta_c_star, fluid)

gamma = cp/cv ;

% SEZIONE DI GOLA
% area di gola
At = (mdot*sqrt(gamma*R*Tc))/(eta_c_star * pc * gamma * (2/(gamma+1))^((gamma+1)/(2*gamma-2))); % [m^2]

% At = mdot * c_star/ pc ;
% diametro sezione di gola
Dt = 2*sqrt(At/pi); % [m]

% lunghezza caratteristica creatada valori minimo e massimo forniti da
% Humble
switch fluid
    case 'LH2'
         L_star = linspace(0.76, 1.02, 0.01); % [m]
         nozzle.fluid = 'LH2';
    case 'CH4'
         L_star = linspace(0.5, 1.5, 0.01) ; %[m] da vedere i dati corretti -> totalmente inventati per il metano
         nozzle.fluid = 'CH4';
end
% chamber contraction ratio (epsilon)[-]
epsilon = (1/M)*((2/(gamma+1))*(1+((gamma-1)/2)*M^2))^((gamma+1)/(2*(gamma-1)));

% lunghezza nozzle [m]
L = zeros(size(L_star)); %inizializzo a zero il vettore che deve raccogliere le lunghezze
L = epsilon.*L_star ; % vettore lunghezza
%valutazione del minimo e del massimo
L_min = min(L);
L_max = max(L);

% nozzle exit diameter [m]
De = sqrt(4*epsilon*At/pi) ;

% nozzle shaping -> bell shaped using parabolic geometry vedi slide paravan

L_conv = 0.5 * (Dc-Dt)/tan(45) ; % [m] -> lunghezza convergente
L_div = 0.5 * (De-Dt)/tan(15) ; % [m] -> lunghzza divergente
L_nozzle = L_div + L_conv  ; % [m]-> lunghezza nozzle
L_div_bell = 0.75 * L_div ; % [m] -> lunghezza tratto diverente a campana
L_noz_bell = L_div_bell + L_conv ; % [m] -> lunghezza complessiva dell'ugello a campana


%struct per raccogliere i dati
nozzle.lunghezza = L ; %da valutare i valori del vettore per vedere quali si avvicinano al valore reale
nozzle.epsilon = epsilon ;
nozzle.exit_diameter = De ;
nozzle.exit_area = Ae;
nozzle.Throat_area = At ;
nozzle.Throat_diameter = Dt;
nozzle.bell_lenght = L_noz_bell ;

end
