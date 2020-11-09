% CISC 330 Assignment 4
% Lauren Yates 10195969
% Compute_Dose_Surface_Histogram

% This function uses the head data, beam data, ptv sphere data, oar
% sphere data, and the center point of the helmet to calculate the surface
% dose histogram of the PTV. The function uses surf2patch to create
% triangular patches with vertices and faces on the sphere. The function
% then calculates the area of each patch using Heron's formula to calculate
% the area of the triangles. The area of each triangle is also summed up to
% have the total surface area of the sphere. The patches with the minimum
% dose and maximum dose are then calculated and used to generate bins and
% edges for the histogram plotting. The function then uses the relative
% areas of each of the triangles and generates a Surface Dose Histogram.

% INPUT
% head_a:    the radius of the head along the x axis
% head_b:    the radius of the head along the y axis
% head_c:    the radius of the head along the z axis
% head_cent: the center of the head
% beam_sep:  the separation angle between the beams
% beam_rad:  the radius of the beam
% iso_cent:  the center point of the helmet where all beams intersect
% ptv_rad:   the radius of the PTV sphere
% ptv_cent:  the center of the PTV sphere
% oar_rad:   the radius of the OAR sphere
% oar_cent:  the center of the OAR sphere

% OUTPUT
% N/A

function Compute_Dose_Surface_Histogram(head_a,head_b,head_c,head_cent,beam_sep,beam_rad,iso_cent,ptv_rad,ptv_cent,oar_rad,oar_cent)

% get the sphere form of the PTV
[px,py,pz] = sphere();
figure();
hold on;
title('PTV Sphere - Without Dose Coloring');
PTV = surf(ptv_rad*px+ptv_cent(1),ptv_rad*py+ptv_cent(2),ptv_rad*pz+ptv_cent(3));
hold off;

% convert the sphere form into patches
[ptv_faces,ptv_vertices,~] = surf2patch(PTV,'triangles');

% calculate the size of the arrays for vertices and faces
vert_size_ptv = size(ptv_vertices,1);
face_size_ptv = size(ptv_faces,1);

% calculate the doses for each vertex of the patch sphere
ptv_doses = zeros(1,vert_size_ptv);
for i = 1:vert_size_ptv
    poi = ptv_vertices(i,:).';
    current = Compute_Point_Dose_from_All_Beams(head_a,head_b,head_c,head_cent,beam_sep,beam_rad,oar_rad,oar_cent,iso_cent,poi);
    ptv_doses(:,i) = current;
end

% calculate the average doses of each triangular patch by taking the
% average doses of the patches vertices
ptv_patch_doses = zeros(1,face_size_ptv);
ptv_patch_areas = zeros(1,face_size_ptv);
for i = 1:face_size_ptv
    patch_dose = (ptv_doses(:,(ptv_faces(i,1))) + ptv_doses(:,(ptv_faces(i,2))) + ptv_doses(:,(ptv_faces(i,3))))/3;
    ptv_patch_doses(:,i) = patch_dose;
    % This formula is Heron's Formula for area of a triangle
    % step 1: calculate the distances (side lengths) for the triangle
    a = DistTwoPoints3D(ptv_vertices(ptv_faces(i,1),:).',ptv_vertices(ptv_faces(i,2),:).');
    b = DistTwoPoints3D(ptv_vertices(ptv_faces(i,1),:).',ptv_vertices(ptv_faces(i,3),:).');
    c = DistTwoPoints3D(ptv_vertices(ptv_faces(i,2),:).',ptv_vertices(ptv_faces(i,3),:).');
    % step 2: calculate half of the perimeter as p
    p = (a+b+c)/2;
    % step 3: calculate the area as sqrt(p*(p-a)*(p-b)*(p-c))
    area = sqrt(p*(p-a)*(p-b)*(p-c));
    ptv_patch_areas(:,i) = area;
end

% total area is the sum of all the patch areas
total_area = sum(ptv_patch_areas);

% calculate the minimum dose patch and the maximum dose patch values
max_patch = ceil(max(ptv_patch_doses));
min_patch = floor(min(ptv_patch_doses));

% calculate the number of bins for the areas to fall into
bin_edges = [min_patch:max_patch];
num_bins = max_patch-min_patch;

ptv_bins_area = zeros(1,num_bins);
% iterate through each patch and determine which bin it falls into
% cumulatively
for i = 1:face_size_ptv
    for j = 1:(num_bins+1)
        if (ptv_patch_doses(:,i) >= bin_edges(:,j))
            ptv_bins_area(:,j) = ptv_bins_area(:,j) + ptv_patch_areas(:,i);
        end
    end
end

% calculate the relative bin areas by dividing by the total area
bin_areas_relative = ptv_bins_area./total_area;

figure();
hold on;
title('PTV Dose Surface Histogram');
xlabel('Absolute Dose');
ylabel('Relative Volume (% of Area)');
plot(bin_edges(:,2:end),bin_areas_relative(:,:),'b');
xlim([min_patch max_patch]);
legend('Cumulative Dose');
hold off;

end