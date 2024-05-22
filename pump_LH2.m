clc;
close all;
clear all;

% prova codice pompe idrogeno
% DATI INIZIALI
% presi da NIST chemical 
% dati termodinamici idrogeno a 20.27 K e 0.2 Mpa -> fase liquida
rho = 71.997 ; %[kg/m^3] -> densità
cp = 9.3707; %[kJ/kgK] -> calore specifico a p costante
cv = 5.6602;  %[kJ/kgK] -> calore specifico a v costante
gamma = cp/cv; %[-] -> coefficiente di compressione/espansione adiabatica-> rapproto tra calori specifici
% h = 0.028601 ; %[kJ/kg] -> entalpia specifica
% s = -0.07183 ; %[kJ/kgK] -> entropia specifica
% v = 0.01406 ; %[m^3/kg] -> volume specifico
p_vap = 101352.9 ; %[Pa] -> pressione di vapore

%% 0 -> 1 : LOW PRESSURE FUEL TURBOPUMP (PUMP)

T0 = 20.27  ; %[K] -> temperatura in ingresso nella prima pompa
p0 = 2e5 ; %[Pa] -> pressione in ingresso alla prima pompa
mdot = 70.4; %[kg/s] -> portata di fuel in ingresso al motore -> costante fino alla fuel main valve
p1 = 1.999e6 ; %[Pa] -> pressione in uscita dalla LPFTP (P)
eff = 0.75; %[-] -> efficienza della pompa -> dato approssimativo, su questo si può giorcare x iterare

tp_design1 = Turbopump_Desing (p0, p1, T0, mdot, rho, p_vap, eff, cp, 0) 

%potenza ci siamo quasi -> deve essere leggermente piu alta
%temperatura in uscita no -> troppo bassa (può dipendere dalla potenza)->
%circ 23K
%velocità rotazione shaft no -> troppo bassa (può dipendere da potenza?)

%% 1 -> 2 : HPFTP (P)
%dati termodinamici di LH2 a 23.19 K e 1.72 MPa
T1 = 23.19;
p1 = 1.72e6 ;
p2 = 4.10e7;
mdot = 70.3068;
rho = 69.597;
cp = 10.587;
cv = 5.8592;
eff = 0.75 ;
pvap = 1294 ; %da ricontrollare

tp_design2 = Turbopump_Desing (p1, p2, T1, mdot, rho, pvap, eff, cp, 0) 

% potenza troppo alta
% velocità quasi giusta
% nume stadi ok
% temp no

%% Pompe ossigeno
%

