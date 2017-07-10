function [ searchSpace ] = SearchSpace( intervals )
%SEARCHSPACE Created a search space
[nbRow, nbCol] = size(intervals);
if nbCol == 2
    field1 = 'dim';
    value1 = nbRow;
    field2 = 'intervals';
    value2 = intervals;
    field3 = 'nbVarDim';
    value3 = (intervals(:,2) - intervals(:,1))' + 1;
    searchSpace = struct(field1,value1,field2,value2,field3,value3);
else
    error('ERROR: The size of input intervals for values is wrong.');
end
end

