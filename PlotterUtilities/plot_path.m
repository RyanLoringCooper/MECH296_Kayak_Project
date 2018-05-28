function [ ] = plot_path( cluster_space_time_series, resolution, width, fieldGenerator, plotRes)
%PLOT_PATH Plots cluster path on contour
%   Superimposes the path the robots took onto a 2D contour map.
%   'width' indicates the range to be plotted, 'resolution' is the time
%   interval in between path points.

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
field_shift = [0 0 0 0];
fieldGrapher(xmin-res, xmax+res, ymin-res, ymax+res, fieldGenerator, true, plotRes);

v = [-100:5:100];

%figure;
%contour(x,y,Z, v);
hold on

%plot(interp1(data.Time, data.Data(:,10), time),interp1(data.Time, data.Data(:,9), time),'kx')
plot(interp1(Time, r1_x, time),interp1(Time, r1_y, time),'ro')
plot(interp1(Time, r2_x, time),interp1(Time, r2_y, time),'go')
plot(interp1(Time, r3_x, time),interp1(Time, r3_y, time),'bo')

xlabel('X (Meters)');
ylabel('Y (Meters)');
axis square
%hold off


end

