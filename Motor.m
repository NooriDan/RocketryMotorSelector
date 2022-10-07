classdef Motor
    %MOTOR Summary of this class goes here
    
    properties
        %Input Data
        motorName;
        thrustCurve;
        %Important Info
        thrust;
        time;
        burnOutTime;
        totalImpulse;

        %Define Global Variables
        samplingFrequency = 120;     %in Hz or num of point in a second
    end
    
    methods
        function obj = Motor(motorName)
            %MOTOR Construct an instance of this class
            obj.motorName = motorName;

            obj.thrustCurve = processMotorData(importdata(motorName).data, ...
                1/obj.samplingFrequency);
            %Properties for accessability 
            obj.thrust = obj.thrustCurve(2,:);   %extract the Thrust array
            obj.time = obj.thrustCurve(1,:);     %extract the time array
            obj.burnOutTime = max(obj.time);
            obj.totalImpulse = obj.calImpulse();

        end


        function totalImpulse = calImpulse(obj)
            %calculates the total impulse generated.
            %   uses midpoint integeration method to calculate the area
            %   under the curve.
            impulse = integerateMP(obj.time, obj.thrust);
            totalImpulse = round(max(impulse), -1);
        end

        function [] = graph(obj)
            %graphs the thrust curve of the motor
            plot(obj.time, obj.thrust, 'r')
            title('Thrust curve for', obj.motorName)
            grid on
            xlabel('Time in seconds'); ylabel('Thrust in N');
        end


    end
end

