function [K_global, F_global] = global_stiffness_matrix(E, body_loads, x_origin, y_origin, n_ele_x, n_ele_y, dim_x, dim_y)

% basic definitions
dofs_per_node = 2;
nodes_per_ele = 4;
dofs_per_ele = dofs_per_node * nodes_per_ele;

% calculate number of global dofs
n_dofs = dofs_per_node*(n_ele_x+1)*(n_ele_y+1);

% initialize global stiffness matrix and force vector
K_global = zeros(n_dofs, n_dofs);
F_global = zeros(n_dofs, 1);

% compute global stiffness matrix and global force vector
for row=1:n_ele_y
    for col=1:n_ele_x
        
        % get element nodal coordinates
        nodal_coord = get_element_nodal_coordinates(row,col, x_origin, y_origin, dim_x, dim_y, n_ele_x, n_ele_y);
        
        % get element stiffness matrix
        [K_element, F_element] = element_stiffness_matrix(nodal_coord, E, body_loads);
        
        % get elements's global dofs
        EGD = get_element_global_dofs(row,col,n_ele_x, n_ele_y);
        
        % populate element stiffness matrix into global stiffness matrix
        K_global(EGD, EGD) = K_global(EGD, EGD) + K_element;
        
        % populate element force vector into global force vector
        F_global(EGD) = F_global(EGD) + F_element;
    end
end
end






