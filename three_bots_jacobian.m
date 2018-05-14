function Output = three_bots_jacobian(u)
%This function computes the cluster velocities based on robots
%velocities.
%arguments:     u = [x1_dot y1_dot theta_1_dot x2_dot y2_dot theta_2_dot x3_dot y3_dot theta_3_dot x1 y1 theta_1 x2 y2 theta_2 x3 y3 theta_3]
%output:     output = [xc_dot yc_dot theta_c_dot phi_1_dot phi_2_dot phi_3_dot p_dot q_dot beta_dot]

%Initialize variables
x1_dot  = u(1);
y1_dot  = u(2);
theta_1_dot  = u(3);
x2_dot  = u(4);
y2_dot  = u(5);
theta_2_dot  = u(6);
x3_dot  = u(7);
y3_dot  = u(8);
theta_3_dot  = u(9);

x1  = u(10);
y1  = u(11);
%theta_1 = u(12);
x2  = u(13);
y2  = u(14);
%theta_2 = u(15);
x3  = u(16);
y3 = u(17);
%theta_3 = u(18);

v_robots=[x1_dot; y1_dot; theta_1_dot; x2_dot; y2_dot; theta_2_dot; x3_dot; y3_dot; theta_3_dot];

x_robots=[x1; y1; x2; y2; x3; y3];
   
J = three_bots_centroid_jacobian_matrix_beta_atan(x_robots); 

Output = J * v_robots;

