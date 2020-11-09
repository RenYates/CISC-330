% CISC 330 Assignment 4
% Intersection of Line and Ellipsoid
% Lauren Yates 10195969

% This function takes a line (inputted as two points) and an ellipsoid
% (inputted as the center point and three principal axes) and finds the
% number and locations of the intersections for the line and the ellipsoid

% INPUT
% pt1 - first point on the line
% pt2 - second point on the line
% center - the center point of the ellipsoid
% a - ellipsoid principal axis value for the x axis
% b - ellipsoid principal axis value for the y axis
% c - ellipsoid principal axis value for the z axis

% OUTPUT
% numIntersect - the number of intersections between the line and ellipsoid
%              (either 0, 1, or 2)
% intersect1 - the first intersect of the line and ellipsoid (if there is
%              no intersection, returns an empty matrix)
% intersect2 - the second intersect of the line and ellipsoid (if there is
%              no intersection, returns an empty matrix)

function [numIntersect, intersect1, intersect2] = IntersectLineandEllipsoid(pt1,pt2,center,a,b,c)

% create a vector for the line
v = pt2-pt1;
v = v/norm(v);
vx = v(1);
vy = v(2);
vz = v(3);

% let Q be a vector from the center to a point on the line (eg. pt1)
Dx = pt1(1) - center(1);
Dy = pt1(2) - center(2);
Dz = pt1(3) - center(3);

% Calculate A, B and C for the quadratic formula (see on paper for
% derivation)
A = ((vx^2)/(a^2)) + ((vy^2)/(b^2)) + ((vz^2)/(c^2));
B = 2*( ((Dx*vx)/(a^2)) + ((Dy*vy)/(b^2)) + ((Dz*vz)/(c^2)) );
C = (((Dx^2)/(a^2)) + ((Dy^2)/(b^2)) + ((Dz^2)/(c^2)))-1;

% calculate the determinant (B^2 - 4AC) to see how many intersections there
% are
deter = (B^2) - 4*(A*C);

% the following two lines of code are from an answer by Roger Stafford 
% on MathWorks
% https://www.mathworks.com/matlabcentral/answers/87495-real-roots-of-a-polynomial
r = roots([A B C]); % Get all the roots
r = r(imag(r)==0); % Save only the real roots

% if the determinant is zero, there is one intersection
if deter == 0
    numIntersect = 1;
    intersect1 = pt1 + r(1,:)*v;
    intersect2 = [];

% if the determinant is greater than zero there are two intersections
elseif deter > 0
    numIntersect = 2;
    intersect1 = pt1 + r(1,:)*v;
    intersect2 = pt1 + r(2,:)*v;

% if the determinant is less than zero then there are no intersections
else
    numIntersect = 0;
    intersect1 = [];
    intersect2 = [];  
end

end