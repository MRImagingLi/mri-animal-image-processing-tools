function registeredVolumes = feature_based_registration(mri_files_fixed, mri_files_moving)
moving_stack = threshold_image(mri_files_moving);
fixed_stack = threshold_image(mri_files_fixed);

[~,~,num_of_images] = size(moving_stack);
registeredVolumes = uint16(size(moving_stack));
%% initial registration
for i = 150:num_of_images
    movingImage = moving_stack(:,:,i);
    fixedImage = fixed_stack(:,:,i);
    % Detect features in both images.
    ptsOriginal  = detectSURFFeatures(fixedImage);
    ptsDistorted = detectSURFFeatures(movingImage);
    % Extract feature descriptors.
    [featuresOriginal,   validPtsOriginal]  = extractFeatures(fixedImage,  ptsOriginal);
    [featuresDistorted, validPtsDistorted]  = extractFeatures(movingImage, ptsDistorted);
    % Match features by using their descriptors.
    indexPairs = matchFeatures(featuresOriginal, featuresDistorted);
    % Retrieve locations of corresponding points for each image.
    matchedOriginal  = validPtsOriginal(indexPairs(:,1));
    matchedDistorted = validPtsDistorted(indexPairs(:,2));
    % Show point matches. Notice the presence of outliers.
    figure;
    showMatchedFeatures(uint16(fixedImage),uint16(movingImage),matchedOriginal,matchedDistorted);
    title('Putatively matched points (including outliers)');
    [tform, inlierDistorted, inlierOriginal] = estimateGeometricTransform(matchedDistorted, matchedOriginal, 'similarity');
    % Display matching point pairs used in the computation of the transformation matrix.
    figure;
    showMatchedFeatures(uint16(fixedImage),uint16(movingImage), inlierOriginal, inlierDistorted);
    title('Matching points (inliers only)');
    legend('ptsOriginal','ptsDistorted');
    % Compute the inverse transformation matrix.
    Tinv  = tform.invert.T;
    ss = Tinv(2,1);
    sc = Tinv(1,1);
    scale_recovered = sqrt(ss*ss + sc*sc)
    theta_recovered = atan2(ss,sc)*180/pi
    % Recover the original image by transforming the distorted image.
    outputView = imref2d(size(uint16(fixedImage)));
    recovered  = imwarp(uint16(movingImage),tform,'OutputView',outputView);
%     registeredVolumes(:,:,i) = recovered;
    % Compare recovered to original by looking at them side-by-side in a montage.
    figure, imshowpair(uint16(fixedImage),uint16(movingImage),'montage')
    delete(findall(0,'Type','figure'))
end 
end