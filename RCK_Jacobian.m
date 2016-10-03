function J = RCK_Jacobian(k, c, params)
% Compute the analytical Jacobian of the RCK equation for dc/dk.
%
% Authors: Sonia Bridge, Ken Deeley
% Copyright 2016 The MathWorks, Inc.

% Define the numerator and denominator.
numerator = c * (RCK_df(k, params) - params.theta - ...
                      params.xi - params.delta - params.phi * params.rho);
denominator = params.rho * (RCK_f(k, params) - c - (params.phi + params.xi + params.delta) * k);

% Compute the derivatives of the numerator and denominator.
numeratorDerivative = numerator / c;
denominatorDerivative = - params.rho;

% Apply the quotient rule.
J = (numeratorDerivative * denominator - ...
     denominatorDerivative * numerator) / (denominator^2);
 
end % RCK_Jacobian

