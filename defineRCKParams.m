%% defineRCKParams
% Parameter definitions for the Ramsey/Cass-Koopmans model.
%
% Authors: Sonia Bridge, Ken Deeley
% Copyright 2016 The MathWorks, Inc.

%% Capital equation parameters.
% Growth rate of labor productivity.
params.phi = 0.02; 
% Growth rate of labor supply (population growth).
params.xi = 0.01; 
% Decay rate of capital (capital depreciation over time).
params.delta = 0.07; 

%% Consumption equation parameters.
% Exponent in the Cobb-Douglas production function.
params.alpha = 0.5;
% Rate at which consumption is discounted.
params.rho = 0.02;
% Intertemporal elasticity of substitution.
params.theta = 0.01;

%% Initial conditions.
% Initial per capita capital (wealth).
params.k_steady = (params.alpha / ...
    (params.theta+params.xi+params.delta+params.rho*params.phi)) ...
     ^ (1/(1-params.alpha));
params.k0 = 5; 
% Initial per capital consumption.
params.c0 = 3; 