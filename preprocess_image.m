function processed_image = preprocess_image(original_image)
% sigma = std(original_image);
Iblur = imgaussfilt(original_image);
figure 
subplot(2,1,1);
imshow(Iblur);
H = fspecial('log');
processed_image = imfilter(Iblur,H,'replicate');
subplot(2,1,2);
imshow(processed_image);
end