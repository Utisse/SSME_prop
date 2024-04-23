function [P_out, T_out] = TurboPumpOperation( eta_pump, beta_pump, P_in, T_in, gamma,t_out)
    
    if(nargin >= 5)
        % Calcolo della pressione in uscita
        P_out = P_in * beta_pump; % Pressione in uscita [Pa]
    
        % Calcolo della temperatura in uscita considerando l'efficienza
        T_out_id= T_in*beta_pump^((gamma-1)/(gamma));% Temperatura in uscita ideale [K]
        T_out = (T_out_id - T_in) / eta_pump ; % considero l'efficienza della turbopompa
    end
    if(nargin == 6)
        errore_perc = abs(t_out - T_out)/t_out;
        if(errore_perc < .05)
            disp('Il valore della temperatura torna');
        else 
            eta_vera = (T_out_id - T_in)/t_out;  
            stampa = ['ERRORE: eta vera = ',num2str(eta_vera)];
            disp(stampa);
        end
end