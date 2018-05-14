function Output = three_robot_centroid_forward_kin_v3(u)
%This function computes the cluster position based on the robot
%positions.
%arguments:     u = [x1 y1 theta1 x2 y2 theta2 x3 y3 theta3]

%Initialize variables
x1 = u(1);
y1 = u(2);
theta_1=u(3);
x2 = u(4);
y2 = u(5);
theta_2=u(6);
x3 = u(7);
y3 = u(8);
theta_3=u(9);

xc=(x1+x2+x3)/3;
yc=(y1+y2+y3)/3;

theta_c=atan2(2/3*x1-1/3*(x2+x3),2/3*y1-1/3*(y2+y3));

phi_1=theta_1+theta_c;
phi_2=theta_2+theta_c;
phi_3=theta_3+theta_c;

p=sqrt((x1-x2)^2+(y1-y2)^2);
q=sqrt((x3-x1)^2+(y1-y3)^2);

%Old Beta
%beta=acos((p^2+q^2-(x3-x2)^2-(y3-y2)^2)/(2*p*q));

%new beta using atan2:
alpha = -atan2(y2-y1,x2-x1);

beta2 = atan2(-(x1-x3)*sin(alpha)-(y1-y3)*cos(alpha),-(x1-x3)*cos(alpha)+(y1-y3)*sin(alpha));

Output = [  xc;
            yc;
            theta_c;
            phi_1;
            phi_2;
            phi_3;
            p;
            q;
            beta2
          ];
