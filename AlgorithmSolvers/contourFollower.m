function [g1_unit, thetac, useG1AsGlobalVel] = contourFollower(r1_pos, r2_pos, r3_pos, sensorResponses, thetac)
    useG1AsGlobalVel = 0; %false
    vectorMagnitudes = [getMagnitude(sensorResponses(1,:)), getMagnitude(sensorResponses(2,:)), getMagnitude(sensorResponses(3,:))];
    
    R1 = [r1_pos(1); r1_pos(2); vectorMagnitudes(1)];
    R2 = [r2_pos(1); r2_pos(2); vectorMagnitudes(2)];
    R3 = [r3_pos(1); r3_pos(2); vectorMagnitudes(3)];
    
    %Gradient calcs 
    g1 = -grad_calc(R1, R2, R3);
    g1_unit_tmp = g1/norm(g1);
    
    % From Robert M scalar field primitive paper
    % bcf = bgrad + d{sgn(Zdes - Zc)*min[Kct*abs(Zdes - Zc),pi/2 - (pi/2)}
    
    % Some parameters to set up
    % TODO: Need to find what is the range of value for Zdes and Kct
    Zdes = 0.48; %Desired contour level to follow. Defined it here for now.
    Kct = 60; %Some gain for the cluster to stay on the contour. 
    d =1; %Contour follower direction: d=1 is CW and d = -1 is CCW
    Zc = (R1(3)+R2(3)+R3(3))/3; 
    
    bgrad = atan2(g1_unit_tmp(2), g1_unit_tmp(1)); %Convert g1_unit to actual angle (bearing)
    bcf = bgrad + d*(sign(Zdes - Zc)*min(Kct*abs(Zdes-Zc),pi/2) - pi/2); %Calculate bearing for contour follower
    
    % convert back to unit vector so that we are consistent
    g1_unit = [cos(bcf);sin(bcf);0];
    
end