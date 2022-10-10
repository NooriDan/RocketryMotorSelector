%Clean the command window

fprintf('\n******************************************')
clear
clc
fprintf('\n Simulation began...\n')


% %Define McGill Rocket
% mass1 = 50;                   %define rocket's dry mass in lb
% diameter1 = 5.17;            %define rocket's diameter in inch
% Cd1 = 0.75;                   %define rocket's coefficient of drag
% motorName1 = 'Cesaroni7388M2045.csv';
% 
% testRocket = ModelRocket(motorName1, mass1, diameter1, Cd1);
% testResult = LaunchResult(testRocket);

%Define Marauder I rocket
dryMass = 70.8- 12.625874;  %define rocket's dry mass in lb
propellersMass = 12.625874;
diameter = 6.17;            %define rocket's diameter in inch
Cd = 10;                   %define rocket's coefficient of drag
motorName = 'Cesaroni_10367N1800-P.csv';

motor = Motor(motorName, propellersMass);
airframe = Airframe(dryMass, diameter, Cd);

macRocket = ModelRocket(motor, airframe);
macResult = LaunchResult(macRocket);

clear dryMass propellersMass diameter Cd motorName

display(macRocket)
% macResult.visualize


% plot(macResult.time(1, 1:414),macResult.velocity(1,1:414), 'b',macResult.time(1, 1:414), newMethodVel, 'r')

fprintf('\n******************************************\n')
