% Calls the function store in AlgToCall and handles creating the
% ClusterStateSpaceVector
function ClusterStateSpaceVector = AlgWrapper(AlgToCall, RobotStateSpaceVector, sensorResponses, isClusterHolonomic)
    %RobotStateSpaceVector = [ 
    %    R1x;       %1
    %    R1y;       %2
    %    phi1;      %3
    %    R2x;       %4
    %    R2y;       %5
    %    phi2;      %6
    %    R3x;       %7
    %    R3y;       %8
    %    phi3;      %9
    %    R1x_dot;   %10
    %    R1y_dot;   %11
    %    phi1_dot;  %12
    %    R2x_dot;   %13
    %    R2y_dot;   %14
    %    phi2_dot;  %15
    %    R3x_dot;   %16
    %    R3y_dot;   %17
    %    phi3_dot]; %18
    r1_pos = RobotStateSpaceVector(1:3);
    r2_pos = RobotStateSpaceVector(4:6);
    r3_pos = RobotStateSpaceVector(7:9);
    
    g1_unit = feval(AlgToCall, r1_pos, r2_pos, r3_pos, sensorResponses);
    
    rVars = [r1_pos, r2_pos, r3_pos]; % verify this
    clusterVars = fwd_kin(rVars);
    clusterTheta = clusterVars(3);

    %Rotation matrix from global frame to cluster frame.
    Rcg = [cos(clusterTheta), sin(clusterTheta), 0; 
           -sin(clusterTheta), cos(clusterTheta), 0;
           0, 0, 1];

    des_theta = atan2(g1_unit(2), g1_unit(1));
    thetac_dot = (des_theta - clusterTheta);

    p_dot = 0; %Can be used to change the size of the cluster
    q_dot = 0;
    beta_dot = 0;
    if isClusterHolonomic
        yc_dot = sin(des_theta);
        xc_dot = cos(des_theta);
    else
        yc_dot = 0;
        xc_dot = 1; % makes the command non holonomic
    end

    %Transformation into global frame
    vg_dot = Rgc*([xc_dot yc_dot]');
    xg_dot = vg_dot(1);
    yg_dot = vg_dot(2);
    
    ClusterStateSpaceVector = [
        xg_dot;                                 %1
        yg_dot;                                 %2
        theatc_dot;                             %3
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
    ClusterStateSpaceVector = ClusterStateSpaceVector';
end