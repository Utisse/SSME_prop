% iniettori 
% DALLA CAMERA DI COMBUSTIONE AGLI INIETTORI ESISTE UNA PERDITA DI
% PRESSIONE DELTA_P GENERALMENTE TRA IL 15% E IL 25%, a seconda del tipo di iniettori usati e della camera

function inj_desing = injectors_desing (v, k, D_p_f, D_p_ox,rho_f, rho_ox, mdot_f, mdot_ox);

% v-> velocita attraverso gli iniettori;
% mdot_f;
% mdot_ox
% k-> coeff perdita di carico; (1.2 o 1.7); radiused or not;
% rho_f -> densità fuel
% rho_ox -> densita ox
% D_p -> perdita di pressione;
Ainj_f= 17.74 % area d'ingresso imniettore singolo -> anello esterno
Ainj_ox = 10 ; %area d'ingresso iniettore singolo -> cilindro interno

N_ox = mdot_pox/Ainj_ox*sqrt(k/(2*rho_ox*D_p_ox));
N_f = mdot_f/Ainj_f*sqrt(k/(2*rho_f*D_p_f)) ;

if N_ox > N_f
N = N_ox
end
if N_ox < N_f
N = N_f
end

end
