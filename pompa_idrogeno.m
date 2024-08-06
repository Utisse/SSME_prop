function HPFP = pompa_idrogeno(P_in, P_out,T_in, mdot, rho, P_vapor, eff, cp)

g = 9.81; % costante (accelerazione gravitazionale) [m/s^2]
Dp = P_out - P_in ;% salto di pressione richiesto a cavallo della pompa [Pa] per stage
beta = P_out/P_in ; %rapporto di compressione della pompa
H = Dp/(g*rho); % head of the pump per stage
% Ns = ceil(Dp/Dp_ps) ; % numero di stadi necessari alla pompa -> se <1 Ns = 1 effettuato da funzione ceil
Q = mdot/rho; % [m^3/s] -> portata volumetrica
NPSH = (P_in - P_vapor)/(g*rho); % [m] Net Positive Suction Head-> misura per evitare cavitazione

Dp_ps = 16e6; % [Pa] -> masssimo Dp (teorico) per singolo stadio per LH2 da libro "space prop. analysis and design " (Humble)
% Vs = 3; % stage specific speed per LH2 -> ipotizzata in base ai dati trovati, secondo humble dovrebbe essere attorno a 2.
u_ss = 130 ;% suction specific speed per LH2
psi = 0.60 ;% pump head coefficient for LH2
tp_design.fluid = 'FUEL LH2';
V = 34000 ; %[rpm]
Vr = V*pi/30 ;
Vs = Vr*sqrt(Q)/((H/1)^0.75);   % [rad/s]? -> stage specific speed rivalutata -> serve a valutare efficienza -> usa grafico
%pump impeller speed
u_t = sqrt((g*H)/(1 * psi)) ; %a cosa serve?

% pump impeller diameters
phi = 0.10 ;% inducer-inlet flow coefficient
L = 0.3 ; % inducer inlet hub-to-tip diameter ratio
D2t = 2*u_t/Vr ; %[m] exit tip diameter
D1t = (((4/pi)*Q)/(phi*Vr)/(1-L^2))^(1/3);% [m] inlet tip diameter

%per i diametri non abbiamo un riferimento attendibile

P_req = (g*mdot*H)/eff; %power required from the turbine to drive the pump
Dh = P_req/mdot; % salto entalpico
Dt = Dh/cp;%variazione di temperatura-> molto meno importante dell'aumento della pressione
% nei due passaggi precedenti c'è qualche errore
T_out = Dt + T_in ;
%T_out troppo bassa


HPFP.head_perstage = H ;
HPFP.exit_d = D2t ;
HPFP.in_d = D1t ;
HPFP.T_exit = T_out ;
HPFP.spec_stag_vel = Vs ;
HPFP.NPSH_perstage = NPSH ;
HPFP.beta_perstage = beta ;
HPFP.power_required = P_req*10^(-6) ;

end
