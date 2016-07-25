%% createRCKModel
% Create the Ramsey-Cass-Koopmans model using MATLAB.
%
% Authors: Sonia Bridge, Ken Deeley
% Copyright 2016 The MathWorks, Inc.

%% Define the model parameters.
defineRCKParams

%% Parametrize the coupled system of equations.
RCK_Fun = @(t, Y) RCK_Equations(t, Y, params);

%% Both per-capita wealth and consumption remain nonnegative over time.
opts = odeset('NonNegative', [1, 2]);

%% Initial values for per-capita wealth and consumption.
Y0 = [25; 2];

%% Create a time vector for the system.
t = linspace(0, 1.5, 5000);

%% Solve the coupled system. 
[~, Y] = ode45(RCK_Fun, t, Y0, opts);
k_out = Y(:, 1); % Output per-capita wealth
c_out = Y(:, 2); % Output per-capita consumption

%% Visualize the resulting trajectory on the phase plane.
figure('Units', 'Normalized', 'Position', 0.25*[1, 1, 2, 2])
comet(k_out, c_out, 0.5);
hold on
axLims = axis;
% Only keep the comet tail for the legend. Adjust the appearance of certain
% comet components.
ax = gca;
cometComponents = ax.Children;
tail = findobj(ax, 'Tag', 'tail');
tail.LineWidth = 1.5;
tail.Color = 'k';
head = findobj(ax, 'Tag', 'head');
head.Marker = 'v';
head.MarkerSize = 10;
head.Color = 'k';
head.MarkerFaceColor = 'k';
set(setdiff(cometComponents, tail), 'HandleVisibility', 'off')
% Show the steady-state curve dk/dt = 0.
plot(params.k_fine, params.c_star, 'r', 'LineWidth', 2)
xlabel('{\it{k}} (capital per capita)')
ylabel('{\it{c}} (consumption per capita)')
title('Ramsey-Cass-Koopmans Capital-Consumption Phase Plane')
grid on
% Increase the font size.
ax = gca;
ax.FontSize = 15;
% Add the legend.
legend({['ODE45 solution, $(k_0, c_0)$ = (', num2str(Y0(1)), ', ' num2str(Y0(2)), ')'], ...
         '$dk/dt = 0$'}, ...
         'Location', 'best', ...
         'Interpreter', 'LaTeX', ...
         'FontSize', 15)
% Restore the original axes limits.
axis([axLims(1:3), Y0(2)+1])