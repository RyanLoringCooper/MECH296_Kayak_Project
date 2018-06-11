function RobotVars = inv_kin(clusterVars)
    %clusterVars = [
    %   xc
    %   yc
    %   thetac
    %   p
    %   q
    %   beta
    %   phi1
    %   phi2
    %   phi3
    %];
    xc = clusterVars(1);
    yc = clusterVars(2);
    thetac = clusterVars(3);
    p = clusterVars(4);
    q = clusterVars(5);
    beta = clusterVars(6);
    phi1 = clusterVars(7);
    phi2 = clusterVars(8);
    phi3 = clusterVars(9);
    Tgc = [ cos(thetac) -sin(thetac) xc; 
            sin(thetac) cos(thetac) yc;
            0 0 1];
        
    if nearBetaSingularity(beta)
        robot1Pos = [xc; yc; 1];
        robot2Pos = robot1Pos+Tgc*[0; -p; 0];
        robot3Pos = robot1Pos+Tgc*[0; q; 0];
    else 
        d = sqrt(p^2+q^2-2*p*q*cos(beta));
        m = sqrt((q^2+p^2)/2 - (d/2)^2);
        k = 2*m/3;
        gamma2 = acos((-(d/2)^2+m^2+p^2)/(2*m*p));
        gamma3 = acos((-(d/2)^2+m^2+q^2)/(2*m*q));
        
        robot1Pos = Tgc*[k; 0; 1];
        T12 = [ cos(thetac+pi+gamma2) -sin(thetac+pi+gamma2) robot1Pos(1);
                sin(thetac+pi+gamma2) cos(thetac+pi+gamma2) robot1Pos(2);
                0 0 1];
        T13 = [ cos(thetac+pi-gamma3) -sin(thetac+pi-gamma3) robot1Pos(1);
                sin(thetac+pi-gamma3) cos(thetac+pi-gamma3) robot1Pos(2);
                0 0 1];
        robot2Pos = T12*[p; 0; 1];
        robot3Pos = T13*[q; 0; 1];
    end
    theta1 = thetac+phi1;
    theta2 = thetac+phi2;
    theta3 = thetac+phi3;
    RobotVars = [
        robot1Pos(1);
        robot1Pos(2);
        theta1;
        robot2Pos(1);
        robot2Pos(2);
        theta2;
        robot3Pos(1);
        robot3Pos(2);
        theta3];
end