clear
clc

run('stewart_parameters.m')

%% Initial pose

pos0 = [0 0 h0];
angle0 = deg2rad([0 0 0]);

L0 = stewartIK(pos0,angle0,B,P);

%% Target pose: Z + 10 mm

pos1 = [0 0 h0+10];
angle1 = deg2rad([0 0 0]);

L1 = stewartIK(pos1,angle1,B,P);

%% Required prismatic displacement

q = L1-L0;

disp('Initial lengths / mm:')
disp(L0)

disp('Target lengths / mm:')
disp(L1)

disp('Prismatic displacement / mm:')
disp(q)