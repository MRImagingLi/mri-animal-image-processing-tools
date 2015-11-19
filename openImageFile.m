function X = openImageFile(fileName)
% add nifti folder to path
% TODO:Make this configurable - e.g. properties file
addpath('/Users/eva/Documents/MATLAB/NIfTI_20140122');

%% Check if the file name is empty and throw exception
if isempty(fileName)
    msgId = 'openImageFile:FileEmpty';
    msg = 'File name shouldn\''t be empty';
    causeException = MException(msgId, msg);
    throw(causeException);
end

%% Check if the file name provided exists and throw exception otherwise
if exist(fileName, 'file') ~= 2
    msgId = 'openImageFile:UnableFindFile';
    msg = 'File doesn\''t exist: ';
    msg = strcat(msg,fileName);
    causeException = MException(msgId, msg);
    throw(causeException);
end

[~,~,ext] = fileparts(fileName);

try
    %% open file based on the image type
    %% TODO: add more image types
    if strcmp(ext,'.img') == 1
        X = openAnalyze75File(fileName);
    elseif strcmp(ext,'.gz') == 1
        X = openNIFTIImage(fileName);
    elseif strcmp(ext,'.dcm') == 1
        X = dicomread(fileName);
    else
        msgId = 'openImageFile:UnsupportedFileType';
        msg = 'Unsupported file type : ';
        msg = strcat(msg,fileExt);
        causeException = MException(msgId, msg);
        throw(causeException);
    end
catch
    msgId = 'openImageFile:UnableOpenFile';
    msg = 'Unable to open file: ';
    msg = strcat(msg,fileName);
    causeException = MException(msgId, msg);
    throw(causeException);
end
end