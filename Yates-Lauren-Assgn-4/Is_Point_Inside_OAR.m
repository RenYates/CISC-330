% CISC 330 Assignment 4
% Lauren Yates 10195969
% Is_Point_Inside_OAR

% This function checks if the point is inside the OAR sphere using the
% center point of the OAR, the radius of the OAR, and the point of
% interest. This function returns 0 if the point is in the OAR, and 1 if
% the point is not inside the OAR.

% INPUT
% OAR_cent: center point of OAR
% OAR_rad:  radius of OAR
% poi:      point of interest

% OUTPUT
% inside:   a 0 or 1 value indicating whether the point is in the sphere or
%           not (0 is yes, 1 is no)

function inside = Is_Point_Inside_OAR(OAR_cent, OAR_rad, poi)

% if the point is not inside or on the surface of the OAR then inside is
% false (1)
inside = 1;
% if the point is inside or on the surface of the OAR then set inside to
% True (0)
if (poi(1,:)-OAR_cent(1,:))^2/OAR_rad + (poi(2,:)-OAR_cent(2,:))^2/OAR_rad +(poi(3,:)-OAR_cent(3,:))^2/OAR_rad <= 1
    inside = 0;
end

end