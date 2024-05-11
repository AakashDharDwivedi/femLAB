function post_processing(disp_solution, n_ele_x, n_ele_y, dim_x, dim_y)

x = linspace(0, dim_x, n_ele_x+1);
y = linspace(0, dim_y, n_ele_y+1);

u_disp_data = disp_solution(1:2:end);
v_disp_data = disp_solution(2:2:end);

undef_coord(1,1,:) = [0 0];
deformed_coord(1,1,:) = [0 0];

% compute undeformed and deformed nodal coordinates
for i = 1:n_ele_y+1
    for j = 1:n_ele_x+1
        undef_coord(i,j,:) = [x(j) y(i)];
        deformed_coord(i,j,1) = undef_coord(i,j,1) + u_disp_data((i-1)*(n_ele_x+1)+j);
        deformed_coord(i,j,2) = undef_coord(i,j,2) + v_disp_data((i-1)*(n_ele_x+1)+j);
    end
end

% display maximum y-displacement
fprintf("\nMaximum absolute y-displacement = %f\n", max(abs(v_disp_data)));

x_min = min(deformed_coord(:,:,1), [], 'all');
x_max = -1*min(-1*deformed_coord(:,:,1), [], 'all');
y_min = min(deformed_coord(:,:,2), [], 'all');
y_max = -1*min(-1*deformed_coord(:,:,2), [], 'all');

lower_x=floor(x_min-1.5);
upper_x=ceil(x_max+1.5);
lower_y=floor(y_min-1.2)+0.5;
upper_y=ceil(y_max+2);

%% Launch
fig_obj= figure('Name','femLAB','NumberTitle','off','units','normalized','outerposition',[0 0 1 1]);
fig_obj.WindowState='maximized';

for i=1:10
    t=linspace(0,i,100);
    s=sin(t);
    plot(t,s,'or','LineWidth',10);
    xlim([0 10]);
    ylim([-1.1 1.1]);
    set(gca,'XTick',[])
    set(gca,'YTick',[])
    title('\fontsize{120}\itfem\rmLAB');
    subtitle('Loading...', 'FontSize', 18);
    hold on;
    pause(1/(2*i));
end
pause(1.0);

%% Configurations
fig_obj=figure('Name','femLAB - Deformed Configuration','NumberTitle','off','units','normalized','outerposition',[0 0 1 1]);
fig_obj.WindowState='maximized';
scatter(undef_coord(:,:,1), undef_coord(:,:,2), 'b','LineWidth',1.5);
title('Undeformed vs. Deformed Configuration', 'FontSize', 14);
%subtitle('Fixed beam subjected to UDL', 'FontSize', 14);
hold on;
grid minor;
grid on;
xlim([lower_x upper_x]);
ylim([lower_y upper_y]);
xlabel("x coordinate",'FontSize',12);
ylabel("y coordinate",'FontSize',12);
pause(1.0);

title('Undeformed vs Deformed Configuration', 'FontSize', 14);
%subtitle('Fixed beam subjected to UDL', 'FontSize', 14);
scatter(deformed_coord(:,:,1), deformed_coord(:,:,2), 'r','LineWidth',1.5);
xlim([lower_x upper_x]);
ylim([lower_y upper_y]);
xlabel("x coordinate",'FontSize',12);
ylabel("y coordinate",'FontSize',12);
pause(1.0);

%% u-displacemnt
fig_obj=figure('Name','femLAB - u_x-Displacement Contours','NumberTitle','off', 'units','normalized','outerposition',[0 0 1 1]);
fig_obj.WindowState='maximized';
surf(x, y, zeros(n_ele_y+1,n_ele_x+1));
title('u_x - Displacement Contour: Undeformed configuration', 'FontSize', 14);
%subtitle('Fixed beam subjected to UDL', 'FontSize', 14);
view(0,90);
xlim([lower_x upper_x]);
ylim([lower_y upper_y]);
colormap(jet(100));
c=colorbar;
c.Label.String='u_x - displacement';
c.Label.FontSize=12;
grid minor;
grid on;
xlabel("x coordinate",'FontSize',12);
ylabel("y coordinate",'FontSize',12);

pause(1.0);
u_disp = reshape(u_disp_data, n_ele_x+1, n_ele_y+1);
surf(deformed_coord(:,:,1), deformed_coord(:,:,2), u_disp');
title('u_x - Displacement Contour: Deformed configuration', 'FontSize', 14);
%subtitle('Fixed beam subjected to UDL', 'FontSize', 14);
view(0,90);
xlim([lower_x upper_x]);
ylim([lower_y upper_y]);
colormap(jet(100));
c=colorbar;
c.Label.String='u_x - displacement';
c.Label.FontSize=12;
grid minor;
grid on;
xlabel("x coordinate",'FontSize',12);
ylabel("y coordinate",'FontSize',12);
pause(1.0);

%% v-displacemnt
fig_obj=figure('Name','femLAB - u_y - Displacement Contours','NumberTitle','off', 'units','normalized','outerposition',[0 0 1 1]);
fig_obj.WindowState='maximized';
surf(x, y, zeros(n_ele_y+1,n_ele_x+1));
title('u_y - Displacement Contour: Undeformed configuration', 'FontSize', 14);
%subtitle('Fixed beam subjected to UDL', 'FontSize', 14);
view(0,90);
xlim([lower_x upper_x]);
ylim([lower_y upper_y]);
colormap(jet(100));
c=colorbar;
c.Label.String='u_y - displacement';
c.Label.FontSize=12;
grid minor;
grid on;
xlabel("x coordinate",'FontSize',12);
ylabel("y coordinate",'FontSize',12);

pause(1.0);
v_disp = reshape(v_disp_data, n_ele_x+1, n_ele_y+1);
surf(deformed_coord(:,:,1), deformed_coord(:,:,2), v_disp');
title('u_y - Displacement Contour: Deformed configuration', 'FontSize', 14);
%subtitle('Fixed beam subjected to UDL', 'FontSize', 14);
view(0,90);
xlim([lower_x upper_x]);
ylim([lower_y upper_y]);
colormap(jet(100));
c=colorbar;
c.Label.String='u_y - displacement';
c.Label.FontSize=12;
grid minor;
grid on;
xlabel("x coordinate",'FontSize',12);
ylabel("y coordinate",'FontSize',12);
pause(1.0);

end
