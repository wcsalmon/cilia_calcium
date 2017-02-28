function [time_series] = time_point_calculation(filename)
% SIMPLIFY

% Returns a list of elapsed times by taking the difference in raw
% timepoints.  Assumes there are only numerical time values in filename
%[num, txt, raw] = xlsread(filename,'','','basic');
num = importdata(filename);
if isstruct(num)
num = num.data;
end
timestamps = num(:,1);

time_series = timestamps-timestamps(1);


end

