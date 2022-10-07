function [burnOutData] = calBurnOut(motorData, mass, diameter, Cd)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
t = motorData(1, :); %extracting data
thrust = motorData(2, :);

sampleSize = max(size(t)); %finding critical constants
g = 9.80665;



%initializing the variables
aBurn = zeros(1, sampleSize);
vBurn = zeros(1, sampleSize);
dragBurn = zeros(1, sampleSize);
xBurn = zeros(1, sampleSize);

for i = 2:(sampleSize) %doing the math for the duration of burnout
    dt = t(i)-t(i-1);
    aBurn(i) = (thrust(i) + dragBurn(i-1) - mass*g)/mass;
    vBurn(i) = vBurn(i-1) + mean(aBurn(i-1), aBurn(i))*dt;
    dragBurn(i) = calDrag(vBurn(i), diameter, Cd);
    xBurn(i) = mean(vBurn(i), vBurn(i-1))*dt + xBurn(i-1);
    %display([dragBurn(i), dragBurn(i+1); aBurn(i), aBurn(i+1); vBurn(i), vBurn(i+1)])
end

burnOutData = [t; aBurn; vBurn; xBurn; dragBurn];
