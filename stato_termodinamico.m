classdef stato_termodinamico
    %STATO_TERMODINAMICO Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        T;
        P;
        Q;
    end
    
    methods
        function obj = stato_termodinamico(temperatura,pressione,portata)
            %SOSTANZA_CHIMICA Construct an instance of this class
            %   Detailed explanation goes here
            obj.T = temperatura;
            obj.P = pressione;
            obj.Q = portata;
        end
    end
end

