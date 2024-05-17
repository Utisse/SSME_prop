% iniettori 
% DALLA CAMERA DI COMBUSTIONE AGLI INIETTORI ESISTE UNA PERDITA DI
% PRESSIONE DELTA_P GENERALMENTE TRA IL 15% E IL 25%, a seconda del tipo di iniettori usati e della camera

function inj_desing = injectors_desing (v, k, D_p,d_gc, m_flow);

v = % velocita attraverso gli iniettori;
m_flow =  % portata;
k =  % coeff perdita di carico; (1.2 o 1.7); radiused or not;
d_gc = % densità gas combusti
D_p=  % perdita di pressione;
Ainj = 17.74 % area d'ingresso imniettore singolo


N = m_flow/Ainj* sqrt(k/(2*d_gc*D_p));
