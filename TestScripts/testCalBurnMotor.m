function [velocity] = testCalBurnMotor(rocketObject)
%TESTCALBURNMOTOR Summary of this function goes here
%   Detailed explanation goes here
motor = rocketObject.motor;
thrust = motor.thrust;
time = motor.time;
g= 9.81;

mass = rocketObject.airframe.mass;

k = 0.5*rocketObject.Cd*pi*(rocketObject.diameter/2)^2;

% Motion differential Equations
% m(t)*x'' = T(t) - m(t)*g - k*(x'^2)
% x'' = T(t)/m(t) - g - k*x'^2/m(t)

velocity = zeros(size(time));


end

