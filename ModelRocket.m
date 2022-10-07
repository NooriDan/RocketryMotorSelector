classdef ModelRocket
    %SIMPLEROCKET Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        %input data
        motorName           %A string of a *.csv file of the thrust curve
        motor               %Automatically instantiated motor object
        mass                %mass in lb
        diameter            %diameter in inches
        Cd                  %Coefficient Of Drag: a ration

        % simulation parameters
        samplingFrequency = 100
    end
    
    methods
        function obj = ModelRocket(motorName, mass, diameter, coefficientOfDrag)
            %SIMPLEROCKET Construct an instance of this class
            obj.motorName = motorName;
            obj.motor = Motor(obj.motorName);   %motor object from motor Class
            obj.mass = (mass/2.20462);           %conversion to kg
            obj.diameter = diameter*2.54/100;   %conversion to m
            obj.Cd = coefficientOfDrag;
        end
        
        function [flightProfile] = launch(obj)
            %Performs simulation from burn out to coasting

            burnOutData = obj.calBurnOut();
            coastingData = obj.calCoasting(burnOutData);
            flightProfile = [burnOutData, coastingData];

        end

        function [coastingData] = calCoasting(obj, burnOutData)

            coastingData = calCoasting(burnOutData, ...
                obj.mass, obj.diameter, obj.Cd, ...
                obj.samplingFrequency);

        end

        function [burnOutData] = calBurnOut(obj)

            burnOutData = calBurnOut(obj.motor.thrustCurve,...
                obj.mass, obj.diameter, obj.Cd);

        end

    end
end

