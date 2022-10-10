function [processedMotorData] = processMotorData(motorData,smallestInterval)
%processMotorData accepts thrust curve data and a float number representing the
%smallest interval desired and then uses mean sample point generating
%method to ensure the data is stored with a constant frequency


%MotorData is a struct with an nX2 double matrix called data
%transpose the vectors to get row vectors
timeData = motorData(:, 1)';
thrustData = motorData(:,2)';

biggestGap = inf;
while biggestGap > smallestInterval*1.05 %5 percent margin
    [timeData, thrustData, biggestGap] = addPoint(timeData,thrustData, smallestInterval);

end

%outputs the processed data as an 2 row vectors ina matrix (2Xm)
processedMotorData = [timeData; thrustData];