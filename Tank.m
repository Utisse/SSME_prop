classdef Tank
    properties
        Volume
        PressVolume
        Temp
        Pressure
        TotMass
    end
    
    methods
        function obj = Tank(volume, pressVolume, temp, pressure, totMass)
            obj.Volume = volume;
            obj.PressVolume = pressVolume;
            obj.Temp = temp;
            obj.Pressure = pressure;
            obj.TotMass = totMass;
        end
        
        function obj = update(obj, volume, pressVolume, temp, pressure, totMass)
            obj.Volume = volume;
            obj.PressVolume = pressVolume;
            obj.Temp = temp;
            obj.Pressure = pressure;
            obj.TotMass = totMass;
        end
    end
end