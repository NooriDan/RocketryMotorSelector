function [coursingData] = calCoasting(burnOutData, airframe, frequency)
%calculates the data that'll represent the rocket coursing after the burout
%period

%extrct the data computed for the period of the motor burning
tBurn = burnOutData(1, end);
vBurn = burnOutData(3, end);
xBurn = burnOutData(4, end);

%
mass=       airframe.mass;
diameter =  airframe.diameter;
Cd =        airframe.Cd;

%define constants for the calculation
g = 9.80665;
extensionFactor = 10;                               % in percentage
sampleDuration = (vBurn/g)*(1+extensionFactor/100); % the end of calculation point is 110% after where
timeIncrement = 1/frequency;                        %changes the number of computed points during coursing stage

numPoints = floor(sampleDuration/timeIncrement);



tCourse = zeros(1, numPoints);
dCourse = zeros(1, numPoints);
aCourse = zeros(1, numPoints);
vCourse = zeros(1, numPoints);
xCourse = zeros(1, numPoints);

%setting the starting values
tCourse(1) = tBurn + timeIncrement;
dCourse(1) = calDrag(vBurn, diameter, Cd, mass);
aCourse(1) = -g + dCourse(1);
vCourse(1) = vBurn + aCourse(1) * timeIncrement;
xCourse(1) = xBurn + vBurn * timeIncrement + 0.5 * aCourse(1) * (timeIncrement^2);


for j = 2: numPoints
    tCourse(j) = tCourse(j-1) + timeIncrement;
    dCourse(j) = calDrag(vCourse(j-1), diameter, Cd, mass);
    aCourse(j) = -g + dCourse(j);
    vCourse(j) = vCourse(j-1) + mean(aCourse(j-1), aCourse(j)) * timeIncrement;
    xCourse(j) = xCourse(j-1) + mean(vCourse(j-1), vCourse(j)) * timeIncrement;
end

%output argument
coursingData = [tCourse; aCourse; vCourse; xCourse; dCourse];
