Project: RocketryMotorSelector
##Project Description

An Object-Oriented program that performs numerical calculation on motor data and rocket specifications to simulate the launch trajectory. The input thrust curve is a .csv file obtained from a static fire test, which is processed to a set sampling frequency using MATLAB built-in interpolation, data filtering and smoothing Tool.

Numerical method...
- Uses Runge-Kutta integration to reduce error
- Based on a simple differential equation of the motion (thrust, gravity, and drag)
- The results are being tested with OpenRocket results (an opensource rocket simulation app)

Advantages...
- Fast testing mode: Finding the right mass, dimensions and motor for a rocket design in the preliminary system definition requires rough calculations that can be done rapidly with this program. Quick optimization of these three parameters is also a feature of this program.
- Learning potentials: familiarizes the team members with the underlying science behind the simulation apps that are used commonly in the industry.
- Research : We have better control on dealing with the complex aerodynamics of the rocket at different Mach number
- Customizable: Could be integrated into our next custom hybrid motor test to simulate the performance of that motor on different rockets' airframe.
