function Output = heading_error_conditioner(u)
%This function produces heading angle error conditioning so there's no jump
%at angular discontinuities
%arguments:     u = [angular_error]
%output:     output = [conditioned_angular_error]

%Initialize variables
threshold=pi;

e = u(1);
e=mod(e,2*pi);

if abs(e) > threshold
    if e<0
        e=e+2*pi;
    else
        e=e-2*pi;
    end
    
end

Output = e;
