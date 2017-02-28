%%% Preprocessing ATP - generates a separate elapsed time file for each
%%% cilia trace.  Otherwise works the same as preprocessing_xls2csv.
%%% Depends on EditDistance.m
%%% (https://www.mathworks.com/matlabcentral/fileexchange/39049-edit-distance-algorithm)

folder = uigetdir; 
cd(folder);

%%% Finding a list of all trace_files and time_files. Note that there will
%%% probably be more trace_files than time_files, as there is only one time
%%% file for each experiment
trace_files = dir('*.xls*');
trace_files = {trace_files(:).name};
time_files = dir('*et.txt');
time_files = {time_files(:).name};

trace_file_ending_pattern = '[a-z]\.xls[x]*';
xls_pattern = '\.xls[x]*';

%% In order to match trace_files with time_files, we assume (pretty generally) that the appropriate
%% time file for a given trace is the one with the closest name to that trace, found using EditDistance.m
file_name_dist = zeros(length(trace_files),length(time_files)); 
closest_match = zeros(length(trace_files),1); 
for i = 1:length(trace_files)
    current_file = trace_files{i};
    for j = 1:length(time_files)
        file_name_dist(i,j) = EditDistance(current_file,time_files{j});
    end
    closest_match(i) = find(file_name_dist(i,:) == min(file_name_dist(i,:)));
    
    % Uncomment this line to see the time file matched with each trace file
   % disp(strcat(trace_files{i}, '   matches  ', time_files{closest_match(i)}));

    % Making new files for the trace and time series, and placing them in a new directory
   cropped_file_name = regexprep(current_file,trace_file_ending_pattern,'','ignorecase');
   intensity_file_name = regexprep(current_file,xls_pattern,'_corrected_intensity.txt');
   
   if ~exist(cropped_file_name,'dir')
       mkdir(cropped_file_name);
   end
   
   new_time_series_file_name = strrep(current_file,'.xls','_elapsed_time.txt');
  copyfile(time_files{closest_match(i)},new_time_series_file_name);
    movefile(new_time_series_file_name, cropped_file_name);
    
    new_location = strcat(cropped_file_name,'/',strrep(current_file,'.xls','.csv'));
    copyfile(current_file,new_location);
    
%    Tries to c obtain the background_corrected_intensity.  If this does
%    not work it outputs that there is a problem, giving the file name, and
%    continues.
try
    background_corrected_intensity = background_correction_csv(new_location);
    csvwrite(strcat(cropped_file_name,'/',intensity_file_name),background_corrected_intensity);
catch
    disp(strcat('problem with ', cropped_file_name));
end
end

