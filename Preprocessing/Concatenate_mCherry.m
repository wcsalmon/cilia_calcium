%%% Performs basic preprocessing on the time course data.
%% Copies xls files to csv files so that they can be opened
%% Then writes out a file of corrected_intensity at each time point
%% and the elapsed time at each timepoint
%% depends on background_correction_csv.m and time_point_calculation.m
% Expects just list of time stamps

%%% Select folder to analyze

folder = uigetdir;
cd(folder);
%%% Collect .xls files (for intensity values)
xlslist = dir('*mCh.csv');
xlslist = {xlslist(:).name};

m_cherry_values = zeros(1,length(xlslist));
for j = 1:length(xlslist)
    
   current_file = xlslist{j};
   % As there are problems openning the .xls files, we convert to .csv
   %new_location = strcat(strrep(current_file,'.xls','.csv'));
   %copyfile(current_file,new_location);
   
   background_corrected_intensity = background_correction_csv(current_file);
   m_cherry_values(j) = background_corrected_intensity(2);

   csvwrite(strcat(xlslist{j},'_corrected_intensity.txt'),background_corrected_intensity);
  
end

m_cherry_table = table(xlslist',m_cherry_values');
output_file = 'mcherry_values.txt';
writetable(m_cherry_table,output_file);