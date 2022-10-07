function f = calDrag(velocity, diameter, Cd)
%Calculates the drag acceleration exerted on circular cross-sectional area for a given
%diameter and velocity
%   velocity is the first term (m/s). Diamter is the second term (in m) and
%   mass in kg. the output is acceleration (in m/s) and is negated to
%   account for direction.

A = pi*((diameter/2)^2);
r = 1.225;
speedOfSound = 331;
%%%
if velocity==0 
    f=0;

else  %drag in high speed

    f = -0.5*(velocity/abs(velocity))*Cd*r*A*( velocity^2 );

end


end
