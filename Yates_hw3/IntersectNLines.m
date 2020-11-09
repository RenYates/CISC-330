% CISC 330 Assignment 1 pt. 3
% Intersection of N Lines
% Lauren Yates 10195969

% This function takes a number of lines (numLines) and a matrix of those
% lines (lnMatrix) and calculates the symbolic intersection point of the
% lines, the average distance from those lines to the intersection point 
% (dist), and the error of the distances (stdev)

% INPUT
% numLines - the number of lines being inputted
% lnMatrix - a matrix of the lines, each line being defined by two points
%            on the line

% OUTPUT
% pt - the intersection point of the lines
% dist - the average distance between the intersection point and the lines
% stdev - the standard deviation (error metric) for the distance from the
%         intersection point to the lines

function [pt, dist, stdev] = IntersectNLines(numLines, lnMatrix)

midPoints = []; % create an empty matrix to hold the mid points
pointIndex = 1; % use index to add poin
len = length(lnMatrix);
% use two for loops to get every combination of lines to calculate all
% intersections
for ln1 = 1:2:len-1
    for ln2 = (ln1+2):2:len
        [midPt, ~] = IntersectofTwoLines(lnMatrix(:,ln1),lnMatrix(:,(ln1+1)),lnMatrix(:,ln2),lnMatrix(:,(ln2+1)));
        if isempty(midPt) % if the lines are parallel do not include it in the matrix
        else
            midPoints(:,pointIndex) = midPt; % add the midpoint to the matrix
            pointIndex = pointIndex + 1; % increase index to add next point
        end
    end
end
% if all the lines are parallel to each other return an empty matrix and
% NaN for distance and stdev
if isempty(midPoints)
    pt = [];
    dist = NaN;
    stdev = NaN;
else
    pt = mean(midPoints,2); % find the average of the midpoints for the intersection
    distance = [];
    index = 1;
    for ln = 1:2:len
        % use created function DistanceofLineandPoint to calculate the
        % distances from the intersection to all lines
        d = DistanceofLineandPoint(lnMatrix(:,ln),lnMatrix(:,ln+1),pt);
        distance(:,index) = d;
        index = index + 1;
    end
pt = round(pt,10);
dist = round(mean(distance),10); % average the distances
stdev = round(std(distance),10); % take the std of the differences for error
end
end
