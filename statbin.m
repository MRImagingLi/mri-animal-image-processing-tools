% procedure to binarize image
function Init = statbin(I,BW)
[rows,columns] = size(I);
Init = zeros(rows,columns);
% copy image I to cI
cI = I;
cI(BW == 0) = NaN;
threshold = std2(cI)
% threshold selection by standard deviation of the image intensity
for i = 1:rows
    for j = 1:columns
        if I(i,j) > threshold
            Init(i,j) = 1;
        else
            Init(i,j) = NaN;
        end
    end
end
end