function [K_mod, F_mod] = apply_DBC(BC, K_global, F_global, n_ele_x, n_ele_y)

% basic definitions
nodes_num = 1:(n_ele_x+1)*(n_ele_y+1);

% assignments
K_mod = K_global;
F_mod = F_global;

arrested_nodes =[];

% Bottom Edge Nodes
if(ismember("bottom_edge", BC))
    BC_bottom = 1:n_ele_x+1;
    arrested_nodes = [arrested_nodes, BC_bottom];
end

% Left Edge Nodes
if(ismember('left_edge', BC))
    BC_left = nodes_num(1:n_ele_x+1:end);
    arrested_nodes = [arrested_nodes, BC_left];
end

% Right Edge Nodes
if(ismember('right_edge', BC))
    BC_right = nodes_num(2*(n_ele_x+1):n_ele_x+1:end);
    arrested_nodes = [arrested_nodes, BC_right];
end

% Top Edge Nodes
if(ismember('top_edge', BC))
    BC_top = nodes_num(end)-n_ele_x:nodes_num(end);
    arrested_nodes = [arrested_nodes, BC_top];
end

if(ismember('mid', BC))
    % Mid Vertical Nodes
    BC_mid = nodes_num(ceil(n_ele_x+1)/2:n_ele_x+1:end);
    arrested_nodes = [arrested_nodes, BC_mid];
end

% arrested dofs computation
index=1;

for i=1:length(arrested_nodes)
    arrested_dofs(index)=2*arrested_nodes(i)-1;
    arrested_dofs(index+1)=2*arrested_nodes(i);
    
    index=index+2;
end

% substitute ZEROS and ONES in the global stiffness matrix & force vector
for i=1:length(arrested_dofs)
    K_mod(:,arrested_dofs(i))=0;
    K_mod(arrested_dofs(i), :)=0;
    K_mod(arrested_dofs(i),arrested_dofs(i))=1;
    
    F_mod(arrested_dofs(i))=0;
end
end
