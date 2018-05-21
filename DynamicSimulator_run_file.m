
sim('DynamicSimulator');

path_resolution = 10;
fieldGenerator = 'source';
width = 50;
vector_field_resolution = 2;

plot_path(ClusterStateSpaceTimeSeries, path_resolution, width, fieldGenerator, vector_field_resolution);  