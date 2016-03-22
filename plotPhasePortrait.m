%% plotPhasePortrait
% Create a visualization of the 2D phase plane for the Ramsey/Cass-Koopmans
% model.
%
% Authors: Sonia Bridge, Ken Deeley
% Copyright 2016 The MathWorks, Inc.

%% Ensure that the required parameters are defined.
defineRCKParams

%% Define sample values for the x-axis in the phase plane.
k_root = (params.phi + params.xi + params.delta) ^ ...
    (1 / (params.alpha - 1));
nPoints = 50;
k_init = 0;
k_fine = linspace(k_init, k_root, nPoints);

%% Compute steady-state curve.
c_star = k_fine .^ params.alpha - ...
    (params.phi + params.xi + params.delta) * k_fine;

%% Define sample values for the y-axis in the phase plane.
c_fine = linspace(k_init, params.c0, nPoints);

%% Create a lattice of points.
[K, C] = meshgrid(k_fine, c_fine);

%% Compute the differentials.
dK = RCK_f(K, params) - C - ...
    (params.phi + params.xi + params.delta) * K; % dk/dt
dC = ((RCK_df(K, params) - ...
    (params.xi + params.delta + params.theta)) ...
    / params.rho - params.phi) .* C; % dc/dt
dC(~isfinite(dC)) = 0;

%% Visualize the phase portrait.
figure
h = streamslice(K, C, dK, dC, 2, 'noarrows', 'cubic');
set(h, 'LineStyle', ':')
% Plot the steady-state vertical line and smooth curve.
hold on
plot(k_fine, c_star, 'm', 'LineWidth', 2)
xlabel('k (capital per capita)')
ylabel('c (consumption per capita)')
title('Ramsey/Cass-Koopmans Capital-Consumption Phase Plane')
grid
plot([params.k_steady, params.k_steady], ylim(), 'k', 'LineWidth', 2)

%% TODO: add the direction arrows (four regions) and labels, similar to
% the Wikipedia article.



