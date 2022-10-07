fprintf('\n******************************************')
fprintf('\n Simulation began...\n')

%Define Global Variables
mass = 22;                   %define rocket's dry mass in kg
diameter = 0.131;            %define rocket's diameter in m^2
Cd = 0.75;                   %define rocket's coefficient of drag
motorName = 'Cesaroni7388M2045.csv';

testMotor = Motor(motorName);
testRocket = ModelRocket(motorName, mass, diameter, Cd);
launchResult = LaunchResult(testRocket);


%Testing Motor class methods


