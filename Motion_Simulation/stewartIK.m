function L = stewartIK(pos, angle, B, P)
% Stewart平台逆运动学
%
% pos   = [x y z]       平台位置
% angle = [roll pitch yaw]
% B     = 3x6 固定平台铰点
% P     = 3x6 运动平台铰点
%
% 输出：
% L = 6x1 六根执行器长度

x = pos(1);
y = pos(2);
z = pos(3);

roll  = angle(1);
pitch = angle(2);
yaw   = angle(3);

% X轴旋转
Rx = [1 0 0;
      0 cos(roll) -sin(roll);
      0 sin(roll)  cos(roll)];

% Y轴旋转
Ry = [ cos(pitch) 0 sin(pitch);
       0          1 0;
      -sin(pitch) 0 cos(pitch)];

% Z轴旋转
Rz = [cos(yaw) -sin(yaw) 0;
      sin(yaw)  cos(yaw) 0;
      0         0        1];

% 总旋转矩阵
R = Rz * Ry * Rx;

T = [x;y;z];

L = zeros(6,1);

for i = 1:6

    % 上平台铰点转换到世界坐标系
    Pw = T + R * P(:,i);

    % 杆向量
    leg = Pw - B(:,i);

    % 杆长度
    L(i) = norm(leg);

end

end