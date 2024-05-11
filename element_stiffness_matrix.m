function [K_element, F_element] = element_stiffness_matrix(nodes, E, body_loads)

% basic definitions
num_gp = 4;
thickness=1;

% initialize element stiffness matrix and element force vector
K_element = zeros(8,8);
F_element = zeros(8,1);

% get Gauss points coordinates
[weights, gauss_coord] = get_gauss_points(num_gp);

for i=1:num_gp
    % get shape functions and derivatives w.r.t xi-eta at the current GP.
    [N, dN_dxi_deta] = get_shape_functions_and_derivatives(gauss_coord(i,:));

    % compute Jacobian
    Jacobian = dN_dxi_deta * nodes;

    % compute shape functin derivatives w.r.t. x-y
    dN_dx_dy = inv(Jacobian) * dN_dxi_deta;

    % compute B-Matrix
     B= compute_B_matrix(dN_dx_dy);

    % compute K_element using Gauss quadrature formula
    K_element = K_element + weights(i) * thickness * det(Jacobian) * B' * E * B;

    % setup shape function matrix
    N_matrix = [N(1) 0 N(2) 0 N(3) 0 N(4) 0;
                0 N(1) 0 N(2) 0 N(3) 0 N(4)];

    % compute F_element using Gauss quadrature formula
    F_element = F_element + weights(i) * thickness * det(Jacobian) * N_matrix' * body_loads;
end

