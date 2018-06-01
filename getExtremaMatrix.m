function [min_M, max_M, ratio_M] = getExtremaMatrix(extremaData)
%GETEXTREMAMATRIX Summary of this function goes here
%   Detailed explanation goes here
    min_M = transpose(extremaData(:,:,1));
    max_M = transpose(extremaData(:,:,2));
    ratio_M = max_M./min_M;


end

