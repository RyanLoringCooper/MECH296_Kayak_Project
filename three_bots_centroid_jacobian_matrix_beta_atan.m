function Output = three_bots_centroid_jacobian_matrix_beta_atan(u)
%This function computes the cluster velocities based on robots
%velocities.
%arguments:     u = [x1 y1 x2 y2 x3 y3 ]
%output:     output = [J]

%Initialize variables
x1  = u(1);
y1  = u(2);
x2  = u(3);
y2  = u(4);
x3  = u(5);
y3 = u(6);

J = (2/3)*x1-(x2+x3)/3;
K = (2/3)*y1-(y2+y3)/3;
M = J^2+K^2;

R = (x1-x2)^2+(y1-y2)^2;
S = (x3-x1)^2+(y1-y3)^2;



J    =[[1/3                 0                   0           1/3                     0                   0           1/3                 0                   0];
       [0                   1/3                 0           0                       1/3                 0           0                   1/3                 0];
       [(2/3)*K/M           -(2/3)*J/M          0           -(1/3)*K/M              (1/3)*J/M           0           -(1/3)*K/M          (1/3)*J/M           0];
       [(2/3)*K/M           -(2/3)*J/M          1           -(1/3)*K/M              (1/3)*J/M           0           -(1/3)*K/M          (1/3)*J/M           0];
       [(2/3)*K/M           -(2/3)*J/M          0           -(1/3)*K/M              (1/3)*J/M           1           -(1/3)*K/M          (1/3)*J/M           0];
       [(2/3)*K/M           -(2/3)*J/M          0           -(1/3)*K/M              (1/3)*J/M           0           -(1/3)*K/M          (1/3)*J/M           1];
       [(x1-x2)/sqrt(R)     (y1-y2)/sqrt(R)     0           -(x1-x2)/sqrt(R)        -(y1-y2)/sqrt(R)    0           0                   0                   0];
       [-(x3-x1)/sqrt(S)    (y1-y3)/sqrt(S)     0           0                       0                   0           (x3-x1)/sqrt(S)     -(y1-y3)/sqrt(S)    0];
       [ -(-2*x3*y2*x1+x1^2*y2+y2^2*y1-y2*y1^2-y2^2*y3-y3*x1^2+y3*y1^2+y3^2*y2-y3^2*y1+x3^2*y2-x3^2*y1+y1*x2^2-y3*x2^2+2*y3*x2*x1+2*x3*y1*x1-2*x1*y1*x2)/(y2^2-2*y2*y1+y1^2+x2^2-2*x2*x1+x1^2)/(x1^2+y1^2-2*x3*x1+x3^2-2*y3*y1+y3^2)        (-y2^2*x3-x3*x2^2-x2*x1^2+x1*x2^2-x3*y1^2-x3^2*x1+x3^2*x2+x3*x1^2-2*y2*y1*x1+x1*y2^2+y3^2*x2+2*y3*y1*x1-y3^2*x1+y1^2*x2-2*y3*y1*x2+2*x3*y2*y1)/(y2^2-2*y2*y1+y1^2+x2^2-2*x2*x1+x1^2)/(x1^2+y1^2-2*x3*x1+x3^2-2*y3*y1+y3^2)      0       -(-y2+y1)/(y2^2-2*y2*y1+y1^2+x2^2-2*x2*x1+x1^2)     (-x2+x1)/(y2^2-2*y2*y1+y1^2+x2^2-2*x2*x1+x1^2)      0       (y1-y3)/(x1^2+y1^2-2*x3*x1+x3^2-2*y3*y1+y3^2)       -(x1-x3)/(x1^2+y1^2-2*x3*x1+x3^2-2*y3*y1+y3^2)      0]
       ];
   
 
Output = J;
