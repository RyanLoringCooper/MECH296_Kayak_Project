function [ out ] = clust_to_global( u )
%CLUST_TO_GLOBAL Rotates from cluster frame to global frame


v = [u(1), u(2)]';
theta_c = u(4);


Rgc = [cos(theta_c), -sin(theta_c);
       sin(theta_c), cos(theta_c)];
   
vg = Rgc*v;
out = [vg; u(3)];

end

