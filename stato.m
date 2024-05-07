classdef stato
    % classe per raggruppare tutte le caratteristiche del fluido che stiamo valutando
    %   
    
    properties
        T;
        P;
        Q;
        p_vap
        rho ;
        cv ;
        cp ;
    end
    
    methods
        function obj = stato(temperatura,pressione,portata, pressione_di_vapore, densita, cv, cp)
            %STATO Construct an instance of this class
            % definizione delle caratteristiche del fluido
            obj.T = temperatura;
            obj.P = pressione;
            obj.Q = portata;
            obj.p_vap = pressione_di_vapore ;
            obj.rho = densita;
            obj.cv = cv ;
            obj.cp = cp ;
          
        end
    end
end

