function [X] = integrateKutta(t, func_x_t, X0)
%integerateKutta inegrated using the 4th order Runge-kutta integration
%method
%   increases accurace by 4 folds compared to typical euler method
%   X is a row vector of the same size as the time (t) vector
%   func_x_t is the function on the right side of x' = f(x, t)
%   X0 is the IVP

samplesize = size(t);

X = zeros(samplesize);

X(1) = X0; %set the IVP
for i = 1:(max(samplesize)-1)
    dt = t(i+1)-t(i);
    k1 = func_x_t(X(i)          , t(i));
    k2 = func_x_t(X(i) + k1*dt/2, t(i) + dt/2);
    k3 = func_x_t(X(i) + k2*dt/2, t(i) + dt/2);
    k4 = func_x_t(X(i) + k3*dt/2, t(i) + dt/2);
    averageSlope = (1/6)*(k1+2*k2+2*k3+k4);
    X(i+1) =  X(i) + averageSlope*dt;
end

end

