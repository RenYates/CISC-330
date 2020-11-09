% CISC 330 Assignment 1 pt. 8
% Rigid Body Transformation- fiducial localization error vector calculation
% Lauren Yates 10195969

% This function takes a vector and a fiducual localization error value 
% (fleVal) and displaces the given vector by a fle vector of 
% magnitude fleVal

function newVec = FLEVecAdd(vector, fleVal)
% rand(3,1) generates a random vector of size 3 by 1
vec = rand(3,1);
% make the generated vector unit length
unitVec = vec/norm(vec);
% increase the magnitude of the randomly generated vector to fleVal to
% create the fle vector
fle = unitVec * (fleVal);
% add the fle vector to the original vector to create the new displaced
% vector
newVec = vector + fle;
end