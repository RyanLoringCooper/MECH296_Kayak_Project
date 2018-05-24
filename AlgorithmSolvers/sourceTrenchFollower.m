function g1_unit = sourceTrenchFollower(r1_pos, r2_pos, r3_pos, sensorResponses)
    clusterVars = fwd_kin([r1_pos; r2_pos; r3_pos]); % TODO verify this
    vectorMagnitudes = [getMagnitude(sensorResponses(1,:)), getMagnitude(sensorResponses(2,:)), getMagnitude(sensorResponses(3,:))];
    
    % this is in the cluster frame
    centeringContributionCluster = zeros(2,1);
    if vectorMagnitudes(2) < vectorMagnitudes(3)
        %centeringContributionCluster = [0; -1];
        centeringContributionCluster = [0; vectorMagnitudes(2)-vectorMagnitudes(3)];
    else
        %centeringContributionCluster = [0; 1];
        centeringContributionCluster = [0; vectorMagnitudes(2)-vectorMagnitudes(3)];
    end
    RclustToGlob = [cos(clusterVars(3)), -sin(clusterVars(3));
            sin(clusterVars(3)), cos(clusterVars(3))];
    centringContribution = RclustToGlob*centeringContributionCluster;
        
    rotatingContribution = zeros(2,1);
    totalRes = vectorResponse(1,:)+vectorResponse(2,:)+vectorResponse(3,:);
    rotatingContribution = totalRes/norm(totalRes);
    
    R1 = [r1_pos(1); r1_pos(2); vectorMagnitudes(1)];
    R2 = [r2_pos(1); r2_pos(2); vectorMagnitudes(2)];
    R3 = [r3_pos(1); r3_pos(2); vectorMagnitudes(3)];
    %Gradient calc for gradient descent
    grad = grad_calc(R1, R2, R3);
    
    g1 = grad+centeringContribution+rotatingContribution;
    g1_unit = g1/norm(g1);
end