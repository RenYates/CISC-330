% CISC 330 Assignment 4
% Lauren Yates 10195969
% Compute_Beam_Safety

% This function takes the beam radius and location, the center point of the
% helmet, the OAR radius and center, and the radiuses of the head (x, y and
% z axis). The function then calculates the safety of the beam by
% calculating the direction vector of the beam, and then the distance of
% the beam to the center of the OAR sphere. If the distance is less than or
% equal to the radius of OAR + beam radius then the beam is unsafe,
% otherwise it is safe.

% INPUT
% beam_rad: the radius of the beam
% beam_lon: the longitude of the current beam
% beam_lat: the latitude of the current beam
% iso_cent: the center point of the helmet where all beams intersect
% oar_rad:  the radius of the OAR sphere
% oar_cent: the center of the OAR sphere
% head_a:   the radius of the head along the x axis
% head_b:   the radius of the head along the y axis
% head_c:   the radius of the head along the z axis

function unsafe = Compute_Beam_Safety(beam_radius,beam_lon,beam_lat,iso_cent,oar_rad,oar_cent,head_a,head_b,head_c)

% calculate the distance of the sphere to the line using the center point
% of the sphere
% the distance from the center point of the sphere and the beam cannot be
% less than the radius of the sphere + the beam radius

% calculate the unit direction vector of the beam
unit_direction = Compute_Beam_Direction_Vector(beam_lon,beam_lat,iso_cent,head_a,head_b,head_c);

% find another point on the beam using the direction vector and a known
% point on the line
pointB = iso_cent + unit_direction;

% calculate the distance of the center of the OAR center and the beam
dist = DistanceofLineandPoint(iso_cent,pointB,oar_cent);

% if the distance is less than the sum of the two radiuses then the OAR is
% being hit (either by the center of the beam or the radius of the beam)
if dist <= (beam_radius+oar_rad)
    unsafe = 0;
else
    unsafe = 1;
end

end