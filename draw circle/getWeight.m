function [weightsArray] = getWeight(param1)
%GETWEIGHT input the range param1, get an array of weight value. the size
%of the array is param1
%   此处显示详细说明
weightsArray = zeros(1, param1);
sum = 0;
for i = 1:param1
    sum = sum + i;
end
for j = 1:param1
    weightsArray(1,j) = (param1+1-j) / sum; %10/sum(1:10)  9/sum(1:10)
end
end

