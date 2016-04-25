%% createRCKModel
% Create the Ramsey/Cass-Koopmans model using MATLAB
%
% Authors: Sonia Bridge, Ken Deeley
% Copyright 2016 The MathWorks, Inc.

%% Define model parameters.
defineRCKParams

%% Define the lower range of k-values.
k_steady = (params.alpha/(params.theta + params.xi + params.delta + ...
    params.rho * params.phi)) ^ (1/(1 - params.alpha));
gap = 1e-2;
k_lower = [10; k_steady - gap];

%% Define the upper range of k-values.
k_upper = [k_steady + gap; 100];

%% Define the initial conditions.
c_lower = 3;
c_upper = c_lower;

%% Define the right-hand side of the equations.
RCK_Fun = @(k, c) RCK_TimeElim(k, c, params);

%% Solve the system.
[k_out_lower, c_out_lower] = ode45(RCK_Fun, k_lower, c_lower);
[k_out_upper, c_out_upper] = ode45(RCK_Fun, k_upper, c_upper);

%% Visualize results.
figure
plot(k_out_lower, c_out_lower, '.-')
hold on
plot(k_out_upper, c_out_upper, '.-')
plot([k_steady, k_steady], ylim(), ':', ...
    'LineWidth', 1.5, 'Color', 0.3*ones(1, 3))
hold off
xlabel('Capital (k, per capita)')
ylabel('Consumption (c, per capita)')
grid
title(char('Numerical Solution of the', 'Ramsey/Cass-Koopmans Equations'))
legend({'Lower solution', 'Upper solution', ...
    ['Steady state $\hat{k}$ = ', num2str(k_steady, '%.2f')]}, ...
    'Interpreter', 'Latex', ...
    'Location', 'north', ...
    'FontSize', 12)