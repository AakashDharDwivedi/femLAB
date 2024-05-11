function [N, dN] = get_shape_functions_and_derivatives(g_coord)

xi =g_coord(1);
eta=g_coord(2);

% Initialize the shape functions array
N = zeros(1,4);

% Assign the values of the functions at the parametric locations
N(1,1) = (1-xi)*(1-eta)/4;
N(1,2) = (1+xi)*(1-eta)/4;
N(1,3) = (1-xi)*(1+eta)/4;
N(1,4) = (1+xi)*(1+eta)/4;


% Initialize the derivatives of the shape functions
dN = zeros(2,4);

% Assign the values of the derivatives at the Gauss points

% dN/dxi
dN(1,1) = -(1-eta)/4;
dN(1,2) = (1-eta)/4;
dN(1,3) = -(1+eta)/4;
dN(1,4) = (1+eta)/4;

% dN/deta
dN(2,1) = -(1-xi)/4;
dN(2,2) = -(1+xi)/4;
dN(2,3) = (1-xi)/4;
dN(2,4) = (1+xi)/4;

end