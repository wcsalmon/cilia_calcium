function [corrected_trace] = background_correction_csv(filename)
% Subtracts the cytoplasmic cilia intensity from that of the cilia
% called by preprocessing_xls2csv.m
% Mean1 corresponds to the cilia, Mean2 corresponds to the background

trace_info = importdata(filename);
txt = trace_info.colheaders;
num = trace_info.data;
corrected_trace = num(:,strcmp(txt,'Mean1'))-num(:,strcmp(txt,'Mean2'));

end

