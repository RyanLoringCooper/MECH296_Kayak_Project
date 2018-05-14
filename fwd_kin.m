function [ out ] = fwd_kin( in )
%UNTITLED3 Generates cluster vars from robot vars
%   This is for a 3 bot, p, q, beta cluster with aero convention

x1 = in(1);
y1 = in(2);
theta1 = in(3);
x2 = in(4);
y2 = in(5);
theta2 = in(6);
x3 = in(7);
y3 = in(8);
theta3 = in(9);

p = sqrt((x1-x2)^2 + (y1-y2)^2);
q = sqrt((x1-x3)^2 + (y1-y3)^2);

v1 = [x2-x1, y2-y1];
v2 = [x3-x1, y3-y1];

denom = (norm(v1)*norm(v2));
if denom == 0
    denom = 1;
end
beta = acos(dot(v1,v2)/denom);

xc = (x1+x2+x3)/3;
yc = (y1+y2+y3)/3;

theta_c = atan2((y1-yc),(x1-xc));

phi1 = theta1 - theta_c;
phi2 = theta2 - theta_c;
phi3 = theta3 - theta_c;

out = [xc; yc; theta_c; p; q; beta; phi1; phi2; phi3];

end
