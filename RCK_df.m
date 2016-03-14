function df_dk = RCK_df(k, params)
% RCK_df Defines the derivative of the customizable Cobb-Douglas function 
% f(k) in the Ramsey/Cass-Koopmans equations.

df_dk = (params.alpha) .* ( k .^ (params.alpha - 1) );

end