function [g1_unit, thetac] = sourceTrenchFollower(r1_pos, r2_pos, r3_pos, sensorResponses, thetac)
    clusterVars = fwd_kin([r1_pos; r2_pos; r3_pos]);
    vectorMagnitudes = [getMagnitude(sensorResponses(1,:)), getMagnitude(sensorResponses(2,:)), getMagnitude(sensorResponses(3,:))];
    
    %% this is in the cluster frame, this vector aims to find the direction
    % the cluster should move so that robot 1 is on top of a trench
    centeringContributionCluster = zeros(3,1);
    %TODO this may have special cases for robot positions relative to the trench
    centeringContributionCluster = [0; vectorMagnitudes(2)-vectorMagnitudes(3); 0];
    if abs(centeringContributionCluster(2)) > 1 
        centeringContributionCluster = centeringContributionCluster/norm(centeringContributionCluster);
    end
    RclustToGlob = [cos(clusterVars(3)), -sin(clusterVars(3)), 0;
                    sin(clusterVars(3)), cos(clusterVars(3)), 0;
                    0,0,1];
    centeringContribution = RclustToGlob*centeringContributionCluster;
    %% this is in the global frame, the vector aims to rotate a non holonomic 
    % cluster so that it is perpendicular to the trench   
    totalRes = sensorResponses(1,:)+sensorResponses(2,:)+sensorResponses(3,:);
    totalRes = totalRes';
    totalRes = [totalRes; 0];
    rotatingContribution = totalRes/norm(totalRes);
    %% this is for the gradient
    R1 = [r1_pos(1); r1_pos(2); vectorMagnitudes(1)];
    R2 = [r2_pos(1); r2_pos(2); vectorMagnitudes(2)];
    R3 = [r3_pos(1); r3_pos(2); vectorMagnitudes(3)];
    %Gradient calc for gradient descent
    grad = grad_calc(R1, R2, R3);
    grad = grad/norm(grad);
    %% turn off other contributions if the rotation contribution is in the opposite direction of the cluster
    % vector representing the way the cluster is facing
    clusterVec = r2_pos-r3_pos;
    % rotate clusterVec by 90 degrees to get orthoVec=[0,-1;1,0]clusterVec
    % this is the direction that the cluster is facing
    orthoVec = [-clusterVec(2); clusterVec(1)];
    if abs(angleBetween(rotatingContribution, orthoVec)) > pi/6
        centeringContribution = zeros(3,1);
        grad = zeros(3,1);
    end
    g1 = grad+centeringContribution+rotatingContribution;
    g1_unit = g1/norm(g1);
end