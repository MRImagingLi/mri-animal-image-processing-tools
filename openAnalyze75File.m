function X = openAnalyze75File(fileName)

try
    %% construct header file for .img file and get info
    hdrFileName = strrep(fileName, '.img', '.hdr');
    info = analyze75info(hdrFileName);
    X = analyze75read(info);
catch
    msgId = 'openAnalyze75File::UnableOpenFile ';
    msg = 'Unable to open Analyze 7.5 file: ';
    msg = strcat(msg,fileName);
    causeException = MException(msgId, msg);
    throw(causeException);
end

end