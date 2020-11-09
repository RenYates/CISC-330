% CISC 330 Assignment 4
% Lauren Yates 10195969
% Compute_Surface_Dose

% This function computes the surface dose for the PTV and OAR by
% calculating the doses for all the vertices of the sphere patches for both
% PTV and OAR and illustrating the doses as a color map over the surface of
% the spheres. The function also calculates the min and max dose and their
% associated points for both spheres and plots them as well (min dose is
% green, max dose is red).

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

function Compute_Surface_Dose(head_a,head_b,head_c,head_cent,beam_sep,beam_rad,iso_cent,ptv_rad,ptv_cent,oar_rad,oar_cent)

% generate sphere for the PTV
[px,py,pz] = sphere();
figure();
hold on;
title('PTV Sphere - Without Dose Coloring');
PTV = surf(ptv_rad*px+ptv_cent(1),ptv_rad*py+ptv_cent(2),ptv_rad*pz+ptv_cent(3));
hold off;

% find the vertices (points on the surface of the PTV) and the fvc
% structure of the PTV sphere
[ptv_faces,ptv_vertices,~] = surf2patch(PTV);

% generate sphere for the OAR
[ox,oy,oz] = sphere();
figure();
hold on;
title('OAR Sphere - Without Dose Coloring');
OAR = surf(oar_rad*ox+oar_cent(1),oar_rad*oy+oar_cent(2),oar_rad*oz+oar_cent(3));
hold off;

% find the vertices (points on the surface of the OAR) and the fvc
% structure of the OAR sphere
[oar_faces,oar_vertices,~] = surf2patch(OAR);

% find the size of the vertices calculated
vert_size_ptv = size(ptv_vertices,1);
vert_size_oar = size(oar_vertices,1);

% calculate all the doses for the vertices of PTV
ptv_doses = zeros(1,vert_size_ptv);
for i = 1:vert_size_ptv
    poi = ptv_vertices(i,:).';
    current = Compute_Point_Dose_from_All_Beams(head_a,head_b,head_c,head_cent,beam_sep,beam_rad,oar_rad,oar_cent,iso_cent,poi);
    ptv_doses(:,i) = current;
end

% find the max and min doses and their indexes to find the associated
% points
[~,ptv_max_index] = max(ptv_doses);
[~,ptv_min_index] = min(ptv_doses);
ptv_max_point = ptv_vertices(ptv_max_index,:);
ptv_min_point = ptv_vertices(ptv_min_index,:);

% use the array of doses as the set of colors for the PTV sphere
ptv_color = ptv_doses.';

figure();
hold on;
title('Surface Dose of PTV with Data Points');
ptv_h = patch('Faces',ptv_faces,'Vertices',ptv_vertices,'FaceVertexCData',ptv_color,'FaceColor','interp');
scatter3(ptv_max_point(:,1),ptv_max_point(:,2),ptv_max_point(:,3),'r','filled');
scatter3(ptv_min_point(:,1),ptv_min_point(:,2),ptv_min_point(:,3),'g','filled');
colorbar;
hold off;

% calculate all the doses for the vertices of OAR
oar_doses = zeros(1,vert_size_oar);
for i = 1:vert_size_oar
    poi = oar_vertices(i,:).';
    current = Compute_Point_Dose_from_All_Beams(head_a,head_b,head_c,head_cent,beam_sep,beam_rad,oar_rad,oar_cent,iso_cent,poi);
    oar_doses(:,i) = current;
end

% find the max and min doses and their indexes to find the associated
% points
[~,oar_max_index] = max(oar_doses);
[~,oar_min_index] = min(oar_doses);
oar_max_point = oar_vertices(oar_max_index,:);
oar_min_point = oar_vertices(oar_min_index,:);

% use the array of doses as the set of colors for the OAR sphere
oar_color = oar_doses.';

figure();
hold on;
title('Surface Dose of OAR with Data Points');
oar_h = patch('Faces',oar_faces,'Vertices',oar_vertices,'FaceVertexCData',oar_color,'FaceColor','interp');
scatter3(oar_max_point(:,1),oar_max_point(:,2),oar_max_point(:,3),'r','filled');
scatter3(oar_min_point(:,1),oar_min_point(:,2),oar_min_point(:,3),'g','filled');
colorbar;
hold off;
end