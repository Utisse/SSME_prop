clc;
close all;
clear all;

% prova codice pompe idrogeno
% DATI INIZIALI
% presi da NIST chemical 
% dati termodinamici idrogeno a 20.27 K e 0.2 Mpa -> fase liquida
rho = 71.997 ; %[kg/m^3] -> densità
cp = 9.3707e3; %[kJ/kgK] -> calore specifico a p costante
cv = 5.6602e3;  %[kJ/kgK] -> calore specifico a v costante
gamma = cp/cv; %[-] -> coefficiente di compressione/espansione adiabatica-> rapproto tra calori specifici
% h = 0.028601 ; %[kJ/kg] -> entalpia specifica
% s = -0.07183 ; %[kJ/kgK] -> entropia specifica
% v = 0.01406 ; %[m^3/kg] -> volume specifico
p_vap = 9e4 ; %[Pa] -> pressione di vapore

%% 0 -> 1 : LOW PRESSURE FUEL TURBOPUMP (PUMP)
% adattato con <vs  = 4.46
T0 = 20.27 ; %[K] -> temperatura in ingresso nella prima pompa
p0 = 2e5 ; %[Pa] -> pressione in ingresso alla prima pompa
mdot = 70.4; %[kg/s] -> portata di fuel in ingresso al motore -> costante fino alla fuel main valve
p1 = 1.968e6 ; %[Pa] -> pressione in uscita dalla LPFTP (P)

eff = 0.84; %[-] -> efficienza della pompa presa da grafico dell'Humble

tp_design1 = Turbopump_Desing (p0, p1, T0, mdot, rho, p_vap, eff, cp, 'LH2' , 'no_booster')


%% 1 -> 2 : HPFTP (P)
%dati termodinamici di LH2 a 23.19 K e 1.72 MPa -> durante il pompaggio il
%fluido diventa supercritico, da vedere come gestire i dati.
T1 = 23.19 ;
p1 =1723690 ;
p2 = 41023822;
mdot = 70.4;
rho = 69.8;
cp = 10.587e3;
cv = 5.8592e3;
gamma = cp/cv; 
eff = 0.75 ;
pvap = 9e4; % da ricontrollare

tp_design2 = Turbopump_Desing (p1, p2, T1, mdot, rho, pvap, eff, cp, 'LH2', 'booster') 

%TUTTO TROPPO ALTO
% potenza troppo alta è il doppio
% velocità troppo alta
% numero stadi ok
% temp alta di 40 K -> dipende da potenza
