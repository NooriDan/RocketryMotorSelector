function [apogeeData,flightPath] = simulateMotor(motorData, mass, diameter, Cd, frequency)
%SimulatorMotor outputs infromation on apogee and burnout for a given
%motor,mass and diameter

%function implementation
burnOutData = calBurnOut(motorData, mass, diameter, Cd);
courseData = calCoasting(burnOutData, mass, diameter, Cd, frequency);

%plotting info
flightPath = [burnOutData courseData];
tPoints = flightPath(1, :);
aPoints = flightPath(2, :);
vPoints = flightPath(3, :);
xPoints = flightPath(4, :); 


%The distance traveled after burnout (coursing)
apogee = max(xPoints);
apogeeTime = tPoints(xPoints == apogee);

maxVelocity = max(vPoints);
maxVelocityTime = tPoints(vPoints == maxVelocity);

maxAcceleration = max(aPoints);
maxAccelerationTime = tPoints(aPoints == maxAcceleration);

%compiling all important info
apogeeData = [[apogeeTime, apogee]; [maxVelocityTime, maxVelocity]; [maxAccelerationTime, maxAcceleration]];


end