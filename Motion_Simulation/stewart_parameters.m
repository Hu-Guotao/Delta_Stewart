%% ==========================================
% Stewart Platform Parameters
% Geometry unit: mm
% Angle unit: deg
% ===========================================



%% ===============================
% Base
% ================================

R_base = 180;       % mm
RB     = 150;       % mm
t_base = 20;        % mm，简化外观

%% ===============================
% Moving platform
% ================================

R_top = 90;         % mm
RP    = 68.805;     % mm
t_top = 22.3;       % mm

%% ===============================
% Initial height
% ================================

h0 = 212.585;       % mm

%% ===============================
% Base joints
% ================================

B = [ ...
      0,       -75.000,  -129.904,  -75.000,   150.000,   129.904;
    150.000,   129.904,   -75.000, -129.904,     0,       -75.000;
      0,         0,         0,        0,          0,         0
    ];

%% ===============================
% Moving-platform joints
% ================================

P = [ ...
     35.756,  -60.358,  -68.787,    1.574,   58.785,   33.031;
     58.785,   33.031,    1.574,  -68.787,   35.756,  -60.358;
      0,        0,         0,        0,        0,        0
    ];

%% ===============================
% Initial platform position
% ================================

T0 = [0; 0; h0];

disp('Stewart geometry parameters loaded.')

%% ==========================================
% Initial leg geometry
% ===========================================

Pw0 = P + [0;0;h0];


legVec0 = Pw0 - B;

L0 = vecnorm(legVec0);

% Unit vectors of six legs
uLeg0 = legVec0 ./ L0;

disp('Initial leg length / mm:')
disp(L0')

disp('Initial leg unit vectors:')
disp(uLeg0)

%% Leg 1 orientation

ez = [0;0;1];

u1 = uLeg0(:,1);

rotAxis1 = cross(ez,u1);

rotAxis1 = rotAxis1 / norm(rotAxis1);

rotAngle1 = acos(dot(ez,u1));

rotAngle1_deg = rad2deg(rotAngle1);

disp('Leg1 rotation axis:')
disp(rotAxis1)

disp('Leg1 rotation angle / deg:')
disp(rotAngle1_deg)