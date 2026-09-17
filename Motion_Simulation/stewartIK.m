function L = stewartIK(pos, angle, B, P)
% ==========================================
% Stewart Platform Inverse Kinematics
%
% pos   = [x y z]       mm
% angle = [roll pitch yaw] rad
%
% B = 3x6 base joint coordinates, mm
% P = 3x6 moving-platform joint coordinates, mm
%
% Output:
% L = 6x1 actuator lengths, mm
% ==========================================

x = pos(1);
y = pos(2);
z = pos(3);

roll  = angle(1);
pitch = angle(2);
yaw   = angle(3);

%% Rotation matrices

Rx = [1 0 0;
      0 cos(roll) -sin(roll);
      0 sin(roll)  cos(roll)];

Ry = [ cos(pitch) 0 sin(pitch);
       0          1 0;
      -sin(pitch) 0 cos(pitch)];

Rz = [cos(yaw) -sin(yaw) 0;
      sin(yaw)  cos(yaw) 0;
      0         0        1];

R = Rz*Ry*Rx;

%% Platform center

T = [x;y;z];

%% Six actuator lengths

L = zeros(6,1);

for i = 1:6

    Pw = T + R*P(:,i);

    leg = Pw - B(:,i);

    L(i) = norm(leg);

end

end