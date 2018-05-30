function [g1_unit, thetac] = oppositeFollower(r1_pos, r2_pos, r3_pos, sensorResponses, thetac)
    grad = -1*(sensorResponses(1,:)+sensorResponses(2,:)+sensorResponses(3,:));
    g1_unit = grad/norm(grad);
end