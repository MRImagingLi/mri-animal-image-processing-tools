function [white,gray] = wm_gm_extraction(I,BW)
[rows,columns] = size(I);
% compute the binarized image
B = statbin(I,BW);
figure
imshow(B);
% create complement of the image
for i = 1:rows
    for j = 1:columns
        if B(i,j) == 1
            B(i,j) = 0;
        end
    end
end
% Compute 2 dimensional wavelet decomposition 
[cl,sl] = wavedec(B,2,'db1');
% recomposition of the image is done by usibg the approximate coefficient
% of previous step
RC = appcoef2(cl,sl,'db1',2);
% Re-complement of the image
for i = 1:rows
    for j = 1:columns
        if RC(i,j) == 1
            RC(i,j) = 0;
        end
    end
end
ALLAREA = bwlabeln(RC);
z = max(max(ALLAREA));
BConvex = convhull(B);
GRAYIMAGE1 = I*BConvex;
BIN2 = statbin(GRAYIMAGE1);
GRAYIMAGE2 = BIN2*GRAYIMAGE1;
sum = 0;
count = 0;
for i = 1:rows
    for j = 1:columns
        if GRAYIMAGE2(i,j) > 0
            intensity = GRAYIMAGE2(i,j);
            sum = sum + intensity;
            count = count + 1;
        end
    end
end

average = sum/count;
white = zeros(rows,columns);
gray = zeros(rows,columns);
for i = 1:rows
    for j = 1:columns
        if  GRAYIMAGE2(i,j) > average
            white(i,j) = 1;
        else
            gray(i,j) = 1;
        end
    end
end
white = GRAYIMAGE2 *white;
gray = GRAYIMAGE2 *gray;
end