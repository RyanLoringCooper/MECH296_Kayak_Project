function Vr = inverse_jacobian( ClusterStateSpaceVector )
%INVERSE_JACOBIAN Returns the inverse jacobian
%   This is for a three bot p,q,beta cluster, in aero frame

theta_c = ClusterStateSpaceVector(18);
p = ClusterStateSpaceVector(19);
q = ClusterStateSpaceVector(20);
beta1 = ClusterStateSpaceVector(21);

inv_Jac = [ 1, 0, -(sin(theta_c)*(p^2 + 2*cos(beta1)*p*q + q^2)^(1/2))/3, (cos(theta_c)*(2*p + 2*q*cos(beta1)))/(6*(p^2 + 2*cos(beta1)*p*q + q^2)^(1/2)), (cos(theta_c)*(2*q + 2*p*cos(beta1)))/(6*(p^2 + 2*cos(beta1)*p*q + q^2)^(1/2)), -(p*q*sin(beta1)*cos(theta_c))/(3*(p^2 + 2*cos(beta1)*p*q + q^2)^(1/2)), 0, 0, 0;
 0, 1,  (cos(theta_c)*(p^2 + 2*cos(beta1)*p*q + q^2)^(1/2))/3, (sin(theta_c)*(2*p + 2*q*cos(beta1)))/(6*(p^2 + 2*cos(beta1)*p*q + q^2)^(1/2)), (sin(theta_c)*(2*q + 2*p*cos(beta1)))/(6*(p^2 + 2*cos(beta1)*p*q + q^2)^(1/2)), -(p*q*sin(beta1)*sin(theta_c))/(3*(p^2 + 2*cos(beta1)*p*q + q^2)^(1/2)), 0, 0, 0;
 0, 0, 1, 0, 0, 0, 1, 0, 0;
 1, 0, p*cos(theta_c)*(-(q^2*(cos(beta1)^2 - 1))/(p^2 + 2*cos(beta1)*p*q + q^2))^(1/2) + (sin(theta_c)*(2*p^2 + cos(beta1)*p*q - q^2))/(3*(p^2 + 2*cos(beta1)*p*q + q^2)^(1/2)),   sin(theta_c)*(-(q^2*(cos(beta1)^2 - 1))/(p^2 + 2*cos(beta1)*p*q + q^2))^(1/2) - (cos(theta_c)*(5*p*q^2 + 2*p^3 + 2*q^3*cos(beta1) + 6*p^2*q*cos(beta1) + p*q^2*cos(beta1)^2))/(3*(p^2 + 2*cos(beta1)*p*q + q^2)^(3/2)) + (p*q^2*sin(theta_c)*(p + q*cos(beta1))*(cos(beta1)^2 - 1))/((p^2 + 2*cos(beta1)*p*q + q^2)^2*(-(q^2*(cos(beta1)^2 - 1))/(p^2 + 2*cos(beta1)*p*q + q^2))^(1/2)), (cos(theta_c)*(4*p^2*q + q^3 + p^3*cos(beta1) + 3*p*q^2*cos(beta1) - p^2*q*cos(beta1)^2))/(3*(p^2 + 2*cos(beta1)*p*q + q^2)^(3/2)) - (p^2*q*sin(theta_c)*(p + q*cos(beta1))*(cos(beta1)^2 - 1))/((p^2 + 2*cos(beta1)*p*q + q^2)^2*(-(q^2*(cos(beta1)^2 - 1))/(p^2 + 2*cos(beta1)*p*q + q^2))^(1/2)), (p*q*sin(beta1)*cos(theta_c)*(- p^2 + cos(beta1)*p*q + 2*q^2))/(3*(p^2 + 2*cos(beta1)*p*q + q^2)^(3/2)) + (p*q^2*sin(beta1)*sin(theta_c)*(p^2*cos(beta1) + p*q*cos(beta1)^2 + p*q + q^2*cos(beta1)))/((p^2 + 2*cos(beta1)*p*q + q^2)^2*(-(q^2*(cos(beta1)^2 - 1))/(p^2 + 2*cos(beta1)*p*q + q^2))^(1/2)), 0, 0, 0;
 0, 1, p*sin(theta_c)*(-(q^2*(cos(beta1)^2 - 1))/(p^2 + 2*cos(beta1)*p*q + q^2))^(1/2) - (cos(theta_c)*(2*p^2 + cos(beta1)*p*q - q^2))/(3*(p^2 + 2*cos(beta1)*p*q + q^2)^(1/2)), - cos(theta_c)*(-(q^2*(cos(beta1)^2 - 1))/(p^2 + 2*cos(beta1)*p*q + q^2))^(1/2) - (sin(theta_c)*(5*p*q^2 + 2*p^3 + 2*q^3*cos(beta1) + 6*p^2*q*cos(beta1) + p*q^2*cos(beta1)^2))/(3*(p^2 + 2*cos(beta1)*p*q + q^2)^(3/2)) - (p*q^2*cos(theta_c)*(p + q*cos(beta1))*(cos(beta1)^2 - 1))/((p^2 + 2*cos(beta1)*p*q + q^2)^2*(-(q^2*(cos(beta1)^2 - 1))/(p^2 + 2*cos(beta1)*p*q + q^2))^(1/2)), (sin(theta_c)*(4*p^2*q + q^3 + p^3*cos(beta1) + 3*p*q^2*cos(beta1) - p^2*q*cos(beta1)^2))/(3*(p^2 + 2*cos(beta1)*p*q + q^2)^(3/2)) + (p^2*q*cos(theta_c)*(p + q*cos(beta1))*(cos(beta1)^2 - 1))/((p^2 + 2*cos(beta1)*p*q + q^2)^2*(-(q^2*(cos(beta1)^2 - 1))/(p^2 + 2*cos(beta1)*p*q + q^2))^(1/2)), (p*q*sin(beta1)*sin(theta_c)*(- p^2 + cos(beta1)*p*q + 2*q^2))/(3*(p^2 + 2*cos(beta1)*p*q + q^2)^(3/2)) - (p*q^2*sin(beta1)*cos(theta_c)*(p^2*cos(beta1) + p*q*cos(beta1)^2 + p*q + q^2*cos(beta1)))/((p^2 + 2*cos(beta1)*p*q + q^2)^2*(-(q^2*(cos(beta1)^2 - 1))/(p^2 + 2*cos(beta1)*p*q + q^2))^(1/2)), 0, 0, 0;
 0, 0, 1, 0, 0, 0, 0, 1, 0;
 1, 0, (sin(theta_c)*(- p^2 + cos(beta1)*p*q + 2*q^2))/(3*(p^2 + 2*cos(beta1)*p*q + q^2)^(1/2)) - q*cos(theta_c)*(-(p^2*(cos(beta1)^2 - 1))/(p^2 + 2*cos(beta1)*p*q + q^2))^(1/2),                                                                                       (cos(theta_c)*(4*p*q^2 + p^3 + q^3*cos(beta1) + 3*p^2*q*cos(beta1) - p*q^2*cos(beta1)^2))/(3*(p^2 + 2*cos(beta1)*p*q + q^2)^(3/2)) + (p*q^2*sin(theta_c)*(q + p*cos(beta1))*(cos(beta1)^2 - 1))/((p^2 + 2*cos(beta1)*p*q + q^2)^2*(-(p^2*(cos(beta1)^2 - 1))/(p^2 + 2*cos(beta1)*p*q + q^2))^(1/2)), - sin(theta_c)*(-(p^2*(cos(beta1)^2 - 1))/(p^2 + 2*cos(beta1)*p*q + q^2))^(1/2) - (cos(theta_c)*(5*p^2*q + 2*q^3 + 2*p^3*cos(beta1) + 6*p*q^2*cos(beta1) + p^2*q*cos(beta1)^2))/(3*(p^2 + 2*cos(beta1)*p*q + q^2)^(3/2)) - (p^2*q*sin(theta_c)*(q + p*cos(beta1))*(cos(beta1)^2 - 1))/((p^2 + 2*cos(beta1)*p*q + q^2)^2*(-(p^2*(cos(beta1)^2 - 1))/(p^2 + 2*cos(beta1)*p*q + q^2))^(1/2)),   (p*q*sin(beta1)*cos(theta_c)*(2*p^2 + cos(beta1)*p*q - q^2))/(3*(p^2 + 2*cos(beta1)*p*q + q^2)^(3/2)) - (p^2*q*sin(beta1)*sin(theta_c)*(p^2*cos(beta1) + p*q*cos(beta1)^2 + p*q + q^2*cos(beta1)))/((p^2 + 2*cos(beta1)*p*q + q^2)^2*(-(p^2*(cos(beta1)^2 - 1))/(p^2 + 2*cos(beta1)*p*q + q^2))^(1/2)), 0, 0, 0;
 0, 1, - q*sin(theta_c)*(-(p^2*(cos(beta1)^2 - 1))/(p^2 + 2*cos(beta1)*p*q + q^2))^(1/2) - (cos(theta_c)*(- p^2 + cos(beta1)*p*q + 2*q^2))/(3*(p^2 + 2*cos(beta1)*p*q + q^2)^(1/2)), (sin(theta_c)*(4*p*q^2 + p^3 + q^3*cos(beta1) + 3*p^2*q*cos(beta1) - p*q^2*cos(beta1)^2))/(3*(p^2 + 2*cos(beta1)*p*q + q^2)^(3/2)) - (p*q^2*cos(theta_c)*(q + p*cos(beta1))*(cos(beta1)^2 - 1))/((p^2 + 2*cos(beta1)*p*q + q^2)^2*(-(p^2*(cos(beta1)^2 - 1))/(p^2 + 2*cos(beta1)*p*q + q^2))^(1/2)),   cos(theta_c)*(-(p^2*(cos(beta1)^2 - 1))/(p^2 + 2*cos(beta1)*p*q + q^2))^(1/2) - (sin(theta_c)*(5*p^2*q + 2*q^3 + 2*p^3*cos(beta1) + 6*p*q^2*cos(beta1) + p^2*q*cos(beta1)^2))/(3*(p^2 + 2*cos(beta1)*p*q + q^2)^(3/2)) + (p^2*q*cos(theta_c)*(q + p*cos(beta1))*(cos(beta1)^2 - 1))/((p^2 + 2*cos(beta1)*p*q + q^2)^2*(-(p^2*(cos(beta1)^2 - 1))/(p^2 + 2*cos(beta1)*p*q + q^2))^(1/2)),   (p*q*sin(beta1)*sin(theta_c)*(2*p^2 + cos(beta1)*p*q - q^2))/(3*(p^2 + 2*cos(beta1)*p*q + q^2)^(3/2)) + (p^2*q*sin(beta1)*cos(theta_c)*(p^2*cos(beta1) + p*q*cos(beta1)^2 + p*q + q^2*cos(beta1)))/((p^2 + 2*cos(beta1)*p*q + q^2)^2*(-(p^2*(cos(beta1)^2 - 1))/(p^2 + 2*cos(beta1)*p*q + q^2))^(1/2)), 0, 0, 0;
 0, 0, 1, 0, 0, 0, 0, 0, 1];
%Vc = [xc_dot; yc_dot; theta_c_dot; p_dot; q_dot; beta_dot; phi1_dot; phi2_dot; phi3_dot];
Vc = [ ClusterStateSpaceVector(25); % xc_dot        %1
       ClusterStateSpaceVector(26); % yc_dot        %2
       ClusterStateSpaceVector(3);  % thetac_dot    %3
       ClusterStateSpaceVector(4);  % p_dot         %4
       ClusterStateSpaceVector(5);  % beta_dot      %5
       ClusterStateSpaceVector(6);  % q_dot         %6
       ClusterStateSpaceVector(22); % phi1_dot      %7
       ClusterStateSpaceVector(23); % phi2_dot      %8
       ClusterStateSpaceVector(24)];% phi3_dot      %9
Vr = inv_Jac*Vc;
end

