% CISC 330 Assignment 1 pt. 2
% Intersection of Two Lines
% Lauren Yates 10195969

% This function takes two points from two lines and calculates and returns
% the intersection point and the error of the intersection (the distance
% between the intersection point and the lines)

% INPUT
% v11 - point 1 from line 1
% v12 - point 2 from line 1
% v21 - point 1 from line 2
% v22 - point 2 from line 2

% OUTPUT
% pt - the intersection point of the two lines
% error - the error of the calculated intersection point (the distance 

function [pt, error] = IntersectofTwoLines(v11, v12, v21, v22)
vec1 = v11 - v12;
vec2 = v21 - v22;
unit1 = vec1/norm(vec1);
unit2 = vec2/norm(vec2);
if unit1 == unit2
    pt = [];
    error = NaN;
else
    % parametric form: Line1(t1) = v11 + unit1*t1
    % parametric form: Line2(t2) = v21 + unit2*t2
    % need to find an approximate intersection (actual intersection is highly
    % unlikely/impossible in 3D)
    % find a third line that is perpendicular to both line1 and line2 and
    % compute the midpoint of that line (M), the distance of M to each line is
    % the error metric
    % parametric form: Line3(t3) = v31 + unit3*t3
    % if the cross product of line1 and line2 = 0 then they are parallel and
    % there is no intersection
    unit3 = cross(unit1,unit2);
    % conditions of intersection:
    % v31 = Line2
    % Line3 = Line1
    % unit1 X unit2 = unit3
    % plug in these cases and use Matrix inversion to solve for [t1;t2;t3]
    t = [(-1)*unit1 unit2 unit3]^(-1) * (v11-v21);
    % calcuate line1 and line2 using the calculated t and points chosen
    line1 = v11 + t(1,1)*unit1;
    line2 = v21 + t(2,1)*unit2;
    pt = (line1 + line2)/2;
    % error metric: distance between calculated point and one of the lines
    % (same distance for either line because pt is the mid point of the
    % distance)
    error = DistanceofLineandPoint(v11,v12,pt);
end
end