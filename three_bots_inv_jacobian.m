function Output = three_bots_inv_jacobian(u)
%This function computes the robot velocities based on the cluster
%velocities.
%arguments:     u = [xc_dot yc_dot theta_c_dot phi_1_dot phi_2_dot phi_3_dot p_dot q_dot beta_dot xc yc theta_c phi_1 phi_2 phi_3 p q beta]
%output:     output = [J_inv]*[V_c]

%Initialize variables
xc_dot = u(1);
yc_dot = u(2);
theta_c_dot = u(3);
phi_1_dot = u(4);
phi_2_dot=u(5);
phi_3_dot=u(6);
p_dot=u(7);
q_dot=u(8);
beta_dot=u(9);

%x_c=u(10);
%y_c=u(11);
theta_c=u(12);
%phi_1=u(13);
%phi_2=u(14);
%phi_3=u(15);
p=u(16); 
q=u(17); 
beta=u(18);

v_cluster=[xc_dot; yc_dot; theta_c_dot; phi_1_dot; phi_2_dot; phi_3_dot; p_dot; q_dot; beta_dot];

J_inv = three_bots_centroid_inv_jacobian_matrix_exact([theta_c p q beta]); 

Output = J_inv * v_cluster;