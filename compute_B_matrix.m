function [B] = compute_B_matrix(dN_dx_dy)

% initialize B-Matrix
B= zeros(3,8);

% compute B-Matrix
for j = 1: 4

    B(1,(j-1)*2+1) = dN_dx_dy(1,j);
    B(1,(j-1)*2+2) = 0;

    B(2,(j-1)*2+1) = 0;
    B(2,(j-1)*2+2) = dN_dx_dy(2,j);

    B(3,(j-1)*2+1) = dN_dx_dy(2,j);
    B(3,(j-1)*2+2) = dN_dx_dy(1,j);

end

end

