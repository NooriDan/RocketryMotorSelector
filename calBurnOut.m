function [burnOutData] = calBurnOut(motor, airframe)
%UNTITLED3 Summary of this function goes here
%   needs motorData, mass, diameter, Cd

%defining input data
t = motor.time;
thrust = motor.thrust;
mass = motor.massTime + airframe.mass;

diameter = airframe.diameter;
Cd = airframe.Cd;

%finding critical constants
sampleSize = size(t); 
g = 9.80665;



%initializing the variables
aBurn = zeros(sampleSize);
vBurn = zeros(sampleSize);
dragBurn = zeros(sampleSize);
xBurn = zeros(sampleSize);


%doing the math for the duration of burnout
for i = 2:max(sampleSize)
    dt = t(i)-t(i-1);
    aBurn(i) = (thrust(i)/mass(i)) - g + dragBurn(i-1);
    vBurn(i) = vBurn(i-1) + mean(aBurn(i-1), aBurn(i))*dt;
    dragBurn(i) = calDrag(vBurn(i), diameter, Cd, mass(i));
    xBurn(i) = mean(vBurn(i), vBurn(i-1))*dt + xBurn(i-1);
end

burnOutData = [t; aBurn; vBurn; xBurn; dragBurn];
