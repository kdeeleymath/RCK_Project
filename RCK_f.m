function fk = RCK_f(k, params)
% RCK_f Defines the customizable Cobb-Douglas function f(k) in the 
% Ramsey/Cass-Koopmans equations.

fk = k .^ (params.alpha);

end