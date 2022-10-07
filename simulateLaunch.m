function [flightPath,apogeeData] = simulateLaunch(rocket)


sampleMotorData = rocket.motor;
samplingFrequency = rocket.samplingFrequency;
rocketMass = rocket.mass;
diameter = rocketDiameter;
Cd = rocket.

%Performing Simulation
[apogeeData, flightPath] = simulateMotor(sampleMotorData, rocketMass, diameter, Cd, samplingFrequency);
fprintf('Motor Simulation done for:  '+ motorName + '\n')

impulse = integerateMP(sampleMotorData(:, 1)', sampleMotorData(:, 2)');
totalImpulse = round(impulse(end), -1);
fprintf('Motor Simulation done for:  '+ motorName + '\nTotal Impulse =' + string(totalImpulse)+'\n\n'); 

end

