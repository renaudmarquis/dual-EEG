function [TimeStart, TimeEnd, Label] = read_mrk_Cartool(Filename)
%read_mrk_Cartool reads .mrk file generated by Cartool and outputs all numeric
%and non-numeric markers
%
% USAGE
% [MarkerTimeStart, MarkerTimeEnd, MarkerLabel] = read_mrk_file(Filename)
%
% INPUTS
% Filename: string, full file path
%
% OUTPUTS
% TimeStart: double, marker beginning in milliseconds
% TimeEnd: double, marker end in milliseconds
% Label: cell of strings, marker names
%
% Renaud Marquis @ FBM lab, March 2018
%
% Renaud Marquis @ FBMlab, March 2019: moved this function to
% read_mrk_Cartool_main() (see internal function below) to convert
% read_mrk_Cartool.m to a wrapper function and avoid unnecessary lines of
% codes in other scripts...

try
    [TimeStart, TimeEnd, Label] = read_mrk_file(Filename);
catch
    try
        [TimeStart, TimeEnd, Label] = read_mrk_Cartool_main(Filename);
    catch
        [TimeStart, TimeEnd, Label] = read_mrk_Excel_export(Filename);
    end
end


end

function [TimeStart, TimeEnd, Label] = read_mrk_Cartool_main(Filename)

delimiter = '\t';
startRow = 2;

%% Format string for each line of text:
%   column2: double (%f)
%	column3: double (%f)
%   column4: text (%q)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%*q%f%f%q%[^\n\r]';

%% Open the text file.
fileID = fopen(Filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines' ,startRow-1, 'ReturnOnError', false);

%% Close the text file.
fclose(fileID);

%% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so no post
% processing code is included. To generate code which works for
% unimportable data, select unimportable cells in a file and regenerate the
% script.

%% Allocate imported array to column variable names
TimeStart = dataArray{:, 1};
TimeEnd = dataArray{:, 2};
Label = dataArray{:, 3};

end