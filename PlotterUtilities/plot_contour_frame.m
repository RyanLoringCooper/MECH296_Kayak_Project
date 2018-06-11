function [ ] = plot_contour_frame(cluster_space_time_series, resolution, width, fieldGenerator, algSolver, plotRes)
%PLOT_PATH Summary of this function goes here
%   Detailed explanation goes here

%load(file);
r1_x = cluster_space_time_series.Data(:,7);
r1_y = cluster_space_time_series.Data(:,8);
r2_x = cluster_space_time_series.Data(:,10);
r2_y = cluster_space_time_series.Data(:,11);
r3_x = cluster_space_time_series.Data(:,13);
r3_y = cluster_space_time_series.Data(:,14);
Time = cluster_space_time_series.Time;
time = [0:resolution:cluster_space_time_series.Time(end)];

xmin = -width;
xmax = width;
ymin = -width;
ymax = width;

res = 1;

x = xmin-res:res:xmax+res;
y = ymin-res:res:ymax+res;

[X,Y] = meshgrid(x,y);
size_x = length(x);
size_y = length(y);

 for i = 1:plotRes:size_y
     for j = 1:plotRes:size_x
         dirt = feval(fieldGenerator, X(i, j), Y(i, j), false);
         u(i, j) = dirt(1);
         v(i, j) = dirt(2);
     end
 end

m = u.^2+v.^2;
Z = sqrt(m);
size_z = size(Z);
ZThreshold = 1.05;
for i = 1:1:size_z(1)
    for j = 1:1:size_z(2)
        if Z(i, j) >= ZThreshold
            Z(i, j) = ZThreshold;
        end
    end
end

contour(x,y,Z,100,'k');
    colorbar
    hold on;
plot(r1_x(i),r1_y(i),'ro');
plot(r2_x(i),r2_y(i),'go');
plot(r3_x(i),r3_y(i),'bo');
    set(gcf,'visible','on');
    xlabel('Y');
    ylabel('X');
    axis square
fname = sprintf('/SimulationImages/%s_%s_2D_Contour.png', fieldGenerator,  algSolver);
saveas(gcf,[pwd, fname])
end

