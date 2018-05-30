function [g1_unit, thetac] = directionFollower(r1_pos, r2_pos, r3_pos, sensorResponses, thetac)
    grad = sensorResponses(1,:)+sensorResponses(2,:)+sensorResponses(3,:);
    g1_unit = grad/norm(grad);
end