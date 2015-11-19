function [minGrayLevel, maxGrayLevel] = grayLimits(gray_image)
minGrayLevel = min(gray_image(:));
maxGrayLevel = max(gray_image(:));
end