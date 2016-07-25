function dc_dk = RCK_TimeElim(k, c, params)
% RCK_TIMEELIM Right-hand side of the Ramsey-Cass-Koopmans differential
% equation for dc/dk obtained after applying the "time elimination" method,
% i.e. writing dc/dk as (dc/dt) / (dk/dt) and simplifying.

% Compute the numerator.
numerator = (RCK_df(k, params) - params.theta - params.xi - params.delta ...
    - params.rho * params.phi) * c;
% Compute the denominator.
denominator = params.rho * (RCK_f(k, params) - c - ...
    (params.phi + params.xi + params.delta) * k);

% Compute the derivative dc/dk.
dc_dk = numerator / denominator;

end % RCK_TimeElim