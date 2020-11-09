% CISC 330 Assignment 4
% Lauren Yates 10195969
% Compute_Beam_Direction_Vector

% This function takes a longitude and latitude (in degrees), and the radius
% of an ellipsoid (x, y, and z radiuses) and calculates the direction
% vector of the beam in cartesian coordinates. The function converts the
% latitude and longitude values into cartesian coordinates using the
% radiuses of the head, and then calculates the direction vector using the
% iso center point (the point where all beams from the helmet intersect)
% and the longitude and latitude point in cartesian coordinates. The
% function then unitizes the direction vector calculated.

% INPUT
% beam_lon: the longitude location of the beam (in degrees)
% beam_lat: the latitude location of the beam (in degrees)
% iso_cent: the center point of the helmet where all the beams intersect
%           (3x1 matrix)
% head_a: the radius of the head on the x axis
% head_b: the radius of the head on the y axis
% head_c: the radius of the head on the z axis

% OUTPUT
% beam_direction_vector: the direction vector of the beam from the surface
% of the head to the iso center point

function beam_direction_vector = Compute_Beam_Direction_Vector(beam_lon,beam_lat,iso_cent,head_a,head_b,head_c)

% convert the longitude and latitude into cartesian coordinates
% This formula was taken from calculating the parametric equation of an
% ellipsoid
% http://mathworld.wolfram.com/Ellipsoid.html
x = head_a * cosd(beam_lat) * cosd(beam_lon);

y = head_b * cosd(beam_lat) * sind(beam_lon);

z = head_c * sind(beam_lat);

helmet_point = [x;y;z];

% calculate the direction vector from the helmet to the center of the
% helmet (ptv_cent)

direction = iso_cent - helmet_point;

% unitize the direction vector
beam_direction_vector = direction/norm(direction);

end