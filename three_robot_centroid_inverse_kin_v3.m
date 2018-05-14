function Output = three_robot_centroid_inverse_kin_v3(u)
%This function computes the robot positions based on the cluster
%position.
%arguments:     u = [xc yc theta_c phi_1 phi_2 phi_3 p q beta] 

%Initialize variables
xc = u(1);
yc = u(2);
theta_c = u(3);
phi_1 = u(4);
phi_2=u(5);
phi_3=u(6);
p=u(7);
q=u(8);
beta=u(9);

r=sqrt(p^2+q^2+2*p*q*cos(beta));

x1=xc+(1/3)*r*sin(theta_c);
y1=yc+(1/3)*r*cos(theta_c);

alpha_1=atan2((yc-y1),xc-x1);
alpha_2=atan2(q*sin(beta),q*cos(beta)+p);
alpha=alpha_2-alpha_1;


x2=x1+p*cos(alpha);
y2=y1-p*sin(alpha);


x3=x1+q*cos(beta-alpha);
y3=y1+q*sin(beta-alpha);

theta_1 = -theta_c+phi_1;
theta_2 = -theta_c+phi_2;
theta_3 = -theta_c+phi_3;

Output = [  x1;
            y1;
            theta_1;
            x2;
            y2;
            theta_2;
            x3;
            y3;
            theta_3;
          ];
