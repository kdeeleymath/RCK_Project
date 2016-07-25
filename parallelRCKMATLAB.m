%% parallelRCKMATLAB
% Simulate the MATLAB-based Ramsey-Cass-Koopmans model in parallel.
%
% Authors: Sonia Bridge, Ken Deeley
% Copyright 2016 The MathWorks, Inc.

%% Define the model parameters.
defineRCKParams

%% Create lattices of (k, c) points.
nPoints = 100;
k0Vec = linspace(0, 100, nPoints);
c0Vec = linspace(0, 3, nPoints);
[K0, C0] = meshgrid(k0Vec, c0Vec);

%% Parametrize the coupled system of equations.    
RCK_Fun = @(t, Y) RCK_Equations(t, Y, params);

%% Both per-capita wealth and consumption remain nonnegative over time.
opts = odeset('NonNegative', [1, 2]);

%% Create a time vector for the system.
t = linspace(0, 1.5, 1000);

%% Perform the simulations in parallel.
parfor k = 1:numel(K0)

    % Initial values for per-capita wealth and consumption.
    Y0 = [K0(k); C0(k)];

    % Solve the coupled system. 
    % Suppress the integration warning.
    warning('off', 'MATLAB:ode45:IntegrationTolNotMet')
    [~, Y] = ode45(RCK_Fun, t, Y0, opts);
    k_out{k} = Y(:, 1); % Output per-capita wealth
    c_out{k} = Y(:, 2); % Output per-capita consumption    
    warning('on', 'MATLAB:ode45:IntegrationTolNotMet')
    
end % parfor

%% Plot the results.
figure('Units', 'Normalized', 'Position', 0.25*[1, 1, 2, 2])
hold on
for k = 1:numel(K0)
    plot(k_out{k}, c_out{k}, '.', 'Color', rand(1, 3))
end
ylim([0, 3])
xlabel('{\it{k}} (capital per capita)')
ylabel('{\it{c}} (consumption per capita)')
title(char('Numerical Solution of the', 'Ramsey-Cass-Koopmans Equations'))
grid on
% Increase the font size.
ax = gca;
ax.FontSize = 15;