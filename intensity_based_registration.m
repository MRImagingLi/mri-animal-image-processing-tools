function intensity_based_registration(mri_files_moving,mri_files_fixed)
%% preprocess images to extract the brain
moving_stack = threshold_image(mri_files_moving,90);
fixed_stack = threshold_image(mri_files_fixed,90);

[~,~,num_of_images] = size(moving_stack);
[optimizer,metric] = imregconfig('monomodal');
optimizer.MaximumIterations = 500;
%% initial registration
for i = 90:num_of_images
    moving = int16(moving_stack(:,:,i));
    fixed = int16(fixed_stack(:,:,i));
    tformSimilarity = imregtform(moving,fixed,'similarity',optimizer,metric);
    Rfixed = imref2d(size(fixed));
    movingRegisteredRigid = imwarp(moving,tformSimilarity,'OutputView',Rfixed);
    imshowpair(movingRegisteredRigid, fixed);
    title('Rigid-Registration');
%     movingRegisteredDefault = imregister(moving, fixed, 'affine', optimizer, metric);
%     subplot(2,2,1);
%     imshow(moving);
%     subplot(2,2,2);
%     imshow(fixed);
%     subplot(2,2,3);
%     imshowpair(movingRegisteredDefault, fixed)    
%     title('A: Default registration')
    delete(findall(0,'Type','figure'))
end
end