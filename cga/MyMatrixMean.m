function [mymean, mystd]=MyMatrixMean(matrix)
[m,n] = size(matrix);
mymean = zeros(1,n);
mystd = zeros(1,n);
for j=1:n
    idx = find(~isnan(matrix(:,j)));
    mymean(j) = sum(matrix(idx,j))/length(idx);
    mystd(j) = 
end
end