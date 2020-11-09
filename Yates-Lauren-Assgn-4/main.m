% CISC 330 Assignment 4
% Lauren Yates 10195969
% Main Testing Function

% This main function calls all of the required functions for this
% assignment and checks the validity of their results (either through
% visual graphing, printing the output, or other methods)

function main()
    global beam_sep; beam_sep = 10;
    global beam_rad; beam_rad = 15;
    global ptv_rad;  ptv_rad = 15;
    global ptv_cent; ptv_cent = [30;0;15];
    global iso_cent; iso_cent = ptv_cent;
    global oar_rad;  oar_rad = 15;
    global oar_cent; oar_cent = [0;30;45];
    global head_a; head_a = 80;
    global head_b; head_b = 100;
    global head_c; head_c = 80;
    global head_cent; head_cent = [0;0;0];
    global max_lon; max_lon = 360;
    global max_lat; max_lat = 180;
    
    % test 1: Calculate and Print the Dose_Box (lowerLeft and upperRight)
    % compare output results to hand written calculations to check validity
    disp('Part 1 Test: Calculate_Dose_Box');
    % these are the ground truth calculations 
    ground_lower = [-15;-15;0];
    ground_upper = [45;45;60];
    
    % these values will be used later in the testing functions
    global lowerLeft; global upperRight;
    
    [lowerLeft,upperRight] = Compute_Dose_Box(ptv_rad,ptv_cent,oar_rad,oar_cent)
    
    if (isequal(ground_lower,lowerLeft))
        fprintf('the lowerLeft ground truth and calculated lowerLeft are equal.\n');
    end
    if (isequal(ground_upper,upperRight))
        fprintf('the upperRight ground truth and calculated upperRight are equal.\n\n');
    end
    
    % test 2: Draw_3D_Scene function
    % this test calls the Draw_3D_Scene function to show a visual
    % representation of the data. The calculated dose box can be further
    % verified visually using this plot.
    
    figure();
    Draw_3D_Scene(head_a, head_b, head_c, head_cent,ptv_rad,ptv_cent,oar_rad,oar_cent,iso_cent,lowerLeft,upperRight);
    
    % test 3: Compute_Linear_Function
    % this test calls the Test_Compute_Linear_Function.m file where the
    % testing and validity is checked separately & printed to the command
    % window.
    
    Test_Compute_Linear_Function
    
    % test 4: Compute_Radial_Distance
    % this test calls the Test_Compute_Radial_Distance.m file where the
    % testing and validity is checked and printed to the command window
    Test_Compute_Radial_Distance
    
    % test 5: Compute_Depth_Dose
    % this test calls the Test_Compute_Depth_Dose.m file where the testing
    % and validity is checked and a graph is generated to visually compare
    % to the linear function given.
    Test_Compute_Depth_Dose
    
    % test 6: Compute_Radial_Dose
    % This test calls the Test_Compute_Radial_Dose.m file where the testing
    % and validity is checked and a graph is generated to visually compare
    % to the linear function given.
    Test_Compute_Radial_Dose
    
    % test 7: Compute_Beam_Direction_Vector
    % This test calls the Test_Compute_Beam_Direction_Vector.m file where
    % the testing and validity is checked by observing the table calculated
    % and comparing to the ground truths calculated on paper.
    Test_Compute_Beam_Direction_Vector
    
    % test 8: Compute_Skin_Entry_Point_Table
    % This test calls the Test_Skin_Entry_Point_Table.m file where the
    % testing and validity is checked by observing the 3D scene plotted
    % with the centerline of all beams and where they intersect the head.
    Test_Compute_Skin_Entry_Point_Table

    % test 9: Compute_Beam_Safety_Table
    % This test calls the Test_Beam_Safety_Table.m file where the testing
    % and validity is checked by observing the table generated.
    Test_Compute_All_Beam_Safety
    
    % test 10: Compute_Point_Dose_From_Beam
    % This test calls the Test_Beam_Safety_Table.m file where the testing
    % and validity is checked by observing the table generated and
    % comparing it to the calculated depth dosages for those beams at the 
    % point chosen.
    Test_Compute_Point_Dose_From_Beam
    
    % test 11: Compute_Dose_Volume_Histogram
    % This test calls the Compute_Dose_Histogram function, which generates
    % a Dose Volume Histogram for both the PTV and the OAR. 
    Compute_Dose_Volume_Histogram(head_a,head_b,head_c,head_cent,beam_sep,beam_rad,ptv_rad,ptv_cent,oar_rad,oar_cent,iso_cent);
    
    % test 12: Compute_Surface_Dose
    % This test calls the Compute_Surface_Dose function, which generates a
    % surface dose plot for both the PTV and the OAR, along with the
    % hottest and coldest points (marked in red and green respectively) for
    % the PTV and the OAR doses.
    Compute_Surface_Dose(head_a,head_b,head_c,head_cent,beam_sep,beam_rad,iso_cent,ptv_rad,ptv_cent,oar_rad,oar_cent);
    
    % test 13: Compute_Dose_Surface Histogram
    % This test calls the Compute_Dose_Surface_Histogram function, which
    % generates a Dose Volume Histogram for the PTV.
    Compute_Dose_Surface_Histogram(head_a,head_b,head_c,head_cent,beam_sep,beam_rad,iso_cent,ptv_rad,ptv_cent,oar_rad,oar_cent);
end