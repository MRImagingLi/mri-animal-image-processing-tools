function [brain,BW] = extract_brain(original_image)
    figure('units','normalized','outerposition',[0 0 1 1])
    subplot(3,3,1);
    imshow(original_image);
    histogram(original_image);
%     adjasted_image = adapthisteq(original_image);
%     adjasted_image = imadjust(original_image);
%     subplot(3,3,9);
%     imshow(adjasted_image);
%     preprocessed_image = preprocess_image(original_image);
    % get global threshold
    normalized_level = graythresh(original_image);
%     normalized_level = iterative_thresholding(original_image);
    BW = im2bw(original_image,normalized_level);
    subplot(3,3,2);
    imshow(BW)
    % erode structures by one pixel in order to perform removal of 
    % structures that might be connected to the brain and this operation
    % will remove these connections to the brain 
    se = strel('diamond',2);
    BW = imerode(BW,se);
    subplot(3,3,3);
    imshow(BW)
    % remove artifacts
    BW = bwareaopen(BW,800);
    subplot(3,3,4);
    imshow(BW)
    % close operation to create compact structures
    se = strel('diamond',5);
    BW = imclose(BW,se);
    subplot(3,3,5);
    imshow(BW);
    % dilate to connect any brain strucures that were separated from
    % the main stem of the brain structure
    se = strel('pair',[4,4]);
    BW = imdilate(BW,se);
    subplot(3,3,6);
    imshow(BW)
    % remove any small structures unrelated to the brain
    BW =  bwareaopen(BW,100);
    subplot(3,3,7);
    imshow(BW)
    subplot(3,3,8);
    brain = double(BW).*double(original_image);
%     H = fspecial('unsharp');
%     brain = roifilt2(H,original_image,BW);
    imshow(int16(brain));
    delete(findall(0,'Type','figure'))
end