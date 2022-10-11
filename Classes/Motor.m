classdef Motor
    %MOTOR Summary of this class goes here
    
    properties
        %Input Data
        motorName;
        propellentMass;

        %Important Info
        thrustCurve;
        thrust;
        impulse
        massTime;
        massFlowRate;
        time;
        burnOutTime;
        totalImpulse;
        specificImpulse;
        averageThrust;
        
        %Define Global Variables
        samplingFrequency = 50;     %in Hz or num of point in a second
    end
    
    methods
        function obj = Motor(motorName, propellerMass)
            %MOTOR Construct an instance of this class
            %   provide the "motorName.csv" and the propeller mass

            obj.motorName = motorName;

            obj.thrustCurve = obj.processCSV;

            obj.propellentMass = propellerMass/2.20462; % lb to Kg

            %Properties for accessability 
            obj.thrust = obj.thrustCurve.Thrust';                %extract the Thrust array
            obj.time = seconds(obj.thrustCurve.Time)';               %extract the time array

            %Compute Motor Specs
            obj.impulse = integerateMP(obj.time, obj.thrust);
            obj.burnOutTime = max(obj.time);
            obj.totalImpulse = round(max(obj.impulse));
            obj.specificImpulse = round(obj.totalImpulse/(obj.propellentMass*2.20462));
            obj.averageThrust = obj.totalImpulse/obj.burnOutTime;
            obj.massTime = obj.burnMass;
            obj.massFlowRate = obj.calMassFlowRate;



        end

        function [timeTable] = processCSV(obj)

            structData = importdata(obj.motorName);

            table = array2table(structData.data, "VariableNames", {'Time', 'Thrust'});
            table.Time = seconds(table.Time);

            timeTable = retime(table2timetable(table),'regular', 'makima', ...
                'SampleRate', obj.samplingFrequency);

        end


        function massArray = burnMass(obj)
            %burnMass returns a row vector that represents the time
            %dependant mass of the motor as it starts to burn
            %   F = k*(dm/dt) => I = k*m => m2/m propellent = I2/Itotatl
            %   M motor = (propellent - M burnt) = propellent*(1- I/Itotal)
            
            massArray = obj.propellentMass*(1 - (obj.impulse)./(obj.totalImpulse));
            %component wise division
        end


        function massFlowRate = calMassFlowRate(obj)
            %The rate of change of the propellent mass over the burning
            %period
            massFlowRate = zeros(size(obj.massTime));
            for i = 2:max(size(obj.massTime))
                massFlowRate(i)=-(obj.massTime(i)-obj.massTime(i-1))/(obj.time(i)-obj.time(i-1));
            end
               
        end


        function [] = graph(obj)
            %graphs the thrust curve of the motor
            plot(obj.time, obj.thrust, 'r')
            title('Thrust curve for', obj.motorName)
            grid on
            xlabel('Time in seconds'); ylabel('Thrust in N');
        end


        function [] = graphMass(obj)
            %graphs the thrust curve of the motor
            plot(obj.time, obj.massTime, 'r')
            title('Propellent mass Vs Time', obj.motorName)
            grid on
            xlabel('Time in seconds'); ylabel('mass in kg');
        end


        function [] = graphMassFlowRate(obj)
            %graphs the thrust curve of the motor
            plot(obj.time, obj.massFlowRate, 'r')
            title('mass Flow Rate Vs Time', obj.motorName)
            grid on
            xlabel('Time in seconds'); ylabel('flow rate in Kg/s');
        end
    end
end

