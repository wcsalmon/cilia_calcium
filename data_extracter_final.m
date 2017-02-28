%% Concatenates data for each output parametere from individual data files.  
%% Can run on multiple folders
%% Must manually run through all the parameters by commenting and uncommenting


%parameter = 'Filling Start'; % change to the data field of interest
%parameter = 'Peak Start'; % change to the data field of interest
%parameter = 'Peak End'; % change to the data field of interest
%parameter = 'Filling Time'; % change to the data field of interest
%parameter = 'Peak Duration'; % change to the data field of interest
%parameter = 'Baseline Intensity'; % change to the data field of interest
%parameter = 'Max Intensity'; % change to the data field of interest
%parameter = 'Final Intensity'; % change to the data field of interest
%parameter = 'Slope Falling'; % change to the data field of interest
parameter = 'Emptying Time'; % change to the data field of interest


%%%% OBTAINING THE FOLDERS FOR EACH GENOTYPE
try
    folder_list = uigetdirMultiSelect();
catch
    if ~exist('uigetdirMultiSelect.m','file')
        error('Add uigetdirMultiSelect.m to Matlab path')
    else
        disp('Unknown error');
    end
end

%%% PICKING DESTINATION FOLDER
disp('Pick a destination folder');
dest_folder = uigetdir;
cd(dest_folder);

 % Creates a new text file for each genotype folder
  % Each of these files contains all data about this parameter
  % for experiments in the corresponding genotype folder
  folder_short = cell(length(folder_list),1);
for folder_index = 1:length(folder_list)
    folder_name_regxp = '[^/]+'; % to obtain filename
    current_folder_short = regexp(folder_list(folder_index),folder_name_regxp,'match');
    current_folder_short = current_folder_short{1};
    folder_short{folder_index} = current_folder_short(end);
   file_wildcard = char(strcat(folder_list(folder_index),'/RESULTs*.txt'));
   file_list = dir(file_wildcard);
   file_list = struct2cell(file_list);
   file_list = file_list(1,:);
   
   %%% Extracting the value of the specified parameter
   parameter_value = zeros(length(file_list),1);
   for file_index = 1:length(file_list)
       file_name = strcat(folder_list(folder_index),'/',file_list{file_index});
       file_name = file_name{1};
       file_info = importdata(file_name);
       file_info.textdata = file_info.textdata(2:end,1);
       parameter_value(file_index) = file_info.data((strcmp(file_info.textdata,parameter)));
   end
   outputfile = strcat(parameter,'_',folder_short{folder_index},'.txt');
   
   trimmed_file_list = strrep(file_list,'RESULTS_','');
   trimmed_file_list = strrep(trimmed_file_list,'RESULTS','');
    
   % Outputting the data
     results_table = table(trimmed_file_list',parameter_value,'VariableNames',{'File_Name', strrep(parameter,' ','_')});
      writetable(results_table, cell2mat(outputfile));
end


