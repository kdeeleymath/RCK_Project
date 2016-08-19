%% parallelRCKSimulink
% Simulate the Simulink-based Ramsey-Cass-Koopmans model in parallel.
%
% Authors: Sonia Bridge, Ken Deeley
% Copyright 2016 The MathWorks, Inc.

%% Load the model once per worker.
spmd
    load_system('RCK_Model');  
end % spmd

%% Create lattices of (k, c) points.
nPoints = 100;
k0Vec = linspace(0, 100, nPoints);
c0Vec = linspace(0, 3, nPoints);
[K0, C0] = meshgrid(k0Vec, c0Vec);

%% Perform the simulations in parallel.
parfor k = 1:numel(K0)

    simout(k) = runSim(K0(k), C0(k));
    
end % parfor

%% Plot the results.
figure('Units', 'Normalized', 'Position', 0.25*[1, 1, 2, 2])
hold on
for k = 1:numel(K0)
    yout = get(simout(k), 'yout');
    if ~isempty(yout)
        plot(yout(:,1), yout(:,2), '.', 'Color', rand(1, 3))
    end % if
end % for
ylim([0, 3])
xlim([0 100])
xlabel('{\it{k}} (capital per capita)')
ylabel('{\it{c}} (consumption per capita)')
title(char('Numerical Solution of the', 'Ramsey-Cass-Koopmans Equations'))
grid on
% Increase the font size.
ax = gca;
ax.FontSize = 15;

%% Local function to run a single simulation given a set of initial conditions.
function simout = runSim(k0, c0)
% RUNSIM Function simulating the model for different initial values
% for per-capita wealth and consumption using the stiff system solver
% ode15s and a stop time of 45 time units.

% Format the initial values for per-capita wealth and consumption as text.
k0 = num2str(k0);
c0 = num2str(c0);
set_param('RCK_Model/capital', 'InitialCondition', k0)
set_param('RCK_Model/consumption', 'InitialCondition', c0)

% Run the simulation. 
try
    simout = sim('RCK_Model', 'Solver', 'ode15s', 'StopTime', '45');
catch
    % If a simulation run fails to converge, assign an empty output.
    simout = Simulink.SimulationOutput;
end % try

end % runSim