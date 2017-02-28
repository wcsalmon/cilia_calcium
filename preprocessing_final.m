%%% Performs basic preprocessing on the time course data.
%% Copies xls files to csv files so that they can be opened
%% Then writes out a file of corrected_intensity at each time point
%% and the elapsed tiime at each timepoint
%% depends on background_correction_csv.m and time_point_calculation.m
% Expects just list of time stamps

trace_file_ending_pattern = '[a-z]\.xls[x]*';
xls_pattern = '\.xls[x]*';
et_pattern = '\.et.*';

%%% Select folder to analyze

folder = uigetdir;
cd(folder);
%%% Collect .xls[x] files (for intensity values)
xlslist = dir('*.xls'); % change to .xlsx if using .xlsx intensity files.
xlslist = {xlslist(:).name};

%%% Collect timepoint files (assumes it has the format '*et*' ~ whether it
%%% is .xlsx or .txt shouldn't matter)
timelist = dir('*et*');
timelist = {timelist(:).name};

for j = 1:length(xlslist)
    
   current_file = xlslist{j};
   % As there are problems openning the .xls files, we convert to .csv
    new_location = strcat(strrep(current_file,'.xls','.csv'));
    copyfile(current_file,new_location);
   
   background_corrected_intensity = background_correction_csv(new_location);
   
   intensity_file_name = regexprep(current_file,xls_pattern,'_corrected_intensity.txt');
   time_file_name = strrep(intensity_file_name,'_corrected_intensity.txt','_elapsed_time.txt');
   
   csvwrite(intensity_file_name,background_corrected_intensity);
   time_series = time_point_calculation(timelist{j});
   csvwrite(time_file_name,time_series);
end