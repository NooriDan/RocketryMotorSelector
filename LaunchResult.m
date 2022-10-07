classdef LaunchResult
    %LAUNCHRESULT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        %Result Data (1Xn row vectors)  
        time
        acceleration
        velocity
        position
        drag

        %flags: a matrix to hold maxAccel, maxVel, and apoee data
        flags
        


    end
    
    methods
        function obj = LaunchResult(testRocket)
            %LAUNCHRESULT Construct an instance of this class

            %perform the launch method on th erocket object
            flightProfile = testRocket.launch();

            %storing the data in appropriate properties
            obj.time = flightProfile(1, :);
            obj.acceleration = flightProfile(2, :);
            obj.velocity = flightProfile(3, :);
            obj.position = flightProfile(4, :);
            obj.drag= flightProfile(5, :);

            obj.flags = [obj.maxAccel(); obj.maxVel(); obj.apogee(); obj.maxDrag()];




        end
        
        function outputArg = apogee(obj)
            apogee = max(obj.position);
            apogeeTime = obj.time(obj.position == apogee);
            outputArg = [apogeeTime, round(apogee, -1)];
        end

        function outputArg = maxVel(obj)
            maxVel = max(obj.velocity);
            maxVelTime = obj.time(obj.velocity == maxVel);
            outputArg = [maxVelTime, round(maxVel)];
        end

        function outputArg = maxAccel(obj)
            maxAccel = max(obj.acceleration);
            maxAccelTime = obj.time(obj.acceleration == maxAccel);
            outputArg = [maxAccelTime, round(maxAccel)];
        end

        function outputArg = maxDrag(obj)
            maxDrag = max(obj.drag);
            maxDragTime = obj.time(obj.drag == maxDrag);
            outputArg = [maxDragTime, round(maxDrag)];
        end


    % methods for data visualization
        function [] = graphAlt(obj)
            plot(obj.time, obj.position, 'g')
            legend('Altitude','Location','NorthWest'); 
            grid on
            xlabel('Time in seconds'); ylabel('Altitude in m');
        end

        function [] = graphVel(obj)
            plot(obj.time, obj.velocity,'b')
            legend('Vertical Velocity','Location','NorthWest'); 
            grid on
            xlabel('Time in seconds'); ylabel('Velocity in m/s');
        end

        function [] = graphAccel(obj)
            plot(obj.time, obj.acceleration, 'r', ...
                obj.time, obj.drag, 'c')
            legend('Acceleration', 'drag','Location','NorthWest'); 
            grid on
            xlabel('Time in seconds'); ylabel('Acceleration in m/s^2');

        end

        function [] = graphBurnOut(obj)


        end


        function visualize(obj)
            %plot the actual values
            plot(obj.time,obj.acceleration/max(obj.acceleration),'r', ...
                obj.time,obj.velocity/max(obj.velocity),'b', ...
                obj.time,obj.position/max(obj.position),'g', ...
                obj.time,obj.drag/max(abs(obj.drag)), 'c');

            legend('acceleration', 'velocity','altitude', 'drag','Location','SouthEast');

            grid on
            xlabel('Time in seconds'); ylabel('Flight Variables');
            ylim([-1.25, 1.25]);
            apogeeTime = obj.flags(3, 1);
            maxVelTime = obj.flags(2, 1);
            maxAccelerationTime = obj.flags(1,1);

            %%marking important apogee data
            text(apogeeTime, 1, '\leftarrow Apogee point', 'FontName','times');
            text(maxVelTime, 1, '\leftarrow max Velocity point', 'FontName','times');
            text(maxAccelerationTime, 1, '\leftarrow max Acceleration Time', 'FontName','times');
            
            obj.generateReport();
            fprintf(['Data Plotted!\n' ...
                '============================\n'])
        end

        function [] = generateReport(obj)
            
            apogeeTime = obj.flags(3, 1);
            apogee =     obj.flags(3, 2);

            maxVelTime = obj.flags(2, 1);
            maxVel =     obj.flags(2, 2);

            maxAccelerationTime = obj.flags(1,1);
            maxAcceleration =     obj.flags(1,2);

            maxDragTime = obj.flags(4, 1);
            maxDrag = obj.flags(4, 2);

            fprintf(['\napogee= %d m after %d seconds;' ...
                '\nmaxVelocity = %d m/s after %d seconds;' ...
                '\nmaxAcceleration= %d m/s^2 after %d seconds' ...
                '\nmaxDrag= %d m/s^s after %d seconds\n\n'], ...
                apogee, apogeeTime, ...
                maxVel, maxVelTime, ...
                maxAcceleration, maxAccelerationTime, ...
                maxDrag, maxDragTime)
        end


        

    end 
end

