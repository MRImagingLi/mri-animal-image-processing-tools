function X = openNIFTIImage(fileName)

try
    %% load nifti image
    Hdr = load_untouch_nii(fileName);
    X = Hdr.img;
catch
    msgId = 'openNIFTIImage::UnableOpenFile ';
    msg = 'Unable to open NIfTI file: ';
    msg = strcat(msg,fileName);
    causeException = MException(msgId, msg);
    throw(causeException);
end

end