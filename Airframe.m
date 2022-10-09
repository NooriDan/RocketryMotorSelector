classdef Airframe
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        mass
        diameter
        Cd
    end
    
    methods
        function obj = Airframe(dryMass, diameter, coefficientOfDrag)
            %UNTITLED Construct an instance of this class
            %   Detailed explanation goes here
            obj.mass = (dryMass/2.20462);            %conversion to kg
            obj.diameter = diameter*2.54/100;           %conversion to m
            obj.Cd = coefficientOfDrag;
        end
        
%         function outputArg = method1(obj,inputArg)
%             %METHOD1 Summary of this method goes here
%             %   Detailed explanation goes here
%             outputArg = obj.Property1 + inputArg;
%         end
    end
end

