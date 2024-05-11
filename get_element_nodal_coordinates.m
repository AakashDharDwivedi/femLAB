function [nodal_coordinates] = get_element_nodal_coordinates(i,j, x_origin, y_origin, dim_x, dim_y, n_ele_x, n_ele_y)

ele_length = dim_x/n_ele_x;
ele_height = dim_y/n_ele_y;

nodal_coordinates = [x_origin + (j-1) * ele_length y_origin + (i-1) * ele_height;
                    x_origin + j * ele_length y_origin + (i-1) * ele_height; 
                    x_origin + (j-1) * ele_length y_origin + i * ele_height;
                    x_origin + j * ele_length y_origin + i * ele_height];


end

