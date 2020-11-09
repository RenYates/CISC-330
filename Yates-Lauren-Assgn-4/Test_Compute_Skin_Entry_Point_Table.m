% CISC 330 Assignment 4
% Lauren Yates 10195969
% Test_Compute_Skin_Entry_Point_Table

% this testing file uses the Draw_3D_Scene function and the
% Compute_Skin_Entry_Point_Table function to graph the 3D scene including
% the beams (colored blue) and their skin entry points (colored magenta)

global beam_sep; global beam_rad; global ptv_rad; global ptv_cent; 
global iso_cent; global oar_rad; global oar_cent; global head_a;
global head_b; global head_c; global head_cent; global lowerLeft; 
global upperRight; global skin_entry_point_table;

figure();
hold on;
Draw_3D_Scene(head_a, head_b, head_c, head_cent,ptv_rad,ptv_cent,oar_rad,oar_cent,iso_cent,lowerLeft,upperRight);
skin_entry_point_table = Compute_Skin_Entry_Point_Table(head_a,head_b,head_c,head_cent,iso_cent,beam_sep,beam_rad);
scatter3(skin_entry_point_table(1,:),skin_entry_point_table(2,:),skin_entry_point_table(3,:),'g','filled');
hold off;