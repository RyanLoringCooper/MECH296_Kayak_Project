function [ output_args ] = plot_time(file, var )
%PLOT_TIME Plots given variable vs time
%   Data is loaded from a file generated by the particle sim. var
%   corresponds to the index of the desired variable.

load(file);


figure;
hold on
plot(data.Time,data.Data(:,var))
xlabel('Time (s)');
ylabel('Magnitude');
axis square
hold off



end

