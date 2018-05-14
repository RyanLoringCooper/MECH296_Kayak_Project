function ClusterStateSpaceVector = minResponseFinder(Rpos, sensorResponses)
    % verify these
    r1_pos = Rpos(1, :);
    r2_pos = Rpos(2, :);
    r3_pos = Rpos(3, :);
    
    vectorMagnitudes = [getMagnitude(sensorResponses(1,:)), getMagnitude(sensorResponses(2,:)), getMagnitude(sensorResponses(3,:))];

    R1 = [r1_pos; vectorMagnitudes(1)];
    R2 = [r2_pos; vectorMagnitudes(2)];
    R3 = [r3_pos; vectorMagnitudes(3)];
    
    %Gradient calcs 
    g1 = grad_calc(R1, R2, R3);
    g1_unit = g1/norm(g1);

    %Rotation matrix from global frame to cluster frame.
    %TODO verify this
    Rcg = [cos(clusterTheta), sin(clusterTheta), 0; 
           -sin(clusterTheta), cos(clusterTheta), 0;
           0, 0, 1];

    des_theta = atan2(g1_unit(2), g1_unit(1));
    thetac_dot = (des_theta - clusterTheta);

    p_dot = 0; %Can be used to change the size of the cluster
    beta_dot = 0;
    q_dot = 0;
    yc_dot = 0;
    xc_dot = 1; % makes the command non holonomic

    %Transformation into global frame
    vg_dot = Rgc*([xc_dot yc_dot]');
    xg_dot = vg_dot(1);
    yg_dot = vg_dot(2);
    rVars = [r1_pos, r2_pos, r3_pos]; % verify this
    clusterVars = fwd_kin(rVars);
    
    ClusterStateSpaceVector = [
        xg_dot;                 %1
        yg_dot;                 %2
        theatc_dot;             %3
        p_dot;                  %4
        beta_dot;               %5
        q_dot;                  %6
        r1_pos(1);              %7
        r1_pos(2);              %8
        r1_pos(3);              %9
        r2_pos(1);              %10
        r2_pos(2);              %11
        r2_pos(3);              %12
        r3_pos(1);              %13
        r3_pos(2);              %14
        r3_pos(3);              %15
        clusterVars(1); %xc     %16
        clusterVars(2); %yc     %17
        clusterVars(3); %theta_c%18
        clusterVars(4); %p      %19
        clusterVars(5); %q      %20
        clusterVars(6); %beta   %21
        clusterVars(7); %phi1   %22
        clusterVars(8); %phi2   %23
        clusterVars(9); %phi3   %24
        ];
    ClusterStateSpaceVector = ClusterStateSpaceVector';
end