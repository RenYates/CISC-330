% CISC 330 Assignment 4
% Lauren Yates 10195969
% Test_Compute_Beam_Direction_Vector

% this testing file uses the testing parameters specified in the assignment
% to check the validity of this function. The direction vectors calculated
% are placed into a table where the vectors can be compared to the hand
% calculated direction vectors using the same parameters.

global head_a; global head_b; global head_c; global iso_cent;

% assemble the arrays to hold the direction vectors and the longitudes and
% latitudes
direction_vectors = zeros(3,8);
long_and_lat = zeros(2,8);
index = 1;
% traverse each longitude and latitude and calculate the beam direction
% vector at that point and add it to the table
for i = 0:90:270
    for j = 0:90:90
        long_and_lat(1,index) = i;
        long_and_lat(2,index) = j;
        direction_vectors(:,index) = Compute_Beam_Direction_Vector(i,j,iso_cent,head_a,head_b,head_c);
        index = index + 1;
    end
end

% generate a formated table to visualize data
form_table = table(long_and_lat(1,:).',long_and_lat(2,:).',direction_vectors(:,:).','VariableNames',{'Longitude','Latitude','Direction_Vectors_xyz'});
disp(form_table);
