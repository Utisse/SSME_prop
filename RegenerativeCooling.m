function RegenerativeCooling()
    % Parametri del raffreddamento rigenerativo
    mdot_coolant = 10; % Portata massica del fluido di raffreddamento [kg/s]
    Tin_coolant = 300; % Temperatura in ingresso del fluido di raffreddamento [K]
    Pin_coolant = 1e5; % Pressione in ingresso del fluido di raffreddamento [Pa]
    T_wall_init = 1500; % Temperatura iniziale della parete del nozzle [K]
    k_coolant = 0.5; % Coefficiente di conducibilità termica del fluido di raffreddamento [W/(m*K)]
    A_nozzle = 1; % Area trasversale del nozzle [m^2]
    h_conv = 100; % Coefficiente di scambio termico convettivo [W/(m^2*K)]
    dt = 0.01; % Passo di integrazione del tempo [s]
    t_final = 10; % Tempo finale della simulazione [s]
    
    % Inizializzazione delle variabili
    t = 0;
    T_wall = T_wall_init;
    T_coolant = Tin_coolant;
    P_coolant = Pin_coolant;
    Q = 0;
    
    % Simulazione del raffreddamento rigenerativo
    while t < t_final
        % Calcolo del flusso di calore assorbito dal fluido di raffreddamento
        Q = h_conv * A_nozzle * (T_wall - T_coolant);
        
        % Calcolo della variazione di temperatura del fluido di raffreddamento
        dT_coolant = Q / (mdot_coolant * k_coolant);
        T_coolant = T_coolant + dT_coolant * dt;
        
        % Calcolo della variazione di temperatura della parete del nozzle
        dT_wall = -Q / (A_nozzle * k_coolant);
        T_wall = T_wall + dT_wall * dt;
        
        % Aggiornamento della pressione del fluido di raffreddamento (ipotizzando un fluido incomprimibile)
        dP_coolant = -mdot_coolant * h_conv * (T_wall - T_coolant) / P_coolant;
        P_coolant = P_coolant + dP_coolant * dt;
        
        % Aggiornamento del tempo
        t = t + dt;
        
        % Visualizzazione dei risultati
        disp(['Tempo: ' num2str(t) ' s, Temperatura del fluido di raffreddamento: ' num2str(T_coolant) ' K, Pressione del fluido di raffreddamento: ' num2str(P_coolant) ' Pa']);
    end
end
