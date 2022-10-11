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

        function [data] = calPoweredFly(obj)

            g       = 9.80665;
            time    = obj.motor.time;
            thrust  = obj.motor.thrust;
            mass    = obj.motor.massTime + obj.airframe.mass;


            sampleSize = size(time);
            accel       = zeros(sampleSize);
            velocity    = zeros(sampleSize);
            drag        = zeros(sampleSize);
            position    = zeros(sampleSize);

            

            for i = 2:max(size(time))
                            
                dt = time(i)-time(i-1);
                %ODE:   x'' = (F - k(x'^2))/m - g;
                k1 = (thrust(i)/mass(i)) -g +  calDrag(velocity(i-1), obj.diameter, obj.Cd, mass(i));
                k2 = (thrust(i)/mass(i)) -g +   calDrag(velocity(i-1) + k1*dt/2, obj.diameter, obj.Cd, mass(i));
                k3 = (thrust(i)/mass(i))  -g +    calDrag(velocity(i-1) + k2*dt/2, obj.diameter, obj.Cd, mass(i));
                k4 = (thrust(i)/mass(i))  -g +   calDrag(velocity(i-1), obj.diameter, obj.Cd, mass(i));
                accel(i) = (1/6)*(k1+2*k2+2*k3+k4);

                velocity(i) = velocity(i-1) + accel(i)*dt;
                %Kutta Integeration method ^^^

                drag(i)     = calDrag(velocity(i), obj.diameter, obj.Cd, mass(i));
                position(i) = position(i-1) + velocity(i)*dt;

            end

            data = [time; accel; velocity; position; drag];

        end

    end
end

