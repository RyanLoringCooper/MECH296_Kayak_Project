function robot_vel_cmd = cluster_to_robot_vel( u )
	% jacobian is 9x9 matrix computed from theta, p, q, and beta
	J = inverse_jacobian( u(10:13) );
	robot_vel_cmd = J*u(1:9);
end
