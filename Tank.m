classdef Tank
    %TANK Classe che riassume i dettagli del tank

    properties
        V_tank;
        T_tank;
        V_press;
        P_tank;

    end

    methods
        function obj = Tank(tankVolume,Pressurizer_Volume,tank_Temperature, tank_Pressure)
        %UNTITLED Construct an instance of this class
        %   Detailed explanation goes here
        obj.V_tank = tankVolume;
        obj.V_press =Pressurizer_Volume;
        obj.T_tank = tank_Temperature;
        obj.P_tank = tank_Pressure;
        end
    end
end
