function testReg(pointsMRI, pointsatlas,choice)
img = openImageFile(pointsMRI, '.img');
atlas = openImageFile(pointsatlas, '.img');

figure
% colormap(map)
image_num = 150;
image(img(:,:,image_num));
axis image
x = xlim;
y = ylim;
figure
% colormap(cm)
contourslice(img,[],[],image_num);
size(h)
axis ij
xlim(x)
ylim(y)
daspect([1,1,1])
figure
contourslice(img,[],[],[90,100,110,150],8);
view(3);
axis tight
figure
Ds = smooth3(img);
hiso = patch(isosurface(Ds,5),'FaceColor', [1,.75,.65],'EdgeColor','none');
isonormals(Ds,hiso);
hcap = patch(isocaps(img,5),'FaceColor','interp','EdgeColor','none');
view(35,30);
axis tight
daspect([1,1,.4]);

% for ii = 1:size(img,3)
%     try
%     figure;
%     imshow(img(:,:, ii));
%     figure;
%     imshow(atlas(:,:, ii));
%     pause(5);
%     original = atlas(:,:,ii);
%     distorted = img(:,:,ii);
%     ptsOriginal  = detectMinEigenFeatures(original);
%     ptsOriginal
%     ptsDistorted = detectMinEigenFeatures(distorted);
%     ptsDistorted
%     [featuresOriginal,   validPtsOriginal]  = extractFeatures(original,  ptsOriginal);
%     [featuresDistorted, validPtsDistorted]  = extractFeatures(distorted, ptsDistorted);
%     indexPairs = matchFeatures(featuresOriginal, featuresDistorted);
%     matchedOriginal  = validPtsOriginal(indexPairs(:,1));
%     matchedDistorted = validPtsDistorted(indexPairs(:,2));
%     matchedOriginal
%     matchedDistorted
%     fig = figure;
%     set(fig,'WindowStyle','docked');
%     showMatchedFeatures(original,distorted,matchedOriginal,matchedDistorted);
%     title('Putatively matched points (including outliers)');
%     pause(10);
%     [tform, inlierDistorted, inlierOriginal] = estimateGeometricTransform(matchedDistorted, matchedOriginal, 'similarity');
%     figure;
%     showMatchedFeatures(original,distorted, inlierOriginal, inlierDistorted);
%     title('Matching points (inliers only)');
%     legend('ptsOriginal','ptsDistorted');
%     tFormAff = fitgeotrans(ptsOriginal, ptsDistorted, 'affine');
%     if choice == 1
%         regOut = imtransform(imagMRI, tFormAff, 'nearest'); 
%     else
%         regOut = imwarp(imagMRI, tFormAff, 'nearest');
%     end
%     imshow(regOut);
%     catch
%     end
%     delete(findall(0,'Type','figure'))
% end


end