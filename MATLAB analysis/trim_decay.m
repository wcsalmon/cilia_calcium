function [falling_values_shifted_trimmed,falling_points_trimmed] = trim_decay(falling_values_shifted,falling_points)
% Removes 'hooks' from the semilog plot of the decay - used to approximate falling as an
% exponential decay.  Very ad-hoc.




cutoff = mean(log(falling_values_shifted(falling_values_shifted~=0)));
% log(falling_values_shifted) would be linear
%if falling_values_shifted is exponential (as it often seems to be

% we are just looking at points above a certain cutoff.
falling_values_shifted_trimmed = falling_values_shifted(log(falling_values_shifted) > cutoff);

falling_points_trimmed = falling_points(log(falling_values_shifted) > cutoff);
end

