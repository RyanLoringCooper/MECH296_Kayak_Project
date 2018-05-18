function ClusterStateSpaceVector = maxResponseFinder(RobotStateSpaceVector, fieldGenerator)
    r1_pos = RobotStateSpaceVector(1:3);
    r2_pos = RobotStateSpaceVector(4:6);
    r3_pos = RobotStateSpaceVector(7:9);
    
    vectorResponses = [feval(fieldGenerator, r1_pos(1), r1_pos(2)); feval(fieldGenerator, r2_pos(1), r2_pos(2)); feval(fieldGenerator, r3_pos(1), r3_pos(2))];
    vectorMagnitudes = [getMagnitude(vectorResponses(1,:)), getMagnitude(vectorResponses(2,:)), getMagnitude(vectorResponses(3,:))];
    
    R1 = [r1_pos(1); r1_pos(2); vectorMagnitudes(1)];
    R2 = [r2_pos(1); r2_pos(2); vectorMagnitudes(2)];
    R3 = [r3_pos(1); r3_pos(2); vectorMagnitudes(3)];
    
    %Gradient calcs 
    g1 = -grad_calc(R1, R2, R3);
    g1_unit = g1/norm(g1);
    
    rVars = [r1_pos, r2_pos, r3_pos]; % verify this
    clusterVars = fwd_kin(rVars);
    clusterTheta = clusterVars(3);

    %Rotation matrix from global frame to cluster frame.
%      Rcg = [cos(clusterTheta), sin(clusterTheta), 0; 
%             -sin(clusterTheta), cos(clusterTheta), 0;
%             0, 0, 1];
    des_theta = 0;
    des_theta = atan2(g1_unit(2), g1_unit(1));
    thetac_dot = 0;
    thetac_dot = double(des_theta)-double(clusterTheta);
    p_dot = 0; %Can be used to change the size of the cluster
    q_dot = 0;
    beta_dot = 0;
%     if isClusterHolonomic
%        yc_dot = sin(des_theta);
%        xc_dot = cos(des_theta);
%     else
       yc_dot = 0;
       xc_dot = 1; % makes the command non holonomic
%     end

    Rgc = [cos(clusterTheta), -sin(clusterTheta);
            sin(clusterTheta), cos(clusterTheta)];
       
    %Transformation into global frame
    vg_dot = Rgc*([xc_dot yc_dot]');
    xg_dot = vg_dot(1);
    yg_dot = vg_dot(2);
    
    ClusterStateSpaceVector = zeros(26,1);
    ClusterStateSpaceVector = [
        xg_dot;                                 %1
        yg_dot;                                 %2
        thetac_dot;                             %3
        p_dot;                                  %4
        q_dot;                                  %5
        beta_dot;                               %6
        r1_pos(1);                  %R1x        %7
        r1_pos(2);                  %R1y        %8
        r1_pos(3);                  %phi1       %9
        r2_pos(1);                  %R2x        %10
        r2_pos(2);                  %R2y        %11
        r2_pos(3);                  %phi2       %12
        r3_pos(1);                  %R3x        %13
        r3_pos(2);                  %R3y        %14
        r3_pos(3);                  %phi3       %15
        clusterVars(1);             %xc         %16
        clusterVars(2);             %yc         %17
        clusterVars(3);             %theta_c    %18
        clusterVars(4);             %p          %19
        clusterVars(5);             %q          %20
        clusterVars(6);             %beta       %21
        RobotStateSpaceVector(12);  %phi1_dot   %22
        RobotStateSpaceVector(15);  %phi2_dot   %23
        RobotStateSpaceVector(18);  %phi3_dot   %24
        xc_dot;                                 %25
        yc_dot;                                 %26
        ];
end