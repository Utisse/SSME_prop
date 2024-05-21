classdef Tank
    %Tank Classe che riassume i dettagli del tank
    %   Detailed explanation goes here

    properties
        V_tank;
        T_tank;
        V_press;
        P_tank;

    end

    methods
        function obj = Tank(TankVolume,Pressurizer_Volume,Tank_Temperature, ...
                Tank_Pressure)
        %UNTITLED Construct an instance of this class
        %   Detailed explanation goes here
        obj.V_tank = TankVolume;
        obj.V_press =Pressurizer_Volume;
        obj.T_tank = Tank_Temperature;
        obj.P_tank = Tank_Pressure;
        end
    end
end