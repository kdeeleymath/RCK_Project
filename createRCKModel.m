%% createRCKModel
% Create the Ramsey/Cass-Koopmans model using MATLAB
%
% Authors: Sonia Bridge, Ken Deeley
% Copyright 2016 The MathWorks, Inc.

%% Define model parameters.
defineRCKParams

%% Define the time span.
tspan = [0, 500];

%% Define the initial conditions.
y0 = [params.k0; params.c0];

%% Define the right-hand side of the equations.
RCK_Fun = @(t, y) RCK_Equations(t, y, params);

%% Solve the system.
[tout, yout] = ode45(RCK_Fun, tspan, y0)







