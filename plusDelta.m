%% MATLAB/Simulink plus/minus section.
% * Simulink plus: work the equations "as is" - no transformation/rewriting
% of the equations required to work with Simulink, whereas with ODE45 you
% need to write the equations in standard form.
% * Time-varying parameters: roughly the same for both approaches. Put in
% further improvements section.
% * Simulink plus: can compute the derivatives of f(k) automatically,
% whereas in MATLAB you could use Symbolic Toolbox to do this, but another
% approach is to use two files, one for f(k) and one for f'(k).