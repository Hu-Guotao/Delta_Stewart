function [theta, valid] = delta(x, y, z)
% deltaIK  Delta机器人逆运动学
%
% 输入:
%   x, y, z    动平台中心位置 [mm]
%
% 输出:
%   theta      [theta1; theta2; theta3] [deg]
%   valid      1 = 三个支链均存在有效解
%              0 = 目标点不可达或超出当前关节范围
%
% 机器人参数:
%   L1 = 200 mm   主动臂长度
%   L2 = 380 mm   从动臂长度
%   R  = 180 mm   固定平台铰点半径
%   r  = 80  mm   动平台铰点半径
%
% 坐标系:
%   固定平台中心为原点
%   工作空间位于 z < 0
%
% 角度定义:
%   theta = 0 deg : 主动臂水平向外
%   theta > 0 deg : 主动臂向下转动
%
% 支链方位:
%   phi1 =   0 deg
%   phi2 = 120 deg
%   phi3 = 240 deg

% 1. 机器人结构参数

L1 = 200.0;
L2 = 380.0;

R = 180.0;
r = 80.0;

% 固定平台和动平台对应铰点的径向差
d = R - r;


% 2. 三个支链方位角

phi = [0.0, 2*pi/3, 4*pi/3];


% 3. 初始化


theta = zeros(3,1);

validJoint = false(3,1);


% 4. 分别计算三个主动关节角


for i = 1:3

    [theta(i), validJoint(i)] = ...
        calcTheta(x, y, z, phi(i), L1, L2, d);

end


% 5. 判断整体逆运动学是否有效

valid = all(validJoint);

end


% 单支链逆运动学


function [theta, valid] = calcTheta(x, y, z, phi, L1, L2, d)

theta = NaN;
valid = false;


% 1. 将末端位置转换到当前支链局部坐标


% 径向分量
q = x*cos(phi) + y*sin(phi);

% 切向分量
s = -x*sin(phi) + y*cos(phi);


% 2. 径向几何参数

a = q - d;


K = (a^2 + s^2 + z^2 + L1^2 - L2^2) ...
    /(2*L1);


% 4. 转换成标准三角方程


rho = sqrt(a^2 + z^2);

if rho < 1e-12
    return
end

c = K/rho;


% 5. 判断是否存在实数解

tol = 1e-10;

if c > 1 + tol || c < -1 - tol
    return
end

% 浮点误差保护
c = min(max(c,-1),1);


% 6. 求两个数学解
%
% rho*cos(theta-delta) = K
%
% delta = atan2(-z,a)

delta = atan2(-z,a);

gamma = acos(c);

th1 = delta + gamma;
th2 = delta - gamma;


% 7. 归一化到 [-pi,pi]


th1 = atan2(sin(th1),cos(th1));
th2 = atan2(sin(th2),cos(th2));


% 8. 当前机器人的关节范围
%
% 根据目前的几何约定暂定：
%
% 0 <= theta <= 90 deg
%
% 如果以后实际机械结构允许负角度或 >90 deg，
% 在这里修改。

thetaMin = 0;
thetaMax = pi/2;

valid1 = th1 >= thetaMin && th1 <= thetaMax;
valid2 = th2 >= thetaMin && th2 <= thetaMax;


% 9. 选择正常装配构型

if valid1 && ~valid2

    thetaRad = th1;

elseif valid2 && ~valid1

    thetaRad = th2;

elseif valid1 && valid2


    if abs(th1) <= abs(th2)
        thetaRad = th1;
    else
        thetaRad = th2;
    end

else

    return

end

% 10. rad -> deg

theta = rad2deg(thetaRad);

valid = true;

end