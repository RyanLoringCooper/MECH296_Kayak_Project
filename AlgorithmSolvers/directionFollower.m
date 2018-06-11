function [g1_unit, thetac, useG1AsGlobalVel] = directionFollower(r1_pos, r2_pos, r3_pos, sensorResponses, thetac)
    useG1AsGlobalVel = 0; %false
    grad = sensorResponses(1,:)+sensorResponses(2,:)+sensorResponses(3,:);
    g1_unit = grad/norm(grad)
    g1_unit = [g1_unit'; 0];
end