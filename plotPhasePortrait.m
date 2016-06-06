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
figure('Units', 'Normalized', 'Position', 0.25*[1, 1, 2, 2])
h = streamslice(K, C, dK, dC, 2, 'noarrows', 'cubic');
set(h, 'LineStyle', ':', 'LineWidth', 1.5)
% Hide all but one streamslice from the legend.
set(h(2:end), 'HandleVisibility', 'off')
% Plot the steady-state vertical line and smooth curve.
hold on
plot(k_fine, c_star, 'm', 'LineWidth', 2)
xlabel('{\it{k}} (capital per capita)')
ylabel('{\it{c}} (consumption per capita)')
title('Ramsey/Cass-Koopmans Capital-Consumption Phase Plane')
grid
plot([params.k_steady, params.k_steady], ylim(), 'k', 'LineWidth', 2)
% Increase the font size.
ax = gca;
ax.FontSize = 15;
% Add the legend.
legend({'Stream Slices', 'dc/dt = 0', 'dk/dt = 0'})

%% Add the direction arrows (four regions) and labels.

% Top-right quadrant.
% Coordinates.
x = [80, 80];
y = [2.5, 2.2];
[xFig, yFig] = ds2nfu(x, y);
% Annotation.
annotation('arrow', xFig, yFig, 'LineWidth', 1.5)
% Coordinates.
x = [80, 73];
y = [2.5, 2.5];
[xFig, yFig] = ds2nfu(x, y);
% Annotation.
annotation('arrow', xFig, yFig, 'LineWidth', 1.5)

% Top-left quadrant.
% Coordinates.
x = [20, 20];
y = [2.6, 2.9];
[xFig, yFig] = ds2nfu(x, y);
% Annotation.
annotation('arrow', xFig, yFig, 'LineWidth', 1.5)
% Coordinates.
x = [20, 13];
y = [2.6, 2.6];
[xFig, yFig] = ds2nfu(x, y);
% Annotation.
annotation('arrow', xFig, yFig, 'LineWidth', 1.5)

% Bottom-right quadrant.
% Coordinates.
x = [60, 60];
y = [1.0, 0.7];
[xFig, yFig] = ds2nfu(x, y);
% Annotation.
annotation('arrow', xFig, yFig, 'LineWidth', 1.5)
% Coordinates.
x = [60, 67];
y = [1.0, 1.0];
[xFig, yFig] = ds2nfu(x, y);
% Annotation.
annotation('arrow', xFig, yFig, 'LineWidth', 1.5)

% Bottom-left quadrant.
% Coordinates.
x = [15, 15];
y = [1.0, 1.3];
[xFig, yFig] = ds2nfu(x, y);
% Annotation.
annotation('arrow', xFig, yFig, 'LineWidth', 1.5)
% Coordinates.
x = [15, 22];
y = [1.0, 1.0];
[xFig, yFig] = ds2nfu(x, y);
% Annotation.
annotation('arrow', xFig, yFig, 'LineWidth', 1.5)
