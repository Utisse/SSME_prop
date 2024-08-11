clc;
close all;
clear;
%ugello per LH2
Dc = 0.45;     % Diametro della camera di combustione (m)
Dg = 0.249;     % Diametro della gola (m)
De = 2.07;     % Diametro di uscita (m)
Lc = 0.37;     % Lunghezza del tratto convergente (m)
Ld = 4.28;     % Lunghezza del tratto divergente (m)
alpha_conv = 15;  % Angolo del tratto convergente (gradi)
alpha_div = 19;   % Angolo del tratto divergente (gradi)
bell_factor = 0.75; % Fattore di dimensionamento per l'ugello a campana

fv1 = plot_nozzle_profile(Dc, Dg, De, Lc, Ld, alpha_conv, alpha_div, bell_factor)


%% ugello per CH4
Dc = 0.45;     % Diametro della camera di combustione (m)
Dg = 0.228;     % Diametro della gola (m)
De = 1.89;     % Diametro di uscita (m)
Lc = 0.3116;     % Lunghezza del tratto convergente (m)
Ld = 4.13;     % Lunghezza del tratto divergente (m)
alpha_conv = 19.66;  % Angolo del tratto convergente (gradi)
alpha_div = 19.54;   % Angolo del tratto divergente (gradi)
bell_factor = 0.75; % Fattore di dimensionamento per l'ugello a campana

fv2 = plot_nozzle_profile(Dc, Dg, De, Lc, Ld, alpha_conv, alpha_div, bell_factor)

%%
figure;
hold on;
patch(fv1, 'FaceColor', 'red', 'EdgeColor', 'none', 'FaceAlpha', 0.2); % Modello 1
patch(fv2, 'FaceColor', 'yellow', 'EdgeColor', 'none', 'FaceAlpha', 0.7);  % Modello 2
axis equal;
xlabel('Lunghezza (m)');
ylabel('Raggio (m)');
zlabel('Raggio (m)');
title('Confronto tra due modelli 3D di ugelli convergente-divergente');
view([90, 90, 45]);
grid on;
legend({'Modello 1', 'Modello 2'});

