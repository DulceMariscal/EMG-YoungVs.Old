function [min_M, max_M, ratio_M] = getExtremaMatrix(extremaData)

    min_M = transpose(extremaData(:,:,1));
    max_M = transpose(extremaData(:,:,2));
    ratio_M = max_M./min_M;

end

