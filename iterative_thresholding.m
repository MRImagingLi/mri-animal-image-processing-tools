function T = iterative_thresholding(original_image)
adjasted_image = imadjust(original_image);
T = graythresh(adjasted_image);
newT = 0;
while newT - T > 0.5
    BW = im2bw(adjasted_image,T);
    IM2 = imcomplement(BW);
    G1 = double(BW).*double(adjasted_image);
    G2 = double(IM2).*double(adjasted_image);
    figure
    subplot(2,1,1);
    imshow(int16(G1));
    subplot(2,1,2);
    imshow(int16(G2));
    m1 = mean(mean(int16(G1>0)));
    m2 = mean(mean(int16(G2>0)));
    T = newT;
    newT = (m1+m2)/2;
end
end