function [Y] = integerateMP(x0,y0)
%Integerates a set of relational data using midpoints
%   first input is th independent value and the second one is the dependant
%   variable. outputs two list. the first list is the first is inputed to
%   it. And the second list is the integral using midpoint integeration.

dimension = max(size(x0));
Y=zeros(1, dimension);
for i = 1:(dimension-1)
    dx = x0(i+1)-x0(i);
    Y(i+1)= 0.5*(y0(i)+y0(i+1))*dx +Y(i);

end