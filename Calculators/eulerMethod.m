function [x] = eulerMethod(t, func_x_t, x0)
%EULERMETHOD Summary of this function goes here
%   Detailed explanation goes here
sampleSize = size(t);

x = x0*ones(sampleSize);
for i = 2:max(sampleSize)
    dt = t(i)-t(i-1);
    x(i) = x(i-1) + dt*func_x_t(x(i-1), t(i-1));
end

