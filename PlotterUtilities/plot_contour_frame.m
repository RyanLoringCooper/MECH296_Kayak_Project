function [ ] = plot_contour_frame(cluster_space_time_series, resolution, width, fieldGenerator, plotRes)
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
figure1 = figure;
contour(x,y,Z,40)
colorbar
hold on;

r1Plots = [interp1(Time, r1_x, time);interp1(Time, r1_y, time)];
r2Plots = [interp1(Time, r2_x, time);interp1(Time, r2_y, time)];
r3Plots = [interp1(Time, r3_x, time);interp1(Time, r3_y, time)];
plot(r1Plots(1,:),r1Plots(2,:),'ro')
plot(r2Plots(1,:),r2Plots(2,:),'go')
plot(r3Plots(1,:),r3Plots(2,:),'bo')

figure2 = figure;
contour3(x,y,Z,60);
colorbar
hold on

r1Plots = [interp1(Time, r1_x, time);interp1(Time, r1_y, time)];
r2Plots = [interp1(Time, r2_x, time);interp1(Time, r2_y, time)];
r3Plots = [interp1(Time, r3_x, time);interp1(Time, r3_y, time)];
%plot(interp1(data.Time, data.Data(:,10), time),interp1(data.Time, data.Data(:,9), time),'kx')
plot(r1Plots(1,:),r1Plots(2,:),'ro')
plot(r2Plots(1,:),r2Plots(2,:),'go')
plot(r3Plots(1,:),r3Plots(2,:),'bo')

%plot(data.Data(:,9),data.Data(:,10),'kx')
%plot(data.Data(:,13),data.Data(:,14),'ro')
%plot(data.Data(:,15),data.Data(:,16),'go')
%plot(data.Data(:,17),data.Data(:,18),'bo')
%plot(interp1(data.Time, data.Data(:,9), time),interp1(data.Time, data.Data(:,10), time),'kx')
%plot(interp1(data.Time, data.Data(:,13), time),interp1(data.Time, data.Data(:,14), time),'ro')
%plot(interp1(data.Time, data.Data(:,15), time),interp1(data.Time, data.Data(:,16), time),'go')
%plot(interp1(data.Time, data.Data(:,17), time),interp1(data.Time, data.Data(:,18), time),'bo')

% xc = interp1(data.Time, data.Data(:,9), time) - interp1(data.Time, data.Data(:,6), time).*time;
% yc = interp1(data.Time, data.Data(:,10), time) - interp1(data.Time, data.Data(:,5), time).*time;
% plot(yc, xc, 'kx');

% plot(interp1(data.Time, data.Data(:,14), time)- interp1(data.Time, data.Data(:,5), time).*time,interp1(data.Time, data.Data(:,13),time) - interp1(data.Time, data.Data(:,6), time).*time,'Marker','o','Color',color, 'LineStyle', 'none')
% plot(interp1(data.Time, data.Data(:,16), time)- interp1(data.Time, data.Data(:,5), time).*time,interp1(data.Time, data.Data(:,15),time) - interp1(data.Time, data.Data(:,6), time).*time,'Marker','o','Color',color, 'LineStyle', 'none')
% plot(interp1(data.Time, data.Data(:,18), time)- interp1(data.Time, data.Data(:,5), time).*time,interp1(data.Time, data.Data(:,17),time) - interp1(data.Time, data.Data(:,6), time).*time,'Marker','o','Color',color, 'LineStyle', 'none')

% plot(interp1(data.Time, data.Data(:,14), time(1:250))- interp1(data.Time, data.Data(:,5), time(1:250)).*time(1:250),interp1(data.Time, data.Data(:,13),time(1:250)) - interp1(data.Time, data.Data(:,6), time(1:250)).*time(1:250),'Marker','o','Color',color, 'LineStyle', 'none')
% plot(interp1(data.Time, data.Data(:,16), time(1:250))- interp1(data.Time, data.Data(:,5), time(1:250)).*time(1:250),interp1(data.Time, data.Data(:,15),time(1:250)) - interp1(data.Time, data.Data(:,6), time(1:250)).*time(1:250),'Marker','o','Color',color, 'LineStyle', 'none')
% plot(interp1(data.Time, data.Data(:,18), time(1:250))- interp1(data.Time, data.Data(:,5), time(1:250)).*time(1:250),interp1(data.Time, data.Data(:,17),time(1:250)) - interp1(data.Time, data.Data(:,6), time(1:250)).*time(1:250),'Marker','o','Color',color, 'LineStyle', 'none')


xlabel('Y');
ylabel('X');
axis square
hold off


end

