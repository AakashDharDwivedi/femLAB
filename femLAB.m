%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   femLAB (FE SOLVER)                                                    %
%                                                                          %
%    _______________________________________________________________       %
%%   Author:                                                               %
%                                                                          %
%    Aakash Dhar Dwivedi, B.E., M.S. (TU MUNICH)                           %
%    Scientist/Engineer-SD                                                 %
%    Vikram Sarabhai Space Centre                                          %
%    Indian Space Research Organisation                                    %
%    _______________________________________________________________       %
%                                                                          %
%%   Copyright:															   %
%	 This work is under  exclusive  copyright  by default on Github.com    %
%    (https://github.com/AakashDharDwivedi/femLAB.git),   				   %
%	 i.e.,  the code author (Aakash Dhar Dwivedi)  retains all rights to   %
%	 the  source  code and  no  one may reproduce, distribute, or create   %
%	 derivative works from this work.									   %
%																		   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
clear
close all

%% Set Geometry
[x_origin, y_origin, dim_x, dim_y] = geometry();

%% Set Disctetization
[n_ele_x, n_ele_y] = mesh();

%% Set Constitutive relation
E = constitutive_relation(1e3, 0.0, "plane_stress");

%% Define loads
body_loads = loads();

%% System of equations
[K_global, F_global] = global_stiffness_matrix(E, body_loads, x_origin, y_origin, n_ele_x, n_ele_y, dim_x, dim_y);

%% Apply BC
[K_mod, F_mod] = apply_DBC({'left_edge'}, K_global, F_global, n_ele_x, n_ele_y);

%% Solve
disp('Solving...');
disp_solution = inv(K_mod)*F_mod;
disp('Solved successfully!');

%% Visualization
post_processing(transpose(disp_solution), n_ele_x, n_ele_y, dim_x, dim_y);

%% end
