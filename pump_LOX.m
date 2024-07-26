clc ;
close all ;
clear all ;

%LPOTP
% aggiustare Vs = 6.18, con questi dati l'efficienza dovrebbe essere 0.84
T4 = 90.37; %[K]
p4 = 6.89e5;
p5 = 2.875e6 ; 
mdot = 424.109;
rho = 1141.6;
cp = 1.6968e3;
cv = 0.92938e3; 
eff = 0.677;
gamma = cp/cv ;
pvap = 8e4;

tp_design = Turbopump_Desing (p4, p5,T4, mdot, rho, pvap, eff, cp, 'LOX', 'no_booster')

%% HPOTP
%pompa semplificata come se avesse un solo ingresso e non 2
% adattata con Vs = 4.7
T5 = 93; %[K]
p5 = 2.62e6;
p6 = 27.88e6 ; 
mdot = 508; % da capire perchè aumenta
rho = 1132.9;
cp = 1.6939e3;
cv = 0.92361e3; 
eff = 0.84;  %efficienza presa da tabella
gamma = cp/cv ;

tp_design = Turbopump_Desing (p5, p6,T5, mdot, rho, pvap, eff, cp, 'LOX', 'booster')
