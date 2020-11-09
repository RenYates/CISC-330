% CISC 330 Assignment 4
% Lauren Yates 10195969
% Compute_Skin_Entry_Point

% This function takes the radiuses and center of the ellipsoidal head, the
% location of the beam in longitude and latitude coordinates, and the
% center point of the helmet and computes the skin entry point of the beam
% on the surface of the head.

% INPUT
% head_a: the radius of the head on the x-axis (single value)
% head_b: the radius of the head on the y-axis (single value)
% head_c: the radius of the head on the z-axis (single value)
% head_cent: the center point of the head (3x1 matrix)
% beam_lon: the location of the beam's longitude (degrees)
% beam_lat: the location of the beam's latitude (degrees)
% iso_cent: the center point of the helmet (where the beams all intersect)

% OUTPUT
% skin_entry_point: the entry point of the beam on the surface of the head
%                   in cartesian coordinates

function skin_entry_point = Compute_Skin_Entry_Point(head_a,head_b,head_c,head_cent,beam_lon,beam_lat,iso_cent)

% calculate the direction vector of the line using the longitude and
% latitude
vector_of_beam = Compute_Beam_Direction_Vector(beam_lon,beam_lat,iso_cent,head_a,head_b,head_c);

% calculate another point on the line using the direction vector and the
% center point
pointB = iso_cent + vector_of_beam;

% the skin entry point is the first intersection point of the head and the
% beam (first intersection point would be out the other side of the head)
[~,intersect1,intersect2] = IntersectLineandEllipsoid(iso_cent,pointB,head_cent,head_a,head_b,head_c);

% if the first intersect is in the northern hemisphere use the first
% intersect, otherwise use the second intersect
if (intersect1(3,:) > 0)
    skin_entry_point = intersect1;
else
    skin_entry_point = intersect2;
end