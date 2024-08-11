% Dati di ingresso
function injectors = inj_design(mdot_LOX, mdot_f, rho_LOX, rho_f, deltaP_LOX, deltaP_f) ;

initial_area_LOX = 5e-6; % Area iniziale di un iniettore per LOX in m^2
initial_area_f = 1e-5; % Area iniziale di un iniettore per fuel in m^2

tolerance = 1e-10; % Tolleranza per la convergenza
max_iterations = 1000; % Numero massimo di iterazioni

% Inizializzazione delle aree degli iniettori
A_LOX = initial_area_LOX;
A_f = initial_area_f;

for iteration = 1:max_iterations
    % Calcolo della velocità di uscita
    velocity_LOX = sqrt(2 * deltaP_LOX / rho_LOX);
    velocity_f = sqrt(2 * deltaP_f / rho_f) ;

    % Calcolo della portata di un singolo iniettore
    mass_flow_injector_LOX = rho_LOX * A_LOX * velocity_LOX;
    mass_flow_injector_f = rho_f * A_f * velocity_f;

    % Calcolo del numero di iniettori necessari
    num_injectors_LOX = mdot_LOX / mass_flow_injector_LOX;
    num_injectors_f = mdot_f / mass_flow_injector_f;

    % Prendere il massimo tra i due numeri di iniettori
    num_injectors = ceil(max(num_injectors_LOX, num_injectors_f));

    % Calcolare le nuove aree degli iniettori
    new_area_LOX = mdot_LOX / (num_injectors * rho_LOX * velocity_LOX);
    new_area_f = mdot_f / (num_injectors * rho_f * velocity_f);

    % Controllare la convergenza
    if abs(new_area_LOX - A_LOX) < tolerance && abs(new_area_f - A_f) < tolerance
        break;
    end

    % Aggiornare le aree degli iniettori
    A_LOX = new_area_LOX;
    A_f = new_area_f;
    D_LOX = sqrt(4*A_LOX/pi) ;
    Spess_fuel = sqrt((A_f + A_LOX)/pi) - D_LOX/2 ;

    injectors.New_area_inj_fuel = A_f ;
    injectors.New_area_inj_LOX = A_LOX;
    injectors.spessore_fuel = Spess_fuel ;
    injectors.diametro_LOX = D_LOX ;
    injectors.number = num_injectors ;
    % Output del risultato
    fprintf('Iterazioni effettuate: %d\n', iteration);
end



