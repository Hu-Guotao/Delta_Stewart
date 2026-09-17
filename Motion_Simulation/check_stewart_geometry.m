clear
clc
close all

run('stewart_parameters.m')

%% 上平台初始世界坐标

Pw = P + T0;

%% 六根支链向量

leg = Pw - B;

%% 六根支链长度

L0 = zeros(6,1);

for i = 1:6
    L0(i) = norm(leg(:,i));
end

disp('初始六根支链长度 / mm：')
disp(L0)

%% ===============================
% 绘图
% ================================

figure
hold on
grid on
axis equal

%% 下平台圆

theta = linspace(0,2*pi,200);

plot3( ...
    R_base*cos(theta), ...
    R_base*sin(theta), ...
    zeros(size(theta)), ...
    'LineWidth',2);

%% 上平台圆

plot3( ...
    R_top*cos(theta), ...
    R_top*sin(theta), ...
    h0*ones(size(theta)), ...
    'LineWidth',2);

%% 下铰点

plot3( ...
    B(1,:), ...
    B(2,:), ...
    B(3,:), ...
    'o','MarkerSize',8,'LineWidth',2);

%% 上铰点

plot3( ...
    Pw(1,:), ...
    Pw(2,:), ...
    Pw(3,:), ...
    'o','MarkerSize',8,'LineWidth',2);

%% 六根支链

for i = 1:6

    plot3( ...
        [B(1,i), Pw(1,i)], ...
        [B(2,i), Pw(2,i)], ...
        [B(3,i), Pw(3,i)], ...
        'LineWidth',2);

    text(B(1,i),B(2,i),B(3,i), ...
        sprintf(' B%d',i));

    text(Pw(1,i),Pw(2,i),Pw(3,i), ...
        sprintf(' P%d',i));

end

xlabel('X / mm')
ylabel('Y / mm')
zlabel('Z / mm')

title('Stewart Platform - CAD Geometry')

view(35,25)