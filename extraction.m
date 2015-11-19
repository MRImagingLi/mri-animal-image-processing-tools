function extraction(mri_files_fixed, mri_files_moving,start_point)
[moving_stack,bw_mov_stack] = threshold_image(mri_files_moving,start_point);
[fixed_stack,bw_fix_stack] = threshold_image(mri_files_fixed,start_point);

[~,~,num_images] = size(moving_stack);
for i = 1:num_images
        moving_image = int16(moving_stack(:,:,num_images));
        fixed_image = int16(fixed_stack(:,:,num_images));
        bw_mov = bw_mov_stack(:,:,num_images);
        bw_fix = bw_fix_stack(:,:,num_images);
        figure
        subplot(2,2,1);
        imshow(moving_image);
        subplot(2,2,2);
        imshow(fixed_image);
        [white_m,gray_m] = wm_gm_extraction(moving_image,bw_mov);
        figure
        subplot(1,2,1);
        imshow(white_m);
        subplot(1,2,2);
        imshow(gray_m);
        [white_g,gray_g] = wm_gm_extraction(fixed_image,bw_fix);
        figure
        subplot(1,2,1);
        imshow(white_g);
        subplot(1,2,2);
        imshow(gray_g);
end
end