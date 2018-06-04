function [g1_unit, desiredThetac, useG1AsGlobalVel] = doubleSourceTrenchAscender(r1_pos, r2_pos, r3_pos, sensorResponses, thetac)
    useG1AsGlobalVel = 1; %true
    clusterVars = fwd_kin([r1_pos; r2_pos; r3_pos]);
    vectorMagnitudes = [getMagnitude(sensorResponses(1,:)), getMagnitude(sensorResponses(2,:)), getMagnitude(sensorResponses(3,:))];
    
    %% this is in the cluster frame, this vector aims to find the direction
    % the cluster should move so that robot 1 is on top of a trench
    %TODO this may have special cases for robot positions relative to the trench
    centeringGain = 1;
    centeringContributionCluster = [0; vectorMagnitudes(2)-vectorMagnitudes(3); 0];
    if abs(centeringContributionCluster(2)) > 1 
        centeringContributionCluster = centeringContributionCluster/norm(centeringContributionCluster);
    end
    RclustToGlob = [cos(clusterVars(3)), -sin(clusterVars(3)), 0;
                    sin(clusterVars(3)), cos(clusterVars(3)), 0;
                    0,0,1];
    centeringContribution = RclustToGlob*centeringContributionCluster*centeringGain;
    
   
    %% this is for the gradient
    R1 = [r1_pos(1); r1_pos(2); vectorMagnitudes(1)];
    R2 = [r2_pos(1); r2_pos(2); vectorMagnitudes(2)];
    R3 = [r3_pos(1); r3_pos(2); vectorMagnitudes(3)];
    %Gradient calc for gradient descent
    grad = grad_calc(R1, R2, R3);
    grad = grad/norm(grad);
 
    g1 = grad+centeringContribution;
    g1_unit = g1/norm(g1);
    
    %% determine desiredThetac as this controller works on a non holonomic cluster 
    % cluster so that it is perpendicular to the trench   
    totalRes = -1*(sensorResponses(1,:)+sensorResponses(2,:)+sensorResponses(3,:));
    totalRes = totalRes';
    totalRes = [totalRes; 0];
    desiredThetac = atan2(totalRes(2), totalRes(1));
    
end