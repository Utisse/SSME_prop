function fv = plot_nozzle_profile(Dc, Dg, De, Lc, Ld, alpha_conv, alpha_div, K)
    % Funzione per tracciare il profilo di un ugello convergente-divergente con Bell Factor

    % Convertire gli angoli in radianti
    alpha_conv = deg2rad(alpha_conv);
    alpha_div = deg2rad(alpha_div);
    
    % Applicare il Bell Factor
    Lc = Lc * K;
    Ld = Ld * K;
    
    % Calcolare i raggi
    R_c = Dc / 2;  % Raggio alla sezione della camera di combustione
    R_g = Dg / 2;  % Raggio alla sezione della gola
    R_e = De / 2;  % Raggio alla sezione di uscita
    
    % Numero di punti per il profilo
    n_points = 1000;
    
    % Generazione delle coordinate x per il tratto convergente
    x_conv = linspace(0, Lc, n_points);  % Coordinate per il tratto convergente
    
    % Calcolo dei raggi per la parte convergente
    y_conv = R_c - (R_c - R_g) * (x_conv / Lc);  % Profilo convergente
    
    % Calcolare i coefficienti della parabola divergente
    % La parabola deve aumentare il raggio da R_g a R_e
    
    % Risolvere il sistema di equazioni per ottenere a, b e c
    syms a b c;
    
    % Sistema di equazioni
    eq1 = a * R_g^2 + b * R_g + c == 0; % Condizione: x = 0 quando y = R_g
    eq2 = a * R_e^2 + b * R_e + c == Ld; % Condizione: x = Ld quando y = R_e
    % Derivata prima in R_g deve essere 1/tan(alpha_div)
    eq3 = 2*a*R_g + b == 1 / tan(alpha_div); 
    
    % Risolvere il sistema
    [sol_a, sol_b, sol_c] = solve([eq1, eq2, eq3], [a, b, c]);
    
    % Convertire in valori numerici
    a = double(sol_a);
    b = double(sol_b);
    c = double(sol_c);
    
    % Assicurarsi che la derivata seconda sia positiva (a > 0)
    if a <= 0
        error('Il coefficiente a deve essere positivo per garantire che la parabola sia convessa.');
    end
    
    % Calcolare i raggi per la parte divergente usando la parabola
    y_div = linspace(R_g, R_e, n_points);
    x_div = a * y_div.^2 + b * y_div + c;
    
    % Coordinare finali dell'ugello
    x_nozzle = [x_conv, Lc + x_div];
    y_nozzle = [y_conv, y_div];
    
    % Tracciare il profilo dell'ugello
    figure;
    hold on;
    
    % Profilo convergente
    plot(x_conv, y_conv, 'b', 'LineWidth', 2, 'DisplayName', 'Profilo Convergente');
    plot(x_conv, -y_conv, 'b', 'LineWidth', 2);
    
    % Profilo divergente
    plot(x_div + Lc, y_div, 'r', 'LineWidth', 2, 'DisplayName', 'Profilo Divergente');
    plot(x_div + Lc, -y_div, 'r', 'LineWidth', 2);
    
    % Riempire l'area sotto il profilo
    fill([x_nozzle, fliplr(x_nozzle)], [y_nozzle, fliplr(-y_nozzle)], 'y', 'FaceAlpha', 0.3);
    
    % Etichettare il grafico
    xlabel('Lunghezza (m)');
    ylabel('Raggio (m)');
    title('Profilo dell''ugello convergente-divergente con Bell Factor');
    grid on;
    axis equal;
    legend show;  % Mostra la legenda per i diversi profili

    % Creare mesh cilindrica ruotando il profilo attorno all'asse x
    theta = linspace(0, 2*pi, n_points);
    [X, Theta] = meshgrid(x_nozzle, theta);
    Y = repmat(y_nozzle, n_points, 1) .* cos(Theta);
    Z = repmat(y_nozzle, n_points, 1) .* sin(Theta);
    
    % Creare la superficie STL
    fv = surf2patch(X, Y, Z, 'triangles');
    % filename = 'nozzle' ;
    % % Salvare il file STL
    % stlwrite(filename, fv);
    
    % Visualizzare il modello 3D
    figure;
    patch(fv, 'FaceColor', 'black', 'EdgeColor', 'none', 'FaceAlpha', 0.3');
    axis equal;
    xlabel('Lunghezza (m)');
    ylabel('Raggio (m)');
    zlabel('Raggio (m)');
    title('Modello 3D dell''ugello convergente-divergente');
    view(3);
    grid on;
    fv = surf2patch(X, Y, Z, 'triangles');
end












