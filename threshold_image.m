function [brainssssss,BW] = threshold_image(mri_images_file,start_point)
mri_stack_images = openImageFile(mri_images_file);

[width, height, num_images] = size(mri_stack_images);
if start_point > num_images
    msgId = 'threshold_image:StartPointLargerThanNumOfImages';
    msg = 'Start point shouldn\''t be larger than the number of images in the stack.';
    causeException = MException(msgId, msg);
    throw(causeException);
end
brainssssss = zeros(width, height, num_images);
BW = zeros(width, height, num_images);
%% create masks for the brain
%% keep only the brain- remove the skull
for num_image = start_point:num_images
    original_image = mri_stack_images(:,:,num_image);
    [brain,BW_img] = extract_brain(original_image);
    brainssssss(:,:,num_image) = brain;
    BW(:,:,num_image) = BW_img;
end
end