fprintf('\n******************************************')
fprintf('\n Simulation began...\n')

%Define Global Variables
dryMass = 63.9341-7.8197964 ;  %define rocket's dry mass in lb
propellersMass = 7.8197964;
diameter = 6.17;            %define rocket's diameter in inch
Cd = .4;                   %define rocket's coefficient of drag
motorName = 'Cesaroni7388M2045.csv';


motor = Motor(motorName, propellersMass);
airframe = Airframe(dryMass, diameter, Cd);
testRocket = ModelRocket(motor,airframe);
result = LaunchResult(testRocket);

clear dryMass propellersMass diameter Cd motorName

%Testing the Motor class methods
% motor.graph
% 
% %testing the ModelRocket
% 
% 
% %Testing the Launch Result class
result.visualize
