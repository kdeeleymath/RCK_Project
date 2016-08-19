%% plotRCKSimulink 
% Simulate the model starting from the point (k0, c0) = (5, 3) and create 
% a visualization of the the solution trajectory.
%
% Authors: Sonia Bridge, Ken Deeley
% Copyright 2016 The MathWorks, Inc.

%% Load the model.
load_system('RCK_Model');

%% Simulate the model.
sim('RCK_Model');

%% Visualize the results.
figure('Units', 'Normalized', 'Position', 0.25*[1, 1, 2, 2])
% k - column 1 of yout
% c - column 2 of yout
plot(yout(:,1), yout(:,2), 'k', 'LineWidth', 2)
xlabel('{\it{k}} (capital per capita)')
ylabel('{\it{c}} (consumption per capita)')
title({'Numerical Solution of the', 'Ramsey-Cass-Koopmans Equations'})
grid on
% Increase the font size.
ax = gca;
ax.FontSize = 15;

%% Close the system.
close_system('RCK_Model');