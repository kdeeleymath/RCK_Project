%% createRCKModelTimeElim
% Create the Ramsey-Cass-Koopmans model using MATLAB.
%
% Authors: Sonia Bridge, Ken Deeley
% Copyright 2016 The MathWorks, Inc.

%% Define the model parameters.
defineRCKParams

%% Define the lower range of k-values.
k_steady = params.k_steady;
gap = 1e-2;
k_lower = [10, k_steady - gap];

%% Define the upper range of k-values.
k_upper = [k_steady + gap, 100];

%% Define the initial conditions.
c_lower = 3;
c_upper = c_lower;

%% Define the right-hand side of the equations.
RCK_Fun = @(k, c) RCK_TimeElim(k, c, params);

%% Solve the system using ode45.
[k_out_lower, c_out_lower] = ode45(RCK_Fun, k_lower, c_lower);
[k_out_upper, c_out_upper] = ode45(RCK_Fun, k_upper, c_upper);

%% Visualize the results.
% First, plot the numerical solution of the ODE.
figure('Units', 'Normalized', 'Position', 0.25*[1, 1, 2, 2])
plot(k_out_lower, c_out_lower, '.-')
hold on
plot(k_out_upper, c_out_upper, '.-')
% Next, add the steady state curves.
plot(params.k_fine, params.c_star, 'r', 'LineWidth', 2)
plot([k_steady, k_steady], ylim(), 'm', 'LineWidth', 2)
hold off
xlabel('{\it{k}} (capital per capita)')
ylabel('{\it{c}} (consumption per capita)')
title(char('Numerical Solution of the', 'Ramsey-Cass-Koopmans Equations'))
grid on
% Increase the font size.
ax = gca;
ax.FontSize = 15;
% Adjust the y-axis limits.
ylim([0, 10])
legend({'Lower solution', 'Upper solution', ...       
        '$dk/dt = 0$', ...
       ['$dc/dt = 0$, $\hat{k}$ = ', num2str(k_steady, '%.2f')]}, ...
        'Interpreter', 'Latex', ...        
        'FontSize', 15)
    
%% Solve the lower system using a stiff solver.    
J = @(k, c) RCK_Jacobian(k, c, params);
opts = odeset('Jacobian', J);
warning('off', 'MATLAB:ode15s:IntegrationTolNotMet')
[k_out_lower, c_out_lower] = ode15s(RCK_Fun, k_lower, c_lower);
warning('on', 'MATLAB:ode15s:IntegrationTolNotMet')
% Plot the numerical solution of the ODE.
figure('Units', 'Normalized', 'Position', 0.25*[1, 1, 2, 2])
plot(k_out_lower, c_out_lower, '.-')
axLims = axis;
hold on
% Next, add the steady state curves.
plot(params.k_fine, params.c_star, 'r', 'LineWidth', 2)
hold off
xlabel('{\it{k}} (capital per capita)')
ylabel('{\it{c}} (consumption per capita)')
title(char('Numerical Solution of the', 'Ramsey-Cass-Koopmans Equations'))
grid on
% Increase the font size.
ax = gca;
ax.FontSize = 15;
% Adjust the axis limits.
axis(axLims)
legend({'Lower solution', ...
        '$dk/dt = 0$'}, ...
        'Interpreter', 'Latex', ...        
        'FontSize', 15)  