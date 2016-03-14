function dy_dt = RCK_Equations(t, y, params) %#ok<INUSL>
% RCK_EQUATIONS Function defining the right-hand sides of the two coupled
% ordinary differential equations for the Ramsey/Cass-Koopmans model.

% Extract k and c.
k = y(1);
c = y(2);

% Write down the equations.
dy_dt(1, 1) = RCK_f(k, params) - c - ...
              (params.phi + params.xi + params.delta) * k;

dy_dt(2, 1) = ( ( RCK_df(k, params) - params.theta - params.xi - ...
                  params.delta ) / params.rho - params.phi ) * c;       

end