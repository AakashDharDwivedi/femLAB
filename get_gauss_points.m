function [weights, gauss_coord] = get_gauss_points(num_gp)

gauss_coord = zeros(num_gp,2);

% weights of the Gauss Points
weights = [1.0, 1.0, 1.0, 1.0];

% coordinates of the Gauss Points (xi, eta in the intervall [-1,1])
gauss_coord(1,:) = [-sqrt(1/3), -sqrt(1/3)];
gauss_coord(2,:) = [sqrt(1/3), -sqrt(1/3)];
gauss_coord(3,:) = [-sqrt(1/3), sqrt(1/3)];
gauss_coord(4,:) = [sqrt(1/3), sqrt(1/3)];

end


