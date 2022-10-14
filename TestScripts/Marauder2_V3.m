%Clean the command window

fprintf('\n******************************************')
clear
clc
fprintf('\n Simulation began...\n')


%Define Marauder II rocket
dryMass = 47.3508847- 8.243084;  %define rocket's dry mass in lb
propellersMass = 8.243084;
diameter = 5.17;            %define rocket's diameter in inch
Cd = .4;                   %define rocket's coefficient of drag
motorName = 'Cesaroni_7388M2045-P.csv';

motor = Motor(motorName, propellersMass);
airframe = Airframe(dryMass, diameter, Cd);

rocket = ModelRocket(motor, airframe);
result = LaunchResult(rocket);

clear dryMass propellersMass diameter Cd motorName

display(rocket)
result.visualize


% plot(macResult.time(1, 1:414),macResult.velocity(1,1:414), 'b',macResult.time(1, 1:414), newMethodVel, 'r')

fprintf('\n******************************************\n')
