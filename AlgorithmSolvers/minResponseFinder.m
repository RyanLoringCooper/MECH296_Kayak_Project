function [g1_unit, thetac, useG1AsGlobalVel] = minResponseFinder(r1_pos, r2_pos, r3_pos, sensorResponses, thetac)
    useG1AsGlobalVel = 0; %false
    vectorMagnitudes = [getMagnitude(sensorResponses(1,:)), getMagnitude(sensorResponses(2,:)), getMagnitude(sensorResponses(3,:))];

    R1 = [r1_pos(1); r1_pos(2); vectorMagnitudes(1)];
    R2 = [r2_pos(1); r2_pos(2); vectorMagnitudes(2)];
    R3 = [r3_pos(1); r3_pos(2); vectorMagnitudes(3)];
    
    %Gradient calcs 
    g1 = -grad_calc(R1, R2, R3);
    g1_unit = g1/norm(g1);
end