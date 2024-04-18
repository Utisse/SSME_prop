classdef stato
    %STATO Classe per raggruppare temp, press e portata
    %   
    
    properties
        T;
        P;
        Q;
    end
    
    methods
        function obj = stato(temperatura,pressione,portata)
            %STATO Construct an instance of this class
            %   Detailed explanation goes here
            obj.T = temperatura;
            obj.P = pressione;
            obj.Q = portata;
        end
    end
end

