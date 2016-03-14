%% plotPhasePortrait
% Create a visualization of the 2D phase plane for the Ramsey/Cass-Koopmans
% model.
%
% Authors: Sonia Bridge, Ken Deeley
% Copyright 2016 The MathWorks, Inc.

%% Ensure that the required parameters are defined.
defineRCKParams

%% Define sample values for the x-axis in the phase plane.
kroot = (phi + xi + delta) ^ (1/(alpha - 1));
nPoints = 50;
initialValue = 0;
kfine = linspace(initialValue, kroot, nPoints);

%% Compute steady-state curve.
cstar = kfine .^ alpha - (phi + xi + delta) * kfine;

%% Define sample values for the y-axis in the phase plane.
cfine = linspace(initialValue, c0, nPoints);

%% Create a lattice of points.
[K, C] = meshgrid(kfine, cfine);

%% Compute the differentials.
f = @(k) k .^ alpha; 
fprime = @(k) alpha * k .^ (alpha - 1);
dK = f(K) - C - (phi + xi + delta)*K; % dk/dt
dC = ((fprime(K) - (xi + delta + theta))/rho - phi) .* C; % dc/dt
dC(~isfinite(dC)) = 0;

%% Visualize the phase portrait.
figure
h = streamslice(K, C, dK, dC, 2, 'noarrows', 'cubic');
set(h, 'LineStyle', ':')
% Plot the steady-state vertical line and smooth curve.
hold on
plot(kfine, cstar, 'm', 'LineWidth', 2)
xlabel('k (capital intensity)')
ylabel('c (per capita consumption)')
title('(k, c) trajectories')
grid
plot([kstar, kstar], ylim, 'k', 'LineWidth', 2)

%% TODO: add the direction arrows (four regions) and labels, similar to
% the Wikipedia article.



