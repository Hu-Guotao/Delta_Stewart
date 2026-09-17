clear
clc

%% 平台参数

Rb = 150;      % 下平台半径 mm
Rp = 100;      % 上平台半径 mm

%% 暂时建立6个均匀分布连接点
thetaB = deg2rad([0 60 120 180 240 300]);
thetaP = deg2rad([30 90 150 210 270 330]);

B = zeros(3,6);
P = zeros(3,6);

for i = 1:6

    B(:,i) = [Rb*cos(thetaB(i));
              Rb*sin(thetaB(i));
              0];

    P(:,i) = [Rp*cos(thetaP(i));
              Rp*sin(thetaP(i));
              0];

end

%% 平台目标位姿

pos = [0 0 260];          % mm

angle = deg2rad([0 0 0]); % roll pitch yaw

%% 逆运动学

L = stewartIK(pos,angle,B,P);

disp('六根杆长度：')
disp(L)