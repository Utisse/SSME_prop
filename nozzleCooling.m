clear;clc; close all;

Cp = 3560;
mu = 1.11e-4;
n = 0.3; % poichè sto raffreddando
k_ch4 = 0.34; 
Dh = 0.02;
m_dot = 123;
Pr = Cp *mu / k_ch4;
Re = m_dot * Dh /(mu * pi * Dh^2 /4);
Nu = 0.023 * Re ^ (0.8) * Pr ^(n);
h_fluido = k_ch4/Dh *Nu;
spessore_parete = .014;
k_parete = 0.8200;
h_gc = 1000;
T_fluido =111;
T_gola = 3500;
q = (T_gola - T_fluido)/(1/h_fluido+ 1/h_gc + spessore_parete/k_parete)