% CISC 330 Assignment 4
% Lauren Yates 10195969
% Compute_Point_Dose_From_Beam

% This function takes the head data (radiuses and center point), helmet
% data (beam radius, beam latitude, beam longitude, the center of the
% helmet), and the point of interest. This function then calculates the
% dosage at the point of interest from the specified beam using the depth
% dosage table and the radial dosage table and the calculated depths and
% distance from the beam to find the dosages of each. The function then
% multiplies the dosages together to find the overall dosage at the point
% from the beam.

% INPUT
% head_a:    the radius of the head along the x axis
% head_b:    the radius of the head along the y axis
% head_c:    the radius of the head along the z axis
% head_cent: the center point of the head
% beam_rad:  the radius of the beam
% beam_lon:  the longitude of the current beam
% beam_lat:  the latitude of the current beam
% iso_cent:  the center point of the helmet where all beams intersect
% poi:       the point in the head where the dosage is being calculated

% OUTPUT
% point_dose_value: the dosage value from the specified beam at the point
%                   of interest

function point_dose_value = Compute_Point_Dose_From_Beam(head_a,head_b,head_c,head_cent,beam_rad,beam_lon,beam_lat,iso_cent,poi)

% calculate the direction vector of the beam
direction_vec = Compute_Beam_Direction_Vector(beam_lon,beam_lat,iso_cent,head_a,head_b,head_c);

% calculate the skin entry point of the beam
skin_entry_pt = Compute_Skin_Entry_Point(head_a,head_b,head_c,head_cent,beam_lon,beam_lat,iso_cent);

% calculate the depth of the point from the beam (distance from the
% skin_entry_pt and the poi)
% depth is in mm, convert to cm for table
depth_x = DistTwoPoints3D(poi,skin_entry_pt);
depth_x = round((depth_x/10),1);

% build the dose table using the depth_x value as the max value
% table is in cm
depth_dose_LUT = Compute_Depth_Dose(depth_x,0,0.1);
n1 = size(depth_dose_LUT,2);

% x for radial dose is the distance of the point and the beam
% calculate second point on beam using direction vector and use to form
% line to calculate distance
iso_2 = iso_cent + direction_vec;
radial_x = round(DistanceofLineandPoint(iso_cent,iso_2,poi),1);

% build the dose table using the radial_x value as the max value
radial_dose_LUT = Compute_Radial_Dose(radial_x,beam_rad,0.1);
n2 = size(radial_dose_LUT,2);

% depth and radial doses are the last values in the tables (the x values
% are the max)
depth_y = depth_dose_LUT(2,n1);
radial_y = radial_dose_LUT(2,n2);

% the point_dose_value is the depth dose * the radius dose
point_dose_value = depth_y * radial_y;

end