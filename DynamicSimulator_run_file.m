clear; clc;


sim('DynamicSimulator');

path_resolution = 10;
fieldGenerator = 'doubleSource'; %this must match the corresponding fieldGenerator box in DynamicSimulator.slx
width = 80;
vector_field_resolution = 1;

%plot_path(ClusterStateSpaceTimeSeries, path_resolution, width, fieldGenerator, vector_field_resolution);


plot_contour_frame(ClusterStateSpaceTimeSeries, path_resolution, width, fieldGenerator, vector_field_resolution)
