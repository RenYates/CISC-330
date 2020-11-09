% CISC 330 Assignment 4
% Lauren Yates 10195969
% Is_Point_Inside_PTV

% This function checks if the point is inside the PTV sphere using the
% center point of the PTV, the radius of the PTV, and the point of
% interest. This function returns 0 if the point is in the PTV, and 1 if
% the point is not inside the PTV.

% INPUT
% PTV_cent: center point of PTV
% PTV_rad:  radius of PTV
% poi:      point of interest

% OUTPUT
% inside:   a 0 or 1 value indicating whether the point is in the sphere or
%           not (0 is yes, 1 is no)

function inside = Is_Point_Inside_PTV(PTV_cent, PTV_rad, poi)

% if the point is not inside or on the surface of the PTV then inside is
% false (1)
inside = 1;
% if the point is inside or on the surface of the PTV then set inside to
% True (0)
if (poi(1,:)-PTV_cent(1,:))^2/PTV_rad + (poi(2,:)-PTV_cent(2,:))^2/PTV_rad +(poi(3,:)-PTV_cent(3,:))^2/PTV_rad <= 1
    inside = 0;
end

end