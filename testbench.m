fprintf('\n******************************************')
fprintf('\n Simulation began...\n')

%Define Global Variables
mass = 50;                   %define rocket's dry mass in lb
diameter = 5.17;            %define rocket's diameter in inch
Cd = 0.75;                   %define rocket's coefficient of drag
motorName = 'Cesaroni7388M2045.csv';

testMotor = Motor(motorName);
testRocket = ModelRocket(motorName, mass, diameter, Cd);
result = LaunchResult(testRocket);


%Testing the Motor class methods
testMotor.graph

%testing the ModelRocket


%Testing the Launch Result class
result.visualize
