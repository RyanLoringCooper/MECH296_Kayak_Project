function [g1_unit, desiredThetac, useG1AsGlobalVel] = FastestFlowFinder(r1_pos, r2_pos, r3_pos, sensorResponses, thetac)
    useG1AsGlobalVel = 1;
    % vector representing the way the cluster 
    clusterVec = r2_pos-r3_pos;
    % rotate clusterVec by 90 degrees to get orthoVec=[0,-1;1,0]clusterVec
    % this is the direction that the cluster is facing
    orthoVec = [-clusterVec(2); clusterVec(1)];
    
    % use these responses to move r1 so that it has the greatest response
    % and r2 and r3 have about the same response (straddeling the saddel)
    totalRes = sensorResponses(1,:)+sensorResponses(2,:)+sensorResponses(3,:);
    % cluster should move so that the angle between the vector field's
    % direction and the cluster direction is zero
    desiredThetac = atan2(totalRes(2), totalRes(1));
    
    vectorMagnitudes = [getMagnitude(sensorResponses(1,:)), getMagnitude(sensorResponses(2,:)), getMagnitude(sensorResponses(3,:))];
    R1 = [r1_pos(1); r1_pos(2); vectorMagnitudes(1)];
    R2 = [r2_pos(1); r2_pos(2); vectorMagnitudes(2)];
    R3 = [r3_pos(1); r3_pos(2); vectorMagnitudes(3)]; 
    %Gradient calcs 
    g1 = -grad_calc(R1, R2, R3);
    g1_unit = g1/norm(g1);

end