%Clean the command window

fprintf('\n******************************************')
clear
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
mass2 = 66-12;                   %define rocket's dry mass in lb
diameter2 = 6.17;            %define rocket's diameter in inch
Cd2 = .75;                   %define rocket's coefficient of drag
motorName2 = 'Cesaroni_10367N1800-P.csv';

mauraduerI = ModelRocket(motorName2, mass2, diameter2, Cd2);
macResult = LaunchResult(mauraduerI);

display(mauraduerI)
macResult.visualize
