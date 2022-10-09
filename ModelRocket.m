classdef ModelRocket
    %SIMPLEROCKET Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        %input data
        motor               %instantiated motor object
        airframe            %instantiated airframe object


        %extracted data
        motorName           % "motorName.csv" 
        liftOffMass             %mass in lb
        diameter            %diameter in inches
        Cd                  %Coefficient Of Drag: a ratio

        % simulation parameters
        samplingFrequency = 60
    end
    
    methods
        function obj = ModelRocket(motorObject, airframeObject)
            %MODELROCKET Construct an instance of this class

            %copying child objects
            obj.airframe = airframeObject;      % from Airframe.m class
            obj.motor = motorObject;            % from Motor.m Class

            obj.motorName = motorObject.motorName;
            obj.liftOffMass = airframeObject.mass + motorObject.propellentMass;
            obj.diameter = airframeObject.diameter;
            obj.Cd = airframeObject.Cd;

        end
        
        function [flightProfile] = launch(obj)
            %Performs simulation from burn out to coasting

            burnOutData = obj.calPoweredFly;
            coastingData = obj.calCoasting(burnOutData);
            flightProfile = [burnOutData, coastingData]; 
            
        end

        function [coastingData] = calCoasting(obj, burnOutData)

            coastingData = calCoasting(burnOutData, ...
                obj.airframe, ...
                obj.samplingFrequency);

        end

        function [burnOutData] = calPoweredFly(obj)

            burnOutData = calBurnOut(obj.motor,...
                obj.airframe);

        end

    end
end

