clear
clc
close all

run('stewart_parameters.m')

figure
hold on
grid on
axis equal

%% Base platform circle

theta = linspace(0,2*pi,200);

xb = R_base*cos(theta);
yb = R_base*sin(theta);

plot(xb,yb,'LineWidth',2)

%% Six base joints

plot(B(1,:),B(2,:),'o','MarkerSize',10,'LineWidth',2)

%% Joint labels

for i = 1:6

    text(B(1,i), ...
         B(2,i), ...
         sprintf('  B%d',i), ...
         'FontSize',12);

end

xlabel('X / m')
ylabel('Y / m')

title('Stewart Platform - Base Joint Geometry')

axis([-0.2 0.2 -0.2 0.2])