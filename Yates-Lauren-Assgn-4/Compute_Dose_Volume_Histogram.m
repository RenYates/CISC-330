% CISC 330 Assignment 4
% Lauren Yates 10195969
% Compute_Dose_Volume_Histogram

% This function uses the head data, beam data, ptv sphere data, oar
% sphere data, and the center point of the helmet to calculate the dose
% volume histograms of the PTV and the OAR. The function searches through
% the dose box by a specified voxel size and marks points as being in the
% OAR sphere or the PTV sphere. These marked points then have their point
% doses calculated using the Compute_Point_Dose_from_All_Beams function.
% These doses are then split up into bins and a histogram is generated
% using the histocount function and the plot function.

% INPUT
% head_a:    the radius of the head along the x axis
% head_b:    the radius of the head along the y axis
% head_c:    the radius of the head along the z axis
% head_cent: the center of the head
% beam_sep:  the separation angle between the beams
% beam_rad:  the radius of the beam
% ptv_rad:   the radius of the PTV sphere
% ptv_cent:  the center of the PTV sphere
% oar_rad:   the radius of the OAR sphere
% oar_cent:  the center of the OAR sphere
% iso_cent:  the center point of the helmet where all beams intersect

% OUTPUT
% N/A

function Compute_Dose_Volume_Histogram(head_a,head_b,head_c,head_cent,beam_sep,beam_rad,ptv_rad,ptv_cent,oar_rad,oar_cent,iso_cent)

% calculate the lowerleft and upperright to traverse the dose box
[lowerLeft,upperRight] = Compute_Dose_Box(ptv_rad,ptv_cent,oar_rad,oar_cent);

% create empty matrices for the points in the PTV and OAR and set voxel
% size
ptv_points = [];
oar_points = [];
voxel_size = 1; % the dose box is in mm, so the voxel size is a step size of 1mm

index_ptv = 1;
index_oar = 1;

% itterate through the dose box and determine where each voxel is located
for x = (lowerLeft(1)):voxel_size:(upperRight(1))
    for y = (lowerLeft(2)):voxel_size:(upperRight(2))
        for z = (lowerLeft(3)):voxel_size:(upperRight(2))
            in_ptv = Is_Point_Inside_PTV(ptv_cent,ptv_rad,[x;y;z]);
            in_oar = Is_Point_Inside_OAR(oar_cent,oar_rad,[x;y;z]);
            if (in_ptv == 0) % if the voxel is in the ptv then add it to the set of points
                ptv_points(:,index_ptv) = [x;y;z];
                index_ptv = index_ptv+1; % increment index of the array
            elseif (in_oar == 0) % if the voxel is in the oar then add it to the set of points
                oar_points(:,index_oar) = [x;y;z];
                index_oar = index_oar+1; % increment index of the array
            end
        end
    end
end

% determine how many voxels are in the PTV and OAR
n = size(ptv_points,2);
m = size(oar_points,2);

ptv_doses = zeros(1,n);
oar_doses = zeros(1,m);
global beam_safety_table;
beam_safety_table = Compute_All_Beam_Safety(beam_rad,beam_sep,iso_cent,oar_rad,oar_cent,head_a,head_b,head_c);
% calculate the doses for each voxel in the PTV
for i = 1:n
    ptv_doses(i) = Compute_Point_Dose_from_All_Beams(head_a,head_b,head_c,head_cent,beam_sep,beam_rad,oar_rad,oar_cent,iso_cent,ptv_points(:,i));
end
% calculate the doses for each voxel in the OAR
for j = 1:m
    oar_doses(j) = Compute_Point_Dose_from_All_Beams(head_a,head_b,head_c,head_cent,beam_sep,beam_rad,oar_rad,oar_cent,iso_cent,oar_points(:,j));
end

% find how many voxels are within each of the the histogram edges
[bin_ptv,edges_ptv] = histcounts(ptv_doses,10); % 10 is the number of bins wanted
edges_oar = [0.0,0.1,0.2,0.3,0.4,0.5];
[bin_oar] = histcounts(oar_doses,edges_oar);

% calculate the percentage of voxels in each bin
relative_bin_ptv = bin_ptv./n;
relative_bin_oar = bin_oar./m;

% calculate the cumulative ammounts in the bins
bin_ptv_cum = cumsum(relative_bin_ptv,'reverse');
bin_oar_cum = cumsum(relative_bin_oar,'reverse');

% plot the PTV Histogram
figure();
hold on;
title('PTV Dose Volume Histogram');
xlabel('Absolute Dose');
ylabel('Relative Volume (% of Voxels)');
plot(edges_ptv(:,2:end),relative_bin_ptv(:,:),'b');
plot(edges_ptv(:,2:end),bin_ptv_cum(:,:),'r');
legend('Relative Dose','Cumulative Dose');
hold off;

% plot the OAR Histogram
figure();
hold on;
title('OAR Dose Volume Histogram');
xlabel('Absolute Dose');
ylabel('Relative Volume (% of Voxels)');
plot(edges_oar(:,2:end),relative_bin_oar(:,:),'b');
plot(edges_oar(:,2:end),bin_oar_cum(:,:),'r');
legend('Relative Dose','Cumulative Dose');
hold off;
end