function [xEdited, yEdited, biggestGap] = addPoint(x,y, floorGap)
%addPoint adds one point between each pair of sample data. the value of th
%eadded point is the mean of the two parent point
%   returns the new set of points and declares the biggest gap between x
%   values. it won't add points if the gap is less than the floorGap value
%   inputed by the user

sampleSize = size(x,2);
biggestGap = -inf;
xEdited = [];
yEdited = [];

for i = 2:sampleSize
    gap = abs( x(i) - x(i-1) );
    xEdited = [xEdited, x(i-1)];
    yEdited = [yEdited, y(i-1)];
    if gap > floorGap
        xEdited = [xEdited, mean( x(i-1), x(i) )];
        yEdited = [yEdited, mean( y(i-1), y(i) )];

    end
    
    if i == sampleSize
        xEdited = [xEdited, x(i)];
        yEdited = [yEdited, y(i)];
    end
    

    if gap > biggestGap
            biggestGap = gap/2;
    end
end




